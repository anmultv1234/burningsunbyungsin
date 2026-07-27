if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not syn or not protectgui then
    getgenv().protectgui = function() end
end

if bypass_adonis then
    task.spawn(function()
        local g = getinfo or debug.getinfo
        local d = false
        local h = {}
        local x, y
        setthreadidentity(2)
        for i, v in getgc(true) do
            if typeof(v) == "table" then
                local a = rawget(v, "Detected")
                local b = rawget(v, "Kill")

                if typeof(a) == "function" and not x then
                    x = a
                    local o; o = hookfunction(x, function(c, f, n)
                        if c ~= "_" then
                            if d then
                            end
                        end
                        return true
                    end)
                    table.insert(h, x)
                end

                if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
                    y = b
                    local o; o = hookfunction(y, function(f)
                        if d then
                        end
                    end)
                    table.insert(h, y)
                end
            end
        end
        local o; o = hookfunction(getrenv().debug.info, newcclosure(function(...)
            local a, f = ...
            if x and a == x then
                return coroutine.yield(coroutine.running())
            end
            return o(...)
        end))
        setthreadidentity(7)
    end)
end

if not getgenv().ScriptState then
    getgenv().ScriptState = {
        isLockedOn = false,
        targetPlayer = nil,
        lockEnabled = false,
        aimLockKeyMode = "Toggle",
        aimLockVisibleCheck = false,
        aimLockAliveCheck = false,
        aimLockTeamCheck = false,
        targetVehicles = false,
        smoothingFactor = 0.1,
        predictionFactor = 0.0,
        bodyPartSelected = "Head",
        ClosestHitPart = nil,
        previousHighlight = nil,
        lockedTime = 12,
        reverseResolveIntensity = 5,
        Desync = false,
        antiLockEnabled = false,
        resolverIntensity = 1.0,
        resolverMethod = "Recalculate",
        fovEnabled = false,
        fovMode = "Mouse",
        nebulaEnabled = false,
        fovValue = 70,
        SelfChamsEnabled = false,
        RainbowChamsEnabled = false,
        SelfChamsColor = Color3.fromRGB(255, 255, 255),
        ChamsEnabled = false,
        isSpeedActive = false,
        isFlyActive = false,
        isNoClipActive = false,
        flySpeed = 1,
        Cmultiplier = 1,
        strafeEnabled = false,
        strafeSpeed = 50,
        strafeRadius = 5,
        strafeMode = "Horizontal",
        strafeTargetPart = nil,
        originalCameraMode = nil,
        LastUpdate = 0
    }
end

local ScriptState = getgenv().ScriptState

local SilentAimSettings = {
    Enabled = false,
    ClassName = "FinalRound  |  anmultv1234",
    ToggleKey = "None",
    KeyMode = "Toggle",
    TeamCheck = false,
    VisibleCheck = false,
    AliveCheck = false,
    TargetVehicles = false,
    TargetPart = "HumanoidRootPart",
    VehicleTargetPart = "TargetPart",
    SilentAimMethod = "Raycast",
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false,
    HitChance = 100,
    MultiplyUnitBy = 1000,
    BlockedMethods = {},
    Include = { Character = true, Camera = true },
    Origin = { Camera = true },
    BulletTP = false,
    CheckForFireFunc = false,
}

getgenv().SilentAimSettings = SilentAimSettings

local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    GuiService = game:GetService("GuiService"),
    UserInputService = game:GetService("UserInputService"),
    HttpService = game:GetService("HttpService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService")
}

local Players = Services.Players
local RunService = Services.RunService
local GuiService = Services.GuiService
local UserInputService = Services.UserInputService
local HttpService = Services.HttpService
local ReplicatedStorage = Services.ReplicatedStorage
local SoundService = Services.SoundService
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Client = LocalPlayer

local GetChildren = game.GetChildren
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GuiInset = GuiService.GetGuiInset
local GetMouseLocation = UserInputService.GetMouseLocation

local ValidTargetParts = {"Head", "HumanoidRootPart", "None"}
local PredictionAmount = 0.165

local fov_circle = nil
if Drawing and Drawing.new then
    pcall(function()
        fov_circle = Drawing.new("Circle")
        fov_circle.Thickness = 1
        fov_circle.NumSides = 100
        fov_circle.Radius = 180
        fov_circle.Filled = false
        fov_circle.Visible = false
        fov_circle.ZIndex = 999
        fov_circle.Transparency = 1
        fov_circle.Color = Color3.fromRGB(54, 57, 241)
    end)
end

local ExpectedArguments = {
    ViewportPointToRay = {
        ArgCountRequired = 2,
        Args = { "number", "number" }
    },
    ScreenPointToRay = {
        ArgCountRequired = 2,
        Args = { "number", "number" }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = { "Instance", "Vector3", "Vector3", "RaycastParams" }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = { "Ray", "Instance?", "boolean?", "boolean?" }
    },
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 2,
        Args = { "Ray", "table", "boolean?", "boolean?" }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 2,
        Args = { "Ray", "table", "boolean?" }
    }
}

function CalculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end

    for Pos, Argument in next, Args do
        local Expected = RayMethod.Args[Pos]
        if not Expected then
            break
        end

        local IsOptional = Expected:sub(-1) == "?"
        local BaseType = IsOptional and Expected:sub(1, -2) or Expected

        if typeof(Argument) == BaseType then
            Matches = Matches + 1
        elseif IsOptional and Argument == nil then
            Matches = Matches + 1
        end
    end

    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit
end

local function getMousePosition()
    return GetMouseLocation(UserInputService)
end

local function getFovOrigin()
    if ScriptState.fovMode == "Center" then
        local viewportSize = Camera.ViewportSize
        return Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    end
    return getMousePosition()
end

local function getTeamComparisonOption()
    local esp = rawget(getgenv(), "ExunysDeveloperESP")
    if esp and esp.DeveloperSettings and esp.DeveloperSettings.TeamCheckOption then
        return esp.DeveloperSettings.TeamCheckOption
    end
end

local function playersOnSameTeam(player)
    if not player then
        return false
    end

    local option = getTeamComparisonOption()
    if option then
        local okLocal, localValue = pcall(function()
            return LocalPlayer[option]
        end)
        local okTarget, targetValue = pcall(function()
            return player[option]
        end)

        if okLocal and okTarget and localValue ~= nil and targetValue ~= nil then
            return targetValue == localValue
        end
    end

    local okLocalTeam, localTeam = pcall(function()
        return LocalPlayer.Team
    end)
    local okTargetTeam, targetTeam = pcall(function()
        return player.Team
    end)

    if okLocalTeam and okTargetTeam and localTeam and targetTeam then
        return targetTeam == localTeam
    end

    local okLocalColor, localColor = pcall(function()
        return LocalPlayer.TeamColor
    end)
    local okTargetColor, targetColor = pcall(function()
        return player.TeamColor
    end)

    if okLocalColor and okTargetColor and localColor and targetColor then
        return targetColor == localColor
    end

    return false
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player and Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character

    if not (PlayerCharacter and LocalPlayerCharacter) then
        return false
    end

    local targetPartOption = (Options and Options.TargetPart and Options.TargetPart.Value) or SilentAimSettings.TargetPart or "HumanoidRootPart"
    local PlayerRoot = FindFirstChild(PlayerCharacter, targetPartOption) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")

    if not PlayerRoot then
        return false
    end

    local CastPoints, IgnoreList = { PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter }, { LocalPlayerCharacter, PlayerCharacter }
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)

    return ObscuringObjects == 0
end

local function normalizeSelection(selection)
    if not selection then
        return {}
    end

    local normalized = {}

    if type(selection) ~= "table" then
        normalized[selection] = true
        return normalized
    end

    local hasNumericKeys = false
    for key in pairs(selection) do
        if type(key) == "number" then
            hasNumericKeys = true
            break
        end
    end

    if hasNumericKeys then
        for _, value in ipairs(selection) do
            normalized[value] = true
        end
    else
        for key, value in pairs(selection) do
            if type(key) == "string" then
                if value == true then
                    normalized[key] = true
                elseif type(value) == "string" then
                    normalized[value] = true
                end
            end
        end
    end

    return normalized
end

local function isSelectionActive(selection, option)
    return selection and selection[option] or false
end

SilentAimSettings.BlockedMethods = normalizeSelection(SilentAimSettings.BlockedMethods)
SilentAimSettings.Include = normalizeSelection(SilentAimSettings.Include)
SilentAimSettings.Origin = normalizeSelection(SilentAimSettings.Origin)

local VehicleCache = {}

local function onVehicleAdded(vehicle)
    task.spawn(function()
        task.wait(0.1)
        if not vehicle or not vehicle.Parent then return end
        
        local vehiclePartOption = SilentAimSettings.VehicleTargetPart or "TargetPart"
        local TargetPart = vehicle:FindFirstChild(vehiclePartOption, true)
        
        if not TargetPart then
            for _, pName in ipairs({"TargetPart", "PropellerBase", "PrimaryPart", "RudderPivotBase"}) do
                TargetPart = vehicle:FindFirstChild(pName, true)
                if TargetPart then break end
            end
        end
        
        if not TargetPart then
            TargetPart = vehicle:FindFirstChild("Body", true) or vehicle:FindFirstChild("Engine", true) or vehicle:FindFirstChild("Chassis", true) or vehicle:FindFirstChild("Hull", true)
        end
        
        if not TargetPart then
            for _, child in ipairs(vehicle:GetDescendants()) do
                if child:IsA("BasePart") then
                    TargetPart = child
                    break
                end
            end
        end
        
        if TargetPart and TargetPart:IsA("BasePart") then
            VehicleCache[vehicle] = TargetPart
        end
    end)
end

local function onVehicleRemoved(vehicle)
    VehicleCache[vehicle] = nil
end

local function setupFolder(folder)
    for _, vehicle in ipairs(folder:GetChildren()) do
        onVehicleAdded(vehicle)
    end
    folder.ChildAdded:Connect(onVehicleAdded)
    folder.ChildRemoved:Connect(onVehicleRemoved)
end

local function setupGameSystems(gameSystems)
    for _, folder in ipairs(gameSystems:GetChildren()) do
        setupFolder(folder)
    end
    gameSystems.ChildAdded:Connect(setupFolder)
    gameSystems.ChildRemoved:Connect(function(folder)
        for vehicle in pairs(VehicleCache) do
            if vehicle.Parent == folder or not vehicle.Parent then
                onVehicleRemoved(vehicle)
            end
        end
    end)
end

local gameSystemsInitial = workspace:FindFirstChild("Game Systems")
if gameSystemsInitial then
    setupGameSystems(gameSystemsInitial)
end

workspace.ChildAdded:Connect(function(child)
    if child.Name == "Game Systems" then
        setupGameSystems(child)
    end
end)

local function GetPlayerVehicle(player)
    if not player or not player.Character then return nil end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.SeatPart then
        local currentSeat = humanoid.SeatPart
        for vehicle, _ in pairs(VehicleCache) do
            if typeof(vehicle) == "Instance" and currentSeat:IsDescendantOf(vehicle) then
                return vehicle.Name
            end
        end
    end
    return nil
end

local function getClosestPlayer(config)
    config = config or {}

    local targetPartOption = config.targetPart or (Options and Options.TargetPart and Options.TargetPart.Value) or SilentAimSettings.TargetPart
    local vehiclePartOption = SilentAimSettings.VehicleTargetPart
    if not targetPartOption then
        return nil, nil
    end

    local ignoredPlayers = config.ignoredPlayers or (Options and Options.PlayerDropdown and Options.PlayerDropdown.Value)
    local radiusOption = config.radius or (Options and Options.Radius and Options.Radius.Value) or SilentAimSettings.FOVRadius or 2000
    local visibleCheck = config.visibleCheck
    if visibleCheck == nil then
        visibleCheck = SilentAimSettings.VisibleCheck
    end
    local aliveCheck = config.aliveCheck
    if aliveCheck == nil then
        aliveCheck = SilentAimSettings.AliveCheck
    end
    local teamCheck = config.teamCheck
    if teamCheck == nil then
        local silentAimTeamCheck = SilentAimSettings.TeamCheck
        local aimLockTeamCheck = ScriptState and ScriptState.aimLockTeamCheck
        local toggleValue = Toggles and Toggles.TeamCheck and Toggles.TeamCheck.Value
        teamCheck = (toggleValue ~= nil and toggleValue) or silentAimTeamCheck or aimLockTeamCheck or false
    end

    local teamEvaluator = config.teamEvaluator
    if type(teamEvaluator) ~= "function" then
        teamEvaluator = playersOnSameTeam
    end

    local originPosition = config.origin
    if typeof(originPosition) == "function" then
        originPosition = originPosition()
    end
    originPosition = originPosition or getFovOrigin()

    local ClosestPart
    local ClosestPlayer
    local DistanceToMouse

    if targetPartOption ~= "None" then
        for _, Player in next, GetPlayers(Players) do
            if Player == LocalPlayer then
                continue
            end

            if ignoredPlayers and ignoredPlayers[Player.Name] then
                continue
            end

            if teamCheck and teamEvaluator(Player) then
                continue
            end

            if visibleCheck and not IsPlayerVisible(Player) then
                continue
            end

            local Character = Player.Character
            if not Character then
                continue
            end

            local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = FindFirstChild(Character, "Humanoid")

            if not HumanoidRootPart or not Humanoid then
                continue
            end

            if aliveCheck and Humanoid.Health <= 0 then
                continue
            end

            local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
            if not OnScreen then
                continue
            end

            local Distance = (originPosition - ScreenPosition).Magnitude
            if Distance <= (DistanceToMouse or radiusOption) then
                local targetPartName
                if targetPartOption == "Random" then
                    targetPartName = ValidTargetParts[math.random(1, 2)]
                else
                    targetPartName = targetPartOption
                end

                local candidatePart = Character[targetPartName]
                if candidatePart then
                    ClosestPart = candidatePart
                    ClosestPlayer = Player
                    DistanceToMouse = Distance
                end
            end
        end
    end
    
    if SilentAimSettings.TargetVehicles or (ScriptState and ScriptState.targetVehicles) then
        local camPos = Camera.CFrame.Position
        local lookVector = Camera.CFrame.LookVector
        
        local IgnoredVehicleInstances = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer or (ignoredPlayers and ignoredPlayers[p.Name]) then
                local char = p.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.SeatPart then
                    for vehicle in pairs(VehicleCache) do
                        if hum.SeatPart:IsDescendantOf(vehicle) then
                            IgnoredVehicleInstances[vehicle] = true
                            break
                        end
                    end
                end
            end
        end

        for vehicle, TargetPart in pairs(VehicleCache) do
            if not vehicle or not vehicle.Parent or IgnoredVehicleInstances[vehicle] then continue end

            if TargetPart and TargetPart:IsA("BasePart") then
                local targetDir = (TargetPart.Position - camPos).Unit
                if lookVector:Dot(targetDir) > 0 then 
                    local Pos, OnScreen = getPositionOnScreen(TargetPart.Position)
                    if OnScreen then
                        local Dist = (originPosition - Pos).Magnitude
                        if Dist <= (DistanceToMouse or radiusOption) then
                            ClosestPart = TargetPart
                            ClosestPlayer = vehicle
                            DistanceToMouse = Dist
                        end
                    end
                end
            end
        end
    end

    return ClosestPart, ClosestPlayer
end

local function getBodyPart(character, part)
    return character:FindFirstChild(part) and part or "Head"
end

local function getNearestPlayerToMouse()
    local _, player = getClosestPlayer({
        targetPart = ScriptState.bodyPartSelected,
        visibleCheck = ScriptState.aimLockVisibleCheck,
        aliveCheck = ScriptState.aimLockAliveCheck,
        teamCheck = ScriptState.aimLockTeamCheck
    })
    if player and player ~= LocalPlayer then
        return player
    end

    return nil
end

local function acquireLockTarget()
    local player = getNearestPlayerToMouse()
    if player and player.Character then
        local partName = getBodyPart(player.Character, ScriptState.bodyPartSelected)
        local targetPart = player.Character:FindFirstChild(partName)

        if targetPart then
            ScriptState.isLockedOn = true
            ScriptState.targetPlayer = player
            return true
        end
    end

    ScriptState.isLockedOn = false
    ScriptState.targetPlayer = nil
    return false
end

local function toggleLockOnPlayer(forceState)
    local desiredState = forceState
    if desiredState == nil then
        desiredState = not ScriptState.lockEnabled
    end

    ScriptState.lockEnabled = desiredState

    if desiredState then
        acquireLockTarget()
    else
        ScriptState.isLockedOn = false
        ScriptState.targetPlayer = nil
    end

    if Toggles and Toggles.aimLockKeyToggle and Toggles.aimLockKeyToggle.Value ~= desiredState then
        Toggles.aimLockKeyToggle:SetValue(desiredState)
    end
end

RunService.RenderStepped:Connect(function()
    if ScriptState.lockEnabled and not ScriptState.isLockedOn then
        acquireLockTarget()
    end

    if ScriptState.lockEnabled and ScriptState.isLockedOn and ScriptState.targetPlayer and ScriptState.targetPlayer.Character then
        if ScriptState.aimLockTeamCheck and ScriptState.targetPlayer.Team == LocalPlayer.Team then
            ScriptState.isLockedOn = false
            ScriptState.targetPlayer = nil
            return
        end

        if ScriptState.aimLockVisibleCheck and not IsPlayerVisible(ScriptState.targetPlayer) then
            ScriptState.isLockedOn = false
            ScriptState.targetPlayer = nil
            return
        end

        local partName = getBodyPart(ScriptState.targetPlayer.Character, ScriptState.bodyPartSelected)
        local part = ScriptState.targetPlayer.Character:FindFirstChild(partName)

        if part and ScriptState.targetPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local predictedPosition = part.Position + (part.AssemblyLinearVelocity * ScriptState.predictionFactor)
            local currentCameraPosition = Camera.CFrame.Position

            Camera.CFrame = CFrame.new(currentCameraPosition, predictedPosition) * CFrame.new(0, 0, ScriptState.smoothingFactor)
        else
            ScriptState.isLockedOn = false
            ScriptState.targetPlayer = nil
        end
    end
end)
