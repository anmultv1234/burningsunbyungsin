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
                            if d then end
                        end
                        return true
                    end)
                    table.insert(h, x)
                end
                if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
                    y = b
                    local o; o = hookfunction(y, function(f)
                        if d then end
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

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

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
        reverse = false,
        isSpeedActive = false,
        isFlyActive = false,
        isNoClipActive = false,
        Cmultiplier = 2,
        flySpeed = 50,
        originalCameraMode = nil,
        strafeEnabled = false,
        strafeTargetPart = nil,
        strafeMode = "Horizontal",
        strafeRadius = 5,
        strafeSpeed = 50
    }
end

local SilentAimSettings = {
    Enabled = false,
    KeyMode = "Toggle",
    TeamCheck = false,
    VisibleCheck = false,
    AliveCheck = false,
    TargetVehicles = false,
    Prediction = 0.0,
    Part = "Head",
    FOVRadius = 80
}

local VehicleCache = {}
local ValidTargetParts = {"Head", "HumanoidRootPart"}

local function FindFirstChild(instance, name)
    if instance then
        return instance:FindFirstChild(name)
    end
    return nil
end

local function IsPlayerVisible(player)
    if not player or not player.Character then return false end
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local origin = Camera.CFrame.Position
    local direction = (root.Position - origin).Unit * 1000
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local ignoreList = {LocalPlayer.Character, Camera}
    raycastParams.FilterDescendantsInstances = ignoreList
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then
        local hitPlayer = result.Instance and Players:GetPlayerFromCharacter(result.Instance:FindFirstAncestorOfClass("Model"))
        return hitPlayer == player
    end
    return true
end

local function playersOnSameTeam(player)
    return player.Team == LocalPlayer.Team
end

local function GetPlayers(playersService)
    return playersService:GetPlayers()
end

local function getPositionOnScreen(worldPosition)
    return Camera:WorldToViewportPoint(worldPosition)
end

local function getFovOrigin()
    return UserInputService:GetMouseLocation()
end

local function cacheVehicles()
    VehicleCache = {}
    local function scanForVehicles(instance)
        if instance:IsA("Model") and instance.PrimaryPart then
            local isVehicle = false
            for _, desc in ipairs(instance:GetDescendants()) do
                if desc:IsA("VehicleSeat") or desc:IsA("Seat") then
                    isVehicle = true
                    break
                end
            end
            if isVehicle then
                local targetPart = instance.PrimaryPart
                for _, desc in ipairs(instance:GetDescendants()) do
                    if desc.Name == "SmokePart" or desc.Name == "Muzzle" or desc.Name == "Handle" then
                        if desc:IsA("BasePart") then
                            targetPart = desc
                            break
                        end
                    end
                end
                VehicleCache[instance] = targetPart
            end
        end
        for _, child in ipairs(instance:GetChildren()) do
            scanForVehicles(child)
        end
    end
    scanForVehicles(workspace)
end

task.spawn(function()
    while task.wait(5) do
        cacheVehicles()
    end
end)

cacheVehicles()

local function getClosestPlayer(config)
    config = config or {}
    local radiusOption = config.radius or SilentAimSettings.FOVRadius
    local targetPartOption = config.targetPart or SilentAimSettings.Part or ScriptState.bodyPartSelected
    local visibleCheck = config.visibleCheck
    if visibleCheck == nil then
        local silentAimVisibleCheck = SilentAimSettings.VisibleCheck
        local aimLockVisibleCheck = ScriptState and ScriptState.aimLockVisibleCheck
        local toggleValue = Toggles and Toggles.VisibleCheck and Toggles.VisibleCheck.Value
        visibleCheck = (toggleValue ~= nil and toggleValue) or silentAimVisibleCheck or aimLockVisibleCheck or false
    end
    local aliveCheck = config.aliveCheck
    if aliveCheck == nil then
        local silentAimAliveCheck = SilentAimSettings.AliveCheck
        local aimLockAliveCheck = ScriptState and ScriptState.aimLockAliveCheck
        local toggleValue = Toggles and Toggles.AliveCheck and Toggles.AliveCheck.Value
        aliveCheck = (toggleValue ~= nil and toggleValue) or silentAimAliveCheck or aimLockAliveCheck or false
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
            if Player == LocalPlayer then continue end
            if teamCheck and teamEvaluator(Player) then continue end
            if visibleCheck and not IsPlayerVisible(Player) then continue end
            local Character = Player.Character
            if not Character then continue end
            local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = FindFirstChild(Character, "Humanoid")
            if not HumanoidRootPart or not Humanoid then continue end
            if aliveCheck and Humanoid.Health <= 0 then continue end
            local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
            if not OnScreen then continue end
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
            if p == LocalPlayer then
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

-- ====== BUG FIX 1: __namecall 훅 (Silent Aim) ======
-- nil.Position 에러 방지: ClosestHitPart가 nil이면 원본 레이캐스트 그대로 통과
local __namecall
__namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() then
        if method == "Raycast" then
            local hitPart = ScriptState.ClosestHitPart
            if hitPart then
                local origin = args[1]
                local direction = args[2]
                local targetPos = hitPart.Position
                if ScriptState.predictionFactor > 0 then
                    local vel = hitPart.AssemblyLinearVelocity
                    if vel then
                        targetPos = targetPos + vel * ScriptState.predictionFactor
                    end
                end
                local newDirection = (targetPos - origin).Unit * direction.Magnitude
                args[2] = newDirection
                return __namecall(self, unpack(args))
            end
        elseif method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" then
            local hitPart = ScriptState.ClosestHitPart
            if hitPart then
                local ray = args[1]
                local origin = ray.Origin
                local targetPos = hitPart.Position
                if ScriptState.predictionFactor > 0 then
                    local vel = hitPart.AssemblyLinearVelocity
                    if vel then
                        targetPos = targetPos + vel * ScriptState.predictionFactor
                    end
                end
                local newDirection = (targetPos - origin).Unit * ray.Direction.Magnitude
                args[1] = Ray.new(origin, newDirection)
                return __namecall(self, unpack(args))
            end
        elseif method == "FireServer" then
            local hitPart = ScriptState.ClosestHitPart
            if hitPart and SilentAimSettings.Enabled then
                -- Turret remote handling (FireTurret etc.)
                if type(args[#args]) == "table" and type(args[#args][1]) == "table" then
                    local hitPoint = hitPart.Position
                    local origin = Camera.CFrame.Position
                    local direction = (hitPoint - origin).Unit
                    local modifiedArgs = {}
                    for i = 1, #args do
                        modifiedArgs[i] = args[i]
                    end
                    if #args >= 4 and typeof(args[4]) == "Vector3" then
                        modifiedArgs[4] = origin
                    end
                    if #args >= 5 and typeof(args[5]) == "Vector3" then
                        modifiedArgs[5] = direction
                    end
                    if #args >= 6 and typeof(args[6]) == "Vector3" then
                        modifiedArgs[6] = hitPoint
                    end
                    if modifiedArgs[#modifiedArgs] and type(modifiedArgs[#modifiedArgs]) == "table" and type(modifiedArgs[#modifiedArgs][1]) == "table" then
                        local hitTable = modifiedArgs[#modifiedArgs][1]
                        if type(hitTable) == "table" and #hitTable >= 1 then
                            modifiedArgs[#modifiedArgs][1] = {LocalPlayer.Character, hitPart, workspace.LocalPartStorage or workspace, {LocalPlayer.Character}}
                        end
                    end
                    return __namecall(self, unpack(modifiedArgs))
                end
            end
        end
    end
    
    return __namecall(self, ...)
end))

-- ====== BUG FIX 2: AimLock 카메라 루프 (Vehicle 대응) ======
-- .Character / Humanoid 없는 Vehicle 객체 처리 + nil safe
local function getVehicleTargetPart(vehicle)
    if not vehicle then return nil end
    local cached = VehicleCache[vehicle]
    if cached and cached:IsA("BasePart") and cached.Parent then
        return cached
    end
    local primary = vehicle.PrimaryPart
    if primary then return primary end
    return vehicle:FindFirstChildWhichIsA("BasePart")
end

local function getNearestTarget()
    local isVehicleMode = ScriptState.targetVehicles or SilentAimSettings.TargetVehicles
    
    if isVehicleMode then
        local part, target = getClosestPlayer({
            targetPart = "None",
            visibleCheck = ScriptState.aimLockVisibleCheck,
            aliveCheck = ScriptState.aimLockAliveCheck,
            teamCheck = ScriptState.aimLockTeamCheck
        })
        if part and target and target ~= LocalPlayer then
            return part, target, true
        end
        -- Vehicle cache에서 직접 찾기
        local camPos = Camera.CFrame.Position
        local lookVector = Camera.CFrame.LookVector
        local closestDist = math.huge
        local closestVeh = nil
        local closestVehPart = nil
        for vehicle, targetPart in pairs(VehicleCache) do
            if not vehicle or not vehicle.Parent then continue end
            if targetPart and targetPart:IsA("BasePart") then
                local dir = (targetPart.Position - camPos).Unit
                if lookVector:Dot(dir) > 0 then
                    local pos, onScr = getPositionOnScreen(targetPart.Position)
                    if onScr then
                        local dist = (getFovOrigin() - pos).Magnitude
                        if dist < closestDist and dist <= SilentAimSettings.FOVRadius then
                            closestDist = dist
                            closestVeh = vehicle
                            closestVehPart = targetPart
                        end
                    end
                end
            end
        end
        if closestVehPart and closestVeh then
            return closestVehPart, closestVeh, true
        end
        return nil, nil, false
    else
        local part, player = getClosestPlayer({
            targetPart = ScriptState.bodyPartSelected,
            visibleCheck = ScriptState.aimLockVisibleCheck,
            aliveCheck = ScriptState.aimLockAliveCheck,
            teamCheck = ScriptState.aimLockTeamCheck
        })
        if player and player ~= LocalPlayer then
            return part, player, false
        end
        return nil, nil, false
    end
end

local function acquireLockTarget()
    local targetPart, target, isVehicle = getNearestTarget()
    if target and targetPart then
        ScriptState.isLockedOn = true
        ScriptState.targetPlayer = target
        ScriptState.ClosestHitPart = targetPart
        return true
    end
    ScriptState.isLockedOn = false
    ScriptState.targetPlayer = nil
    ScriptState.ClosestHitPart = nil
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
        ScriptState.ClosestHitPart = nil
    end
    if Toggles and Toggles.aimLockKeyToggle and Toggles.aimLockKeyToggle.Value ~= desiredState then
        Toggles.aimLockKeyToggle:SetValue(desiredState)
    end
end

-- RenderStepped에서 getClosestPlayer 호출하여 ClosestHitPart 최신화
RunService.RenderStepped:Connect(function()
    -- Silent Aim을 위한 ClosestHitPart 업데이트
    if SilentAimSettings.Enabled then
        local part, _ = getClosestPlayer({
            targetPart = SilentAimSettings.Part,
            visibleCheck = SilentAimSettings.VisibleCheck,
            aliveCheck = SilentAimSettings.AliveCheck,
            teamCheck = SilentAimSettings.TeamCheck
        })
        ScriptState.ClosestHitPart = part
    elseif not ScriptState.lockEnabled then
        ScriptState.ClosestHitPart = nil
    end
    
    -- AimLock 로직
    if ScriptState.lockEnabled and not ScriptState.isLockedOn then
        acquireLockTarget()
    end

    if ScriptState.lockEnabled and ScriptState.isLockedOn and ScriptState.targetPlayer then
        local target = ScriptState.targetPlayer
        local isVehicle = ScriptState.targetVehicles or SilentAimSettings.TargetVehicles
        local targetPos = nil
        local shouldUnlock = false
        
        if isVehicle then
            local vehPart = getVehicleTargetPart(target)
            if vehPart then
                targetPos = vehPart.Position
                ScriptState.ClosestHitPart = vehPart
            else
                shouldUnlock = true
            end
        else
            if target.Character then
                if ScriptState.aimLockTeamCheck and target.Team == LocalPlayer.Team then
                    shouldUnlock = true
                end
                if not shouldUnlock and ScriptState.aimLockVisibleCheck and not IsPlayerVisible(target) then
                    shouldUnlock = true
                end
                if not shouldUnlock then
                    local partName = getBodyPart(target.Character, ScriptState.bodyPartSelected)
                    local part = target.Character:FindFirstChild(partName)
                    local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                    if part and humanoid and humanoid.Health > 0 then
                        targetPos = part.Position
                        ScriptState.ClosestHitPart = part
                    else
                        shouldUnlock = true
                    end
                end
            else
                shouldUnlock = true
            end
        end
        
        if shouldUnlock or not targetPos then
            ScriptState.isLockedOn = false
            ScriptState.targetPlayer = nil
            ScriptState.ClosestHitPart = nil
            return
        end
        
        local predictedPosition = targetPos
        if not isVehicle and ScriptState.predictionFactor > 0 then
            local part = ScriptState.ClosestHitPart
            if part then
                local vel = part.AssemblyLinearVelocity
                if vel then
                    predictedPosition = targetPos + vel * ScriptState.predictionFactor
                end
            end
        end
        
        local currentCameraPosition = Camera.CFrame.Position
        if ScriptState.smoothingFactor > 0 and ScriptState.smoothingFactor < 1 then
            local currentLook = Camera.CFrame.LookVector
            local desiredLook = (predictedPosition - currentCameraPosition).Unit
            local smoothed = currentLook:Lerp(desiredLook, ScriptState.smoothingFactor)
            Camera.CFrame = CFrame.new(currentCameraPosition, currentCameraPosition + smoothed)
        else
            Camera.CFrame = CFrame.new(currentCameraPosition, predictedPosition)
        end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/anmultv1234/FinalRound/refs/heads/main/Mobile_Lib.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/anmultv1234/FinalRoundUI-Lib/refs/heads/main/%E2%80%8Bmanage2.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/anmultv1234/FinalRoundUI-Lib/refs/heads/main/%E2%80%8Bmanager.lua"))()
local Window = Library:CreateWindow({
    Title = 'FinalRound  |  anmultv1234',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local GeneralTab = Window:AddTab("Main")
local aimbox = GeneralTab:AddRightGroupbox("AimLock")
local velbox = GeneralTab:AddRightGroupbox("Anti Lock")
local frabox = GeneralTab:AddRightGroupbox("Movement")
local ragebox = GeneralTab:AddLeftGroupbox("Rage")
local ExploitTab = Window:AddTab("Exploits")
local ACSEngineBox = ExploitTab:AddLeftGroupbox("ACS Engine")
local VehicleModBox = ExploitTab:AddRightGroupbox("Vehicle Modifier")
local VisualsTab = Window:AddTab("Visuals")
local settingsTab = Window:AddTab("Settings")
local MenuGroup = settingsTab:AddLeftGroupbox("Menu")
MenuGroup:AddButton("Unload", function() Library:Unload() end)
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "None", NoUI = true, Text = "Menu keybind" })

Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:ApplyToTab(settingsTab)
SaveManager:BuildConfigSection(settingsTab)

local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
OpenButton.Size = UDim2.new(0, 80, 0, 30)
OpenButton.Position = UDim2.new(1, -100, 0.5, -15)
OpenButton.Text = "OPEN"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.Code
OpenButton.TextSize = 14
OpenButton.BorderSizePixel = 0
OpenButton.Active = true

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1.5
UIStroke.Color = Color3.fromRGB(0, 110, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = OpenButton

OpenButton.MouseButton1Click:Connect(function()
    Library:Toggle()
end)

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    OpenButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = OpenButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

OpenButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local AimLockButton = Instance.new("TextButton")
AimLockButton.Parent = ScreenGui
AimLockButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
AimLockButton.Size = UDim2.new(0, 80, 0, 30)
AimLockButton.Position = UDim2.new(1, -100, 0.5, 25)
AimLockButton.Text = "AIMLOCK"
AimLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimLockButton.Font = Enum.Font.Code
AimLockButton.TextSize = 14
AimLockButton.BorderSizePixel = 0
AimLockButton.Active = true

local AimLockUIStroke = Instance.new("UIStroke")
AimLockUIStroke.Thickness = 1.5
AimLockUIStroke.Color = Color3.fromRGB(255, 0, 0)
AimLockUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
AimLockUIStroke.Parent = AimLockButton

AimLockButton.MouseButton1Click:Connect(function()
    local newState = not ScriptState.lockEnabled
    toggleLockOnPlayer(newState)
    if ScriptState.lockEnabled then
        AimLockUIStroke.Color = Color3.fromRGB(0, 255, 0)
    else
        AimLockUIStroke.Color = Color3.fromRGB(255, 0, 0)
    end
end)

local aimDragging, aimDragInput, aimDragStart, aimStartPos
local function aimUpdate(input)
    local delta = input.Position - aimDragStart
    AimLockButton.Position = UDim2.new(
        aimStartPos.X.Scale,
        aimStartPos.X.Offset + delta.X,
        aimStartPos.Y.Scale,
        aimStartPos.Y.Offset + delta.Y
    )
end

AimLockButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        aimDragging = true
        aimDragStart = input.Position
        aimStartPos = AimLockButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                aimDragging = false
            end
        end)
    end
end)

AimLockButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        aimDragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and aimDragging then
        aimUpdate(input)
    end
end)

local SilentAimButton = Instance.new("TextButton")
SilentAimButton.Parent = ScreenGui
SilentAimButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SilentAimButton.Size = UDim2.new(0, 80, 0, 30)
SilentAimButton.Position = UDim2.new(1, -100, 0.5, 65)
SilentAimButton.Text = "SILENTAIM"
SilentAimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SilentAimButton.Font = Enum.Font.Code
SilentAimButton.TextSize = 14
SilentAimButton.BorderSizePixel = 0
SilentAimButton.Active = true

local SilentAimUIStroke = Instance.new("UIStroke")
SilentAimUIStroke.Thickness = 1.5
SilentAimUIStroke.Color = Color3.fromRGB(255, 0, 0)
SilentAimUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SilentAimUIStroke.Parent = SilentAimButton

SilentAimButton.MouseButton1Click:Connect(function()
    local newState = not SilentAimSettings.Enabled
    SilentAimSettings.Enabled = newState
    if Toggles and Toggles.silentAimEnabled then
        Toggles.silentAimEnabled:SetValue(newState)
    end
    if SilentAimSettings.Enabled then
        SilentAimUIStroke.Color = Color3.fromRGB(0, 255, 0)
    else
        SilentAimUIStroke.Color = Color3.fromRGB(255, 0, 0)
    end
end)

local saDragging, saDragInput, saDragStart, saStartPos
local function saUpdate(input)
    local delta = input.Position - saDragStart
    SilentAimButton.Position = UDim2.new(
        saStartPos.X.Scale,
        saStartPos.X.Offset + delta.X,
        saStartPos.Y.Scale,
        saStartPos.Y.Offset + delta.Y
    )
end

SilentAimButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        saDragging = true
        saDragStart = input.Position
        saStartPos = SilentAimButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                saDragging = false
            end
        end)
    end
end)

SilentAimButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        saDragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == saDragInput and saDragging then
        saUpdate(input)
    end
end)

local lastAimLockKeyState = false
local lastAimLockKeyMode = ScriptState.aimLockKeyMode

aimbox:AddToggle("aimLockKeyToggle", {
    Text = "aimlock",
    Default = false,
    Tooltip = "Toggle AimLock on or off.",
    Callback = function(value)
        if ScriptState.lockEnabled == value then
            return
        end
        toggleLockOnPlayer(value)
    end,
}):AddKeyPicker("aimLock_KeyPicker", {
    Default = "None",
    SyncToggleState = true,
    Mode = ScriptState.aimLockKeyMode,
    Text = "AimLock",
    Tooltip = "Keybind for AimLock",
    Callback = function()
        if Options.aimLock_KeyPicker.Mode == "Toggle" then
            toggleLockOnPlayer(Options.aimLock_KeyPicker:GetState())
        end
    end,
    ChangedCallback = function()
        lastAimLockKeyState = Options.aimLock_KeyPicker:GetState()
    end
})

lastAimLockKeyState = Options.aimLock_KeyPicker:GetState()
lastAimLockKeyMode = Options.aimLock_KeyPicker.Mode or lastAimLockKeyMode
ScriptState.aimLockKeyMode = lastAimLockKeyMode

RunService.RenderStepped:Connect(function()
    local keyPicker = Options.aimLock_KeyPicker
    if not keyPicker then
        return
    end

    local currentMode = keyPicker.Mode or "Toggle"
    if currentMode ~= lastAimLockKeyMode then
        ScriptState.aimLockKeyMode = currentMode
        lastAimLockKeyMode = currentMode
        lastAimLockKeyState = keyPicker:GetState()
        if lastAimLockKeyState then
            toggleLockOnPlayer(true)
        elseif ScriptState.lockEnabled and not lastAimLockKeyState then
            toggleLockOnPlayer(false)
        end
    end

    if currentMode ~= "Toggle" then
        local currentState = keyPicker:GetState()
        if currentState ~= lastAimLockKeyState then
            toggleLockOnPlayer(currentState)
            lastAimLockKeyState = currentState
        elseif currentMode == "Always" and not ScriptState.lockEnabled then
            toggleLockOnPlayer(true)
            lastAimLockKeyState = keyPicker:GetState()
        elseif currentMode == "Hold" and currentState then
            toggleLockOnPlayer(true)
        end
    else
        lastAimLockKeyState = keyPicker:GetState()
    end
end)

aimbox:AddSlider("Smoothing", {
    Text = "Camera Smoothing",
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Tooltip = "Adjust camera smoothing factor.",
    Callback = function(value)
        ScriptState.smoothingFactor = value
    end,
})

aimbox:AddSlider("Prediction", {
    Text = "Prediction Factor",
    Default = 0.0,
    Min = 0,
    Max = 2,
    Rounding = 2,
    Tooltip = "Adjust prediction for target movement.",
    Callback = function(value)
        ScriptState.predictionFactor = value
    end,
})

aimbox:AddToggle("aimLockVisibleCheck", {
    Text = "Visible Check",
    Default = ScriptState.aimLockVisibleCheck,
    Tooltip = "Skip targets blocked by objects.",
    Callback = function(value)
        ScriptState.aimLockVisibleCheck = value
    end
})

aimbox:AddToggle("aimLockAliveCheck", {
    Text = "Alive Check",
    Default = ScriptState.aimLockAliveCheck,
    Tooltip = "Ignore eliminated targets.",
    Callback = function(value)
        ScriptState.aimLockAliveCheck = value
    end
})

aimbox:AddToggle("aimLockTeamCheck", {
    Text = "Team Check",
    Default = ScriptState.aimLockTeamCheck,
    Tooltip = "Avoid locking teammates.",
    Callback = function(value)
        ScriptState.aimLockTeamCheck = value
        if value and ScriptState.lockEnabled and ScriptState.targetPlayer and ScriptState.targetPlayer.Team == LocalPlayer.Team then
            acquireLockTarget()
        end
    end
})

aimbox:AddDropdown("BodyParts", {
    Values = {"Head", "UpperTorso", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg", "LeftUpperArm"},
    Default = "Head",
    Multi = false,
    Text = "Target Body Part",
    Tooltip = "Select which body part to lock onto.",
    Callback = function(value)
        ScriptState.bodyPartSelected = value
    end,
})

getgenv().ScriptState.Desync = false

RunService.Heartbeat:Connect(function()
    if getgenv().ScriptState.Desync then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then return end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        local originalVelocity = humanoidRootPart.Velocity

        local randomOffset = Vector3.new(
            math.random(-1, 1) * ScriptState.reverseResolveIntensity * 1000,
            math.random(-1, 1) * ScriptState.reverseResolveIntensity * 1000,
            math.random(-1, 1) * ScriptState.reverseResolveIntensity * 1000
        )
        humanoidRootPart.Velocity = randomOffset
        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(
            0,
            math.random(-1, 1) * ScriptState.reverseResolveIntensity * 0.001,
            0
        )
        RunService.RenderStepped:Wait()
        humanoidRootPart.Velocity = originalVelocity
    end
end)

velbox:AddToggle("desyncEnabled", {
    Text = "Desync",
    Default = false,
    Tooltip = "Enable or disable reverse resolve desync.",
    Callback = function(value)
        getgenv().ScriptState.Desync = value
    end
}):AddKeyPicker("desyncToggleKey", {
    Default = "None",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Desync Toggle Key",
    Tooltip = "Toggle to enable/disable velocity desync.",
    Callback = function(value)
        getgenv().ScriptState.Desync = value
    end
})

velbox:AddSlider("ReverseResolveIntensity", {
    Text = "velocity intensity",
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Tooltip = "Adjust the intensity of the reverse resolve effect.",
    Callback = function(value)
        ScriptState.reverseResolveIntensity = value
    end
})

getgenv().config = getgenv().config or {}
getgenv().config.killRange = getgenv().config.killRange or 100
ScriptState.rageEnabled = false

ragebox:AddToggle("rageEnabledToggle", {
    Text = "Rage Mode",
    Default = false,
    Callback = function(value)
        ScriptState.rageEnabled = value
    end
})

ragebox:AddSlider("killRangeSlider", {
    Text = "Kill Range",
    Default = 100,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Callback = function(value)
        getgenv().config.killRange = value
    end
})

local utils = {}
function utils.desyncTo(meRoot, targetRoot)
    if meRoot and targetRoot then
        local originalVelocity = meRoot.Velocity
        local direction = (targetRoot.Position - meRoot.Position).Unit
        meRoot.Velocity = direction * ((ScriptState.reverseResolveIntensity or 5) * 1000)
        RunService.RenderStepped:Wait()
        meRoot.Velocity = originalVelocity
    end
end

RunService.RenderStepped:Connect(function()
    if ScriptState.rageEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local me = { rootpart = LocalPlayer.Character.HumanoidRootPart }
        local targets = {}
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local head = player.Character:FindFirstChild("Head")
                local rootpart = humanoid and humanoid.RootPart
                
                if head and rootpart and humanoid.Health > 0 then
                    local distance = (me.rootpart.Position - rootpart.Position).Magnitude
                    if distance <= (getgenv().config.killRange or 100) then
                        table.insert(targets, {
                            head = head,
                            rootpart = rootpart,
                            player = player
                        })
                    end
                end
            end
        end
        
        if #targets > 0 then
            for _, target in ipairs(targets) do
                utils.desyncTo(me.rootpart, target.rootpart)
                ScriptState.ClosestHitPart = target.head
                
                if getgenv().WeaponOnHands then
                    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if ScriptState.isLockedOn and ScriptState.targetPlayer and ScriptState.targetPlayer.Character then
        local partName = getBodyPart(ScriptState.targetPlayer.Character, ScriptState.bodyPartSelected)
        local part = ScriptState.targetPlayer.Character:FindFirstChild(partName)

        if part and ScriptState.targetPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local predictedPosition = part.Position + (part.AssemblyLinearVelocity * ScriptState.predictionFactor)

            if ScriptState.antiLockEnabled then
                if ScriptState.resolverMethod == "Recalculate" then
                    predictedPosition = predictedPosition + (part.AssemblyLinearVelocity * ScriptState.resolverIntensity)
                elseif ScriptState.resolverMethod == "Randomize" then
                    predictedPosition = predictedPosition + Vector3.new(
                        math.random() * ScriptState.resolverIntensity - (ScriptState.resolverIntensity / 2),
                        math.random() * ScriptState.resolverIntensity - (ScriptState.resolverIntensity / 2),
                        math.random() * ScriptState.resolverIntensity - (ScriptState.resolverIntensity / 2)
                    )
                elseif ScriptState.resolverMethod == "Invert" then
                    predictedPosition = predictedPosition - (part.AssemblyLinearVelocity * ScriptState.resolverIntensity * 2)
                end
            end

            local currentCameraPosition = Camera.CFrame.Position
            Camera.CFrame = CFrame.new(currentCameraPosition, predictedPosition) * CFrame.new(0, 0, ScriptState.smoothingFactor)
        else
            ScriptState.isLockedOn = false
            ScriptState.targetPlayer = nil
        end
    end
end)

aimbox:AddToggle("antiLock_Enabled", {
    Text = "Anti Lock Resolver",
    Default = false,
    Tooltip = "Toggle the Anti Lock Resolver on or off.",
    Callback = function(value)
        ScriptState.antiLockEnabled = value
    end,
})

aimbox:AddSlider("ResolverIntensity", {
    Text = "Resolver Intensity",
    Default = 1.0,
    Min = 0,
    Max = 5,
    Rounding = 2,
    Tooltip = "Adjust the intensity of the Anti Lock Resolver.",
    Callback = function(value)
        ScriptState.resolverIntensity = value
    end,
})

aimbox:AddDropdown("ResolverMethods", {
    Values = {"Recalculate", "Randomize", "Invert"},
    Default = "Recalculate",
    Multi = false,
    Text = "Resolver Method",
    Tooltip = "Select the method used by the Anti Lock Resolver.",
    Callback = function(value)
        ScriptState.resolverMethod = value
    end,
})

local MainBOX = GeneralTab:AddLeftTabbox("Silent Aim")
local Main = MainBOX:AddTab("Silent Aim")

local silentAimToggle = Main:AddToggle("silentAimEnabled", {
    Text = "Silent Aim",
    Default = SilentAimSettings.Enabled,
    Callback = function(value)
        SilentAimSettings.Enabled = value
        if SilentAimUIStroke then
            SilentAimUIStroke.Color = value and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        end
    end
})

silentAimToggle:AddKeyPicker("silentAim_KeyPicker", {
    Default = SilentAimSettings.ToggleKey or "None",
    SyncToggleState = true,
    Mode = SilentAimSettings.KeyMode or "Toggle",
    Text = "Enabled",
    NoUI = false,
    Callback = function(state)
        if silentAimToggle.Value ~= state then
            silentAimToggle:SetValue(state)
        end
    end,
    ChangedCallback = function()
        SilentAimSettings.ToggleKey = Options.silentAim_KeyPicker.Value
        SilentAimSettings.KeyMode = Options.silentAim_KeyPicker.Mode
    end
})

SilentAimSettings.ToggleKey = Options.silentAim_KeyPicker.Value

Main:AddToggle("TeamCheck", {
    Text = "Team Check",
    Default = SilentAimSettings.TeamCheck
}):OnChanged(function()
    SilentAimSettings.TeamCheck = Toggles.TeamCheck.Value
end)

Main:AddToggle("VisibleCheck", {
    Text = "Visible Check",
    Default = SilentAimSettings.VisibleCheck,
    Tooltip = "Only target players that are visible"
}):OnChanged(function()
    SilentAimSettings.VisibleCheck = Toggles.VisibleCheck.Value
end)

Main:AddToggle("AliveCheck", {
    Text = "Alive Check",
    Default = SilentAimSettings.AliveCheck,
    Tooltip = "Ignore players with zero health"
}):OnChanged(function()
    SilentAimSettings.AliveCheck = Toggles.AliveCheck.Value
end)

Main:AddToggle("TargetVehicles", {
    Text = "Target Vehicles",
    Default = SilentAimSettings.TargetVehicles,
}):OnChanged(function()
    SilentAimSettings.TargetVehicles = Toggles.TargetVehicles.Value
end)

Main:AddToggle("BulletTP", {
    Text = "Bullet Teleport",
    Default = SilentAimSettings.BulletTP,
    Tooltip = "Teleports bullet origin to target"
}):OnChanged(function()
    SilentAimSettings.BulletTP = Toggles.BulletTP.Value
end)

Main:AddToggle("CheckForFireFunc", {
    Text = "Check For Fire Function",
    Default = SilentAimSettings.CheckForFireFunc,
    Tooltip = "Checks if the method is called from a fire function"
}):OnChanged(function()
    SilentAimSettings.CheckForFireFunc = Toggles.CheckForFireFunc.Value
end)

Main:AddDropdown("TargetPart", {
    AllowNull = true,
    Text = "Target Part",
    Default = SilentAimSettings.TargetPart,
    Values = {"Head", "HumanoidRootPart", "None", "Random"}
}):OnChanged(function()
    SilentAimSettings.TargetPart = Options.TargetPart.Value
end)

Main:AddDropdown("VehicleTargetPart", {
    AllowNull = false,
    Text = "Vehicle Target Part",
    Default = "TargetPart",
    Values = {"TargetPart", "PropellerBase", "PrimaryPart", "RudderPivotBase"}
}):OnChanged(function()
    SilentAimSettings.VehicleTargetPart = Options.VehicleTargetPart.Value
end)

Main:AddDropdown("Method", {
    AllowNull = true,
    Text = "Silent Aim Method",
    Default = SilentAimSettings.SilentAimMethod,
    Values = {
        "ViewportPointToRay",
        "ScreenPointToRay",
        "Raycast",
        "FindPartOnRay",
        "FindPartOnRayWithIgnoreList",
        "FindPartOnRayWithWhitelist",
        "CounterBlox"
    }
}):OnChanged(function()
    SilentAimSettings.SilentAimMethod = Options.Method.Value
end)

if not SilentAimSettings.BlockedMethods then
    SilentAimSettings.BlockedMethods = {}
end

Main:AddDropdown("Blocked Methods", {
    AllowNull = true,
    Multi = true,
    Text = "Blocked Methods",
    Default = SilentAimSettings.BlockedMethods,
    Values = {
        "BulkMoveTo",
        "PivotTo",
        "TranslateBy",
        "SetPrimaryPartCFrame"
    }
}):OnChanged(function()
    SilentAimSettings.BlockedMethods = normalizeSelection(Options["Blocked Methods"].Value)
end)

Main:AddDropdown("Include", {
    AllowNull = true,
    Multi = true,
    Text = "Include",
    Default = SilentAimSettings.Include,
    Values = {"Camera", "Character"},
    Tooltip = "Includes these objects in the ignore list"
}):OnChanged(function()
    SilentAimSettings.Include = normalizeSelection(Options.Include.Value)
end)

Main:AddDropdown("Origin", {
    AllowNull = true,
    Multi = true,
    Text = "Origin",
    Default = SilentAimSettings.Origin,
    Values = {"Camera"},
    Tooltip = "Sets the origin of the bullet"
}):OnChanged(function()
    SilentAimSettings.Origin = normalizeSelection(Options.Origin.Value)
end)

Main:AddSlider("MultiplyUnitBy", {
    Text = "Multiply Unit By",
    Default = SilentAimSettings.MultiplyUnitBy,
    Min = 1,
    Max = 10000,
    Rounding = 0,
    Compact = false,
    Tooltip = "Multiplies the direction vector by this value"
}):OnChanged(function()
    SilentAimSettings.MultiplyUnitBy = Options.MultiplyUnitBy.Value
end)

Main:AddSlider("HitChance", {
    Text = "Hit Chance",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Compact = false,
}):OnChanged(function()
    SilentAimSettings.HitChance = Options.HitChance.Value
end)

local FieldOfViewBOX = GeneralTab:AddLeftTabbox("Field Of View") do
    local Main = FieldOfViewBOX:AddTab("Visuals")

    Main:AddToggle("Visible", {Text = "Show FOV Circle"})
        :AddColorPicker("Color", {Default = Color3.fromRGB(54, 57, 241)})
        :OnChanged(function()
            if fov_circle then
                fov_circle.Visible = Toggles.Visible.Value
            end
            SilentAimSettings.FOVVisible = Toggles.Visible.Value
        end)

    Main:AddSlider("Radius", {
        Text = "FOV Circle Radius",
        Min = 0,
        Max = 360,
        Default = 130,
        Rounding = 0
    }):OnChanged(function()
        if fov_circle then
            fov_circle.Radius = Options.Radius.Value
        end
        SilentAimSettings.FOVRadius = Options.Radius.Value
    end)

    Main:AddDropdown("FovMode", {
        Values = {"Mouse", "Center"},
        Default = ScriptState.fovMode,
        Text = "FOV Origin",
        Tooltip = "Choose whether the FOV stays centered or follows the cursor."
    }):OnChanged(function()
        ScriptState.fovMode = Options.FovMode.Value
    end)

    Main:AddToggle("MousePosition", {Text = "Show Silent Aim Target"})
        :AddColorPicker("MouseVisualizeColor", {Default = Color3.fromRGB(54, 57, 241)})
        :OnChanged(function()
            SilentAimSettings.ShowSilentAimTarget = Toggles.MousePosition.Value
        end)

    Main:AddDropdown("PlayerDropdown", {
        SpecialType = "Player",
        Text = "Ignore Player",
        Tooltip = "Friend list",
        Multi = true
    })
end

local VehicleDrawings = {}

local function removeOldHighlight()
    if ScriptState.previousHighlight then
        ScriptState.previousHighlight:Destroy()
        ScriptState.previousHighlight = nil
    end
end

task.spawn(function()
    RenderStepped:Connect(function()
        if Toggles.MousePosition.Value then
            local visibleCheckActive = SilentAimSettings.VisibleCheck or ScriptState.aimLockVisibleCheck
            local teamCheckActive = SilentAimSettings.TeamCheck or ScriptState.aimLockTeamCheck
            local aliveCheckActive = SilentAimSettings.AliveCheck or ScriptState.aimLockAliveCheck

            local closestPart, closestPlayer = getClosestPlayer({
                visibleCheck = visibleCheckActive,
                teamCheck = teamCheckActive,
                aliveCheck = aliveCheckActive
            })
            if closestPart and closestPlayer then
                local char = closestPlayer.Character or closestPart.Parent
                if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                    if teamCheckActive and playersOnSameTeam(closestPlayer) then
                        removeOldHighlight()
                        return
                    end
                    if visibleCheckActive and not IsPlayerVisible(closestPlayer) then
                        removeOldHighlight()
                        return
                    end
                    if SilentAimSettings.VisibleCheck and not IsPlayerVisible(closestPlayer) then
                        removeOldHighlight()
                        return
                    end
                    local Root = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart")
                    if Root then
                        local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position)
                        removeOldHighlight()
                        if IsOnScreen then
                            local highlight = char:FindFirstChildOfClass("Highlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Parent = char
                                highlight.Adornee = char
                            end
                            highlight.FillColor = Options.MouseVisualizeColor.Value
                            highlight.FillTransparency = 0.5
                            highlight.OutlineColor = Options.MouseVisualizeColor.Value
                            highlight.OutlineTransparency = 0
                            ScriptState.previousHighlight = highlight
                        end
                    end
                end
            else
                removeOldHighlight()
            end
        end
        if fov_circle and Toggles.Visible and Toggles.Visible.Value then
            fov_circle.Visible = Toggles.Visible.Value
            if Options.Color then
                fov_circle.Color = Options.Color.Value
            end
            fov_circle.Position = getFovOrigin()
        end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local hasDrawing = typeof(Drawing) == "table" and typeof(Drawing.new) == "function"
                if hasDrawing then
                    if not VehicleDrawings[player] then
                        local d = Drawing.new("Text")
                        d.Center = true
                        d.Outline = true
                        d.Color = Color3.new(1, 1, 1)
                        d.Size = 16
                        d.Visible = false
                        VehicleDrawings[player] = d
                    end
                    
                    local d = VehicleDrawings[player]
                    local ESP_Global = getgenv().ExunysDeveloperESP
                    local espProps = ESP_Global and ESP_Global.Properties and ESP_Global.Properties.ESP
                    local showVehicle = espProps and espProps.DisplayVehicle
                    local espOn = ESP_Global and ESP_Global.Settings and ESP_Global.Settings.Enabled

                    if showVehicle and espOn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local vName = GetPlayerVehicle(player)
                        if vName then
                            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position - Vector3.new(0, 4, 0))
                            if onScreen then
                                d.Text = "[" .. vName .. "]"
                                d.Position = Vector2.new(pos.X, pos.Y)
                                d.Visible = true
                            else
                                d.Visible = false
                            end
                        else
                            d.Visible = false
                        end
                    else
                        if d then d.Visible = false end
                    end
                end
            end
        end
    end)
end)

local sounds = {
    ["RIFK7"] = "rbxassetid://9102080552",
    ["Bubble"] = "rbxassetid://9102092728",
    ["Minecraft"] = "rbxassetid://5869422451",
    ["Cod"] = "rbxassetid://160432334",
    ["Bameware"] = "rbxassetid://6565367558",
    ["Neverlose"] = "rbxassetid://6565370984",
    ["Gamesense"] = "rbxassetid://4817809188",
    ["Rust"] = "rbxassetid://6565371338",
}

local hitSound = Instance.new("Sound")
hitSound.Volume = 3
hitSound.Parent = SoundService

local HitSoundBox = GeneralTab:AddRightTabbox("HitSound") do
    local Main = HitSoundBox:AddTab("HitSound [beta]")

    Main:AddToggle("HitSoundEnabled", {Text = "Enable HitSound", Default = false})

    Main:AddDropdown("HitSoundSelect", {
        Values = {"RIFK7","Bubble","Minecraft","Cod","Bameware","Neverlose","Gamesense","Rust"},
        Default = "Neverlose",
        Text = "HitSound",
        Tooltip = "Choose sound"
    }):OnChanged(function()
        local id = sounds[Options.HitSoundSelect.Value]
        if id then
            hitSound.SoundId = id
        end
    end)
end

hitSound.SoundId = sounds[Options.HitSoundSelect.Value]

local soundPool = {}
local soundIndex = 1

local function getNextSound()
    if soundIndex > #soundPool then
        local s = hitSound:Clone()
        s.Parent = workspace
        s.Looped = false
        table.insert(soundPool, s)
    end
    local s = soundPool[soundIndex]
    soundIndex = soundIndex + 1
    return s
end

local function playHitSound()
    local s = getNextSound()
    s:Stop()
    s:Play()
end

local function trackPlayer(plr)
    if plr == LocalPlayer then return end

    plr.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid", 10)
        if not hum then return end

        local lastHealth = hum.Health

        hum.HealthChanged:Connect(function(newHp)
            if Toggles.HitSoundEnabled.Value then
                local closestPart, closestPlayer = getClosestPlayer()
                if closestPart and closestPlayer and closestPlayer == plr then
                    if newHp < lastHealth then
                        playHitSound()
                    end
                    if lastHealth > 0 and newHp <= 0 then
                        playHitSound()
                    end
                end
            end
            lastHealth = newHp
        end)
    end)
end

for _, plr in ipairs(Players:GetPlayers()) do
    trackPlayer(plr)
end
Players.PlayerAdded:Connect(trackPlayer)

RunService.RenderStepped:Connect(function()
    if Toggles.silentAimEnabled and Toggles.silentAimEnabled.Value then
        local closestPart = getClosestPlayer()
        ScriptState.ClosestHitPart = closestPart
    else
        ScriptState.ClosestHitPart = nil
    end
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method, Arguments = getnamecallmethod(), {...}
    local self, chance = Arguments[1], CalculateChance(SilentAimSettings.HitChance)

    local BlockedMethods = SilentAimSettings.BlockedMethods or {}
    if Method == "Destroy" and self == Client then
        return
    end
    if BlockedMethods[Method] then
        return
    end

    local function getIgnoredList()
        if Method == "Raycast" then
            local params = Arguments[4]
            if typeof(params) == "RaycastParams" then
                return params.FilterDescendantsInstances
            end
        elseif Method == "FindPartOnRayWithIgnoreList" then
            return Arguments[3]
        end
    end

    local function getOriginalOrigin()
        if Method == "Raycast" then
            return Arguments[2]
        end

        if Method == "FindPartOnRayWithIgnoreList" or Method == "FindPartOnRayWithWhitelist" or Method == "FindPartOnRay" or Method == "findPartOnRay" then
            local ray = Arguments[2]
            if typeof(ray) == "Ray" then
                return ray.Origin
            end
        end

        return nil
    end

    local allowedFireCall = true
    if SilentAimSettings.CheckForFireFunc and (Method == "FindPartOnRay" or Method == "findPartOnRay" or Method == "FindPartOnRayWithWhitelist" or Method == "FindPartOnRayWithIgnoreList" or Method == "Raycast" or Method == "ViewportPointToRay" or Method == "ScreenPointToRay") then
        local trace = tostring(debug.traceback()):lower()
        if trace:find("bullet") or trace:find("gun") or trace:find("fire") then
            allowedFireCall = true
        else
            return oldNamecall(...)
        end
    end

    if Toggles.silentAimEnabled and Toggles.silentAimEnabled.Value and self == workspace and not checkcaller() and chance and allowedFireCall then
        local HitPart = ScriptState.ClosestHitPart or getClosestPlayer()
        
        if not HitPart then
            return oldNamecall(...)
        end

        if HitPart then
            local ignoredList = getIgnoredList()
            local originOptions = SilentAimSettings.Origin
            local includeOptions = SilentAimSettings.Include
            local originalOrigin = getOriginalOrigin()

            if originalOrigin and originOptions and next(originOptions) then
                local matchesOrigin = false
                if isSelectionActive(originOptions, "Camera") and originalOrigin == Camera.CFrame.p then
                    matchesOrigin = true
                end

                if not matchesOrigin then
                    return oldNamecall(...)
                end
            end

            if ignoredList and includeOptions and next(includeOptions) then
                if isSelectionActive(includeOptions, "Camera") and not table.find(ignoredList, Camera) then
                    return oldNamecall(...)
                end

                local character = LocalPlayer.Character
                if character and isSelectionActive(includeOptions, "Character") and not table.find(ignoredList, character) then
                    return oldNamecall(...)
                end
            end

            local function computeRay(origin)
                local adjustedOrigin = origin
                if SilentAimSettings.BulletTP then
                    adjustedOrigin = (HitPart.CFrame * CFrame.new(0, 0, 1)).p
                end

                local multiplier = SilentAimSettings.MultiplyUnitBy or 1000
                local direction = getDirection(adjustedOrigin, HitPart.Position) * multiplier
                return adjustedOrigin, direction
            end

            if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                    local Origin, Direction = computeRay(Arguments[2].Origin)
                    Arguments[2] = Ray.new(Origin, Direction)
                    return oldNamecall(unpack(Arguments))
                end
            elseif Method == "FindPartOnRayWithWhitelist" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
                    local Origin, Direction = computeRay(Arguments[2].Origin)
                    Arguments[2] = Ray.new(Origin, Direction)
                    return oldNamecall(unpack(Arguments))
                end
            elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and SilentAimSettings.SilentAimMethod:lower() == Method:lower() then
                if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
                    local Origin, Direction = computeRay(Arguments[2].Origin)
                    Arguments[2] = Ray.new(Origin, Direction)
                    return oldNamecall(unpack(Arguments))
                end
            elseif Method == "Raycast" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                    local Origin, Direction = computeRay(Arguments[2])
                    Arguments[2], Arguments[3] = Origin, Direction
                    return oldNamecall(unpack(Arguments))
                end
            elseif Method == "ViewportPointToRay" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.ViewportPointToRay) then
                    local Origin = Camera.CFrame.p
                    local NewOrigin, Direction = computeRay(Origin)
                    return Ray.new(NewOrigin, Direction)
                end
            elseif Method == "ScreenPointToRay" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.ScreenPointToRay) then
                    local Origin = Camera.CFrame.p
                    local NewOrigin, Direction = computeRay(Origin)
                    return Ray.new(NewOrigin, Direction)
                end
            elseif Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == "CounterBlox" then
                local Origin, Direction = computeRay(Arguments[2].Origin)
                Arguments[2] = Ray.new(Origin, Direction)
                return oldNamecall(unpack(Arguments))
            end
        end
    end

    return oldNamecall(...)
end))

local worldbox = VisualsTab:AddRightGroupbox("World")

local lighting = Services.Lighting
ScriptState.lockedTime, ScriptState.fovValue, ScriptState.nebulaEnabled = 12, 70, false
local originalAmbient, originalOutdoorAmbient = lighting.Ambient, lighting.OutdoorAmbient
local originalFogStart, originalFogEnd, originalFogColor = lighting.FogStart, lighting.FogEnd, lighting.FogColor
local nebulaThemeColor = Color3.fromRGB(173, 216, 230)

worldbox:AddSlider("world_time", {
    Text = "Clock Time", Default = 12, Min = 0, Max = 24, Rounding = 1,
    Callback = function(v)
        ScriptState.lockedTime = v
        if ScriptState.lockTimeEnabled then
            lighting.ClockTime = v
        end
    end
})

local oldNewIndex
oldNewIndex = hookmetamethod(game, "__newindex", function(self, property, value)
    if not checkcaller() and self == lighting and property == "ClockTime" then
        if ScriptState.lockTimeEnabled then
            value = ScriptState.lockedTime
        end
    end
    return oldNewIndex(self, property, value)
end)

worldbox:AddSlider("fov_slider", {
    Text = "FOV", Default = 70, Min = 30, Max = 120, Rounding = 2,
    Callback = function(v) ScriptState.fovValue = v end,
})

worldbox:AddToggle("lock_time_toggle", {
    Text = "Lock Time",
    Default = false,
    Callback = function(v)
        ScriptState.lockTimeEnabled = v
        if v then
            lighting.ClockTime = ScriptState.lockedTime
        end
    end
})

worldbox:AddToggle("fov_toggle", {
    Text = "FOV Change", Default = false,
    Callback = function(state) ScriptState.fovEnabled = state end,
})

RunService.RenderStepped:Connect(function()
    if ScriptState.fovEnabled then
        Camera.FieldOfView = ScriptState.fovValue
    end
end)

worldbox:AddToggle("nebula_theme", {
    Text = "Nebula Theme", Default = false,
    Callback = function(state)
        ScriptState.nebulaEnabled = state
        if state then
            local b = Instance.new("BloomEffect", lighting) b.Intensity, b.Size, b.Threshold, b.Name = 0.7, 24, 1, "NebulaBloom"
            local c = Instance.new("ColorCorrectionEffect", lighting) c.Saturation, c.Contrast, c.TintColor, c.Name = 0.5, 0.2, nebulaThemeColor, "NebulaColorCorrection"
            local a = Instance.new("Atmosphere", lighting) a.Density, a.Offset, a.Glare, a.Haze, a.Color, a.Decay, a.Name = 0.4, 0.25, 1, 2, nebulaThemeColor, Color3.fromRGB(25, 25, 112), "NebulaAtmosphere"
            lighting.Ambient, lighting.OutdoorAmbient = nebulaThemeColor, nebulaThemeColor
            lighting.FogStart, lighting.FogEnd = 100, 500
            lighting.FogColor = nebulaThemeColor
        else
            for _, v in pairs({"NebulaBloom", "NebulaColorCorrection", "NebulaAtmosphere"}) do
                local obj = lighting:FindFirstChild(v) if obj then obj:Destroy() end
            end
            lighting.Ambient, lighting.OutdoorAmbient = originalAmbient, originalOutdoorAmbient
            lighting.FogStart, lighting.FogEnd = originalFogStart, originalFogEnd
            lighting.FogColor = originalFogColor
        end
    end,
}):AddColorPicker("nebula_color_picker", {
    Text = "Nebula Color", Default = Color3.fromRGB(173, 216, 230),
    Callback = function(c)
        nebulaThemeColor = c
        if ScriptState.nebulaEnabled then
            local nc = lighting:FindFirstChild("NebulaColorCorrection") if nc then nc.TintColor = c end
            local na = lighting:FindFirstChild("NebulaAtmosphere") if na then na.Color = c end
            lighting.Ambient, lighting.OutdoorAmbient = c, c
            lighting.FogColor = c
        end
    end,
})

local Lighting = Services.Lighting
local Visuals = {}
local Skyboxes = {}

function Visuals:NewSky(Data)
    local Name = Data.Name
    Skyboxes[Name] = {
        SkyboxBk = Data.SkyboxBk,
        SkyboxDn = Data.SkyboxDn,
        SkyboxFt = Data.SkyboxFt,
        SkyboxLf = Data.SkyboxLf,
        SkyboxRt = Data.SkyboxRt,
        SkyboxUp = Data.SkyboxUp,
        MoonTextureId = Data.Moon or "rbxasset://sky/moon.jpg",
        SunTextureId = Data.Sun or "rbxasset://sky/sun.jpg"
    }
end

function Visuals:SwitchSkybox(Name)
    local OldSky = Lighting:FindFirstChildOfClass("Sky")
    if OldSky then OldSky:Destroy() end

    local Sky = Instance.new("Sky", Lighting)
    for Index, Value in pairs(Skyboxes[Name]) do
        Sky[Index] = Value
    end
end

if Lighting:FindFirstChildOfClass("Sky") then
    local OldSky = Lighting:FindFirstChildOfClass("Sky")
    Visuals:NewSky({
        Name = "Game's Default Sky",
        SkyboxBk = OldSky.SkyboxBk,
        SkyboxDn = OldSky.SkyboxDn,
        SkyboxFt = OldSky.SkyboxFt,
        SkyboxLf = OldSky.SkyboxLf,
        SkyboxRt = OldSky.SkyboxRt,
        SkyboxUp = OldSky.SkyboxUp
    })
end

Visuals:NewSky({
    Name = "Sunset",
    SkyboxBk = "rbxassetid://600830446",
    SkyboxDn = "rbxassetid://600831635",
    SkyboxFt = "rbxassetid://600832720",
    SkyboxLf = "rbxassetid://600886090",
    SkyboxRt = "rbxassetid://600833862",
    SkyboxUp = "rbxassetid://600835177"
})

Visuals:NewSky({
    Name = "Arctic",
    SkyboxBk = "http://www.roblox.com/asset/?id=225469390",
    SkyboxDn = "http://www.roblox.com/asset/?id=225469395",
    SkyboxFt = "http://www.roblox.com/asset/?id=225469403",
    SkyboxLf = "http://www.roblox.com/asset/?id=225469450",
    SkyboxRt = "http://www.roblox.com/asset/?id=225469471",
    SkyboxUp = "http://www.roblox.com/asset/?id=225469481"
})

Visuals:NewSky({
    Name = "Space",
    SkyboxBk = "http://www.roblox.com/asset/?id=166509999",
    SkyboxDn = "http://www.roblox.com/asset/?id=166510057",
    SkyboxFt = "http://www.roblox.com/asset/?id=166510116",
    SkyboxLf = "http://www.roblox.com/asset/?id=166510092",
    SkyboxRt = "http://www.roblox.com/asset/?id=166510131",
    SkyboxUp = "http://www.roblox.com/asset/?id=166510114"
})

Visuals:NewSky({
    Name = "Roblox Default",
    SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex",
    SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex",
    SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex",
    SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex",
    SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex",
    SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
})

Visuals:NewSky({
    Name = "Red Night",
    SkyboxBk = "http://www.roblox.com/Asset/?ID=401664839";
    SkyboxDn = "http://www.roblox.com/Asset/?ID=401664862";
    SkyboxFt = "http://www.roblox.com/Asset/?ID=401664960";
    SkyboxLf = "http://www.roblox.com/Asset/?ID=401664881";
    SkyboxRt = "http://www.roblox.com/Asset/?ID=401664901";
    SkyboxUp = "http://www.roblox.com/Asset/?ID=401664936";
})

Visuals:NewSky({
    Name = "Deep Space",
    SkyboxBk = "http://www.roblox.com/asset/?id=149397692";
    SkyboxDn = "http://www.roblox.com/asset/?id=149397686";
    SkyboxFt = "http://www.roblox.com/asset/?id=149397697";
    SkyboxLf = "http://www.roblox.com/asset/?id=149397684";
    SkyboxRt = "http://www.roblox.com/asset/?id=149397688";
    SkyboxUp = "http://www.roblox.com/asset/?id=149397702";
})

Visuals:NewSky({
    Name = "Pink Skies",
    SkyboxBk = "http://www.roblox.com/asset/?id=151165214";
    SkyboxDn = "http://www.roblox.com/asset/?id=151165197";
    SkyboxFt = "http://www.roblox.com/asset/?id=151165224";
    SkyboxLf = "http://www.roblox.com/asset/?id=151165191";
    SkyboxRt = "http://www.roblox.com/asset/?id=151165206";
    SkyboxUp = "http://www.roblox.com/asset/?id=151165227";
})

Visuals:NewSky({
    Name = "Purple Sunset",
    SkyboxBk = "rbxassetid://264908339";
    SkyboxDn = "rbxassetid://264907909";
    SkyboxFt = "rbxassetid://264909420";
    SkyboxLf = "rbxassetid://264909758";
    SkyboxRt = "rbxassetid://264908886";
    SkyboxUp = "rbxassetid://264907379";
})

Visuals:NewSky({
    Name = "Blue Night",
    SkyboxBk = "http://www.roblox.com/Asset/?ID=12064107";
    SkyboxDn = "http://www.roblox.com/Asset/?ID=12064152";
    SkyboxFt = "http://www.roblox.com/Asset/?ID=12064121";
    SkyboxLf = "http://www.roblox.com/Asset/?ID=12063984";
    SkyboxRt = "http://www.roblox.com/Asset/?ID=12064115";
    SkyboxUp = "http://www.roblox.com/Asset/?ID=12064131";
})

Visuals:NewSky({
    Name = "Blossom Daylight",
    SkyboxBk = "http://www.roblox.com/asset/?id=271042516";
    SkyboxDn = "http://www.roblox.com/asset/?id=271077243";
    SkyboxFt = "http://www.roblox.com/asset/?id=271042556";
    SkyboxLf = "http://www.roblox.com/asset/?id=271042310";
    SkyboxRt = "http://www.roblox.com/asset/?id=271042467";
    SkyboxUp = "http://www.roblox.com/asset/?id=271077958";
})

Visuals:NewSky({
    Name = "Blue Nebula",
    SkyboxBk = "http://www.roblox.com/asset?id=135207744";
    SkyboxDn = "http://www.roblox.com/asset?id=135207662";
    SkyboxFt = "http://www.roblox.com/asset?id=135207770";
    SkyboxLf = "http://www.roblox.com/asset?id=135207615";
    SkyboxRt = "http://www.roblox.com/asset?id=135207695";
    SkyboxUp = "http://www.roblox.com/asset?id=135207794";
})

Visuals:NewSky({
    Name = "Blue Planet",
    SkyboxBk = "rbxassetid://218955819";
    SkyboxDn = "rbxassetid://218953419";
    SkyboxFt = "rbxassetid://218954524";
    SkyboxLf = "rbxassetid://218958493";
    SkyboxRt = "rbxassetid://218957134";
    SkyboxUp = "rbxassetid://218950090";
})

Visuals:NewSky({
    Name = "Deep Space",
    SkyboxBk = "http://www.roblox.com/asset/?id=159248188";
    SkyboxDn = "http://www.roblox.com/asset/?id=159248183";
    SkyboxFt = "http://www.roblox.com/asset/?id=159248187";
    SkyboxLf = "http://www.roblox.com/asset/?id=159248173";
    SkyboxRt = "http://www.roblox.com/asset/?id=159248192";
    SkyboxUp = "http://www.roblox.com/asset/?id=159248176";
})

local SkyboxNames = {}
for Name, _ in pairs(Skyboxes) do
    table.insert(SkyboxNames, Name)
end

local worldbox = VisualsTab:AddRightGroupbox("SkyBox")
local SkyboxDropdown = worldbox:AddDropdown("SkyboxSelector", {
    AllowNull = false,
    Text = "Select Skybox",
    Default = "Game's Default Sky",
    Values = SkyboxNames
}):OnChanged(function(SelectedSkybox)
    if Skyboxes[SelectedSkybox] then
        Visuals:SwitchSkybox(SelectedSkybox)
    end
end)

local VisualsEx = VisualsTab:AddLeftGroupbox("ESP")

if not _G.ExunysESPLoaded then
    pcall(function() 
     loadstring(game:HttpGet("https://raw.githubusercontent.com/anmultv1234/FinalRound/refs/heads/main/ExLib.lua"))()
    end)
end

local ESP = getgenv().ExunysDeveloperESP
if not ESP then
    ESP = {
        Settings = {},
        Properties = {
            ESP = { DisplayVehicle = true },
            Tracer = {},
            HeadDot = {},
            Box = {},
            HealthBar = {},
            Crosshair = { CenterDot = {} }
        },
        DeveloperSettings = {}
    }
    getgenv().ExunysDeveloperESP = ESP
end

local function ensurePath(path)
    local ref = ESP
    for index = 1, #path - 1 do
        local key = path[index]
        if type(ref[key]) ~= "table" then
            ref[key] = {}
        end
        ref = ref[key]
    end
    return ref, path[#path]
end

local function getProperty(path)
    local ref = ESP
    for index = 1, #path do
        if not ref then return nil end
        ref = ref[path[index]]
    end
    return ref
end

local function updateProperty(path, value)
    local ref, key = ensurePath(path)
    if ref and key then
        ref[key] = value
    end
end

local function makeId(path, suffix)
    local id = table.concat(path, "_")
    if suffix then
        id = id .. "_" .. suffix
    end
    return id
end

local function refreshESPConfiguration()
    if ESP and ESP.UpdateConfiguration then
        pcall(function()
            ESP.UpdateConfiguration(ESP.DeveloperSettings, ESP.Settings, ESP.Properties)
        end)
    end
end

local function refreshChams()
    if UpdateAllChams then
        pcall(UpdateAllChams)
    end
end

local function addDefinitionControls(group, definitions)
    for _, def in ipairs(definitions) do
        local getValue = def.Get or function()
            return getProperty(def.Path)
        end

        local setValue = def.Set or function(value)
            updateProperty(def.Path, value)
        end

        local id = def.Id or makeId(def.Path, def.Suffix)

        if def.Type == "toggle" then
            group:AddToggle(id, {
                Text = def.Name,
                Default = def.Default ~= nil and def.Default or (getValue() or false),
                Callback = function(val)
                    setValue(val)
                    if def.OnChange then def.OnChange(val) end
                end
            })
        elseif def.Type == "slider" then
            group:AddSlider(id, {
                Text = def.Name,
                Min = def.Min,
                Max = def.Max,
                Rounding = def.Rounding or 1,
                Default = getValue() or def.Default or def.Min or 0,
                Callback = function(val)
                    setValue(val)
                    if def.OnChange then def.OnChange(val) end
                end
            })
        elseif def.Type == "color" then
            local label = group:AddLabel(def.Name)
            label:AddColorPicker(id, {
                Default = getValue() or def.Default or Color3.new(1, 1, 1),
                Callback = function(val)
                    setValue(val)
                    if def.OnChange then def.OnChange(val) end
                end
            })
        elseif def.Type == "dropdown" then
            local values = def.Values
            if not values and def.Map then
                values = {}
                for option in pairs(def.Map) do
                    table.insert(values, option)
                end
                table.sort(values)
            end

            local current = getValue()
            if def.Map then
                local mapped
                for option, mappedValue in pairs(def.Map) do
                    if mappedValue == current then
                        mapped = option
                        break
                    end
                end
                current = mapped
            end

            local dropdown = group:AddDropdown(id, {
                AllowNull = false,
                Text = def.Name,
                Values = values,
                Default = current or def.Default or (values and values[1])
            })

            dropdown:OnChanged(function(value)
                local finalValue = def.Map and def.Map[value] or value
                setValue(finalValue)
                if def.OnChange then def.OnChange(finalValue, value) end
            end)
        elseif def.Type == "input" then
            group:AddInput(id, {
                Text = def.Name,
                Default = tostring(getValue() or def.Default or ""),
                Numeric = def.Numeric,
                Finished = def.Finished,
                Placeholder = def.Placeholder,
                Callback = function(val)
                    local finalValue = def.Numeric and tonumber(val) or val
                    setValue(finalValue)
                    if def.OnChange then def.OnChange(finalValue) end
                end
            })
        end
    end
end

VisualsEx:AddToggle("espEnabled", {
    Text = "Enable ESP",
    Default = ESP.Settings and ESP.Settings.Enabled or false,
    Callback = function(value)
        if value and ESP and not ESP.Loaded and ESP.Load then
            pcall(function()
                ESP:Load()
            end)
        end

        updateProperty({"Settings", "Enabled"}, value)
        refreshESPConfiguration()
    end
})

local DrawingFonts = Drawing and Drawing.Fonts
local fontMap = {
    Plex = DrawingFonts and DrawingFonts.Plex or "Plex",
    System = DrawingFonts and DrawingFonts.System or "System",
    UI = DrawingFonts and DrawingFonts.UI or "UI",
    Monospace = DrawingFonts and DrawingFonts.Monospace or "Monospace"
}
local fontValues = {"Plex", "System", "UI", "Monospace"}

local tracerPositionMap = {Bottom = 1, Center = 2, Mouse = 3}
local tracerPositions = {"Bottom", "Center", "Mouse"}

local healthBarPositionMap = {Top = 1, Bottom = 2, Left = 3, Right = 4}
local healthBarPositions = {"Top", "Bottom", "Left", "Right"}

local ESPSettingsGroup = VisualsTab:AddRightGroupbox("ESP Settings")
addDefinitionControls(ESPSettingsGroup, {
    {Type = "toggle", Name = "Parts Only", Path = {"Settings", "PartsOnly"}},
    {Type = "toggle", Name = "Team Check", Path = {"Settings", "TeamCheck"}, OnChange = function()
        refreshESPConfiguration()
        refreshChams()
    end},
    {Type = "toggle", Name = "Alive Check", Path = {"Settings", "AliveCheck"}, OnChange = refreshESPConfiguration},
    {Type = "toggle", Name = "Enable Team Colors", Path = {"Settings", "EnableTeamColors"}, OnChange = function()
        refreshESPConfiguration()
        refreshChams()
    end},
    {Type = "toggle", Name = "Entity ESP", Path = {"Settings", "EntityESP"}}
})

local DeveloperSettingsGroup = VisualsTab:AddRightGroupbox("ESP Developer")
addDefinitionControls(DeveloperSettingsGroup, {
    {Type = "toggle", Name = "Unwrap On Character Absence", Path = {"DeveloperSettings", "UnwrapOnCharacterAbsence"}, OnChange = refreshESPConfiguration},
    {Type = "dropdown", Name = "Update Mode", Path = {"DeveloperSettings", "UpdateMode"}, Values = {"RenderStepped", "Heartbeat", "Stepped"}, OnChange = refreshESPConfiguration},
    {Type = "dropdown", Name = "Team Check Option", Path = {"DeveloperSettings", "TeamCheckOption"}, Values = {"TeamColor", "Team"}, OnChange = refreshESPConfiguration},
    {Type = "slider", Name = "Rainbow Speed", Path = {"DeveloperSettings", "RainbowSpeed"}, Min = 0.1, Max = 10, Rounding = 1, OnChange = refreshESPConfiguration},
    {Type = "slider", Name = "Width Boundary", Path = {"DeveloperSettings", "WidthBoundary"}, Min = 0.5, Max = 5, Rounding = 2, OnChange = refreshESPConfiguration},
    {Type = "input", Name = "Config Path", Path = {"DeveloperSettings", "Path"}}
})

local ESPVisualGroup = VisualsTab:AddLeftGroupbox("ESP Text")
addDefinitionControls(ESPVisualGroup, {
    {Type = "toggle", Name = "Enabled", Path = {"Properties", "ESP", "Enabled"}},
    {Type = "toggle", Name = "Rainbow Color", Path = {"Properties", "ESP", "RainbowColor"}},
    {Type = "toggle", Name = "Rainbow Outline", Path = {"Properties", "ESP", "RainbowOutlineColor"}},
    {Type = "slider", Name = "Offset", Path = {"Properties", "ESP", "Offset"}, Min = 0, Max = 50, Rounding = 0},
    {Type = "color", Name = "Color", Path = {"Properties", "ESP", "Color"}},
    {Type = "slider", Name = "Transparency", Path = {"Properties", "ESP", "Transparency"}, Min = 0, Max = 1, Rounding = 2},
    {Type = "slider", Name = "Size", Path = {"Properties", "ESP", "Size"}, Min = 10, Max = 30, Rounding = 0},
    {Type = "dropdown", Name = "Font", Path = {"Properties", "ESP", "Font"}, Values = fontValues, Map = fontMap, OnChange = refreshESPConfiguration},
    {Type = "color", Name = "Outline Color", Path = {"Properties", "ESP", "OutlineColor"}},
    {Type = "toggle", Name = "Outline", Path = {"Properties", "ESP", "Outline"}},
    {Type = "toggle", Name = "Display Distance", Path = {"Properties", "ESP", "DisplayDistance"}},
    {Type = "toggle", Name = "Display Health", Path = {"Properties", "ESP", "DisplayHealth"}},
    {Type = "toggle", Name = "Display Name", Path = {"Properties", "ESP", "DisplayName"}},
    {Type = "toggle", Name = "Display DisplayName", Path = {"Properties", "ESP", "DisplayDisplayName"}},
    {Type = "toggle", Name = "Display Tool", Path = {"Properties", "ESP", "DisplayTool"}},
    {Type = "toggle", Name = "Display Vehicle", Path = {"Properties", "ESP", "DisplayVehicle"}, Default = true}
})

local TracerGroup = VisualsTab:AddRightGroupbox("ESP Tracer")
addDefinitionControls(TracerGroup, {
    {Type = "toggle", Name = "Enabled", Path = {"Properties", "Tracer", "Enabled"}},
    {Type = "toggle", Name = "Rainbow Color", Path = {"Properties", "Tracer", "RainbowColor"}},
    {Type = "toggle", Name = "Rainbow Outline", Path = {"Properties", "Tracer", "RainbowOutlineColor"}},
    {Type = "dropdown", Name = "Position", Path = {"Properties", "Tracer", "Position"}, Values = tracerPositions, Map = tracerPositionMap},
    {Type = "slider", Name = "Transparency", Path = {"Properties", "Tracer", "Transparency"}, Min = 0, Max = 1, Rounding = 2},
    {Type = "slider", Name = "Thickness", Path = {"Properties", "Tracer", "Thickness"}, Min = 0, Max = 5, Rounding = 2},
    {Type = "color", Name = "Color", Path = {"Properties", "Tracer", "Color"}},
    {Type = "toggle", Name = "Outline", Path = {"Properties", "Tracer", "Outline"}},
    {Type = "color", Name = "Outline Color", Path = {"Properties", "Tracer", "OutlineColor"}}
})

local HeadDotGroup = VisualsTab:AddLeftGroupbox("ESP Head Dot")
addDefinitionControls(HeadDotGroup, {
    {Type = "toggle", Name = "Enabled", Path = {"Properties", "HeadDot", "Enabled"}},
    {Type = "toggle", Name = "Rainbow Color", Path = {"Properties", "HeadDot", "RainbowColor"}},
    {Type = "toggle", Name = "Rainbow Outline", Path = {"Properties", "HeadDot", "RainbowOutlineColor"}},
    {Type = "color", Name = "Color", Path = {"Properties", "HeadDot", "Color"}},
    {Type = "slider", Name = "Transparency", Path = {"Properties", "HeadDot", "Transparency"}, Min = 0, Max = 1, Rounding = 2},
    {Type = "slider", Name = "Thickness", Path = {"Properties", "HeadDot", "Thickness"}, Min = 0, Max = 5, Rounding = 2},
    {Type = "slider", Name = "Num Sides", Path = {"Properties", "HeadDot", "NumSides"}, Min = 3, Max = 60, Rounding = 0},
    {Type = "toggle", Name = "Filled", Path = {"Properties", "HeadDot", "Filled"}},
    {Type = "color", Name = "Outline Color", Path = {"Properties", "HeadDot", "OutlineColor"}},
    {Type = "toggle", Name = "Outline", Path = {"Properties", "HeadDot", "Outline"}}
})

local BoxGroup = VisualsTab:AddRightGroupbox("ESP Box")
addDefinitionControls(BoxGroup, {
    {Type = "toggle", Name = "Enabled", Path = {"Properties", "Box", "Enabled"}},
    {Type = "toggle", Name = "Rainbow Color", Path = {"Properties", "Box", "RainbowColor"}},
    {Type = "toggle", Name = "Rainbow Outline", Path = {"Properties", "Box", "RainbowOutlineColor"}},
    {Type = "color", Name = "Color", Path = {"Properties", "Box", "Color"}},
    {Type = "slider", Name = "Transparency", Path = {"Properties", "Box", "Transparency"}, Min = 0, Max = 1, Rounding = 2},
    {Type = "slider", Name = "Thickness", Path = {"Properties", "Box", "Thickness"}, Min = 0, Max = 5, Rounding = 2},
    {Type = "toggle", Name = "Filled", Path = {"Properties", "Box", "Filled"}},
    {Type = "color", Name = "Outline Color", Path = {"Properties", "Box", "OutlineColor"}},
    {Type = "toggle", Name = "Outline", Path = {"Properties", "Box", "Outline"}}
})

local HealthBarGroup = VisualsTab:AddLeftGroupbox("ESP Health Bar")
addDefinitionControls(HealthBarGroup, {
    {Type = "toggle", Name = "Enabled", Path = {"Properties", "HealthBar", "Enabled"}},
    {Type = "toggle", Name = "Rainbow Outline", Path = {"Properties", "HealthBar", "RainbowOutlineColor"}},
    {Type = "slider", Name = "Offset", Path = {"Properties", "HealthBar", "Offset"}, Min = 0, Max = 20, Rounding = 0},
    {Type = "slider", Name = "Blue", Path = {"Properties", "HealthBar", "Blue"}, Min = 0, Max = 255, Rounding = 0},
    {Type = "dropdown", Name = "Position", Path = {"Properties", "HealthBar", "Position"}, Values = healthBarPositions, Map = healthBarPositionMap},
    {Type = "slider", Name = "Thickness", Path = {"Properties", "HealthBar", "Thickness"}, Min = 0, Max = 5, Rounding = 2},
    {Type = "slider", Name = "Transparency", Path = {"Properties", "HealthBar", "Transparency"}, Min = 0, Max = 1, Rounding = 2},
    {Type = "color", Name = "Outline Color", Path = {"Properties", "HealthBar", "OutlineColor"}},
    {Type = "toggle", Name = "Outline", Path = {"Properties", "HealthBar", "Outline"}}
})

updateProperty({"Properties", "Crosshair", "Enabled"}, false)
updateProperty({"Properties", "Crosshair", "CenterDot", "Enabled"}, false)
refreshESPConfiguration()
local originalProperties = {}

local function HSVToRGB(h, s, v)
    local c = v * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = v - c
    local r, g, b = 0, 0, 0

    if h < 60 then r, g, b = c, x, 0
    elseif h < 120 then r, g, b = x, c, 0
    elseif h < 180 then r, g, b = 0, c, x
    elseif h < 240 then r, g, b = 0, x, c
    elseif h < 300 then r, g, b = x, 0, c
    else r, g, b = c, 0, x end

    return Color3.new(r + m, g + m, b + m)
end

local function applyChams(char)
    if not char then return end
    originalProperties = {}
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            originalProperties[part] = {
                Color = part.Color,
                Material = part.Material
            }
            part.Material = Enum.Material.ForceField
            part.Color = ScriptState.SelfChamsColor
        end
    end
end

local function restoreChams()
    for part, props in pairs(originalProperties) do
        if part and part.Parent then
            part.Color = props.Color
            part.Material = props.Material
        end
    end
    originalProperties = {}
end

local function updateChams()
    if not ScriptState.SelfChamsEnabled then return end
    for part, _ in pairs(originalProperties) do
        if part and part.Parent then
            if ScriptState.RainbowChamsEnabled then
                local hue = (tick() * 120) % 360
                part.Color = HSVToRGB(hue, 1, 1)
            else
                part.Color = ScriptState.SelfChamsColor
            end
        end
    end
end

RunService.RenderStepped:Connect(updateChams)

LocalPlayer.CharacterAdded:Connect(function(char)
    if ScriptState.SelfChamsEnabled then
        task.wait(1)
        applyChams(char)
    end
end)

VisualsEx:AddToggle("selfChamsEnabled", {
    Text = "Self Chams",
    Default = false,
    Callback = function(val)
        ScriptState.SelfChamsEnabled = val
        if val then
            if LocalPlayer.Character then
                applyChams(LocalPlayer.Character)
            end
        else
            restoreChams()
        end
    end
})

VisualsEx:AddToggle("rainbowChams", {
    Text = "Rainbow Chams",
    Default = false,
    Callback = function(val)
        ScriptState.RainbowChamsEnabled = val
    end
})

VisualsEx:AddLabel("Self Chams Color"):AddColorPicker("selfChamsColor", {
    Default = ScriptState.SelfChamsColor,
    Callback = function(val)
        ScriptState.SelfChamsColor = val
    end
})

local ChamsOccludedColor = {Color3.fromRGB(128, 0, 128), 0.7}
local ChamsVisibleColor = {Color3.fromRGB(255, 0, 255), 0.3}

local AdornmentsCache = {}
local IgnoreNames = {["HumanoidRootPart"] = true}

local function CreateAdornment(part, isHead, vis)
    local adorn
    if isHead then
        adorn = Instance.new("CylinderHandleAdornment")
        adorn.Height = vis == 1 and 0.87 or 1.02
        adorn.Radius = vis == 1 and 0.5 or 0.65
    else
        adorn = Instance.new("BoxHandleAdornment")
        local offset = vis == 1 and -0.05 or 0.05
        adorn.Size = part.Size + Vector3.new(offset, offset, offset)
    end
    adorn.Adornee = part
    adorn.Parent = part
    adorn.ZIndex = vis == 1 and 2 or 1
    adorn.AlwaysOnTop = vis == 1
    adorn.Visible = false
    return adorn
end

local function IsEnemy(player)
    if ESP and ESP.Settings and ESP.Settings.TeamCheck then
        return player.Team ~= LocalPlayer.Team
    end
    return true
end

local function ApplyChams(player)
    if player ~= LocalPlayer and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and not IgnoreNames[part.Name] then
                if not AdornmentsCache[part] then
                    AdornmentsCache[part] = {
                        CreateAdornment(part, part.Name=="Head", 1),
                        CreateAdornment(part, part.Name=="Head", 2)
                    }
                end
                local ad = AdornmentsCache[part]
                local visible = ScriptState.ChamsEnabled and IsEnemy(player)

                ad[1].Visible = visible
                ad[1].Color3 = ChamsOccludedColor[1]
                ad[1].Transparency = ChamsOccludedColor[2]

                ad[2].Visible = visible
                ad[2].AlwaysOnTop = true
                ad[2].ZIndex = 9e9
                ad[2].Color3 = ChamsVisibleColor[1]
                ad[2].Transparency = ChamsVisibleColor[2]
            end
        end
    end
end

local function UpdateAllChams()
    for _, player in pairs(Players:GetPlayers()) do
        ApplyChams(player)
    end
end

local function TrackPlayer(player)
    player:GetPropertyChangedSignal("Team"):Connect(function()
        if player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if AdornmentsCache[part] then
                    for _, ad in pairs(AdornmentsCache[part]) do
                        ad.Visible = ScriptState.ChamsEnabled and IsEnemy(player)
                    end
                end
            end
        end
    end)
end

Players.PlayerAdded:Connect(TrackPlayer)
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        TrackPlayer(plr)
    end
end

RunService.RenderStepped:Connect(UpdateAllChams)

VisualsEx:AddToggle("chamsEnabled", {
    Text = "Chams",
    Default = ScriptState.ChamsEnabled,
    Callback = function(val)
        ScriptState.ChamsEnabled = val
        for part, ad in pairs(AdornmentsCache) do
            ad[1].Visible = val
            ad[2].Visible = val
        end
    end
})

VisualsEx:AddLabel("Chams Occluded Color"):AddColorPicker("chamsOccludedColor", {
    Default = ChamsOccludedColor[1],
    Callback = function(val)
        ChamsOccludedColor[1] = val
    end
})

VisualsEx:AddLabel("Chams Visible Color"):AddColorPicker("chamsVisibleColor", {
    Default = ChamsVisibleColor[1],
    Callback = function(val)
        ChamsVisibleColor[1] = val
    end
})

VisualsEx:AddSlider("chamsOccludedTransparency", {
    Text = "Occluded Transparency",
    Default = ChamsOccludedColor[2],
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(val)
        ChamsOccludedColor[2] = val
    end
})

VisualsEx:AddSlider("chamsVisibleTransparency", {
    Text = "Visible Transparency",
    Default = ChamsVisibleColor[2],
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(val)
        ChamsVisibleColor[2] = val
    end
})

local humanoid = nil

frabox:AddToggle("speedEnabled", {
    Text = "Speed Toggle",
    Default = false,
    Tooltip = "It makes you go fast.",
    Callback = function(value)
        ScriptState.isSpeedActive = value
    end
}):AddKeyPicker("speedToggleKey", {
    Default = "None",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Speed Toggle Key",
    Tooltip = "CFrame keybind.",
    Callback = function(value)
        ScriptState.isSpeedActive = value
    end
})

frabox:AddSlider("cframespeed", {
    Text = "CFrame Multiplier",
    Default = 1,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Tooltip = "The CFrame speed.",
    Callback = function(value)
        ScriptState.Cmultiplier = value
    end,
})

frabox:AddToggle("flyEnabled", {
    Text = "CFly Toggle",
    Default = false,
    Tooltip = "Toggle CFrame Fly functionality.",
    Callback = function(value)
        ScriptState.isFlyActive = value
    end
}):AddKeyPicker("flyToggleKey", {
    Default = "None",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "CFly Toggle Key",
    Tooltip = "CFrame Fly keybind.",
    Callback = function(value)
        ScriptState.isFlyActive = value
    end
})

frabox:AddSlider("flySpeed", {
    Text = "CFly Speed",
    Default = 1,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Tooltip = "The CFrame Fly speed.",
    Callback = function(value)
        ScriptState.flySpeed = value
    end,
})

frabox:AddToggle("noClipEnabled", {
    Text = "NoClip Toggle",
    Default = false,
    Tooltip = "Enable or disable NoClip.",
    Callback = function(value)
        ScriptState.isNoClipActive = value
    end
}):AddKeyPicker("noClipToggleKey", {
    Default = "None",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "NoClip Toggle Key",
    Tooltip = "Keybind to toggle NoClip.",
    Callback = function(value)
        ScriptState.isNoClipActive = value
    end
})

getgenv().WeaponOnHands = getgenv().WeaponOnHands or false
getgenv().WeaponModifyMethod = getgenv().WeaponModifyMethod or "Attribute"

local function findSettingsModuleForWeapon(weapon, property)
    if not (weapon and weapon:IsA("Tool")) then
        return nil
    end

    local function moduleSupportsProperty(moduleScript)
        local success, module = pcall(require, moduleScript)
        if success and type(module) == "table" and module[property] ~= nil then
            return true
        end
        return false
    end

    for _, moduleScript in ipairs(weapon:GetDescendants()) do
        if moduleScript:IsA("ModuleScript") and moduleSupportsProperty(moduleScript) then
            return moduleScript
        end
    end

    local weaponName = weapon.Name
    local searchFolders = {}

    local configurations = ReplicatedStorage:FindFirstChild("Configurations")
    if configurations then
        table.insert(searchFolders, configurations)
    end

    local acsFolder = ReplicatedStorage:FindFirstChild("ACS_Guns", true)
    if acsFolder then
        table.insert(searchFolders, acsFolder)
    end

    table.insert(searchFolders, ReplicatedStorage)

    for _, container in ipairs(searchFolders) do
        if typeof(container) == "Instance" then
            local candidate = container:FindFirstChild(weaponName, true)
            if candidate then
                if candidate:IsA("ModuleScript") and moduleSupportsProperty(candidate) then
                    return candidate
                end

                for _, moduleScript in ipairs(candidate:GetDescendants()) do
                    if moduleScript:IsA("ModuleScript") and moduleSupportsProperty(moduleScript) then
                        return moduleScript
                    end
                end
            end
        end
    end

    return nil
end

local function applyGunSettings(weapon, property, value)
    if not (weapon and weapon:IsA("Tool")) then return end

    if property == "Mode" then
        weapon:SetAttribute("Mode", value)
        local settingsModule = findSettingsModuleForWeapon(weapon, "Mode")

        if settingsModule then
            local success, module = pcall(require, settingsModule)
            if success and type(module) == "table" then
                module.Mode = value
                if module.CurrentFireMode then module.CurrentFireMode = value end

                -- FireModes 서브테이블 동기화 (표시/판정용)
                if type(module.FireModes) == "table" then
                    for key in pairs(module.FireModes) do
                        module.FireModes[key] = false
                    end
                    if module.FireModes[value] ~= nil then
                        module.FireModes[value] = true
                    end
                end

                -- ⭐ 핵심: 서버에 새 Settings 스냅샷을 재전송하기 위한 강제 재장착
                local character = weapon.Parent
                if character and character:FindFirstChildOfClass("Humanoid") then
                    local humanoid = character.Humanoid
                    humanoid:UnequipTools()
                    task.wait(0.15)
                    humanoid:EquipTool(weapon)
                end
            end
        end

        for _, scr in ipairs(weapon:GetDescendants()) do
            if scr:IsA("LocalScript") or scr:IsA("Script") then
                pcall(function()
                    local env = getsenv(scr)
                    if env then
                        env.Mode = value
                        env.FireMode = value
                        if env.CurrentMode then env.CurrentMode = value end
                        if env.CurrentFireMode then env.CurrentFireMode = value end
                    end
                end)
            end
        end

        local character = LocalPlayer.Character
        if character and weapon.Parent == character then
            local backup = weapon.Parent
            weapon.Parent = LocalPlayer.Backpack
            task.wait(0.1)
            weapon.Parent = backup
        end
    else
        if (getgenv().WeaponModifyMethod or "Attribute") == "Attribute" then
            pcall(function() weapon:SetAttribute(property, value) end)
        else
            local settingsModule = findSettingsModuleForWeapon(weapon, property)
            if settingsModule then
                local success, module = pcall(require, settingsModule)
                if success and type(module) == "table" then
                    module[property] = value
                end
            end
        end
    end
end

local function modifyWeaponSettings(property, value)
    local player = Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local character = player.Character or player.CharacterAdded:Wait()

    local function processWeapon(weapon)
        if not (weapon and weapon:IsA("Tool")) then
            return
        end
        applyGunSettings(weapon, property, value)
    end

    local handledEquippedWeapon = false

    if getgenv().WeaponOnHands then
        local toolInHand = character:FindFirstChildOfClass("Tool")
        if toolInHand then
            processWeapon(toolInHand)
            handledEquippedWeapon = true
        end
    end

    if not handledEquippedWeapon then
        for _, item in ipairs(backpack:GetChildren()) do
            processWeapon(item)
        end

        local equippedTool = character:FindFirstChildOfClass("Tool")
        if equippedTool and equippedTool.Parent ~= backpack then
            processWeapon(equippedTool)
        end
    end
end

ACSEngineBox:AddToggle("WeaponOnHands", {
    Text = "Weapon In Hands",
    Default = false,
    Tooltip = "Apply changes only to the weapon in hands if enabled.",
    Callback = function(value)
        getgenv().WeaponOnHands = value
    end
})

ACSEngineBox:AddDropdown("WeaponModifyMethod", {
    Text = "Weapon Modify Method",
    Default = "Attribute",
    Values = {"Attribute", "Require"},
    Tooltip = "Choose how to modify weapon settings",
    Callback = function(value)
        getgenv().WeaponModifyMethod = value
    end
})

ACSEngineBox:AddButton('INF AMMO', function()
    modifyWeaponSettings("Ammo", math.huge)
end)

ACSEngineBox:AddButton('NO RECOIL | NO SPREAD', function()
    if getgenv().WeaponModifyMethod == "Attribute" then
        modifyWeaponSettings("VRecoil", Vector2.new(0, 0))
        modifyWeaponSettings("HRecoil", Vector2.new(0, 0))
    else
        modifyWeaponSettings("VRecoil", {0, 0})
        modifyWeaponSettings("HRecoil", {0, 0})
    end
    modifyWeaponSettings("MinSpread", 0)
    modifyWeaponSettings("MaxSpread", 0)
    modifyWeaponSettings("RecoilPunch", 0)
    modifyWeaponSettings("AimRecoilReduction", 0)
end)

ACSEngineBox:AddButton('INF BULLET DISTANCE', function()
    modifyWeaponSettings("Distance", 25000)
end)

ACSEngineBox:AddInput("BulletSpeedInput", {
    Text = "Bullet Speed",
    Default = "10000",
    Tooltip = "Set the bullet speed",
    Callback = function(value)
        getgenv().bulletSpeedValue = tonumber(value) or 10000
    end
})

ACSEngineBox:AddButton('CHANGE BULLET SPEED', function()
    modifyWeaponSettings("BSpeed", getgenv().bulletSpeedValue or 10000)
    modifyWeaponSettings("MuzzleVelocity", getgenv().bulletSpeedValue or 10000)
end)

local fireRateInput = ACSEngineBox:AddInput('FireRateInput', {
    Text = 'Enter Fire Rate',
    Default = '8888',
    Tooltip = 'Type the fire rate value you want to apply.',
})

ACSEngineBox:AddButton('CHANGE FIRE RATE', function()
    local rate = tonumber(fireRateInput.Value) or 8888
    modifyWeaponSettings("FireRate", rate)
    modifyWeaponSettings("ShootRate", rate)
end)

local bulletsInput = ACSEngineBox:AddInput('BulletsInput', {
    Text = 'Enter Bullets',
    Default = '50',
    Tooltip = 'Type the number of bullets you want to apply.',
    Numeric = true
})

ACSEngineBox:AddButton('MULTI BULLETS', function()
    local bulletsValue = tonumber(bulletsInput.Value) or 50
    modifyWeaponSettings("Bullets", bulletsValue)
end)

local inputField = ACSEngineBox:AddInput('FireModeInput', {
    Text = 'Enter Fire Mode',
    Default = 'Auto',
    Tooltip = 'Type the fire mode you want to apply.',
})

ACSEngineBox:AddButton('CHANGE FIRE MODE', function()
    modifyWeaponSettings("Mode", inputField.Value or 'Auto')
end)

local VehicleModBox = ExploitTab:AddRightGroupbox("Vehicle Modifier")

getgenv().AutoVehicleMod = false
getgenv().VehicleModifyMethod = "Attribute"
getgenv().VehicleFireRate = 8888
getgenv().VehicleBullets = 50
getgenv().VehicleSpeed = 10000

VehicleModBox:AddToggle("AutoVehicleModToggle", {
    Text = "Auto Mod Vehicle Weapons",
    Default = false,
    Callback = function(value)
        getgenv().AutoVehicleMod = value
    end
})

VehicleModBox:AddDropdown("VehicleModifyMethodDropdown", {
    Text = "Modify Method",
    Default = "Attribute",
    Values = {"Attribute", "Require"},
    Callback = function(value)
        getgenv().VehicleModifyMethod = value
    end
})

VehicleModBox:AddInput("VehicleFireRateInput", {
    Text = "Vehicle Fire Rate",
    Default = "8888",
    Numeric = true,
    Callback = function(value)
        getgenv().VehicleFireRate = tonumber(value) or 8888
    end
})

VehicleModBox:AddInput("VehicleBulletsInput", {
    Text = "Vehicle Bullets",
    Default = "50",
    Numeric = true,
    Callback = function(value)
        getgenv().VehicleBullets = tonumber(value) or 50
    end
})

VehicleModBox:AddInput("VehicleSpeedInput", {
    Text = "Vehicle Bullet Speed",
    Default = "10000",
    Numeric = true,
    Callback = function(value)
        getgenv().VehicleSpeed = tonumber(value) or 10000
    end
})

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function autoApplyGUIWeapon(gui)
    if not getgenv().AutoVehicleMod then return end
    task.wait(0.5)
    local method = getgenv().VehicleModifyMethod or "Attribute"
    local fireRate = getgenv().VehicleFireRate or 8888
    local bullets = getgenv().VehicleBullets or 50
    local speed = getgenv().VehicleSpeed or 10000

    for _, obj in ipairs(gui:GetDescendants()) do
        if method == "Require" and obj:IsA("ModuleScript") then
            local success, module = pcall(require, obj)
            if success and type(module) == "table" and (module.FireRate ~= nil or module.Ammo ~= nil or module.BulletSpread ~= nil or module.CooldownTime ~= nil) then
                module.Ammo = math.huge
                module.Bullets = bullets
                module.FireRate = fireRate
                module.ShootRate = fireRate
                module.MinSpread = 0
                module.MaxSpread = 0
                module.BulletSpread = 0
                module.RecoilPunch = 0
                module.AimRecoilReduction = 0
                module.CooldownTime = 0
                module.OverheatCount = 99999
                module.Distance = 25000
                module.BSpeed = speed
                module.MuzzleVelocity = speed
                module.VRecoil = {0, 0}
                module.HRecoil = {0, 0}
            end
        elseif method == "Attribute" then
            if obj:GetAttribute("FireRate") ~= nil or obj:GetAttribute("Ammo") ~= nil or obj:GetAttribute("BulletSpread") ~= nil or obj:GetAttribute("CooldownTime") ~= nil then
                pcall(function()
                    obj:SetAttribute("Ammo", 99999)
                    obj:SetAttribute("Bullets", bullets)
                    obj:SetAttribute("FireRate", fireRate)
                    obj:SetAttribute("ShootRate", fireRate)
                    obj:SetAttribute("MinSpread", 0)
                    obj:SetAttribute("MaxSpread", 0)
                    obj:SetAttribute("BulletSpread", 0)
                    obj:SetAttribute("CooldownTime", 0)
                    obj:SetAttribute("OverheatCount", 99999)
                    obj:SetAttribute("Distance", 25000)
                    obj:SetAttribute("BSpeed", speed)
                    obj:SetAttribute("MuzzleVelocity", speed)
                    obj:SetAttribute("VRecoil", Vector2.new(0, 0))
                    obj:SetAttribute("HRecoil", Vector2.new(0, 0))
                end)
            end
        end
    end
end

PlayerGui.ChildAdded:Connect(autoApplyGUIWeapon)

for _, gui in ipairs(PlayerGui:GetChildren()) do
    task.spawn(autoApplyGUIWeapon, gui)
end

local targetStrafe = GeneralTab:AddLeftGroupbox("Target Strafe")
ScriptState.strafeSpeed, ScriptState.strafeRadius = 50, 5
ScriptState.strafeMode, ScriptState.strafeTargetPart = "Horizontal", nil
local function startTargetStrafe()
    local targetPart = getClosestPlayer()
    ScriptState.strafeTargetPart = targetPart
    if ScriptState.strafeTargetPart and ScriptState.strafeTargetPart.Parent then
        ScriptState.originalCameraMode = Players.LocalPlayer.CameraMode
        Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
        local targetPos = ScriptState.strafeTargetPart.Position
        LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPos))
        Camera.CameraSubject = ScriptState.strafeTargetPart.Parent:FindFirstChild("Humanoid")
    end
end

local function strafeAroundTarget()
    if not (ScriptState.strafeTargetPart and ScriptState.strafeTargetPart.Parent) then return end
    local targetPos = ScriptState.strafeTargetPart.Position
    local angle = tick() * (ScriptState.strafeSpeed / 10)
    local offset = ScriptState.strafeMode == "Horizontal"
        and Vector3.new(math.cos(angle) * ScriptState.strafeRadius, 0, math.sin(angle) * ScriptState.strafeRadius)
        or Vector3.new(math.cos(angle) * ScriptState.strafeRadius, ScriptState.strafeRadius, math.sin(angle) * ScriptState.strafeRadius)
    LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPos + offset))
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, targetPos)
end

local function stopTargetStrafe()
    Players.LocalPlayer.CameraMode = ScriptState.originalCameraMode or Enum.CameraMode.Classic
    Camera.CameraSubject = LocalPlayer.Character.Humanoid
    ScriptState.strafeEnabled, ScriptState.strafeTargetPart = false, nil
end
targetStrafe:AddToggle("strafeToggle", {
    Text = "Target Strafe",
    Default = false,
    Tooltip = "Enable or disable Target Strafe.",
    Callback = function(value)
        ScriptState.strafeEnabled = value
        if ScriptState.strafeEnabled then
            startTargetStrafe()
        else
            stopTargetStrafe()
        end
    end
}):AddKeyPicker("strafeToggleKey", {
    Default = "None",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Target Strafe",
    Tooltip = "Key to toggle Target Strafe",
    Callback = function(value)
        ScriptState.strafeEnabled = value
        if ScriptState.strafeEnabled then
            startTargetStrafe()
        else
            stopTargetStrafe()
        end
    end
})

targetStrafe:AddDropdown("strafeModeDropdown", {
    AllowNull = false,
    Text = "Target Strafe Mode",
    Default = "Horizontal",
    Values = {"Horizontal", "UP"},
    Tooltip = "Select the strafing mode.",
    Callback = function(value) ScriptState.strafeMode = value end
})

targetStrafe:AddSlider("strafeRadiusSlider", {
    Text = "Strafe Radius",
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Tooltip = "Set the radius of movement around the target.",
    Callback = function(value) ScriptState.strafeRadius = value end
})

targetStrafe:AddSlider("strafeSpeedSlider", {
    Text = "Strafe Speed",
    Default = 50,
    Min = 10,
    Max = 200,
    Rounding = 1,
    Tooltip = "Set the speed of strafing around the target.",
    Callback = function(value) ScriptState.strafeSpeed = value end
})

local keybindWatchers = {}

local function registerKeybindWatcher(toggleId, keyPickerId, handlers)
    local toggle = Toggles[toggleId]
    local keyPicker = Options[keyPickerId]

    if not (toggle and keyPicker) then
        return
    end

    local watcher = {
        toggle = toggle,
        keyPicker = keyPicker,
        lastState = keyPicker:GetState(),
        lastMode = keyPicker.Mode,
        modeChanged = handlers and handlers.onModeChanged,
        stateChanged = handlers and handlers.onStateChanged,
    }

    if toggle.Value ~= watcher.lastState then
        toggle:SetValue(watcher.lastState)
    elseif watcher.stateChanged then
        watcher.stateChanged(watcher.lastState)
    end

    if watcher.modeChanged then
        watcher.modeChanged(watcher.lastMode)
    end

    keyPicker:OnChanged(function()
        watcher.lastMode = keyPicker.Mode
        watcher.lastState = keyPicker:GetState()
        if watcher.modeChanged then
            watcher.modeChanged(watcher.lastMode)
        end
        if toggle.Value ~= watcher.lastState then
            toggle:SetValue(watcher.lastState)
        elseif watcher.stateChanged then
            watcher.stateChanged(watcher.lastState)
        end
    end)

    table.insert(keybindWatchers, watcher)
end

registerKeybindWatcher("silentAimEnabled", "silentAim_KeyPicker", {
    onModeChanged = function(mode)
        SilentAimSettings.KeyMode = mode or "Toggle"
    end,
    onStateChanged = function(state)
        SilentAimSettings.Enabled = state
        if silentAimToggle.Value ~= state then
            silentAimToggle:SetValue(state)
        end
    end,
})

registerKeybindWatcher("speedEnabled", "speedToggleKey")
registerKeybindWatcher("flyEnabled", "flyToggleKey")
registerKeybindWatcher("noClipEnabled", "noClipToggleKey")
registerKeybindWatcher("strafeToggle", "strafeToggleKey")

RunService.RenderStepped:Connect(function()
    for _, watcher in ipairs(keybindWatchers) do
        local state = watcher.keyPicker:GetState()

        if watcher.keyPicker.Mode ~= watcher.lastMode then
            watcher.lastMode = watcher.keyPicker.Mode
            if watcher.modeChanged then
                watcher.modeChanged(watcher.lastMode)
            end
            state = watcher.keyPicker:GetState()
        end

        if state ~= watcher.lastState then
            watcher.lastState = state
            if watcher.toggle.Value ~= state then
                watcher.toggle:SetValue(state)
            elseif watcher.stateChanged then
                watcher.stateChanged(state)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if ScriptState.strafeEnabled then
        strafeAroundTarget()
    end
end)

task.spawn(function()
    while true do
        task.wait()

        if ScriptState.isSpeedActive or ScriptState.isFlyActive or ScriptState.isNoClipActive then
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")

            if character and rootPart then
                humanoid = character:FindFirstChild("Humanoid")

                if ScriptState.isSpeedActive and humanoid and humanoid.MoveDirection.Magnitude > 0 then
                    local moveDirection = humanoid.MoveDirection.Unit
                    rootPart.CFrame = rootPart.CFrame + moveDirection * ScriptState.Cmultiplier
                end

                if ScriptState.isFlyActive then
                    local flyDirection = Vector3.zero

                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        flyDirection = flyDirection + Camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        flyDirection = flyDirection - Camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        flyDirection = flyDirection - Camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        flyDirection = flyDirection + Camera.CFrame.RightVector
                    end

                    if flyDirection.Magnitude > 0 then
                        flyDirection = flyDirection.Unit
                    end

                    local newPosition = rootPart.Position + flyDirection * ScriptState.flySpeed
                    rootPart.CFrame = CFrame.new(newPosition)
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                end

                if ScriptState.isNoClipActive then
                    for _, v in pairs(character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end
    end
end)
