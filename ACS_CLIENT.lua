

-- Script Path: game:GetService("Workspace").GamingRaj30001.ACS_Client
-- Took 0.19s to decompile.
-- Executor: Delta (1.2.729.840)

local v_u_1 = game:GetService("Players")
game:GetService("RunService")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Workspace")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = require(script:WaitForChild("RiotShield"))
local v_u_8 = require(v5:WaitForChild("DebrisGobbler"))
local v_u_9 = game:GetService("HapticService")
local v_u_10 = game:GetService("GamepadService")
local v11 = require(v5:WaitForChild("Modules"):WaitForChild("Tables"))
local v_u_12 = v11.CamoTextures
local v_u_13 = v_u_3.CurrentCamera
local v_u_14 = game:GetService("SoundService"):WaitForChild("Main")
local v_u_15 = game:GetService("StarterPlayer").CameraMaxZoomDistance
local v_u_16 = v_u_3.Terrain
local v_u_17 = game:GetService("Players").LocalPlayer
repeat
    task.wait(0.05)
until v_u_17.Character
local v_u_18 = UDim2.new()
local v_u_19 = UDim2.new()
local v_u_20 = UDim2.new()
local v_u_21 = UDim2.new()
local v_u_22 = require(script:WaitForChild("Startup")).Initialize()
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v26 = v5:WaitForChild("ACS_Engine")
local v_u_27 = v26:WaitForChild("Events")
local v_u_28 = v26:WaitForChild("GunModels")
local v_u_29 = require(v26:WaitForChild("Modules"):WaitForChild("Utilities"))
local v_u_30 = require(v26:WaitForChild("Modules"):WaitForChild("SetupModule"))
local v_u_31 = require(v5:WaitForChild("Modules"):WaitForChild("Hitmarker"))
local v32 = require(v26:WaitForChild("Modules"):WaitForChild("Spring"))
local v_u_33 = require(v26.ServerConfigs:WaitForChild("Config"))
local v34 = v_u_3:WaitForChild("Game Systems"):WaitForChild("ACS_WorkSpace")
local v_u_35 = v5.Configurations.ACS_Guns
local v_u_36 = v_u_17:WaitForChild("SettingsFolder"):WaitForChild("bulletShells")
local v_u_37 = v_u_17:WaitForChild("SettingsFolder"):WaitForChild("objectHitmarker")
local v38 = require(v5:WaitForChild("Modules"):WaitForChild("Gun Sounds"))
local v_u_39 = v38.soundDistances
local v_u_40 = v38.CreateSound
local v_u_41 = require(script:WaitForChild("Sensitivity")).ChangeSensitivity
local v_u_42 = require(script:WaitForChild("SniperFocus"))
require(v5:WaitForChild("BulletFireSystem"):WaitForChild("DamageDisplay"))
local v_u_43 = v11.HelicopterNames
local v_u_44 = v11.PlaneNames
local v_u_45 = v11.UAVNames
local v_u_46 = nil
local v_u_47 = TweenInfo.new(0.3)
local v_u_48 = v_u_17.PlayerGui:WaitForChild("UI"):WaitForChild("Container"):WaitForChild("HUD"):WaitForChild("Menu"):WaitForChild("HUD")
local v_u_49 = {
    ["Left"] = v_u_48:WaitForChild("Left").Position,
    ["Right"] = v_u_48:WaitForChild("Right").Position
}
_G.GunEquipped = false
local v_u_50 = nil
local v_u_51 = nil
local v_u_52 = nil
v_u_17.CameraMode = Enum.CameraMode.Classic
local v_u_53 = v_u_17.Character
local v_u_54 = v_u_53:WaitForChild("Humanoid")
local v55 = v_u_17:GetMouse()
local v_u_56 = false
local v_u_57 = false
local v_u_58 = v_u_53:WaitForChild("Saude"):WaitForChild("Stances")
local v59 = v_u_58:WaitForChild("Correndo")
local v_u_60 = CFrame.new()
local v_u_61 = nil
local v_u_62 = nil
local v_u_63 = nil
local v_u_64 = nil
local v_u_65 = nil
local v_u_66 = nil
local v_u_67 = nil
local v_u_68 = nil
local v_u_69 = nil
local v_u_70 = nil
local v_u_71 = nil
local v_u_72 = 1
local v_u_73 = {}
local v_u_74 = false
local v_u_75 = time()
local v_u_76 = nil
local v_u_77 = v26:WaitForChild("HUD"):WaitForChild("StatusUI"):Clone()
v_u_77.Parent = v_u_17.PlayerGui
local v_u_78 = nil
local v_u_79 = v_u_77:WaitForChild("Crosshair")
local v_u_80 = 1
local v_u_81 = 0
local v_u_82 = false
local v_u_83 = false
local v_u_84 = true
local v_u_85 = false
local v_u_86 = false
local v_u_87 = false
local v_u_88 = nil
local v_u_89 = nil
local v_u_90 = nil
local v_u_91 = nil
local v_u_92 = false
local v_u_93 = false
local v_u_94 = false
local v_u_95 = 0
local v_u_96 = nil
local v_u_97 = nil
local v_u_98 = nil
local v_u_99 = nil
local v_u_100 = nil
local v_u_101 = nil
local v_u_102 = nil
local v_u_103 = nil
local v_u_104 = tick()
local v_u_105 = nil
local v_u_106 = tick()
local v_u_107 = 0
local v108 = v32.new((Vector3.new()))
local v_u_109 = v32.new((Vector3.new()))
local v_u_110 = v32.new((Vector3.new()))
local v_u_111 = 1
local v_u_112 = v_u_6:GetLastInputType()
v_u_110.s = 10
v_u_110.d = 1
v108.s = 10
v108.d = 0.15
v_u_109.s = 10
v_u_109.d = 1
local v_u_113 = 0.25
local v_u_114 = CFrame.new()
local v_u_115 = v_u_53:WaitForChild("Humanoid")
local v116 = v_u_53:WaitForChild("Torso")
local v_u_117 = v_u_53:WaitForChild("HumanoidRootPart")
local v_u_118 = v116:WaitForChild("Neck")
local v_u_119 = {}
local v_u_120 = {}
local v_u_121 = nil
local v_u_122 = v34:FindFirstChild("Server")
local v_u_123 = v34:FindFirstChild("Client")
local v_u_124 = {
    ["Ignorable"] = true,
    ["Ignore"] = true,
    ["Seat1"] = true,
    ["Seat2"] = true,
    ["Seat3"] = true,
    ["Seat4"] = true,
    ["Seat5"] = true,
    ["Seat6"] = true,
    ["DriveSeat"] = true,
    ["Armor"] = true,
    ["EShield"] = true,
    ["FL"] = true,
    ["FR"] = true,
    ["BB"] = true,
    ["BR"] = true,
    ["BL"] = true,
    ["Light"] = true,
    ["Gradient"] = true,
    ["AntiHelicopterField"] = true,
    ["HelicopterKillField"] = true
}
local v_u_125 = {
    "RPG",
    "Javelin",
    "Stinger",
    "Grenade Launcher"
}
local v_u_126 = {
    v_u_53,
    v_u_122,
    v_u_13,
    v_u_123
}
if v_u_17.Team.Name ~= "Loading" then
    v_u_13.CameraType = Enum.CameraType.Custom
    v_u_13.CameraSubject = v_u_115
    task.spawn(function()
        -- upvalues: (copy) v_u_3, (copy) v_u_17, (copy) v_u_13, (copy) v_u_15, (copy) v_u_6
        if v_u_3:WaitForChild("Tycoon"):WaitForChild("Tycoons"):WaitForChild(v_u_17.Team.Name):WaitForChild("Loaded").Value ~= false then
            v_u_13.FieldOfView = 70
            v_u_17.CameraMaxZoomDistance = v_u_15
            v_u_17.CameraMinZoomDistance = 0.5
            v_u_6.ModalEnabled = false
        end
    end)
end
local v_u_127 = {
    ["AimHide"] = v_u_2:Create(v_u_77.Effects.Aim, TweenInfo.new(0.3), {
        ["ImageTransparency"] = 1
    }),
    ["AimShow"] = v_u_2:Create(v_u_77.Effects.Aim, TweenInfo.new(0.75), {
        ["ImageTransparency"] = 0
    }),
    ["CrosshairHide"] = {
        v_u_2:Create(v_u_79:WaitForChild("Up"), TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 1
        }),
        v_u_2:Create(v_u_79:WaitForChild("Down"), TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 1
        }),
        v_u_2:Create(v_u_79:WaitForChild("Left"), TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 1
        }),
        v_u_2:Create(v_u_79:WaitForChild("Right"), TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 1
        }),
        v_u_2:Create(v_u_79:WaitForChild("Center"), TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["ImageTransparency"] = 1
        })
    },
    ["CrosshairShow"] = {
        v_u_2:Create(v_u_79.Up, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 0
        }),
        v_u_2:Create(v_u_79.Down, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 0
        }),
        v_u_2:Create(v_u_79.Left, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 0
        }),
        v_u_2:Create(v_u_79.Right, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["BackgroundTransparency"] = 0
        }),
        v_u_2:Create(v_u_79.Center, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            ["ImageTransparency"] = 0
        })
    }
}
v_u_6.MouseIconEnabled = true
local v_u_128 = nil
local v_u_129 = false
local v_u_130 = false
for _, v131 in v_u_28:GetChildren() do
    for _, v132 in v131:GetDescendants() do
        if v132.Name == "GlassLense" and v132:IsA("BasePart") then
            v132:SetAttribute("OGTransparency", v132.Transparency)
            for _, v133 in v132.Parent:GetDescendants() do
                if v133:IsA("Decal") and (v133.Name ~= "SecondaryCamo" and v133.Name ~= "PrimaryCamo") then
                    v133.Transparency = 1
                elseif v133:IsA("ImageLabel") then
                    v133.ImageTransparency = 1
                end
            end
        end
    end
end
for _, v134 in v5:WaitForChild("Attachments System"):WaitForChild("Attachments"):WaitForChild("Scopes"):GetChildren() do
    for _, v135 in v134:GetDescendants() do
        if v135.Name == "GlassLense" and v135:IsA("BasePart") then
            v135:SetAttribute("OGTransparency", v135.Transparency)
            for _, v136 in v135.Parent:GetDescendants() do
                if v136:IsA("Decal") and (v136.Name ~= "SecondaryCamo" and v136.Name ~= "PrimaryCamo") then
                    v136.Transparency = 1
                elseif v136:IsA("ImageLabel") then
                    v136.ImageTransparency = 1
                end
            end
        end
    end
end
local v137 = Instance.new("BindableEvent")
v137.Name = "PreventFallDamageBindableEvent"
v137.Parent = v_u_53
local function v_u_142(p138, p139, p140, p141) -- name: vibrateController
    -- upvalues: (ref) v_u_129, (copy) v_u_9
    if v_u_129 and p138 then
        v_u_9:SetMotor(p138.UserInputType, p139, p140)
        task.wait((math.clamp(p141, 0, 0.2)))
        v_u_9:SetMotor(p138.UserInputType, p139, 0)
    end
end
local function v_u_144() -- name: ResetWorkspace
    -- upvalues: (copy) v_u_122, (copy) v_u_123, (copy) v_u_16
    v_u_122:ClearAllChildren()
    v_u_123:ClearAllChildren()
    for _, v143 in v_u_16:GetChildren() do
        if v143.Name ~= "Clouds" then
            v143:Destroy()
        end
    end
end
v_u_53:GetAttributeChangedSignal("Wingsuit"):Connect(function()
    -- upvalues: (ref) v_u_87, (copy) v_u_53
    v_u_87 = v_u_53:GetAttribute("Wingsuit")
end)
v_u_144()
v_u_27.Hit.OnClientEvent:Connect(function(p145, p146, p147, p148, p149)
    -- upvalues: (copy) v_u_17, (copy) v_u_31
    if p145 ~= v_u_17 then
        v_u_31.HitEffect(p146, p147, p148, p149, v_u_17)
    end
end)
v_u_27.HeadRot.OnClientEvent:Connect(function(p150, p151)
    -- upvalues: (ref) v_u_112, (copy) v_u_17
    if v_u_112 == Enum.UserInputType.Touch then
        return
    elseif p150 and p150 ~= v_u_17 then
        if p150.Character and p150.Character:FindFirstChild("Head") then
            if p150.Character:FindFirstChild("HumanoidRootPart") and p150.Character.HumanoidRootPart.Anchored ~= true then
                local v152 = p150.Character.Torso:FindFirstChild("Neck")
                if v152 then
                    local v153 = v152.C1
                    for v154 = 0, 1, 0.07 do
                        v152.C1 = v153:Lerp(p151, v154)
                        task.wait()
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end)
v_u_27.SubToHeadrot:FireServer()
v_u_27.ServerGunAnim.OnClientEvent:Connect(function(p_u_155, p156, p157, p_u_158)
    -- upvalues: (copy) v_u_17, (copy) v_u_53, (copy) v_u_39, (copy) v_u_13, (copy) v_u_40, (copy) v_u_12, (copy) v_u_2
    if p_u_155 ~= v_u_17 then
        if not (p_u_155.Character:FindFirstChild("S" .. p_u_158.Name) and p_u_155.Character["S" .. p_u_158.Name]:FindFirstChild("Handle")) then
            return
        end
        pcall(function()
            -- upvalues: (copy) p_u_158, (ref) v_u_53, (copy) p_u_155, (ref) v_u_39, (ref) v_u_13, (ref) v_u_40
            if p_u_158.Parent == nil or p_u_158.Parent:FindFirstChild("S" .. p_u_158.Name) == nil then
                return
            else
                local v159 = p_u_158.Parent:FindFirstChild("S" .. p_u_158.Name)
                if v159 then
                    local v160 = (v_u_53.Torso.Position - p_u_155.Character.Torso.Position).Magnitude
                    if v159:FindFirstChild("Suppressor") then
                        if v_u_39.Suppressed.EchoMax + 40 >= v160 or v_u_13.CameraType == Enum.CameraType.Scriptable then
                            v_u_40(p_u_158, p_u_158.Parent.Torso, "Suppressed", "Server")
                        end
                    elseif v_u_39.Normal.EchoMax + 50 >= v160 or v_u_13.CameraType == Enum.CameraType.Scriptable then
                        v_u_40(p_u_158, p_u_158.Parent.Torso, "Normal", "Server")
                    end
                else
                    return
                end
            end
        end)
        if p_u_155.Character:FindFirstChild("S" .. p_u_158.Name) ~= nil and p_u_155.Character["S" .. p_u_158.Name]:FindFirstChild("SmokePart") ~= nil then
            local v_u_161 = p_u_155.Character["S" .. p_u_158.Name]:FindFirstChild("SmokePart")
            local v_u_162 = v_u_161:FindFirstChild("FlashFX[Flash]")
            local v_u_163 = v_u_161:FindFirstChild("Smoke")
            if not (v_u_162 and v_u_163) then
                return
            end
            local v164 = p_u_155:FindFirstChild("Attachments"):FindFirstChild(p_u_158.Name)
            local v165 = {}
            local v166
            if v164 then
                v166 = v164:GetAttribute("VFXUsing")
            else
                v166 = v164
            end
            if v166 then
                local v167 = v164:GetAttribute("Camo" .. v166)
                v165 = v167 and (v_u_12[v167].CustomVFX or {}) or v165
            end
            if v_u_162 and v165.FlashColor then
                v_u_162.Color = v165.FlashColor
            elseif v_u_162 then
                v_u_162.Color = ColorSequence.new(Color3.new(1, 1, 0.498039), Color3.new(1, 0.333333, 0))
            end
            if v_u_163 and v165.SmokeColor then
                v_u_163.Color = v165.SmokeColor
            elseif v_u_163 then
                v_u_163.Color = ColorSequence.new(Color3.new(1, 1, 1))
            end
            if p_u_155.Character["S" .. p_u_158.Name]:FindFirstChild("Flash Hider") then
                v_u_162.Rate = 150
            elseif v_u_161:FindFirstChild("FlashFX[Flash]") then
                v_u_162.Rate = 1000
            end
            v_u_162.Enabled = true
            v_u_163.Enabled = true
            task.delay(0.03333333333333333, function()
                -- upvalues: (copy) v_u_161, (copy) v_u_162, (copy) v_u_163
                if v_u_161 and (v_u_161:FindFirstChild("FlashFX[Flash]") and v_u_161:FindFirstChild("Smoke")) then
                    v_u_162.Enabled = false
                    v_u_163.Enabled = false
                end
            end)
        end
        if p_u_155.Character:FindFirstChild("AnimBase") ~= nil and p_u_155.Character.AnimBase:FindFirstChild("AnimBaseW") then
            local v168 = p_u_155.Character:WaitForChild("AnimBase"):WaitForChild("AnimBaseW")
            v_u_2:Create(v168, TweenInfo.new(p156), {
                ["C1"] = p157.ShootPos
            }):Play()
            task.wait(p156 * 2)
            v_u_2:Create(v168, TweenInfo.new(0.2), {
                ["C1"] = CFrame.new()
            }):Play()
        end
    end
end)
local function v_u_177(p169) -- name: Update_Gui
    -- upvalues: (ref) v_u_51, (ref) v_u_76, (ref) v_u_25, (ref) v_u_24, (copy) v_u_73, (ref) v_u_70, (copy) v_u_6, (ref) v_u_112, (ref) v_u_94
    if v_u_51.Mode == "RPG" then
        v_u_76.FireMode.Text = "Single-Shot"
    else
        v_u_76.FireMode.Text = v_u_51.Mode
    end
    v_u_76.GunName.Text = v_u_25.Name
    local v170 = v_u_24:GetAttribute("Ammo") or v_u_51.Ammo
    if not v_u_24:GetAttribute("Cooldown") then
        local v171 = v_u_76.AmmoText
        local v172 = v_u_73[v_u_24]
        local v173 = v170 + 1
        v171.Text = math.clamp(v172, 0, v173) .. " "
        v_u_76.AmmoTextSecondary.Text = "/ " .. v170
    end
    local v174 = v_u_76.BarBackground.Bar
    local v175 = UDim2.new
    local v176 = v_u_73[v_u_24] / v170
    v174.Size = v175(1, 0, math.clamp(v176, 0, 1), 0)
    if v_u_70.Value == true and v_u_73[v_u_24] > 0 then
        v_u_76.BarBackground.Bar.BackgroundColor3 = Color3.fromRGB(238, 254, 255)
        v_u_76.BarBackground.BackgroundColor3 = Color3.fromRGB(93, 93, 93)
        v_u_76.InfoText.Visible = false
    elseif v_u_70.Value == false and v_u_73[v_u_24] > 0 then
        v_u_76.BarBackground.Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        v_u_76.BarBackground.BackgroundColor3 = Color3.fromRGB(93, 52, 52)
        if v_u_6.GamepadEnabled then
            v_u_76.InfoText.Text = "Press " .. v_u_6:GetStringForKeyCode(Enum.KeyCode.ButtonY):gsub("Button", "")
            v_u_76.InfoText.Visible = true
            return
        end
        if v_u_112 ~= Enum.UserInputType.Touch then
            v_u_76.InfoText.Text = "Press F"
            v_u_76.InfoText.Visible = true
            return
        end
    elseif not v_u_94 then
        if v_u_51.Cooldown then
            v_u_76.AmmoText.Text = "Cooldown"
        elseif v_u_6.GamepadEnabled then
            v_u_76.InfoText.Text = "Press " .. v_u_6:GetStringForKeyCode(Enum.KeyCode.ButtonX):gsub("Button", "")
            v_u_76.InfoText.Visible = true
        elseif v_u_112 ~= Enum.UserInputType.Touch then
            v_u_76.InfoText.Text = "Press R"
            v_u_76.InfoText.Visible = true
        end
        if v_u_73[v_u_24] <= 0 and not p169 then
            reloadGun()
        end
    end
end
local v_u_178 = require(v5:WaitForChild("Attachments System"):WaitForChild("Welds"))
local function v_u_189(p179) -- name: Setup
    -- upvalues: (copy) v_u_120, (ref) v_u_85, (copy) v_u_53, (ref) v_u_24, (ref) v_u_25, (copy) v_u_28, (ref) v_u_50, (copy) v_u_35, (ref) v_u_51, (ref) v_u_52, (ref) v_u_72, (ref) v_u_68, (ref) v_u_69, (ref) v_u_61, (ref) v_u_62, (ref) v_u_63, (ref) v_u_64, (ref) v_u_65, (ref) v_u_66, (ref) v_u_67, (copy) v_u_73, (copy) v_u_48, (copy) v_u_49, (ref) v_u_70, (ref) v_u_121, (copy) v_u_177, (ref) v_u_71, (copy) v_u_27, (ref) v_u_102, (copy) v_u_13, (ref) v_u_100, (ref) v_u_101, (copy) v_u_22, (ref) v_u_103, (copy) v_u_178, (copy) v_u_17, (copy) v_u_29, (ref) v_u_98, (ref) v_u_99, (ref) v_u_97, (ref) v_u_96, (copy) v_u_30, (ref) v_u_56, (ref) v_u_104, (ref) v_u_112, (ref) v_u_90
    for _, v180 in pairs(v_u_120) do
        coroutine.close(v180)
    end
    table.clear(v_u_120)
    v_u_85 = false
    v_u_53:FindFirstChild("Torso")
    v_u_53:FindFirstChild("Head")
    v_u_53:FindFirstChild("HumanoidRootPart")
    v_u_24 = p179
    v_u_25 = v_u_28:WaitForChild(v_u_24.Name):Clone()
    v_u_50 = v_u_35[p179.Name]
    v_u_51 = require(v_u_50:WaitForChild("Settings"))
    v_u_52 = require(v_u_50:WaitForChild("Animations"))
    v_u_72 = v_u_51.AimSpeedMultiplier or 1
    if p179:GetAttribute("FireRate") then
        v_u_68 = 1 / (p179:GetAttribute("FireRate") / 60)
    else
        v_u_68 = 1 / (v_u_51.FireRate / 60)
    end
    v_u_69 = 1 / (v_u_51.BurstFireRate / 60)
    if p179:GetAttribute("VRecoil") then
        v_u_61 = math.random(p179:GetAttribute("VRecoil").X, p179:GetAttribute("VRecoil").Y) / 1000
    else
        v_u_61 = math.random(v_u_51.VRecoil[1], v_u_51.VRecoil[2]) / 1000
    end
    if p179:GetAttribute("HRecoil") then
        v_u_62 = math.random(p179:GetAttribute("HRecoil").X, p179:GetAttribute("HRecoil").Y) / 1000
    else
        v_u_62 = math.random(v_u_51.HRecoil[1], v_u_51.HRecoil[2]) / 1000
    end
    v_u_63 = v_u_51.VPunchBase
    v_u_64 = v_u_51.HPunchBase
    v_u_65 = v_u_51.DPunchBase
    v_u_66 = v_u_51.MinRecoilPower
    v_u_67 = p179:GetAttribute("MinSpread") or v_u_51.MinSpread
    if not v_u_73[p179] then
        v_u_73[p179] = v_u_50.Ammo.Value
    end
    v_u_48.Left:TweenPosition(UDim2.fromScale(-1.2, v_u_49.Left.Y.Scale), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
    v_u_48.Right:TweenPosition(UDim2.fromScale(1.2, v_u_49.Right.Y.Scale), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
    v_u_70 = v_u_50.Chambered
    v_u_121 = v_u_70.Changed:Connect(v_u_177)
    v_u_71 = v_u_50.Sens
    v_u_27.Equip:FireServer(v_u_24, v_u_51)
    v_u_102 = Instance.new("Model")
    v_u_102.Name = p179.Name
    v_u_102.Parent = v_u_13
    v_u_100 = Instance.new("Part")
    v_u_100.CastShadow = false
    v_u_100.FormFactor = "Custom"
    v_u_100.CanCollide = false
    v_u_100.Transparency = 1
    v_u_100.Anchored = true
    v_u_100.Name = "AnimBase"
    v_u_100.Massless = true
    v_u_100.Size = Vector3.new(0.1, 0.1, 0.1)
    v_u_100.Parent = v_u_102
    v_u_101 = Instance.new("Motor6D")
    v_u_101.Part0 = v_u_100
    v_u_101.Part1 = v_u_22
    v_u_101.Name = "AnimBaseW"
    v_u_100.Anchored = false
    v_u_101.Parent = v_u_100
    v_u_103 = Instance.new("Motor6D")
    v_u_103.Name = "Clone"
    v_u_103.Part0 = v_u_100
    v_u_103.Part1 = v_u_22
    v_u_103.Parent = v_u_100
    v_u_25.Parent = v_u_102
    v_u_178.AddAttachments(v_u_17, v_u_25)
    for _, v181 in v_u_25:GetDescendants() do
        if v181.Name ~= "ZoomScope" and (v181.Name ~= "PivotHolder" and (v181:IsA("BasePart") and v181.Name ~= "Handle")) then
            if v181.Name ~= "Bolt" and (v181.Name ~= "Lid" and (v181.Name ~= "Bolt2" and v181.Name ~= "Barrell Move")) then
                v_u_29.Weld(v181, v_u_25:WaitForChild("Handle"))
            end
            if v181.Name == "Bolt" or (v181.Name == "Slide" or v181.Name == "Barrell Move") then
                v_u_29.WeldComplex(v_u_25:WaitForChild("Handle"), v181, v181.Name)
            end
            if v181.Name == "Lid" then
                if v_u_25:FindFirstChild("LidHinge") then
                    v_u_29.Weld(v181, v_u_25:WaitForChild("LidHinge"))
                else
                    v_u_29.Weld(v181, v_u_25:WaitForChild("Handle"))
                end
            end
            if v181.Name == "Bolt2" then
                if v_u_25:FindFirstChild("Bolt") then
                    v_u_29.Weld(v181, v_u_25:WaitForChild("Bolt"))
                else
                    v_u_29.Weld(v181, v_u_25:WaitForChild("Handle"))
                end
            end
        end
    end
    for _, v182 in v_u_25:GetDescendants() do
        if v182:IsA("BasePart") and v182.Name ~= "Grip" then
            v182.Anchored = false
            v182.CanCollide = false
        end
    end
    v_u_178.MoveAim(v_u_17, v_u_25)
    v_u_178.MoveSmokePart(v_u_17, v_u_25)
    local v183, v184, v185, v186, v187, v188 = v_u_30(v_u_102, v_u_29, v_u_53, v_u_98, v_u_99, v_u_97, v_u_96, v_u_100, v_u_101, v_u_51, v_u_25)
    v_u_98 = v183
    v_u_99 = v184
    v_u_97 = v185
    v_u_96 = v186
    v_u_100 = v187
    v_u_101 = v188
    v_u_56 = true
    _G.GunEquipped = true
    v_u_104 = tick()
    if v_u_112 == Enum.UserInputType.Touch then
        v_u_90()
    end
end
local function v_u_219(_) -- name: Unset
    -- upvalues: (copy) v_u_42, (ref) v_u_24, (copy) v_u_53, (copy) v_u_27, (ref) v_u_51, (copy) v_u_120, (ref) v_u_121, (ref) v_u_102, (copy) v_u_48, (copy) v_u_49, (ref) v_u_56, (ref) v_u_93, (ref) v_u_85, (ref) v_u_86, (ref) v_u_94, (ref) v_u_83, (copy) v_u_41, (copy) v_u_115, (copy) v_u_3, (copy) v_u_17, (copy) v_u_6, (ref) v_u_105, (ref) v_u_112, (copy) v_u_13, (ref) v_u_80, (ref) v_u_95, (copy) v_u_127, (copy) v_u_79, (ref) v_u_76, (ref) v_u_78, (copy) v_u_77, (ref) v_u_119, (ref) v_u_91, (copy) v_u_7
    v_u_42:Stop()
    if v_u_24 then
        pcall(function()
            -- upvalues: (ref) v_u_24, (ref) v_u_53
            v_u_24:SetAttribute("Aiming", nil)
            if v_u_53:FindFirstChild("S" .. v_u_24.Name) then
                v_u_53["S" .. v_u_24.Name]:Destroy()
                if v_u_53:FindFirstChild("AnimBase") then
                    v_u_53.AnimBase:Destroy()
                end
            end
            local v190 = v_u_53:FindFirstChild("Torso")
            if v190 ~= nil then
                local v191 = v190:FindFirstChild("Right Shoulder")
                local v192 = v190:FindFirstChild("Left Shoulder")
                local v193 = v190:FindFirstChild("Neck")
                if v191 ~= nil then
                    v191.Part1 = v_u_53["Right Arm"]
                end
                if v192 ~= nil then
                    v192.Part1 = v_u_53["Left Arm"]
                end
                if v193 ~= nil then
                    v193.C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
                    v193.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
                end
            end
        end)
        v_u_27.Unequip:FireServer(v_u_24, v_u_51)
    end
    for _, v194 in pairs(v_u_120) do
        coroutine.close(v194)
    end
    table.clear(v_u_120)
    if v_u_121 then
        v_u_121:Disconnect()
    end
    if v_u_102 then
        v_u_102:Destroy()
    end
    v_u_48.Left:TweenPosition(v_u_49.Left, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
    v_u_48.Right:TweenPosition(v_u_49.Right, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
    v_u_56 = false
    _G.GunEquipped = false
    v_u_93 = false
    v_u_85 = false
    v_u_86 = false
    v_u_94 = false
    v_u_83 = false
    v_u_41(1)
    task.spawn(function()
        -- upvalues: (ref) v_u_115, (ref) v_u_3, (ref) v_u_17, (ref) v_u_6, (ref) v_u_105, (ref) v_u_112, (ref) v_u_41, (ref) v_u_13
        if v_u_115.Health <= 0 then
            for _, v195 in v_u_115:GetChildren() do
                if v195:IsA("ObjectValue") and (v195.Value and v195.Value:IsA("Player")) then
                    return
                end
            end
            if not v_u_115.SeatPart or v_u_115.SeatPart.Parent.Parent and (v_u_115.SeatPart.Parent.Parent.Name ~= "Turrets" and (v_u_115.SeatPart.Parent.Name ~= "Boxer CRV" and not v_u_3:FindFirstChild("CrosshairPart"))) or not v_u_17.PlayerGui:FindFirstChild("TurretGui") then
                v_u_17.CameraMode = Enum.CameraMode.Classic
                v_u_6.MouseIconEnabled = true
            end
            local v_u_196 = 15
            local v_u_197 = 70
            task.spawn(function()
                -- upvalues: (ref) v_u_105, (copy) v_u_196, (ref) v_u_112, (copy) v_u_197, (ref) v_u_41, (ref) v_u_13
                v_u_105 = v_u_105 and v_u_105 + 1 or 0
                local v198 = v_u_105
                local v199 = tick()
                local v200 = v_u_196 / 90
                local v201 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                local v202 = v_u_197
                local v203 = math.rad(v202) / 2
                local v204 = (math.tan(v203) / 0.7002075382097097 - 1) * v201 + 1
                v_u_41((math.clamp(v204, 0.04, 1)))
                while v_u_105 == v198 do
                    local v205 = tick() - v199
                    v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_197 - v_u_13.FieldOfView) * (v205 / v200)
                    task.wait()
                    if v200 < v205 then
                        break
                    end
                end
            end)
        else
            if not v_u_115.SeatPart or v_u_115.SeatPart.Parent.Parent and (v_u_115.SeatPart.Parent.Parent.Name ~= "Turrets" and (v_u_115.SeatPart.Parent.Name ~= "Boxer CRV" and not v_u_3:FindFirstChild("CrosshairPart"))) or not v_u_17.PlayerGui:FindFirstChild("TurretGui") then
                v_u_17.CameraMode = Enum.CameraMode.Classic
                v_u_6.MouseIconEnabled = true
            end
            local v_u_206 = 15
            local v_u_207 = 70
            task.spawn(function()
                -- upvalues: (ref) v_u_105, (copy) v_u_206, (ref) v_u_112, (copy) v_u_207, (ref) v_u_41, (ref) v_u_13
                v_u_105 = v_u_105 and v_u_105 + 1 or 0
                local v208 = v_u_105
                local v209 = tick()
                local v210 = v_u_206 / 90
                local v211 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                local v212 = v_u_207
                local v213 = math.rad(v212) / 2
                local v214 = (math.tan(v213) / 0.7002075382097097 - 1) * v211 + 1
                v_u_41((math.clamp(v214, 0.04, 1)))
                while v_u_105 == v208 do
                    local v215 = tick() - v209
                    v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_207 - v_u_13.FieldOfView) * (v215 / v210)
                    task.wait()
                    if v210 < v215 then
                        break
                    end
                end
            end)
        end
    end)
    v_u_80 = 1
    v_u_95 = 0
    v_u_127.AimHide:Play()
    if v_u_79 and v_u_79:FindFirstChild("Up") then
        for _, v216 in pairs(v_u_127.CrosshairHide) do
            v216:Play()
        end
    end
    if v_u_76 then
        v_u_76.Visible = false
        v_u_79.Visible = false
        v_u_78.Visible = false
        for _, v217 in v_u_77.CustomCrosshairs:GetChildren() do
            v217.Visible = false
        end
    end
    for _, v218 in pairs(v_u_119) do
        v218:disconnect()
    end
    v_u_119 = {}
    a = false
    d = false
    v_u_91()
    v_u_7.Disconnect()
end
local function v_u_220() -- name: Sprint
    -- upvalues: (ref) v_u_56, (ref) v_u_23, (ref) v_u_81, (ref) v_u_88, (ref) v_u_89, (ref) v_u_93, (ref) v_u_85, (ref) v_u_95
    if v_u_56 then
        if v_u_23 and v_u_81 > 0 then
            v_u_88 = false
            v_u_89 = false
            if v_u_93 then
                aimGun()
            end
            if not v_u_85 then
                v_u_95 = 3
                SprintAnim()
                return
            end
        elseif (not v_u_23 or v_u_81 == 0) and not v_u_85 then
            if v_u_93 then
                v_u_95 = 2
                IdleAnim()
                return
            end
            v_u_95 = 0
            IdleAnim()
        end
    end
end
v59.Changed:connect(function(p221)
    -- upvalues: (ref) v_u_23, (copy) v_u_220
    v_u_23 = p221
    v_u_220()
end)
local v222 = v5:WaitForChild("BulletFireSystem")
local v223 = v222:WaitForChild("BulletHit")
local v_u_224 = require(script:WaitForChild("FireModuleClient"))
local v225 = v222:WaitForChild("BulletFired")
local v_u_226 = v222:WaitForChild("FireGun")
local function v_u_247(p227) -- name: GetDir
    -- upvalues: (ref) v_u_25, (copy) v_u_53, (copy) v_u_13, (copy) v_u_3, (copy) v_u_224, (ref) v_u_81, (copy) v_u_58, (ref) v_u_51
    local v228 = v_u_25.SmokePart.CFrame.lookVector
    local v229 = v_u_25.SmokePart.CFrame
    local v230 = { v_u_53, v_u_25, v_u_13 }
    local v231 = 0
    while true do
        local v232 = RaycastParams.new()
        v232.FilterType = Enum.RaycastFilterType.Exclude
        v232.FilterDescendantsInstances = v230
        local v233 = v_u_3:Raycast(v_u_13.CFrame.Position, v_u_13.CFrame.LookVector * 500000, v232)
        if v233 and v_u_224.CanRayPierce(nil, v233) then
            local v234 = v233.Instance
            table.insert(v230, v234)
        end
        v231 = v231 + 1
        if v231 > 10 or not (v233 and v_u_224.CanRayPierce(nil, v233)) then
            if v233 then
                if (v233.Position - v229.Position).Magnitude > 10 then
                    v228 = (CFrame.lookAt(v233.Position, v233.Position + v_u_13.CFrame.LookVector).Position - v229.Position).Unit
                else
                    v228 = ((CFrame.lookAt(v233.Position, v233.Position + v_u_13.CFrame.LookVector) * CFrame.new(0, 0, -5)).Position - v229.Position).Unit
                end
            end
            local v235 = CFrame.Angles
            local v236 = -p227 - v_u_81 / v_u_58.Mobility.Value * v_u_51.WalkMultiplier
            local v237 = p227 + v_u_81 / v_u_58.Mobility.Value * v_u_51.WalkMultiplier
            local v238 = math.random(v236 * 1, v237 * 1) / 1 / 20
            local v239 = math.rad(v238)
            local v240 = -p227 - v_u_81 / v_u_58.Mobility.Value * v_u_51.WalkMultiplier
            local v241 = p227 + v_u_81 / v_u_58.Mobility.Value * v_u_51.WalkMultiplier
            local v242 = math.random(v240 * 1, v241 * 1) / 1 / 20
            local v243 = math.rad(v242)
            local v244 = -p227 - v_u_81 / v_u_58.Mobility.Value * v_u_51.WalkMultiplier
            local v245 = p227 + v_u_81 / v_u_58.Mobility.Value * v_u_51.WalkMultiplier
            local v246 = math.random(v244 * 1, v245 * 1) / 1 / 20
            return v235(v239, v243, (math.rad(v246))) * v228
        end
    end
end
function CastRay(p248) -- name: CastRay
    -- upvalues: (copy) v_u_53, (copy) v_u_13, (copy) v_u_117, (copy) v_u_224, (copy) v_u_17, (ref) v_u_25, (copy) v_u_226, (ref) v_u_92, (copy) v_u_14, (copy) v_u_8
    if p248 then
        local v249 = v_u_53:FindFirstChildOfClass("Tool")
        local v250 = v_u_13[v249.Name][v249.Name]
        local v251 = v250.SmokePart.CFrame:ToObjectSpace(v_u_117.CFrame).Z
        local v252 = v250.SmokePart.CFrame * CFrame.new(0, 0, v251 + 0.5)
        v_u_224.FireGun(v_u_17, p248, v249, v_u_25, v252.Position)
        v_u_226:FireServer(p248, v249, v_u_53:FindFirstChild("S" .. v249.Name), v252.Position, v_u_92)
        task.delay(math.random(4, 8) / 10, function()
            -- upvalues: (ref) v_u_14, (ref) v_u_17, (ref) v_u_8
            local v253 = Instance.new("Sound")
            v253.SoundId = "rbxassetid://325025387"
            v253.Volume = 0.5
            v253.PlaybackSpeed = math.random(30, 50) / 40
            v253.SoundGroup = v_u_14
            v253.Parent = v_u_17.PlayerGui
            v253:Play()
            v_u_8:AddItem(v253, v253.TimeLength + 0.5)
        end)
    end
end
v225.OnClientEvent:Connect(function(p254, p255, p256, p257, p258)
    -- upvalues: (copy) v_u_17, (copy) v_u_224
    if p254 ~= v_u_17 then
        v_u_224.FireGun(p254, p255, p256, p257, p258)
    end
end)
v223.OnClientEvent:Connect(function(p259, _, _)
    -- upvalues: (ref) v_u_56, (copy) v_u_79, (copy) v_u_17, (copy) v_u_2, (copy) v_u_37
    if v_u_56 == false or (v_u_79.Parent.Enabled == false or v_u_79.Visible == false) then
        return
    elseif p259 then
        local v260 = Instance.new("Sound")
        if math.random(1, 2) == 1 then
            v260.SoundId = "rbxassetid://8397760862"
        else
            v260.SoundId = "rbxassetid://8397760683"
        end
        v260.Parent = v_u_17.PlayerGui
        v260.Volume = 2
        v260.PlayOnRemove = true
        v260:Destroy()
        task.spawn(function()
            -- upvalues: (ref) v_u_79, (ref) v_u_2
            for _, v261 in v_u_79.HitMarker:GetChildren() do
                v_u_2:Create(v261, TweenInfo.new(0.3), {
                    ["BackgroundTransparency"] = 0
                }):Play()
            end
            task.wait(0.3)
            for _, v262 in v_u_79.HitMarker:GetChildren() do
                v_u_2:Create(v262, TweenInfo.new(0.3), {
                    ["BackgroundTransparency"] = 1
                }):Play()
            end
        end)
        return
    elseif v_u_37.Value ~= false then
        local v263 = Instance.new("Sound")
        if math.random(1, 2) == 1 then
            v263.SoundId = "rbxassetid://11387332687"
        else
            v263.SoundId = "rbxassetid://11387332597"
        end
        v263.Parent = v_u_17.PlayerGui
        v263.Volume = 0.2
        v263.PlaybackSpeed = 2
        v263.PlayOnRemove = true
        v263:Destroy()
        task.spawn(function()
            -- upvalues: (ref) v_u_79, (ref) v_u_2
            for _, v264 in v_u_79.ObjectHitMarker:GetChildren() do
                v_u_2:Create(v264, TweenInfo.new(0.2), {
                    ["BackgroundTransparency"] = 0
                }):Play()
            end
            task.wait(0.3)
            for _, v265 in v_u_79.ObjectHitMarker:GetChildren() do
                v_u_2:Create(v265, TweenInfo.new(0.2), {
                    ["BackgroundTransparency"] = 1
                }):Play()
            end
        end)
    end
end)
v_u_54.Running:Connect(function(p266)
    -- upvalues: (copy) v_u_115, (ref) v_u_81, (ref) v_u_56, (copy) v_u_220
    local v267 = v_u_115:GetState()
    if v267 == Enum.HumanoidStateType.FallingDown or (v267 == Enum.HumanoidStateType.Flying or (v267 == Enum.HumanoidStateType.Freefall or v267 == Enum.HumanoidStateType.PlatformStanding)) then
        v_u_81 = 0
    else
        v_u_81 = p266
    end
    if v_u_56 then
        v_u_220()
    end
end)
local function v_u_412() -- name: SlideEx
    -- upvalues: (ref) v_u_56, (ref) v_u_25, (ref) v_u_51, (ref) v_u_68, (copy) v_u_4, (copy) v_u_73, (ref) v_u_24, (copy) v_u_125, (ref) v_u_70, (copy) v_u_22, (ref) v_u_83
    if v_u_56 == false then
        return
    elseif v_u_25:FindFirstChild("Slide") then
        local v_u_268 = v_u_25.Handle:WaitForChild("Slide")
        local v_u_269 = CFrame.new(v_u_51.SlideExtend) * CFrame.Angles(0, 0, 0)
        local function v_u_272(p270)
            local v271 = math.rad(p270)
            return math.sin(v271)
        end
        local v_u_273 = 1 * (v_u_68 / 2)
        local v_u_274 = nil
        task.spawn(function()
            -- upvalues: (copy) v_u_268, (copy) v_u_273, (copy) v_u_269, (copy) v_u_274, (ref) v_u_4, (ref) v_u_56, (copy) v_u_272
            local v_u_275 = math.random(-1000000000, 1000000000)
            local v_u_276
            if v_u_268:findFirstChild("tweenCode") then
                v_u_276 = v_u_268.tweenCode
                v_u_276.Value = v_u_275
            else
                v_u_276 = Instance.new("IntValue")
                v_u_276.Name = "tweenCode"
                v_u_276.Value = v_u_275
                v_u_276.Parent = v_u_268
            end
            if v_u_273 <= 0 then
                if v_u_269 then
                    v_u_268.C0 = v_u_269
                end
                if v_u_274 then
                    v_u_268.C1 = v_u_274
                end
            else
                local v_u_277 = 1.5 / v_u_273
                local v_u_278 = v_u_268.C0
                local v_u_279 = v_u_268.C1
                local v_u_280 = 0
                local v_u_281 = nil
                local v_u_282 = true
                v_u_281 = v_u_4.Heartbeat:Connect(function(_)
                    -- upvalues: (ref) v_u_280, (copy) v_u_277, (ref) v_u_276, (copy) v_u_275, (ref) v_u_282, (ref) v_u_281, (ref) v_u_56, (ref) v_u_269, (ref) v_u_268, (copy) v_u_278, (ref) v_u_272, (ref) v_u_274, (copy) v_u_279
                    local v283 = v_u_280 + v_u_277
                    v_u_280 = v283 > 90 and 90 or v283
                    if v_u_276.Value ~= v_u_275 then
                        v_u_282 = false
                        v_u_281:Disconnect()
                    end
                    if not v_u_56 then
                        v_u_282 = false
                        v_u_281:Disconnect()
                    end
                    if v_u_269 then
                        v_u_268.C0 = v_u_278:Lerp(v_u_269, v_u_272(v_u_280))
                    end
                    if v_u_274 then
                        v_u_268.C1 = v_u_279:Lerp(v_u_274, v_u_272(v_u_280))
                    end
                    if v_u_280 == 90 then
                        v_u_282 = false
                        v_u_281:Disconnect()
                    end
                end)
                repeat
                    task.wait()
                until v_u_282 == false
            end
            if v_u_276.Value == v_u_275 then
                v_u_276:Destroy()
            end
        end)
        if v_u_51.MoveBolt == true then
            local v_u_284 = v_u_25.Handle:WaitForChild("Bolt")
            local v_u_285 = CFrame.new(v_u_51.BoltExtend) * CFrame.Angles(0, 0, 0)
            local function v_u_288(p286)
                local v287 = math.rad(p286)
                return math.sin(v287)
            end
            local v_u_289 = 1 * (v_u_68 / 2)
            local v_u_290 = nil
            task.spawn(function()
                -- upvalues: (copy) v_u_284, (copy) v_u_289, (copy) v_u_285, (copy) v_u_290, (ref) v_u_4, (ref) v_u_56, (copy) v_u_288
                local v_u_291 = math.random(-1000000000, 1000000000)
                local v_u_292
                if v_u_284:findFirstChild("tweenCode") then
                    v_u_292 = v_u_284.tweenCode
                    v_u_292.Value = v_u_291
                else
                    v_u_292 = Instance.new("IntValue")
                    v_u_292.Name = "tweenCode"
                    v_u_292.Value = v_u_291
                    v_u_292.Parent = v_u_284
                end
                if v_u_289 <= 0 then
                    if v_u_285 then
                        v_u_284.C0 = v_u_285
                    end
                    if v_u_290 then
                        v_u_284.C1 = v_u_290
                    end
                else
                    local v_u_293 = 1.5 / v_u_289
                    local v_u_294 = v_u_284.C0
                    local v_u_295 = v_u_284.C1
                    local v_u_296 = 0
                    local v_u_297 = nil
                    local v_u_298 = true
                    v_u_297 = v_u_4.Heartbeat:Connect(function(_)
                        -- upvalues: (ref) v_u_296, (copy) v_u_293, (ref) v_u_292, (copy) v_u_291, (ref) v_u_298, (ref) v_u_297, (ref) v_u_56, (ref) v_u_285, (ref) v_u_284, (copy) v_u_294, (ref) v_u_288, (ref) v_u_290, (copy) v_u_295
                        local v299 = v_u_296 + v_u_293
                        v_u_296 = v299 > 90 and 90 or v299
                        if v_u_292.Value ~= v_u_291 then
                            v_u_298 = false
                            v_u_297:Disconnect()
                        end
                        if not v_u_56 then
                            v_u_298 = false
                            v_u_297:Disconnect()
                        end
                        if v_u_285 then
                            v_u_284.C0 = v_u_294:Lerp(v_u_285, v_u_288(v_u_296))
                        end
                        if v_u_290 then
                            v_u_284.C1 = v_u_295:Lerp(v_u_290, v_u_288(v_u_296))
                        end
                        if v_u_296 == 90 then
                            v_u_298 = false
                            v_u_297:Disconnect()
                        end
                    end)
                    repeat
                        task.wait()
                    until v_u_298 == false
                end
                if v_u_292.Value == v_u_291 then
                    v_u_292:Destroy()
                end
            end)
        end
        if v_u_25.Name == "Barrett M82" then
            local v_u_300 = v_u_25.Handle:WaitForChild("Barrell Move")
            local v_u_301 = CFrame.new(0, 0, 0.8) * CFrame.Angles(0, 0, 0)
            local function v_u_304(p302)
                local v303 = math.rad(p302)
                return math.sin(v303)
            end
            local v_u_305 = 250
            local v_u_306 = nil
            task.spawn(function()
                -- upvalues: (copy) v_u_300, (copy) v_u_305, (copy) v_u_301, (copy) v_u_306, (ref) v_u_4, (ref) v_u_56, (copy) v_u_304
                local v_u_307 = math.random(-1000000000, 1000000000)
                local v_u_308
                if v_u_300:findFirstChild("tweenCode") then
                    v_u_308 = v_u_300.tweenCode
                    v_u_308.Value = v_u_307
                else
                    v_u_308 = Instance.new("IntValue")
                    v_u_308.Name = "tweenCode"
                    v_u_308.Value = v_u_307
                    v_u_308.Parent = v_u_300
                end
                if v_u_305 <= 0 then
                    if v_u_301 then
                        v_u_300.C0 = v_u_301
                    end
                    if v_u_306 then
                        v_u_300.C1 = v_u_306
                    end
                else
                    local v_u_309 = 1.5 / v_u_305
                    local v_u_310 = v_u_300.C0
                    local v_u_311 = v_u_300.C1
                    local v_u_312 = 0
                    local v_u_313 = nil
                    local v_u_314 = true
                    v_u_313 = v_u_4.Heartbeat:Connect(function(_)
                        -- upvalues: (ref) v_u_312, (copy) v_u_309, (ref) v_u_308, (copy) v_u_307, (ref) v_u_314, (ref) v_u_313, (ref) v_u_56, (ref) v_u_301, (ref) v_u_300, (copy) v_u_310, (ref) v_u_304, (ref) v_u_306, (copy) v_u_311
                        local v315 = v_u_312 + v_u_309
                        v_u_312 = v315 > 90 and 90 or v315
                        if v_u_308.Value ~= v_u_307 then
                            v_u_314 = false
                            v_u_313:Disconnect()
                        end
                        if not v_u_56 then
                            v_u_314 = false
                            v_u_313:Disconnect()
                        end
                        if v_u_301 then
                            v_u_300.C0 = v_u_310:Lerp(v_u_301, v_u_304(v_u_312))
                        end
                        if v_u_306 then
                            v_u_300.C1 = v_u_311:Lerp(v_u_306, v_u_304(v_u_312))
                        end
                        if v_u_312 == 90 then
                            v_u_314 = false
                            v_u_313:Disconnect()
                        end
                    end)
                    repeat
                        task.wait()
                    until v_u_314 == false
                end
                if v_u_308.Value == v_u_307 then
                    v_u_308:Destroy()
                end
            end)
            task.delay(125, function()
                -- upvalues: (ref) v_u_25, (ref) v_u_4, (ref) v_u_56
                if v_u_25 and v_u_25:FindFirstChild("Handle") then
                    local v_u_316 = v_u_25.Handle:WaitForChild("Barrell Move")
                    local v_u_317 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                    local function v_u_320(p318)
                        local v319 = math.rad(p318)
                        return math.sin(v319)
                    end
                    local v_u_321 = 250
                    local v_u_322 = nil
                    task.spawn(function()
                        -- upvalues: (copy) v_u_316, (copy) v_u_321, (copy) v_u_317, (copy) v_u_322, (ref) v_u_4, (ref) v_u_56, (copy) v_u_320
                        local v_u_323 = math.random(-1000000000, 1000000000)
                        local v_u_324
                        if v_u_316:findFirstChild("tweenCode") then
                            v_u_324 = v_u_316.tweenCode
                            v_u_324.Value = v_u_323
                        else
                            v_u_324 = Instance.new("IntValue")
                            v_u_324.Name = "tweenCode"
                            v_u_324.Value = v_u_323
                            v_u_324.Parent = v_u_316
                        end
                        if v_u_321 <= 0 then
                            if v_u_317 then
                                v_u_316.C0 = v_u_317
                            end
                            if v_u_322 then
                                v_u_316.C1 = v_u_322
                            end
                        else
                            local v_u_325 = 1.5 / v_u_321
                            local v_u_326 = v_u_316.C0
                            local v_u_327 = v_u_316.C1
                            local v_u_328 = 0
                            local v_u_329 = nil
                            local v_u_330 = true
                            v_u_329 = v_u_4.Heartbeat:Connect(function(_)
                                -- upvalues: (ref) v_u_328, (copy) v_u_325, (ref) v_u_324, (copy) v_u_323, (ref) v_u_330, (ref) v_u_329, (ref) v_u_56, (ref) v_u_317, (ref) v_u_316, (copy) v_u_326, (ref) v_u_320, (ref) v_u_322, (copy) v_u_327
                                local v331 = v_u_328 + v_u_325
                                v_u_328 = v331 > 90 and 90 or v331
                                if v_u_324.Value ~= v_u_323 then
                                    v_u_330 = false
                                    v_u_329:Disconnect()
                                end
                                if not v_u_56 then
                                    v_u_330 = false
                                    v_u_329:Disconnect()
                                end
                                if v_u_317 then
                                    v_u_316.C0 = v_u_326:Lerp(v_u_317, v_u_320(v_u_328))
                                end
                                if v_u_322 then
                                    v_u_316.C1 = v_u_327:Lerp(v_u_322, v_u_320(v_u_328))
                                end
                                if v_u_328 == 90 then
                                    v_u_330 = false
                                    v_u_329:Disconnect()
                                end
                            end)
                            repeat
                                task.wait()
                            until v_u_330 == false
                        end
                        if v_u_324.Value == v_u_323 then
                            v_u_324:Destroy()
                        end
                    end)
                end
            end)
        end
        task.delay(v_u_68 / 2, function()
            -- upvalues: (ref) v_u_25, (ref) v_u_73, (ref) v_u_24, (ref) v_u_56, (ref) v_u_68, (ref) v_u_4, (ref) v_u_51, (ref) v_u_125, (ref) v_u_70, (ref) v_u_22, (ref) v_u_83
            if v_u_25 and v_u_25:FindFirstChild("Handle") then
                if v_u_73[v_u_24] >= 1 then
                    if v_u_56 == false then
                        return
                    end
                    local v_u_332 = v_u_25.Handle:WaitForChild("Slide")
                    local v_u_333 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                    local function v_u_336(p334)
                        local v335 = math.rad(p334)
                        return math.sin(v335)
                    end
                    local v_u_337 = 1 * (v_u_68 / 2)
                    local v_u_338 = nil
                    task.spawn(function()
                        -- upvalues: (copy) v_u_332, (copy) v_u_337, (copy) v_u_333, (copy) v_u_338, (ref) v_u_4, (ref) v_u_56, (copy) v_u_336
                        local v_u_339 = math.random(-1000000000, 1000000000)
                        local v_u_340
                        if v_u_332:findFirstChild("tweenCode") then
                            v_u_340 = v_u_332.tweenCode
                            v_u_340.Value = v_u_339
                        else
                            v_u_340 = Instance.new("IntValue")
                            v_u_340.Name = "tweenCode"
                            v_u_340.Value = v_u_339
                            v_u_340.Parent = v_u_332
                        end
                        if v_u_337 <= 0 then
                            if v_u_333 then
                                v_u_332.C0 = v_u_333
                            end
                            if v_u_338 then
                                v_u_332.C1 = v_u_338
                            end
                        else
                            local v_u_341 = 1.5 / v_u_337
                            local v_u_342 = v_u_332.C0
                            local v_u_343 = v_u_332.C1
                            local v_u_344 = 0
                            local v_u_345 = nil
                            local v_u_346 = true
                            v_u_345 = v_u_4.Heartbeat:Connect(function(_)
                                -- upvalues: (ref) v_u_344, (copy) v_u_341, (ref) v_u_340, (copy) v_u_339, (ref) v_u_346, (ref) v_u_345, (ref) v_u_56, (ref) v_u_333, (ref) v_u_332, (copy) v_u_342, (ref) v_u_336, (ref) v_u_338, (copy) v_u_343
                                local v347 = v_u_344 + v_u_341
                                v_u_344 = v347 > 90 and 90 or v347
                                if v_u_340.Value ~= v_u_339 then
                                    v_u_346 = false
                                    v_u_345:Disconnect()
                                end
                                if not v_u_56 then
                                    v_u_346 = false
                                    v_u_345:Disconnect()
                                end
                                if v_u_333 then
                                    v_u_332.C0 = v_u_342:Lerp(v_u_333, v_u_336(v_u_344))
                                end
                                if v_u_338 then
                                    v_u_332.C1 = v_u_343:Lerp(v_u_338, v_u_336(v_u_344))
                                end
                                if v_u_344 == 90 then
                                    v_u_346 = false
                                    v_u_345:Disconnect()
                                end
                            end)
                            repeat
                                task.wait()
                            until v_u_346 == false
                        end
                        if v_u_340.Value == v_u_339 then
                            v_u_340:Destroy()
                        end
                    end)
                    if v_u_51.MoveBolt == true then
                        local v_u_348 = v_u_25.Handle:WaitForChild("Bolt")
                        local v_u_349 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                        local function v_u_352(p350)
                            local v351 = math.rad(p350)
                            return math.sin(v351)
                        end
                        local v_u_353 = 1 * (v_u_68 / 2)
                        local v_u_354 = nil
                        task.spawn(function()
                            -- upvalues: (copy) v_u_348, (copy) v_u_353, (copy) v_u_349, (copy) v_u_354, (ref) v_u_4, (ref) v_u_56, (copy) v_u_352
                            local v_u_355 = math.random(-1000000000, 1000000000)
                            local v_u_356
                            if v_u_348:findFirstChild("tweenCode") then
                                v_u_356 = v_u_348.tweenCode
                                v_u_356.Value = v_u_355
                            else
                                v_u_356 = Instance.new("IntValue")
                                v_u_356.Name = "tweenCode"
                                v_u_356.Value = v_u_355
                                v_u_356.Parent = v_u_348
                            end
                            if v_u_353 <= 0 then
                                if v_u_349 then
                                    v_u_348.C0 = v_u_349
                                end
                                if v_u_354 then
                                    v_u_348.C1 = v_u_354
                                end
                            else
                                local v_u_357 = 1.5 / v_u_353
                                local v_u_358 = v_u_348.C0
                                local v_u_359 = v_u_348.C1
                                local v_u_360 = 0
                                local v_u_361 = nil
                                local v_u_362 = true
                                v_u_361 = v_u_4.Heartbeat:Connect(function(_)
                                    -- upvalues: (ref) v_u_360, (copy) v_u_357, (ref) v_u_356, (copy) v_u_355, (ref) v_u_362, (ref) v_u_361, (ref) v_u_56, (ref) v_u_349, (ref) v_u_348, (copy) v_u_358, (ref) v_u_352, (ref) v_u_354, (copy) v_u_359
                                    local v363 = v_u_360 + v_u_357
                                    v_u_360 = v363 > 90 and 90 or v363
                                    if v_u_356.Value ~= v_u_355 then
                                        v_u_362 = false
                                        v_u_361:Disconnect()
                                    end
                                    if not v_u_56 then
                                        v_u_362 = false
                                        v_u_361:Disconnect()
                                    end
                                    if v_u_349 then
                                        v_u_348.C0 = v_u_358:Lerp(v_u_349, v_u_352(v_u_360))
                                    end
                                    if v_u_354 then
                                        v_u_348.C1 = v_u_359:Lerp(v_u_354, v_u_352(v_u_360))
                                    end
                                    if v_u_360 == 90 then
                                        v_u_362 = false
                                        v_u_361:Disconnect()
                                    end
                                end)
                                repeat
                                    task.wait()
                                until v_u_362 == false
                            end
                            if v_u_356.Value == v_u_355 then
                                v_u_356:Destroy()
                            end
                        end)
                        return
                    end
                else
                    if v_u_73[v_u_24] < 1 and v_u_51.SlideLock == true then
                        if not table.find(v_u_125, v_u_25.Name) then
                            v_u_70.Value = false
                        end
                        if v_u_51.MoveBolt == true and v_u_51.BoltLock == false then
                            local v_u_364 = v_u_25.Handle:WaitForChild("Bolt")
                            local v_u_365 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                            local function v_u_368(p366)
                                local v367 = math.rad(p366)
                                return math.sin(v367)
                            end
                            local v_u_369 = 1 * (v_u_68 / 2)
                            local v_u_370 = nil
                            task.spawn(function()
                                -- upvalues: (copy) v_u_364, (copy) v_u_369, (copy) v_u_365, (copy) v_u_370, (ref) v_u_4, (ref) v_u_56, (copy) v_u_368
                                local v_u_371 = math.random(-1000000000, 1000000000)
                                local v_u_372
                                if v_u_364:findFirstChild("tweenCode") then
                                    v_u_372 = v_u_364.tweenCode
                                    v_u_372.Value = v_u_371
                                else
                                    v_u_372 = Instance.new("IntValue")
                                    v_u_372.Name = "tweenCode"
                                    v_u_372.Value = v_u_371
                                    v_u_372.Parent = v_u_364
                                end
                                if v_u_369 <= 0 then
                                    if v_u_365 then
                                        v_u_364.C0 = v_u_365
                                    end
                                    if v_u_370 then
                                        v_u_364.C1 = v_u_370
                                    end
                                else
                                    local v_u_373 = 1.5 / v_u_369
                                    local v_u_374 = v_u_364.C0
                                    local v_u_375 = v_u_364.C1
                                    local v_u_376 = 0
                                    local v_u_377 = nil
                                    local v_u_378 = true
                                    v_u_377 = v_u_4.Heartbeat:Connect(function(_)
                                        -- upvalues: (ref) v_u_376, (copy) v_u_373, (ref) v_u_372, (copy) v_u_371, (ref) v_u_378, (ref) v_u_377, (ref) v_u_56, (ref) v_u_365, (ref) v_u_364, (copy) v_u_374, (ref) v_u_368, (ref) v_u_370, (copy) v_u_375
                                        local v379 = v_u_376 + v_u_373
                                        v_u_376 = v379 > 90 and 90 or v379
                                        if v_u_372.Value ~= v_u_371 then
                                            v_u_378 = false
                                            v_u_377:Disconnect()
                                        end
                                        if not v_u_56 then
                                            v_u_378 = false
                                            v_u_377:Disconnect()
                                        end
                                        if v_u_365 then
                                            v_u_364.C0 = v_u_374:Lerp(v_u_365, v_u_368(v_u_376))
                                        end
                                        if v_u_370 then
                                            v_u_364.C1 = v_u_375:Lerp(v_u_370, v_u_368(v_u_376))
                                        end
                                        if v_u_376 == 90 then
                                            v_u_378 = false
                                            v_u_377:Disconnect()
                                        end
                                    end)
                                    repeat
                                        task.wait()
                                    until v_u_378 == false
                                end
                                if v_u_372.Value == v_u_371 then
                                    v_u_372:Destroy()
                                end
                            end)
                        end
                        v_u_22.Click:Play()
                        v_u_83 = true
                        return
                    end
                    if v_u_73[v_u_24] and v_u_51.SlideLock == false then
                        local v_u_380 = v_u_25.Handle:WaitForChild("Slide")
                        local v_u_381 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                        local function v_u_384(p382)
                            local v383 = math.rad(p382)
                            return math.sin(v383)
                        end
                        local v_u_385 = 1 * (v_u_68 / 2)
                        local v_u_386 = nil
                        task.spawn(function()
                            -- upvalues: (copy) v_u_380, (copy) v_u_385, (copy) v_u_381, (copy) v_u_386, (ref) v_u_4, (ref) v_u_56, (copy) v_u_384
                            local v_u_387 = math.random(-1000000000, 1000000000)
                            local v_u_388
                            if v_u_380:findFirstChild("tweenCode") then
                                v_u_388 = v_u_380.tweenCode
                                v_u_388.Value = v_u_387
                            else
                                v_u_388 = Instance.new("IntValue")
                                v_u_388.Name = "tweenCode"
                                v_u_388.Value = v_u_387
                                v_u_388.Parent = v_u_380
                            end
                            if v_u_385 <= 0 then
                                if v_u_381 then
                                    v_u_380.C0 = v_u_381
                                end
                                if v_u_386 then
                                    v_u_380.C1 = v_u_386
                                end
                            else
                                local v_u_389 = 1.5 / v_u_385
                                local v_u_390 = v_u_380.C0
                                local v_u_391 = v_u_380.C1
                                local v_u_392 = 0
                                local v_u_393 = nil
                                local v_u_394 = true
                                v_u_393 = v_u_4.Heartbeat:Connect(function(_)
                                    -- upvalues: (ref) v_u_392, (copy) v_u_389, (ref) v_u_388, (copy) v_u_387, (ref) v_u_394, (ref) v_u_393, (ref) v_u_56, (ref) v_u_381, (ref) v_u_380, (copy) v_u_390, (ref) v_u_384, (ref) v_u_386, (copy) v_u_391
                                    local v395 = v_u_392 + v_u_389
                                    v_u_392 = v395 > 90 and 90 or v395
                                    if v_u_388.Value ~= v_u_387 then
                                        v_u_394 = false
                                        v_u_393:Disconnect()
                                    end
                                    if not v_u_56 then
                                        v_u_394 = false
                                        v_u_393:Disconnect()
                                    end
                                    if v_u_381 then
                                        v_u_380.C0 = v_u_390:Lerp(v_u_381, v_u_384(v_u_392))
                                    end
                                    if v_u_386 then
                                        v_u_380.C1 = v_u_391:Lerp(v_u_386, v_u_384(v_u_392))
                                    end
                                    if v_u_392 == 90 then
                                        v_u_394 = false
                                        v_u_393:Disconnect()
                                    end
                                end)
                                repeat
                                    task.wait()
                                until v_u_394 == false
                            end
                            if v_u_388.Value == v_u_387 then
                                v_u_388:Destroy()
                            end
                        end)
                        if v_u_51.MoveBolt == true then
                            local v_u_396 = v_u_25.Handle:WaitForChild("Bolt")
                            local v_u_397 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                            local function v_u_400(p398)
                                local v399 = math.rad(p398)
                                return math.sin(v399)
                            end
                            local v_u_401 = 1 * (v_u_68 / 2)
                            local v_u_402 = nil
                            task.spawn(function()
                                -- upvalues: (copy) v_u_396, (copy) v_u_401, (copy) v_u_397, (copy) v_u_402, (ref) v_u_4, (ref) v_u_56, (copy) v_u_400
                                local v_u_403 = math.random(-1000000000, 1000000000)
                                local v_u_404
                                if v_u_396:findFirstChild("tweenCode") then
                                    v_u_404 = v_u_396.tweenCode
                                    v_u_404.Value = v_u_403
                                else
                                    v_u_404 = Instance.new("IntValue")
                                    v_u_404.Name = "tweenCode"
                                    v_u_404.Value = v_u_403
                                    v_u_404.Parent = v_u_396
                                end
                                if v_u_401 <= 0 then
                                    if v_u_397 then
                                        v_u_396.C0 = v_u_397
                                    end
                                    if v_u_402 then
                                        v_u_396.C1 = v_u_402
                                    end
                                else
                                    local v_u_405 = 1.5 / v_u_401
                                    local v_u_406 = v_u_396.C0
                                    local v_u_407 = v_u_396.C1
                                    local v_u_408 = 0
                                    local v_u_409 = nil
                                    local v_u_410 = true
                                    v_u_409 = v_u_4.Heartbeat:Connect(function(_)
                                        -- upvalues: (ref) v_u_408, (copy) v_u_405, (ref) v_u_404, (copy) v_u_403, (ref) v_u_410, (ref) v_u_409, (ref) v_u_56, (ref) v_u_397, (ref) v_u_396, (copy) v_u_406, (ref) v_u_400, (ref) v_u_402, (copy) v_u_407
                                        local v411 = v_u_408 + v_u_405
                                        v_u_408 = v411 > 90 and 90 or v411
                                        if v_u_404.Value ~= v_u_403 then
                                            v_u_410 = false
                                            v_u_409:Disconnect()
                                        end
                                        if not v_u_56 then
                                            v_u_410 = false
                                            v_u_409:Disconnect()
                                        end
                                        if v_u_397 then
                                            v_u_396.C0 = v_u_406:Lerp(v_u_397, v_u_400(v_u_408))
                                        end
                                        if v_u_402 then
                                            v_u_396.C1 = v_u_407:Lerp(v_u_402, v_u_400(v_u_408))
                                        end
                                        if v_u_408 == 90 then
                                            v_u_410 = false
                                            v_u_409:Disconnect()
                                        end
                                    end)
                                    repeat
                                        task.wait()
                                    until v_u_410 == false
                                end
                                if v_u_404.Value == v_u_403 then
                                    v_u_404:Destroy()
                                end
                            end)
                        end
                        if not table.find(v_u_125, v_u_25.Name) then
                            v_u_70.Value = false
                        end
                        v_u_22.Click:Play()
                    end
                end
            end
        end)
    end
end
local v_u_413 = 1
local v_u_414 = 1
local function v_u_451() -- name: recoil
    -- upvalues: (ref) v_u_24, (copy) v_u_53, (ref) v_u_61, (ref) v_u_62, (copy) v_u_13, (ref) v_u_51, (ref) v_u_63, (ref) v_u_64, (ref) v_u_65, (ref) v_u_112, (ref) v_u_414, (copy) v_u_6, (ref) v_u_93, (ref) v_u_60, (ref) v_u_66, (ref) v_u_25, (copy) v_u_17, (copy) v_u_12, (ref) v_u_56, (copy) v_u_36, (copy) v_u_40, (copy) v_u_22, (ref) v_u_413, (copy) v_u_412
    if v_u_24.Parent ~= v_u_53 then
        return
    end
    task.spawn(function()
        -- upvalues: (ref) v_u_61, (ref) v_u_62, (ref) v_u_13, (ref) v_u_51, (ref) v_u_63, (ref) v_u_64, (ref) v_u_65, (ref) v_u_112, (ref) v_u_414, (ref) v_u_6, (ref) v_u_93, (ref) v_u_60, (ref) v_u_66
        local v415 = v_u_61
        local v416 = v_u_62 * math.random(-1, 1)
        v_u_13.CFrame = v_u_13.CFrame * CFrame.Angles(v415, v416, 0)
        local v417 = -v415 / 30
        local v418 = -v416 / 30
        local v419
        if v_u_51.GunType == 0 then
            v419 = v_u_63
        else
            v419 = math.random(-v_u_63 * 50, v_u_63 * 100) / 100
        end
        local v420 = math.random(-v_u_64 * 100, v_u_64 * 100) / 100
        local v421 = v_u_65 * math.random(-1, 1)
        local v422 = v_u_51.AimRecoilReduction
        if v_u_112 == Enum.UserInputType.Touch then
            v_u_414 = 0.6
        elseif v_u_6.GamepadEnabled then
            v_u_414 = 0.8
        else
            v_u_414 = 1
        end
        if v_u_93 then
            local v423 = v_u_60
            local v424 = v_u_60 * CFrame.new(0, 0, v_u_51.RecoilPunch / 2)
            local v425 = CFrame.Angles
            local v426 = v419 * v_u_66 / v422 * v_u_414
            local v427 = math.rad(v426)
            local v428 = v420 * v_u_66 / v422 * v_u_414
            local v429 = math.rad(v428)
            local v430 = v421 * v_u_66 / v422 * v_u_414
            v_u_60 = v423:Lerp(v424 * v425(v427, v429, (math.rad(v430))), 1)
        else
            local v431 = v_u_60
            local v432 = v_u_60 * CFrame.new(0, 0, v_u_51.RecoilPunch)
            local v433 = CFrame.Angles
            local v434 = v419 * v_u_66 * v_u_414
            local v435 = math.rad(v434)
            local v436 = v420 * v_u_66 * v_u_414
            local v437 = math.rad(v436)
            local v438 = v421 * v_u_66 * v_u_414
            v_u_60 = v431:Lerp(v432 * v433(v435, v437, (math.rad(v438))), 1)
        end
        for _ = 1, 30 * v_u_51.AimRecover do
            v_u_13.CoordinateFrame = CFrame.new(v_u_13.Focus.p) * (v_u_13.CoordinateFrame - v_u_13.CoordinateFrame.p) * CFrame.Angles(v417, v418, 0) * CFrame.new(0, 0, (v_u_13.Focus.p - v_u_13.CoordinateFrame.p).magnitude)
            task.wait()
        end
    end)
    local v_u_439 = v_u_25:FindFirstChild("SmokePart")
    local v_u_440
    if v_u_439 then
        v_u_440 = v_u_439:FindFirstChild("FlashFX[Flash]")
    else
        v_u_440 = v_u_439
    end
    local v_u_441
    if v_u_439 then
        v_u_441 = v_u_439:FindFirstChild("Smoke")
    else
        v_u_441 = v_u_439
    end
    local v_u_442
    if v_u_439 then
        v_u_442 = v_u_439:FindFirstChild("FlashFX")
    else
        v_u_442 = v_u_439
    end
    local v443 = v_u_17:FindFirstChild("Attachments"):FindFirstChild(v_u_25.Name)
    local v444 = {}
    local v445
    if v443 then
        v445 = v443:GetAttribute("VFXUsing")
    else
        v445 = v443
    end
    if v445 then
        local v446 = v443:GetAttribute("Camo" .. v445)
        v444 = v446 and (v_u_12[v446].CustomVFX or {}) or v444
    end
    if v_u_440 and v444.FlashColor then
        v_u_440.Color = v444.FlashColor
    elseif v_u_440 then
        v_u_440.Color = ColorSequence.new(Color3.new(1, 1, 0.498039), Color3.new(1, 0.333333, 0))
    end
    if v_u_441 and v444.SmokeColor then
        v_u_441.Color = v444.SmokeColor
    elseif v_u_441 then
        v_u_441.Color = ColorSequence.new(Color3.new(1, 1, 1))
    end
    if v_u_442 and v444.LightFlashColor then
        v_u_442.Color = v444.LightFlashColor
    elseif v_u_442 then
        v_u_442.Color = Color3.new(1, 0.843137, 0.145098)
    end
    if v_u_440 then
        if v_u_25:FindFirstChild("Flash Hider") then
            v_u_440.Rate = 150
        else
            v_u_440.Rate = 1000
            if v_u_442 then
                v_u_442.Enabled = true
            end
        end
        v_u_440.Enabled = true
    end
    if v_u_441 then
        v_u_441.Enabled = true
    end
    if v_u_25:FindFirstChild("Chamber") then
        for _, v447 in v_u_25.Chamber:GetChildren() do
            if v_u_56 == false then
                break
            end
            if v447.Name == "Shell" and v_u_36.Value == true then
                v447:Emit(1)
            elseif v447:IsA("ParticleEmitter") then
                v447.Enabled = true
            end
        end
    end
    task.delay(0.03333333333333333, function()
        -- upvalues: (copy) v_u_439, (ref) v_u_25, (copy) v_u_440, (copy) v_u_441, (copy) v_u_442
        if v_u_439 and v_u_25 then
            if v_u_439:FindFirstChild("FlashFX[Flash]") then
                v_u_440.Enabled = false
            end
            if v_u_439:FindFirstChild("Smoke") then
                v_u_441.Enabled = false
            end
            if v_u_439:FindFirstChild("FlashFX") then
                v_u_442.Enabled = false
            end
            local v448 = v_u_25:FindFirstChild("Chamber")
            if v448 then
                for _, v449 in v448:GetChildren() do
                    if v449:IsA("ParticleEmitter") then
                        v449.Enabled = false
                    end
                end
            end
        end
    end)
    local v450 = v_u_53:WaitForChild("S" .. v_u_25.Name, 5)
    if v450 then
        if v450:FindFirstChild("Suppressor") then
            v_u_40(v_u_25, v_u_22["Sound" .. v_u_413], "Suppressed")
        else
            v_u_40(v_u_25, v_u_22["Sound" .. v_u_413], "Normal")
        end
        v_u_413 = v_u_413 + 1
        if v_u_413 == 5 then
            v_u_413 = 1
        end
        v_u_412()
    end
end
local v_u_452 = 0
local v_u_453 = nil
local function v_u_466() -- name: HeadMovement
    -- upvalues: (ref) v_u_452, (copy) v_u_53, (ref) v_u_87, (ref) v_u_453, (copy) v_u_27, (copy) v_u_13, (copy) v_u_118, (ref) v_u_56
    local v454 = os.clock()
    if v454 - v_u_452 < 0.06666666666666667 then
        return
    else
        v_u_452 = v454
        if v_u_53.Humanoid.Health <= 0 then
            return
        elseif v_u_87 then
            v_u_453 = CFrame.new(0, -0.5, 0) * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
            v_u_27.HeadRot:FireServer(v_u_453)
        else
            local v455 = v_u_53.HumanoidRootPart.CFrame:toObjectSpace(v_u_13.CFrame).lookVector
            if v_u_118 then
                if v_u_53.Humanoid.Sit == true or (v_u_53.HumanoidRootPart.Anchored == true or v_u_53:GetAttribute("NoMovement") == true) then
                    v_u_453 = CFrame.new(0, -0.5, 0) * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
                else
                    local v456 = CFrame.new(0, -0.5, 0)
                    local v457 = CFrame.Angles
                    local v458 = v455.X
                    local v459 = v456 * v457(0, math.asin(v458) / 1.15, 0)
                    local v460 = CFrame.Angles
                    local v461 = v_u_13.CFrame.LookVector.Y
                    local v462 = -math.asin(v461)
                    local v463 = v_u_53.Torso.CFrame.lookVector.Y
                    v_u_453 = v459 * v460(v462 + math.asin(v463), 0, 0) * CFrame.Angles(-1.5707963267948966, 0, 3.141592653589793)
                end
                if not v_u_56 then
                    local v464 = v_u_118.C1
                    for v465 = 0, 1, 0.07 do
                        v_u_118.C1 = v464:Lerp(v_u_453, v465)
                        task.wait()
                    end
                end
                v_u_27.HeadRot:FireServer(v_u_453)
            end
        end
    end
end
local v_u_467 = 0
local v_u_468 = 0
local v_u_469 = 0
local v_u_470 = 0
local v_u_471 = 0
local v_u_472 = nil
v_u_53.ChildAdded:connect(function(p473)
    -- upvalues: (copy) v_u_17, (copy) v_u_115, (copy) v_u_53, (copy) v_u_35, (ref) v_u_57, (ref) v_u_472, (ref) v_u_56, (copy) v_u_6, (copy) v_u_10, (copy) v_u_189, (ref) v_u_126, (copy) v_u_122, (copy) v_u_13, (copy) v_u_123, (ref) v_u_76, (copy) v_u_77, (ref) v_u_78, (ref) v_u_112, (copy) v_u_79, (ref) v_u_51, (ref) v_u_25, (copy) v_u_7, (ref) v_u_24, (copy) v_u_177, (copy) v_u_73, (ref) v_u_70, (copy) v_u_22, (copy) v_u_220, (copy) v_u_219
    if v_u_17.Team.Name == "Loading" then
        task.wait()
        v_u_115:UnequipTools()
        return
    elseif v_u_53:GetAttribute("Downed") == true then
        task.wait()
        v_u_115:UnequipTools()
        return
    elseif v_u_53:GetAttribute((("S%*_Health"):format((string.gsub(p473.Name, " ", "_"))))) == 0 then
        local v474 = nil
        for _, v475 in v_u_17.Backpack:GetChildren() do
            if v474 ~= p473 then
                v474 = v475
            end
        end
        task.wait()
        if v474 then
            v_u_115:EquipTool(v474)
            task.wait()
        end
        v_u_115:UnequipTools()
        return
    elseif v_u_53:FindFirstChild("HumanoidRootPart") and (v_u_53.HumanoidRootPart.Anchored ~= true or v_u_53:GetAttribute("InDrone") == true) then
        if p473:IsA("Tool") and (v_u_35:FindFirstChild(p473.Name) and v_u_115.Health > 0) then
            local v476 = true
            local v477 = v_u_35:FindFirstChild(p473.Name)
            if v477 then
                v477 = v477:FindFirstChild("Settings")
            end
            if v477 then
                v477 = require(v477)
            end
            if v_u_53:WaitForChild("Humanoid").Sit and v_u_53.Humanoid.SeatPart:IsA("VehicleSeat") or (v_u_53:WaitForChild("Humanoid").Sit and v_u_53.Humanoid.SeatPart:IsA("Seat") or (v_u_57 and not v477.AllowedInWater or (v_u_17:GetAttribute("ControllingLargeDrone") or v_u_53:GetAttribute("InDrone")))) then
                task.wait()
                v_u_115:UnequipTools()
                v476 = false
            end
            if v476 then
                v_u_472 = p473
                if not v_u_56 then
                    v_u_6.MouseIconEnabled = false
                    v_u_10:DisableGamepadCursor()
                    v_u_17.CameraMode = Enum.CameraMode.LockFirstPerson
                    v_u_189(p473)
                    v_u_126 = {
                        v_u_53,
                        v_u_122,
                        v_u_13,
                        v_u_123
                    }
                    v_u_76 = v_u_77:WaitForChild("GunHUD")
                    v_u_78 = v_u_77:WaitForChild("Mobile")
                    v_u_112 = v_u_6:GetLastInputType()
                    v_u_79.CurrentGun.Value = p473.Name
                    if v_u_112 == Enum.UserInputType.Touch then
                        v_u_76.Position = UDim2.new(0.82, 0, 0.96, 0)
                        v_u_78.Visible = true
                        if v_u_51.FireModes.ChangeFiremode then
                            v_u_78.FireMode.Visible = true
                        else
                            v_u_78.FireMode.Visible = false
                        end
                        if v_u_25:FindFirstChild("Aim2", true) or v_u_25:FindFirstChild("Hybrid") then
                            v_u_78.ScopeSwap.Visible = true
                        else
                            v_u_78.ScopeSwap.Visible = false
                        end
                    else
                        v_u_76.Position = UDim2.new(0.97, 0, 0.96, 0)
                        v_u_78.Visible = false
                    end
                    if v_u_17.SettingsFolder.crosshair.Value == true and p473.Name ~= "Riot Shield" then
                        if p473.Name == "Binoculars" then
                            v_u_79.Visible = false
                            v_u_76.Visible = false
                        else
                            v_u_79.Visible = true
                            v_u_76.Visible = true
                        end
                    else
                        v_u_79.Visible = true
                        if p473.Name == "Riot Shield" then
                            task.spawn(function()
                                -- upvalues: (ref) v_u_7, (ref) v_u_77, (ref) v_u_53, (ref) v_u_24, (ref) v_u_51
                                v_u_7.TrackHealth(v_u_77, v_u_53:WaitForChild("S" .. v_u_24.Name), v_u_51)
                            end)
                            v_u_76.Visible = false
                        elseif p473.Name == "Binoculars" then
                            v_u_76.Visible = false
                        else
                            v_u_76.Visible = true
                        end
                    end
                    v_u_177(true)
                    if v_u_73[v_u_24] <= 0 then
                        if v_u_25.Name == "RPG" then
                            v_u_25.Rocket.Transparency = 1
                        end
                        reloadGun()
                        return
                    elseif v_u_70.Value == false and v_u_73[v_u_24] > 0 then
                        chamberGun()
                    else
                        task.delay(0.1, function()
                            -- upvalues: (ref) v_u_56, (ref) v_u_22
                            if v_u_56 then
                                v_u_22.AimUp:Play()
                            end
                        end)
                        EquipAnim()
                        v_u_220()
                    end
                end
                if v_u_56 then
                    v_u_219()
                    v_u_189(v_u_472)
                end
            end
        end
    else
        task.wait()
        v_u_115:UnequipTools()
    end
end)
v_u_54.Seated:Connect(function(p478, p479)
    -- upvalues: (copy) v_u_115, (copy) v_u_17, (copy) v_u_15
    if p478 and (p479 and p479:IsA("VehicleSeat")) then
        v_u_115:UnequipTools()
        return
    elseif not p479 or (not p479.Parent.Parent or p479.Parent.Parent.Name ~= "Turrets") then
        v_u_17.CameraMaxZoomDistance = v_u_15
    end
end)
v_u_53.ChildRemoved:Connect(function(p480)
    -- upvalues: (ref) v_u_24, (ref) v_u_56, (copy) v_u_219
    if p480 == v_u_24 and v_u_56 then
        v_u_219()
    end
end)
local v_u_592 = v_u_4.RenderStepped:Connect(function(p481)
    -- upvalues: (copy) v_u_466, (ref) v_u_56, (ref) v_u_60, (ref) v_u_51, (ref) v_u_25, (copy) v_u_13, (copy) v_u_3, (ref) v_u_126, (copy) v_u_124, (ref) v_u_469, (ref) v_u_470, (ref) v_u_468, (ref) v_u_467, (copy) v_u_109, (ref) v_u_471, (ref) v_u_107, (ref) v_u_81, (copy) v_u_33, (ref) v_u_113, (copy) v_u_110, (ref) v_u_103, (ref) v_u_93, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (copy) v_u_127, (copy) v_u_77, (ref) v_u_24, (copy) v_u_17, (copy) v_u_79, (ref) v_u_67, (ref) v_u_111, (copy) v_u_54, (ref) v_u_106, (ref) v_u_114, (ref) v_u_75, (ref) v_u_68, (ref) v_u_66, (ref) v_u_80, (copy) v_u_22, (ref) v_u_72, (ref) v_u_95
    v_u_466()
    if v_u_56 ~= false then
        local v482 = v_u_60
        local v483 = CFrame.new()
        local v484 = -v_u_51.PunchRecover * 60 * p481
        v_u_60 = v482:Lerp(v483, 1 - math.exp(v484))
        local v485, v486 = v_u_3:FindPartOnRayWithIgnoreList(Ray.new(v_u_25.Handle.Position, v_u_13.CFrame.LookVector * v_u_51.GunSize), v_u_126, false, true)
        if v485 and v_u_124[v485.Name] then
            v485 = nil
            v486 = nil
        end
        local v487 = v_u_13.CoordinateFrame.lookVector
        local v488 = v487.X
        local v489 = v487.Y
        local v490 = v487.Z
        local v491 = math.asin(v489)
        local v492 = v488 / v490
        local v493 = -math.atan(v492)
        local v494 = v_u_469 - v491
        local v495 = v_u_470 - v493
        local v496 = v494 * (math.abs(v494) < 1 and 1 or 0)
        local v497 = v495 * (math.abs(v495) < 1 and 1 or 0)
        v_u_468 = v_u_468 * 0.5 + v496
        v_u_467 = v_u_467 * 0.5 + v497
        v_u_469 = v491
        v_u_470 = v493
        local v498 = v_u_467
        local v499 = v_u_468
        local v500 = v_u_471
        v_u_109.t = Vector3.new(v498, v499, v500)
        local v501 = v_u_109.p
        local v502 = v501.z
        local v503 = v501.X * 5
        local v504 = v501.Y * 5
        local v505 = v_u_107 * 3
        local v506 = math.sin(v505) * (v_u_81 / v_u_33.RunWalkSpeed * (v_u_113 + 1))
        local v507 = v_u_107 * 3
        local v508 = math.cos(v507) * (v_u_81 / v_u_33.RunWalkSpeed * (v_u_113 + 1))
        local v509 = v_u_107 * 1.75
        local v510 = math.sin(v509) * (v_u_81 / v_u_33.RunWalkSpeed * (v_u_113 + 1))
        local v511 = v_u_107 * 3.5
        local v512 = math.cos(v511) * (v_u_81 / v_u_33.RunWalkSpeed * (v_u_113 + 1))
        local v513 = v_u_113
        v_u_110.t = Vector3.new(v506, v508, v513)
        local v514 = v_u_110.p
        local v515 = v514.Z / 10
        local v516 = v514.X / 1
        local v517 = v514.Y / 1
        if v_u_103 then
            if v_u_93 then
                local v518 = v_u_18
                local v519 = UDim2.new(0.5, 0, 0.5, 0)
                local v520 = -10 * p481
                v_u_18 = v518:Lerp(v519, 1 - math.exp(v520))
                local v521 = v_u_19
                local v522 = UDim2.new(0.5, 0, 0.5, 0)
                local v523 = -10 * p481
                v_u_19 = v521:Lerp(v522, 1 - math.exp(v523))
                local v524 = v_u_20
                local v525 = UDim2.new(0.5, 0, 0.5, 0)
                local v526 = -10 * p481
                v_u_20 = v524:Lerp(v525, 1 - math.exp(v526))
                local v527 = v_u_21
                local v528 = UDim2.new(0.5, 0, 0.5, 0)
                local v529 = -10 * p481
                v_u_21 = v527:Lerp(v528, 1 - math.exp(v529))
                for _, v530 in pairs(v_u_127.CrosshairHide) do
                    v530:Play()
                end
            else
                local v531 = v_u_77.CustomCrosshairs:FindFirstChild(v_u_24.Name)
                if v_u_17.SettingsFolder.crosshair.Value == true and (v_u_79.CurrentGun.Value ~= "Riot Shield" and not v531) then
                    if v_u_79.CurrentGun.Value ~= "Binoculars" then
                        v_u_79.Visible = true
                        local v532 = v_u_67 * 1.2 + 1
                        local v533 = v_u_81
                        local v534 = (math.clamp(v532, 5, 50) + math.clamp(v533, 1, 25) * 1) / 50 / 10
                        local v535 = v_u_18
                        local v536 = UDim2.new(0.5, 0, 0.5 - v534, 0)
                        local v537 = -30 * p481
                        v_u_18 = v535:Lerp(v536, 1 - math.exp(v537))
                        local v538 = v_u_19
                        local v539 = UDim2.new(0.5, 0, v534 + 0.5, 0)
                        local v540 = -30 * p481
                        v_u_19 = v538:Lerp(v539, 1 - math.exp(v540))
                        local v541 = v_u_20
                        local v542 = UDim2.new(0.5 - v534, 0, 0.5, 0)
                        local v543 = -30 * p481
                        v_u_20 = v541:Lerp(v542, 1 - math.exp(v543))
                        local v544 = v_u_21
                        local v545 = UDim2.new(v534 + 0.5, 0, 0.5, 0)
                        local v546 = -30 * p481
                        v_u_21 = v544:Lerp(v545, 1 - math.exp(v546))
                        for _, v547 in pairs(v_u_127.CrosshairShow) do
                            v547:Play()
                        end
                    end
                elseif v531 then
                    v531.Visible = true
                end
            end
            if v_u_81 > 1 then
                v_u_111 = v_u_54.WalkSpeed / 3
                if a then
                    v_u_471 = 0 + (v_u_81 * -0.2 / v_u_33.RunWalkSpeed - 0) * 10
                elseif d then
                    v_u_471 = 0 + (v_u_81 * 0.2 / v_u_33.RunWalkSpeed - 0) * 10
                else
                    v_u_471 = 0
                end
            else
                v_u_111 = v_u_81 / v_u_33.RunWalkSpeed + 0.5
                v_u_113 = 0
            end
            local v548 = tick()
            v_u_107 = v_u_107 + (v548 - v_u_106) * v_u_111
            v_u_106 = v548
            local v549 = CFrame.Angles(v504 * 0.08726646259971647, -v503 * 0.08726646259971647, -v503 * 0)
            local v550 = v_u_114
            local v551 = CFrame.new(v516 / 220, -v517 / 180, 0) * CFrame.new(v510 / 220, -v512 / 180, 0) * CFrame.Angles(0, 0, v515 / 5) * CFrame.Angles(0, 0, v502 / 2 / 10)
            local v552 = -80 * p481
            v_u_114 = v550:Lerp(v551, 1 - math.exp(v552))
            local v553 = v_u_103
            local v554 = v_u_103.C0
            local v555 = v_u_114 * v549
            local v556 = -75 * p481
            v553.C0 = v554:Lerp(v555, 1 - math.exp(v556))
        end
        v_u_79.Position = UDim2.new(0.5, 0, 0.5, 0)
        v_u_79.Up.Position = v_u_18
        v_u_79.Down.Position = v_u_19
        v_u_79.Left.Position = v_u_20
        v_u_79.Right.Position = v_u_21
        if v_u_67 then
            local v557 = time()
            if v557 - v_u_75 > v_u_68 * 2 then
                v_u_75 = v557
                local v558 = v_u_24:GetAttribute("MinSpread") or v_u_51.MinSpread
                local v559 = v_u_67 - v_u_51.AimInaccuracyStepAmount / 5
                v_u_67 = math.max(v558, v559)
                local v560 = v_u_51.MinRecoilPower
                local v561 = v_u_66 - v_u_51.RecoilPowerStepAmount / 4
                v_u_66 = math.max(v560, v561)
            end
        end
        if v_u_93 then
            local v562 = v_u_25:FindFirstChild("Aim2", true)
            if v_u_80 == 1 and v562 then
                local v563 = v_u_103
                local v564 = v_u_103.C1
                local v565 = v_u_103.C1 * v_u_103.C0:inverse() * v_u_60 * CFrame.new() * v_u_25.Aim.CFrame:toObjectSpace(v_u_22.CFrame)
                local v566 = -10 * p481
                v563.C1 = v564:Lerp(v565, (1 - math.exp(v566)) * v_u_72)
            elseif v_u_80 == 2 and v562 then
                local v567 = v_u_103
                local v568 = v_u_103.C1
                local v569 = v_u_103.C1 * v_u_103.C0:inverse() * v_u_60 * v562.CFrame:toObjectSpace(v_u_22.CFrame)
                local v570 = -10 * p481
                v567.C1 = v568:Lerp(v569, (1 - math.exp(v570)) * v_u_72)
            else
                local v571 = v_u_103
                local v572 = v_u_103.C1
                local v573 = v_u_103.C1 * v_u_103.C0:inverse() * v_u_60 * v_u_25.Aim.CFrame:toObjectSpace(v_u_22.CFrame)
                local v574 = -10 * p481
                v571.C1 = v572:Lerp(v573, (1 - math.exp(v574)) * v_u_72)
            end
        elseif v485 and v_u_95 == 0 then
            local v575 = v_u_103
            local v576 = v_u_103.C1
            local v577 = v_u_103.C0:inverse() * v_u_60 * CFrame.new(0, 0, ((v_u_25.Handle.Position - v486).magnitude / v_u_51.GunSize - 1) * -v_u_51.GunFOVReduction)
            local v578 = -10 * p481
            v575.C1 = v576:Lerp(v577, (1 - math.exp(v578)) * v_u_72)
        else
            local v579 = v_u_103
            local v580 = v_u_103.C1
            local v581 = v_u_103.C0:inverse() * v_u_60 * CFrame.new()
            local v582 = -10 * p481
            v579.C1 = v580:Lerp(v581, (1 - math.exp(v582)) * v_u_72)
        end
        local v583 = v_u_24:GetAttribute("SwayBase") or v_u_51.SwayBase
        local v584 = v_u_22
        local v585 = v_u_13.CFrame * CFrame.new(0, 0, -0.5)
        local v586 = CFrame.Angles
        local v587 = tick() * 2.5
        local v588 = v583 * math.sin(v587)
        local v589 = math.rad(v588)
        local v590 = tick() * 1.25
        local v591 = v583 * math.sin(v590)
        v584.CFrame = v585 * v586(v589, math.rad(v591), 0)
    end
end)
v55.Button1Up:Connect(function()
    -- upvalues: (ref) v_u_56, (ref) v_u_88, (ref) v_u_89
    if v_u_56 then
        v_u_88 = false
        v_u_89 = false
    end
end)
local v_u_593 = v5:WaitForChild("RocketSystem")
local v_u_594 = v_u_593.Events:WaitForChild("FireRocketBindable")
local v_u_595 = v_u_593.Events:WaitForChild("FireRocket")
local function v_u_639(p596) -- name: fireGun
    -- upvalues: (ref) v_u_51, (ref) v_u_24, (ref) v_u_104, (ref) v_u_56, (ref) v_u_128, (ref) v_u_88, (ref) v_u_472, (copy) v_u_73, (copy) v_u_125, (ref) v_u_25, (ref) v_u_70, (copy) v_u_22, (ref) v_u_83, (ref) v_u_84, (ref) v_u_94, (ref) v_u_23, (ref) v_u_129, (copy) v_u_142, (ref) v_u_68, (ref) v_u_93, (ref) v_u_112, (copy) v_u_247, (ref) v_u_67, (copy) v_u_451, (copy) v_u_177, (copy) v_u_27, (ref) v_u_52, (ref) v_u_74, (ref) v_u_66, (ref) v_u_69, (ref) v_u_130, (ref) v_u_89, (copy) v_u_220, (copy) v_u_593, (copy) v_u_17, (copy) v_u_595, (copy) v_u_594
    if v_u_51 and (v_u_51.Cooldown and v_u_24:GetAttribute("Cooldown")) then
        return
    end
    if v_u_51 and (v_u_51.EquipDelay and tick() - v_u_104 < v_u_51.EquipDelay) then
        return
    end
    if v_u_56 then
        v_u_128 = p596
        v_u_88 = true
        local v597 = v_u_472
        if v_u_73[v_u_24] <= 0 then
            if not table.find(v_u_125, v_u_25.Name) then
                v_u_70.Value = false
            end
            v_u_22.Click:Play()
            reloadGun(true)
            return
        end
        if v_u_83 or v_u_70.Value ~= true then
            v_u_22.Click:Play()
            return
        end
        if v_u_84 and not (v_u_94 or v_u_23) then
            v_u_84 = false
            local v598 = v_u_51.Mode
            if v598 == "Semi" and v_u_73[v_u_24] > 0 then
                if v597 ~= v_u_472 then
                    return
                end
                if v_u_129 then
                    coroutine.wrap(v_u_142)(p596, Enum.VibrationMotor.Small, math.random(300, 450) / 1000, v_u_68)
                end
                local v_u_599 = (v_u_93 or not v_u_51.HipfireSpreadMuitpler) and 1 or v_u_51.HipfireSpreadMuitpler
                if v_u_112 == Enum.UserInputType.Touch then
                    v_u_599 = v_u_599 * 0.25
                end
                local v_u_600 = {}
                for _ = 1, v_u_51.Bullets do
                    coroutine.resume(coroutine.create(function()
                        -- upvalues: (ref) v_u_247, (ref) v_u_599, (ref) v_u_67, (copy) v_u_600
                        local v601 = v_u_247(v_u_599 * v_u_67)
                        local v602 = v_u_600
                        table.insert(v602, v601)
                    end))
                end
                CastRay(v_u_600)
                v_u_451()
                v_u_73[v_u_24] = v_u_73[v_u_24] - 1
                v_u_177(true)
                v_u_27.ServerGunAnim:FireServer(v_u_68, v_u_52, v_u_24)
                if v_u_67 and not v_u_74 then
                    local v603 = v_u_24:GetAttribute("MaxSpread") or v_u_51.MaxSpread
                    local v604 = v_u_67 + v_u_51.AimInaccuracyStepAmount
                    v_u_67 = math.min(v603, v604)
                    local v605 = v_u_51.MaxRecoilPower
                    local v606 = v_u_66 + v_u_51.RecoilPowerStepAmount
                    v_u_66 = math.min(v605, v606)
                end
                v_u_74 = not v_u_74
                task.wait(v_u_68)
            elseif v598 == "Auto" then
                while v_u_88 and (v_u_56 and (not v_u_84 and (v_u_73[v_u_24] > 0 and (v597 == v_u_472 and v_u_51.Mode == v598)))) do
                    if v_u_129 then
                        coroutine.wrap(v_u_142)(p596, Enum.VibrationMotor.Small, math.random(300, 450) / 1000, v_u_68)
                    end
                    local v_u_607 = {}
                    for _ = 1, v_u_51.Bullets do
                        coroutine.resume(coroutine.create(function()
                            -- upvalues: (ref) v_u_247, (ref) v_u_67, (copy) v_u_607
                            local v608 = v_u_247(v_u_67)
                            local v609 = v_u_607
                            table.insert(v609, v608)
                        end))
                    end
                    CastRay(v_u_607)
                    v_u_451()
                    v_u_73[v_u_24] = v_u_73[v_u_24] - 1
                    v_u_177(true)
                    v_u_27.ServerGunAnim:FireServer(v_u_68, v_u_52, v_u_24)
                    if v_u_67 and not v_u_74 then
                        local v610 = v_u_24:GetAttribute("MaxSpread") or v_u_51.MaxSpread
                        local v611 = v_u_67 + v_u_51.AimInaccuracyStepAmount
                        v_u_67 = math.min(v610, v611)
                        local v612 = v_u_51.MaxRecoilPower
                        local v613 = v_u_66 + v_u_51.RecoilPowerStepAmount
                        v_u_66 = math.min(v612, v613)
                    end
                    v_u_74 = not v_u_74
                    task.wait(v_u_68)
                end
            elseif v598 == "Burst" and v_u_73[v_u_24] > 0 then
                for _ = 1, v_u_51.BurstShot do
                    if v597 ~= v_u_472 then
                        return
                    end
                    if v_u_51.Mode ~= v598 then
                        break
                    end
                    local v_u_614 = {}
                    for _ = 1, v_u_51.Bullets do
                        if v_u_88 and v_u_73[v_u_24] > 0 then
                            if v_u_129 then
                                coroutine.wrap(v_u_142)(p596, Enum.VibrationMotor.Small, math.random(400, 600) / 1000, v_u_69)
                            end
                            coroutine.resume(coroutine.create(function()
                                -- upvalues: (ref) v_u_247, (ref) v_u_67, (copy) v_u_614
                                local v615 = v_u_247(v_u_67)
                                local v616 = v_u_614
                                table.insert(v616, v615)
                            end))
                            CastRay(v_u_614)
                            v_u_451()
                            v_u_73[v_u_24] = v_u_73[v_u_24] - 1
                            v_u_177(true)
                        end
                    end
                    if v_u_67 and not v_u_74 then
                        local v617 = v_u_24:GetAttribute("MaxSpread") or v_u_51.MaxSpread
                        local v618 = v_u_67 + v_u_51.AimInaccuracyStepAmount
                        v_u_67 = math.min(v617, v618)
                        local v619 = v_u_51.MaxRecoilPower
                        local v620 = v_u_66 + v_u_51.RecoilPowerStepAmount
                        v_u_66 = math.min(v619, v620)
                    end
                    v_u_74 = not v_u_74
                    task.wait(v_u_69)
                end
            elseif (v598 == "Bolt-Action" or v598 == "Pump-Action") and v_u_73[v_u_24] > 0 then
                if v597 ~= v_u_472 then
                    return
                end
                v_u_27.ServerGunAnim:FireServer(v_u_68, v_u_52, v_u_24)
                if v_u_129 and v_u_130 then
                    coroutine.wrap(v_u_142)(p596, Enum.VibrationMotor.Large, math.random(350, 600) / 1000, v_u_68)
                elseif v_u_129 then
                    coroutine.wrap(v_u_142)(p596, Enum.VibrationMotor.Small, math.random(350, 600) / 1000, v_u_68)
                end
                local v_u_621 = {}
                local v_u_622 = (v_u_93 or not v_u_51.HipfireSpreadMuitpler) and 1 or v_u_51.HipfireSpreadMuitpler
                if v_u_112 == Enum.UserInputType.Touch then
                    v_u_622 = v_u_622 * 0.25
                end
                for _ = 1, v_u_51.Bullets do
                    coroutine.resume(coroutine.create(function()
                        -- upvalues: (ref) v_u_247, (ref) v_u_622, (ref) v_u_67, (copy) v_u_621
                        local v623 = v_u_247(v_u_622 * v_u_67)
                        local v624 = v_u_621
                        table.insert(v624, v623)
                    end))
                end
                CastRay(v_u_621)
                v_u_451()
                v_u_73[v_u_24] = v_u_73[v_u_24] - 1
                v_u_177(true)
                if v_u_67 and not v_u_74 then
                    local v625 = v_u_24:GetAttribute("MaxSpread") or v_u_51.MaxSpread
                    local v626 = v_u_67 + v_u_51.AimInaccuracyStepAmount
                    v_u_67 = math.min(v625, v626)
                    local v627 = v_u_51.MaxRecoilPower
                    local v628 = v_u_66 + v_u_51.RecoilPowerStepAmount
                    v_u_66 = math.min(v627, v628)
                end
                v_u_74 = not v_u_74
                if v_u_93 then
                    v_u_88 = false
                    v_u_89 = false
                    v_u_84 = false
                    v_u_94 = true
                    ChamberAnim(true)
                    if v597 ~= v_u_472 then
                        return
                    end
                    v_u_220()
                    v_u_84 = true
                    v_u_94 = false
                elseif not v_u_93 then
                    v_u_88 = false
                    v_u_89 = false
                    v_u_84 = false
                    v_u_94 = true
                    ChamberAnim(true)
                    if v597 ~= v_u_472 then
                        return
                    end
                    v_u_220()
                    v_u_84 = true
                    v_u_94 = false
                end
                task.wait(v_u_68)
            elseif v598 == "RPG" and v_u_73[v_u_24] > 0 then
                local v629 = v_u_247(v_u_67)
                local v630 = v_u_25.Rocket.Position
                local v631 = v_u_593.Rockets:WaitForChild("RPG Rocket")
                local v632 = require(v_u_24:WaitForChild("RocketSettings"))
                v_u_451()
                v_u_73[v_u_24] = v_u_73[v_u_24] - 1
                v_u_177(true)
                local v633 = {
                    ["Origin"] = v630,
                    ["Direction"] = v629,
                    ["Settings"] = v632,
                    ["RocketModel"] = v631,
                    ["Vehicle"] = v_u_24,
                    ["Weapon"] = v_u_24,
                    ["PlrFired"] = v_u_17
                }
                v_u_595:InvokeServer(v633)
                v_u_594:Fire(v_u_17, v633)
                if v_u_25:FindFirstChild("Rocket") then
                    v_u_25.Rocket.Transparency = 1
                end
                task.wait(0.2)
            elseif v598 == "Lock-On" and v_u_73[v_u_24] > 0 then
                local v634 = v_u_24:FindFirstChild("Target")
                if v634 and v634.Value then
                    local v635 = v634.Value
                    local v636 = v_u_593.Rockets:WaitForChild(v_u_24.Name .. " G-Rocket")
                    if v636:IsA("ObjectValue") then
                        v636 = v636.Value
                    end
                    local v637 = require(v_u_24:WaitForChild("RocketSettings"))
                    local v638 = {
                        ["Origin"] = v_u_25.Rocket.Position,
                        ["Direction"] = v_u_247(v_u_67),
                        ["Settings"] = v637,
                        ["RocketModel"] = v636,
                        ["Vehicle"] = v_u_24,
                        ["Weapon"] = v_u_24,
                        ["PlrFired"] = v_u_17,
                        ["Target"] = v635
                    }
                    v_u_595:InvokeServer(v638)
                    v_u_594:Fire(v_u_17, v638)
                    v_u_451()
                    v_u_73[v_u_24] = v_u_73[v_u_24] - 1
                    v_u_177(true)
                end
            end
            v_u_84 = true
            if v_u_73[v_u_24] <= 0 then
                if not table.find(v_u_125, v_u_25.Name) then
                    v_u_70.Value = false
                end
                reloadGun(true)
            end
        end
    end
end
function aimGun(p640) -- name: aimGun
    -- upvalues: (ref) v_u_25, (ref) v_u_56, (ref) v_u_95, (ref) v_u_93, (copy) v_u_13, (ref) v_u_23, (ref) v_u_94, (ref) v_u_129, (copy) v_u_142, (ref) v_u_24, (copy) v_u_22, (copy) v_u_42, (ref) v_u_46, (copy) v_u_2, (copy) v_u_47, (ref) v_u_80, (ref) v_u_105, (ref) v_u_112, (copy) v_u_41, (ref) v_u_51, (copy) v_u_127
    local v641
    if v_u_25 then
        v641 = v_u_25:FindFirstChild("GlassLense", true)
    else
        v641 = nil
    end
    if v_u_56 and (v_u_95 > -2 and (not v_u_93 and ((v_u_13.Focus.p - v_u_13.CFrame.p).magnitude < 1 and not v_u_23))) then
        if (v_u_25.Name == "RPG" or (v_u_25.Name == "Javelin" or v_u_25.Name ~= "Stinger")) and v_u_94 == true then
            return
        end
        if v_u_129 then
            coroutine.wrap(v_u_142)(p640, Enum.VibrationMotor.Small, math.random(100, 200) / 1000, 0.1)
        end
        v_u_95 = 2
        v_u_93 = true
        v_u_24:SetAttribute("Aiming", true)
        v_u_22.AimDown:Play()
        if v641 then
            if v641.Parent:GetAttribute("Glare") == true then
                v_u_42:Start(v_u_25)
            end
            if v_u_46 then
                v_u_46:Cancel()
            end
            v_u_46 = v_u_2:Create(v641, v_u_47, {
                ["Transparency"] = 1
            })
            for _, v642 in v641.Parent:GetDescendants() do
                if v642:IsA("Decal") and (v642.Name ~= "SecondaryCamo" and v642.Name ~= "PrimaryCamo") then
                    v_u_2:Create(v642, v_u_47, {
                        ["Transparency"] = 0
                    }):Play()
                elseif v642:IsA("ImageLabel") then
                    v_u_2:Create(v642, v_u_47, {
                        ["ImageTransparency"] = 0
                    }):Play()
                end
            end
            v_u_46:Play()
        end
        if v_u_25:FindFirstChild("Aim2", true) == nil then
            if v_u_80 == 1 then
                if v_u_24:GetAttribute("ChangeFOV") then
                    local v_u_643 = v_u_24:GetAttribute("ChangeFOV").X
                    local v_u_644 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_644, (ref) v_u_112, (copy) v_u_643, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v645 = v_u_105
                        local v646 = tick()
                        local v647 = v_u_644 / 90
                        local v648 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v649 = v_u_643
                        local v650 = math.rad(v649) / 2
                        local v651 = (math.tan(v650) / 0.7002075382097097 - 1) * v648 + 1
                        v_u_41((math.clamp(v651, 0.04, 1)))
                        while v_u_105 == v645 do
                            local v652 = tick() - v646
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_643 - v_u_13.FieldOfView) * (v652 / v647)
                            task.wait()
                            if v647 < v652 then
                                break
                            end
                        end
                    end)
                else
                    local v_u_653 = v_u_51.ChangeFOV[1]
                    local v_u_654 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_654, (ref) v_u_112, (copy) v_u_653, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v655 = v_u_105
                        local v656 = tick()
                        local v657 = v_u_654 / 90
                        local v658 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v659 = v_u_653
                        local v660 = math.rad(v659) / 2
                        local v661 = (math.tan(v660) / 0.7002075382097097 - 1) * v658 + 1
                        v_u_41((math.clamp(v661, 0.04, 1)))
                        while v_u_105 == v655 do
                            local v662 = tick() - v656
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_653 - v_u_13.FieldOfView) * (v662 / v657)
                            task.wait()
                            if v657 < v662 then
                                break
                            end
                        end
                    end)
                end
                if v_u_51.FocusOnSight or v_u_24:GetAttribute("FocusOnSight") then
                    v_u_127.AimShow:Play()
                else
                    v_u_127.AimHide:Play()
                end
            end
            if v_u_80 == 2 then
                if v_u_24:GetAttribute("ChangeFOV") then
                    local v_u_663 = v_u_24:GetAttribute("ChangeFOV").Y
                    local v_u_664 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_664, (ref) v_u_112, (copy) v_u_663, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v665 = v_u_105
                        local v666 = tick()
                        local v667 = v_u_664 / 90
                        local v668 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v669 = v_u_663
                        local v670 = math.rad(v669) / 2
                        local v671 = (math.tan(v670) / 0.7002075382097097 - 1) * v668 + 1
                        v_u_41((math.clamp(v671, 0.04, 1)))
                        while v_u_105 == v665 do
                            local v672 = tick() - v666
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_663 - v_u_13.FieldOfView) * (v672 / v667)
                            task.wait()
                            if v667 < v672 then
                                break
                            end
                        end
                    end)
                else
                    local v_u_673 = v_u_51.ChangeFOV[2]
                    local v_u_674 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_674, (ref) v_u_112, (copy) v_u_673, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v675 = v_u_105
                        local v676 = tick()
                        local v677 = v_u_674 / 90
                        local v678 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v679 = v_u_673
                        local v680 = math.rad(v679) / 2
                        local v681 = (math.tan(v680) / 0.7002075382097097 - 1) * v678 + 1
                        v_u_41((math.clamp(v681, 0.04, 1)))
                        while v_u_105 == v675 do
                            local v682 = tick() - v676
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_673 - v_u_13.FieldOfView) * (v682 / v677)
                            task.wait()
                            if v677 < v682 then
                                break
                            end
                        end
                    end)
                end
                if v_u_51.FocusOnSight2 or v_u_24:GetAttribute("FocusOnSight2") then
                    v_u_127.AimShow:Play()
                else
                    v_u_127.AimHide:Play()
                end
            end
        else
            if v_u_80 == 1 then
                if v_u_24:GetAttribute("ChangeFOV") then
                    local v_u_683 = v_u_24:GetAttribute("ChangeFOV").X
                    local v_u_684 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_684, (ref) v_u_112, (copy) v_u_683, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v685 = v_u_105
                        local v686 = tick()
                        local v687 = v_u_684 / 90
                        local v688 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v689 = v_u_683
                        local v690 = math.rad(v689) / 2
                        local v691 = (math.tan(v690) / 0.7002075382097097 - 1) * v688 + 1
                        v_u_41((math.clamp(v691, 0.04, 1)))
                        while v_u_105 == v685 do
                            local v692 = tick() - v686
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_683 - v_u_13.FieldOfView) * (v692 / v687)
                            task.wait()
                            if v687 < v692 then
                                break
                            end
                        end
                    end)
                else
                    local v_u_693 = v_u_51.ChangeFOV[1]
                    local v_u_694 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_694, (ref) v_u_112, (copy) v_u_693, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v695 = v_u_105
                        local v696 = tick()
                        local v697 = v_u_694 / 90
                        local v698 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v699 = v_u_693
                        local v700 = math.rad(v699) / 2
                        local v701 = (math.tan(v700) / 0.7002075382097097 - 1) * v698 + 1
                        v_u_41((math.clamp(v701, 0.04, 1)))
                        while v_u_105 == v695 do
                            local v702 = tick() - v696
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_693 - v_u_13.FieldOfView) * (v702 / v697)
                            task.wait()
                            if v697 < v702 then
                                break
                            end
                        end
                    end)
                end
                if v_u_51.FocusOnSight or v_u_24:GetAttribute("FocusOnSight") then
                    v_u_127.AimShow:Play()
                else
                    v_u_127.AimHide:Play()
                end
            end
            if v_u_80 == 2 then
                if v_u_24:GetAttribute("ChangeFOV") then
                    local v_u_703 = v_u_24:GetAttribute("ChangeFOV").Y
                    local v_u_704 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_704, (ref) v_u_112, (copy) v_u_703, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v705 = v_u_105
                        local v706 = tick()
                        local v707 = v_u_704 / 90
                        local v708 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v709 = v_u_703
                        local v710 = math.rad(v709) / 2
                        local v711 = (math.tan(v710) / 0.7002075382097097 - 1) * v708 + 1
                        v_u_41((math.clamp(v711, 0.04, 1)))
                        while v_u_105 == v705 do
                            local v712 = tick() - v706
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_703 - v_u_13.FieldOfView) * (v712 / v707)
                            task.wait()
                            if v707 < v712 then
                                break
                            end
                        end
                    end)
                else
                    local v_u_713 = v_u_51.ChangeFOV[2]
                    local v_u_714 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_714, (ref) v_u_112, (copy) v_u_713, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v715 = v_u_105
                        local v716 = tick()
                        local v717 = v_u_714 / 90
                        local v718 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v719 = v_u_713
                        local v720 = math.rad(v719) / 2
                        local v721 = (math.tan(v720) / 0.7002075382097097 - 1) * v718 + 1
                        v_u_41((math.clamp(v721, 0.04, 1)))
                        while v_u_105 == v715 do
                            local v722 = tick() - v716
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_713 - v_u_13.FieldOfView) * (v722 / v717)
                            task.wait()
                            if v717 < v722 then
                                break
                            end
                        end
                    end)
                end
                if v_u_51.FocusOnSight2 or v_u_24:GetAttribute("FocusOnSight2") then
                    v_u_127.AimShow:Play()
                else
                    v_u_127.AimHide:Play()
                end
            end
        end
    elseif v_u_93 and v_u_56 then
        if v_u_129 then
            coroutine.wrap(v_u_142)(p640, Enum.VibrationMotor.Small, math.random(100, 200) / 1000, 0.1)
        end
        if v641 then
            v_u_42:Stop()
            if v_u_46 then
                v_u_46:Cancel()
            end
            v_u_46 = v_u_2:Create(v641, v_u_47, {
                ["Transparency"] = v641:GetAttribute("OGTransparency")
            })
            for _, v723 in v641.Parent:GetDescendants() do
                if v723:IsA("Decal") and (v723.Name ~= "SecondaryCamo" and v723.Name ~= "PrimaryCamo") then
                    v_u_2:Create(v723, v_u_47, {
                        ["Transparency"] = 1
                    }):Play()
                elseif v723:IsA("ImageLabel") then
                    v_u_2:Create(v723, v_u_47, {
                        ["ImageTransparency"] = 1
                    }):Play()
                end
            end
            v_u_46:Play()
        end
        v_u_95 = 0
        v_u_41(1)
        v_u_22.AimUp:Play()
        local v_u_724 = 120
        local v_u_725 = 70
        task.spawn(function()
            -- upvalues: (ref) v_u_105, (copy) v_u_724, (ref) v_u_112, (copy) v_u_725, (ref) v_u_41, (ref) v_u_13
            v_u_105 = v_u_105 and v_u_105 + 1 or 0
            local v726 = v_u_105
            local v727 = tick()
            local v728 = v_u_724 / 90
            local v729 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
            local v730 = v_u_725
            local v731 = math.rad(v730) / 2
            local v732 = (math.tan(v731) / 0.7002075382097097 - 1) * v729 + 1
            v_u_41((math.clamp(v732, 0.04, 1)))
            while v_u_105 == v726 do
                local v733 = tick() - v727
                v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_725 - v_u_13.FieldOfView) * (v733 / v728)
                task.wait()
                if v728 < v733 then
                    break
                end
            end
        end)
        v_u_93 = false
        v_u_24:SetAttribute("Aiming", nil)
        v_u_127.AimHide:Play()
    end
end
function reloadGun(p734) -- name: reloadGun
    -- upvalues: (ref) v_u_56, (ref) v_u_95, (ref) v_u_25, (ref) v_u_24, (ref) v_u_51, (ref) v_u_86, (ref) v_u_94, (copy) v_u_73, (ref) v_u_70, (ref) v_u_88, (ref) v_u_89, (ref) v_u_84, (copy) v_u_593, (ref) v_u_93, (ref) v_u_83, (copy) v_u_220, (ref) v_u_85, (copy) v_u_177
    if v_u_56 and v_u_95 > -2 then
        local v735 = v_u_25.Name
        local v736 = v_u_24:GetAttribute("Ammo") or v_u_51.Ammo
        v_u_86 = false
        if v_u_51.Mode == "Explosive" or (v_u_94 or v_u_51.ReloadType ~= 1) then
            if v_u_51.Mode == "Explosive" or (v_u_94 or v_u_51.ReloadType ~= 2) then
                if v_u_51.Mode ~= "Explosive" and (v_u_94 and (v_u_51.ReloadType == 2 and (v_u_85 and not (p734 or v_u_86)))) then
                    v_u_86 = true
                    v_u_220()
                    task.wait(0.25)
                end
            else
                if v_u_51.IncludeChamberedBullet and v_u_73[v_u_24] == v736 + 1 or (not v_u_51.IncludeChamberedBullet and (v_u_73[v_u_24] == v736 and v_u_70.Value == true) or v_u_86) then
                    v_u_220()
                    return
                end
                v_u_88 = false
                v_u_89 = false
                v_u_84 = false
                v_u_94 = true
                for _ = 1, v736 - v_u_73[v_u_24] do
                    if not v_u_56 or (not v_u_25 or v_u_25.Name ~= v735) then
                        v_u_94 = false
                        return
                    end
                    if not v_u_86 and (v_u_73[v_u_24] < v736 and not v_u_85) then
                        ShellInsertAnim()
                        if v_u_25.Name ~= v735 then
                            return
                        end
                        local v737 = v_u_24:GetAttribute("Ammo") or v_u_51.Ammo
                        if v_u_51.ReloadType == 1 then
                            if v_u_73[v_u_24] > 0 and v_u_51.IncludeChamberedBullet == true then
                                v_u_73[v_u_24] = v737 + 1
                            else
                                v_u_73[v_u_24] = v737
                            end
                        elseif v_u_51.ReloadType == 2 and v_u_73[v_u_24] < v737 then
                            local v738 = v_u_73
                            local v739 = v_u_24
                            v738[v739] = v738[v739] + 1
                        end
                        v_u_177(true)
                    end
                end
                if v_u_70.Value == false and v_u_83 == true then
                    ChamberBKAnim()
                elseif v_u_70.Value == false and v_u_83 == false then
                    ChamberAnim()
                end
                if v_u_25.Name ~= v735 then
                    return
                end
                v_u_220()
                v_u_86 = false
                v_u_84 = true
                v_u_94 = false
            end
        else
            if v_u_51.IncludeChamberedBullet and v_u_73[v_u_24] == v736 + 1 or not v_u_51.IncludeChamberedBullet and (v_u_73[v_u_24] == v736 and v_u_70.Value == true) then
                return
            end
            v_u_88 = false
            v_u_89 = false
            v_u_84 = false
            v_u_94 = true
            if v_u_25.Name == "RPG" or (v_u_25.Name == "Javelin" or v_u_25.Name == "Stinger") then
                v_u_593.Events.RocketReloadedFX:FireServer(v_u_24, false)
                if v_u_93 == true then
                    aimGun()
                end
            end
            ReloadAnim()
            if not v_u_56 or (not v_u_25 or v_u_25.Name ~= v735) then
                v_u_94 = false
                return
            end
            if v_u_70.Value == false and v_u_83 == true then
                ChamberBKAnim()
            elseif v_u_70.Value == false and v_u_83 == false then
                ChamberAnim()
            end
            if v_u_25.Name ~= v735 then
                return
            end
            v_u_220()
            v_u_84 = true
            v_u_94 = false
            if v_u_25.Name == "RPG" or (v_u_25.Name == "Javelin" or v_u_25.Name == "Stinger") then
                v_u_593.Events.RocketReloadedFX:FireServer(v_u_24, true)
            end
        end
        v_u_177(true)
    end
end
function chamberGun() -- name: chamberGun
    -- upvalues: (ref) v_u_56, (ref) v_u_94, (ref) v_u_95, (copy) v_u_125, (ref) v_u_25, (ref) v_u_88, (ref) v_u_89, (ref) v_u_84, (ref) v_u_472, (ref) v_u_83, (copy) v_u_220
    if v_u_56 and (not v_u_94 and (v_u_95 > -2 and not table.find(v_u_125, v_u_25.Name))) then
        v_u_88 = false
        v_u_89 = false
        v_u_84 = false
        v_u_94 = true
        local v740 = v_u_472
        if v_u_83 then
            ChamberBKAnim()
        else
            ChamberAnim()
        end
        if v740 ~= v_u_472 then
            return
        end
        v_u_220()
        v_u_84 = true
        v_u_94 = false
    end
end
local function v_u_741() -- name: changeFireMode
    -- upvalues: (ref) v_u_56, (ref) v_u_51, (copy) v_u_22, (copy) v_u_177
    if v_u_56 and v_u_51.FireModes.ChangeFiremode then
        v_u_22.SafetyClick:Play()
        if v_u_51.Mode == "Semi" and v_u_51.FireModes.Burst == true then
            v_u_51.Mode = "Burst"
        elseif v_u_51.Mode == "Semi" and (v_u_51.FireModes.Burst == false and v_u_51.FireModes.Auto == true) then
            v_u_51.Mode = "Auto"
        elseif v_u_51.Mode == "Semi" and (v_u_51.FireModes.Burst == false and (v_u_51.FireModes.Auto == false and v_u_51.FireModes.Explosive == true)) then
            v_u_51.Mode = "Explosive"
        elseif v_u_51.Mode == "Burst" and v_u_51.FireModes.Auto == true then
            v_u_51.Mode = "Auto"
        elseif v_u_51.Mode == "Burst" and (v_u_51.FireModes.Explosive == true and v_u_51.FireModes.Auto == false) then
            v_u_51.Mode = "Explosive"
        elseif v_u_51.Mode == "Burst" and (v_u_51.FireModes.Semi == true and (v_u_51.FireModes.Auto == false and v_u_51.FireModes.Explosive == false)) then
            v_u_51.Mode = "Semi"
        elseif v_u_51.Mode == "Auto" and v_u_51.FireModes.Explosive == true then
            v_u_51.Mode = "Explosive"
        elseif v_u_51.Mode == "Auto" and (v_u_51.FireModes.Semi == true and v_u_51.FireModes.Explosive == false) then
            v_u_51.Mode = "Semi"
        elseif v_u_51.Mode == "Auto" and (v_u_51.FireModes.Semi == false and (v_u_51.FireModes.Burst == true and v_u_51.FireModes.Explosive == false)) then
            v_u_51.Mode = "Burst"
        elseif v_u_51.Mode == "Explosive" and v_u_51.FireModes.Semi == true then
            v_u_51.Mode = "Semi"
        elseif v_u_51.Mode == "Explosive" and (v_u_51.FireModes.Semi == false and v_u_51.FireModes.Burst == true) then
            v_u_51.Mode = "Burst"
        elseif v_u_51.Mode == "Explosive" and (v_u_51.FireModes.Semi == false and (v_u_51.FireModes.Burst == false and v_u_51.FireModes.Auto == true)) then
            v_u_51.Mode = "Auto"
        end
        v_u_177()
    end
end
local v_u_742 = nil
local function v_u_824() -- name: swapGunScope
    -- upvalues: (ref) v_u_56, (ref) v_u_25, (ref) v_u_742, (ref) v_u_80, (copy) v_u_2, (ref) v_u_93, (ref) v_u_24, (ref) v_u_105, (ref) v_u_112, (copy) v_u_41, (copy) v_u_13, (ref) v_u_51, (copy) v_u_127
    local v743 = v_u_56 and v_u_25:FindFirstChild("ScopePivot", true)
    if v743 then
        if v_u_742 then
            v_u_742:Cancel()
        end
        if v_u_80 == 2 then
            v_u_742 = v_u_2:Create(v743.PivotWeld, TweenInfo.new(0.15), {
                ["C1"] = CFrame.new()
            })
            v_u_742:Play()
        elseif v_u_80 == 1 then
            v_u_742 = v_u_2:Create(v743.PivotWeld, TweenInfo.new(0.15), {
                ["C1"] = CFrame.new(0, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
            })
            v_u_742:Play()
        end
    end
    if v_u_93 and v_u_56 then
        if v_u_25:FindFirstChild("Aim2", true) == nil then
            if v_u_80 == 1 then
                v_u_80 = 2
                if v_u_24:GetAttribute("ChangeFOV") then
                    local v_u_744 = v_u_24:GetAttribute("ChangeFOV").Y
                    local v_u_745 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_745, (ref) v_u_112, (copy) v_u_744, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v746 = v_u_105
                        local v747 = tick()
                        local v748 = v_u_745 / 90
                        local v749 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v750 = v_u_744
                        local v751 = math.rad(v750) / 2
                        local v752 = (math.tan(v751) / 0.7002075382097097 - 1) * v749 + 1
                        v_u_41((math.clamp(v752, 0.04, 1)))
                        while v_u_105 == v746 do
                            local v753 = tick() - v747
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_744 - v_u_13.FieldOfView) * (v753 / v748)
                            task.wait()
                            if v748 < v753 then
                                break
                            end
                        end
                    end)
                else
                    local v_u_754 = v_u_51.ChangeFOV[2]
                    local v_u_755 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_755, (ref) v_u_112, (copy) v_u_754, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v756 = v_u_105
                        local v757 = tick()
                        local v758 = v_u_755 / 90
                        local v759 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v760 = v_u_754
                        local v761 = math.rad(v760) / 2
                        local v762 = (math.tan(v761) / 0.7002075382097097 - 1) * v759 + 1
                        v_u_41((math.clamp(v762, 0.04, 1)))
                        while v_u_105 == v756 do
                            local v763 = tick() - v757
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_754 - v_u_13.FieldOfView) * (v763 / v758)
                            task.wait()
                            if v758 < v763 then
                                break
                            end
                        end
                    end)
                end
                if v_u_51.FocusOnSight2 or v_u_24:GetAttribute("FocusOnSight2") then
                    if v_u_93 then
                        v_u_127.AimShow:Play()
                    else
                        v_u_127.AimHide:Play()
                    end
                end
            elseif v_u_80 == 2 then
                v_u_80 = 1
                if v_u_24:GetAttribute("ChangeFOV") then
                    local v_u_764 = v_u_24:GetAttribute("ChangeFOV").X
                    local v_u_765 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_765, (ref) v_u_112, (copy) v_u_764, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v766 = v_u_105
                        local v767 = tick()
                        local v768 = v_u_765 / 90
                        local v769 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v770 = v_u_764
                        local v771 = math.rad(v770) / 2
                        local v772 = (math.tan(v771) / 0.7002075382097097 - 1) * v769 + 1
                        v_u_41((math.clamp(v772, 0.04, 1)))
                        while v_u_105 == v766 do
                            local v773 = tick() - v767
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_764 - v_u_13.FieldOfView) * (v773 / v768)
                            task.wait()
                            if v768 < v773 then
                                break
                            end
                        end
                    end)
                else
                    local v_u_774 = v_u_51.ChangeFOV[1]
                    local v_u_775 = 120
                    task.spawn(function()
                        -- upvalues: (ref) v_u_105, (copy) v_u_775, (ref) v_u_112, (copy) v_u_774, (ref) v_u_41, (ref) v_u_13
                        v_u_105 = v_u_105 and v_u_105 + 1 or 0
                        local v776 = v_u_105
                        local v777 = tick()
                        local v778 = v_u_775 / 90
                        local v779 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                        local v780 = v_u_774
                        local v781 = math.rad(v780) / 2
                        local v782 = (math.tan(v781) / 0.7002075382097097 - 1) * v779 + 1
                        v_u_41((math.clamp(v782, 0.04, 1)))
                        while v_u_105 == v776 do
                            local v783 = tick() - v777
                            v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_774 - v_u_13.FieldOfView) * (v783 / v778)
                            task.wait()
                            if v778 < v783 then
                                break
                            end
                        end
                    end)
                end
                if v_u_51.FocusOnSight or v_u_24:GetAttribute("FocusOnSight") then
                    if v_u_93 then
                        v_u_127.AimShow:Play()
                    else
                        v_u_127.AimHide:Play()
                    end
                end
            end
        elseif v_u_80 == 1 then
            v_u_80 = 2
            if v_u_24:GetAttribute("ChangeFOV") then
                local v_u_784 = v_u_24:GetAttribute("ChangeFOV").Y
                local v_u_785 = 120
                task.spawn(function()
                    -- upvalues: (ref) v_u_105, (copy) v_u_785, (ref) v_u_112, (copy) v_u_784, (ref) v_u_41, (ref) v_u_13
                    v_u_105 = v_u_105 and v_u_105 + 1 or 0
                    local v786 = v_u_105
                    local v787 = tick()
                    local v788 = v_u_785 / 90
                    local v789 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                    local v790 = v_u_784
                    local v791 = math.rad(v790) / 2
                    local v792 = (math.tan(v791) / 0.7002075382097097 - 1) * v789 + 1
                    v_u_41((math.clamp(v792, 0.04, 1)))
                    while v_u_105 == v786 do
                        local v793 = tick() - v787
                        v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_784 - v_u_13.FieldOfView) * (v793 / v788)
                        task.wait()
                        if v788 < v793 then
                            break
                        end
                    end
                end)
            else
                local v_u_794 = v_u_51.ChangeFOV[2]
                local v_u_795 = 120
                task.spawn(function()
                    -- upvalues: (ref) v_u_105, (copy) v_u_795, (ref) v_u_112, (copy) v_u_794, (ref) v_u_41, (ref) v_u_13
                    v_u_105 = v_u_105 and v_u_105 + 1 or 0
                    local v796 = v_u_105
                    local v797 = tick()
                    local v798 = v_u_795 / 90
                    local v799 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                    local v800 = v_u_794
                    local v801 = math.rad(v800) / 2
                    local v802 = (math.tan(v801) / 0.7002075382097097 - 1) * v799 + 1
                    v_u_41((math.clamp(v802, 0.04, 1)))
                    while v_u_105 == v796 do
                        local v803 = tick() - v797
                        v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_794 - v_u_13.FieldOfView) * (v803 / v798)
                        task.wait()
                        if v798 < v803 then
                            break
                        end
                    end
                end)
            end
            if v_u_51.FocusOnSight2 or v_u_24:GetAttribute("FocusOnSight2") then
                if v_u_93 then
                    v_u_127.AimShow:Play()
                else
                    v_u_127.AimHide:Play()
                end
            end
        elseif v_u_80 == 2 then
            v_u_80 = 1
            if v_u_24:GetAttribute("ChangeFOV") then
                local v_u_804 = v_u_24:GetAttribute("ChangeFOV").X
                local v_u_805 = 120
                task.spawn(function()
                    -- upvalues: (ref) v_u_105, (copy) v_u_805, (ref) v_u_112, (copy) v_u_804, (ref) v_u_41, (ref) v_u_13
                    v_u_105 = v_u_105 and v_u_105 + 1 or 0
                    local v806 = v_u_105
                    local v807 = tick()
                    local v808 = v_u_805 / 90
                    local v809 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                    local v810 = v_u_804
                    local v811 = math.rad(v810) / 2
                    local v812 = (math.tan(v811) / 0.7002075382097097 - 1) * v809 + 1
                    v_u_41((math.clamp(v812, 0.04, 1)))
                    while v_u_105 == v806 do
                        local v813 = tick() - v807
                        v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_804 - v_u_13.FieldOfView) * (v813 / v808)
                        task.wait()
                        if v808 < v813 then
                            break
                        end
                    end
                end)
            else
                local v_u_814 = v_u_51.ChangeFOV[1]
                local v_u_815 = 120
                task.spawn(function()
                    -- upvalues: (ref) v_u_105, (copy) v_u_815, (ref) v_u_112, (copy) v_u_814, (ref) v_u_41, (ref) v_u_13
                    v_u_105 = v_u_105 and v_u_105 + 1 or 0
                    local v816 = v_u_105
                    local v817 = tick()
                    local v818 = v_u_815 / 90
                    local v819 = v_u_112 == Enum.UserInputType.Touch and 1.4 or 1
                    local v820 = v_u_814
                    local v821 = math.rad(v820) / 2
                    local v822 = (math.tan(v821) / 0.7002075382097097 - 1) * v819 + 1
                    v_u_41((math.clamp(v822, 0.04, 1)))
                    while v_u_105 == v816 do
                        local v823 = tick() - v817
                        v_u_13.FieldOfView = v_u_13.FieldOfView + (v_u_814 - v_u_13.FieldOfView) * (v823 / v818)
                        task.wait()
                        if v818 < v823 then
                            break
                        end
                    end
                end)
            end
            if v_u_51.FocusOnSight or v_u_24:GetAttribute("FocusOnSight") then
                if v_u_93 then
                    v_u_127.AimShow:Play()
                else
                    v_u_127.AimHide:Play()
                end
            end
        end
    elseif v_u_80 == 1 then
        v_u_80 = 2
        if v_u_51.FocusOnSight2 or v_u_24:GetAttribute("FocusOnSight2") then
            if v_u_93 then
                v_u_127.AimShow:Play()
            else
                v_u_127.AimHide:Play()
            end
        end
    elseif v_u_80 == 2 then
        v_u_80 = 1
        if v_u_51.FocusOnSight or v_u_24:GetAttribute("FocusOnSight") then
            if v_u_93 then
                v_u_127.AimShow:Play()
                return
            end
            v_u_127.AimHide:Play()
        end
    end
end
v_u_77:WaitForChild("Mobile"):WaitForChild("Fire").MouseButton1Down:Connect(function()
    -- upvalues: (ref) v_u_112, (copy) v_u_6, (ref) v_u_89, (copy) v_u_639
    v_u_112 = v_u_6:GetLastInputType()
    if v_u_112 == Enum.UserInputType.Touch then
        v_u_89 = true
        v_u_639(nil)
    end
end)
v_u_77:WaitForChild("Mobile"):WaitForChild("Fire").MouseButton1Up:Connect(function()
    -- upvalues: (ref) v_u_112, (copy) v_u_6, (ref) v_u_56, (ref) v_u_88, (ref) v_u_89
    v_u_112 = v_u_6:GetLastInputType()
    if v_u_112 == Enum.UserInputType.Touch and v_u_56 then
        v_u_88 = false
        v_u_89 = false
    end
end)
v_u_77:WaitForChild("Mobile"):WaitForChild("Reload").InputBegan:Connect(reloadGun)
v_u_77:WaitForChild("Mobile"):WaitForChild("Aim").InputBegan:Connect(function()
    -- upvalues: (ref) v_u_112
    aimGun(v_u_112)
end)
v_u_77:WaitForChild("Mobile"):WaitForChild("ScopeSwap").InputBegan:Connect(v_u_824)
v_u_77:WaitForChild("Mobile"):WaitForChild("FireMode").InputBegan:Connect(v_u_741)
local v_u_825 = 0
local v_u_826 = RaycastParams.new()
v_u_826.FilterType = Enum.RaycastFilterType.Exclude
local v_u_827 = nil
local v_u_828 = nil
local v_u_829 = 0
local v_u_830 = {}
local function v_u_842(p831) -- name: autoFire
    -- upvalues: (ref) v_u_112, (ref) v_u_829, (ref) v_u_830, (ref) v_u_24, (ref) v_u_25, (ref) v_u_51, (copy) v_u_6, (copy) v_u_826, (copy) v_u_53, (ref) v_u_100, (ref) v_u_101, (copy) v_u_13, (ref) v_u_828, (copy) v_u_1, (ref) v_u_825, (copy) v_u_639, (ref) v_u_89, (ref) v_u_88
    if v_u_112 == Enum.UserInputType.Touch then
        if v_u_829 > 60 then
            v_u_829 = 0
            v_u_830 = {}
        else
            v_u_829 = v_u_829 + p831
        end
        if v_u_24 and v_u_25 then
            if v_u_51.Mode ~= "RPG" and v_u_51.GunType ~= 3 then
                v_u_112 = v_u_6:GetLastInputType()
                local v832 = v_u_826
                local v833 = {}
                local v834 = v_u_830
                __set_list(v833, 1, {v_u_25, v_u_24, v_u_53, v_u_100, v_u_101, v_u_13, unpack(v834)})
                v832.FilterDescendantsInstances = v833
                local v835 = v_u_13.CFrame.Position
                local v836 = v_u_13.CFrame.LookVector
                local v837 = workspace:Raycast(v835, v836 * 300, v_u_826)
                if v837 then
                    if v837.Instance.CanCollide == false and v837.Instance.Transparency == 1 then
                        local v838 = v_u_830
                        local v839 = v837.Instance
                        table.insert(v838, v839)
                        return
                    end
                    local v840 = v837.Instance:FindFirstAncestorOfClass("Model")
                    local v841
                    if v840 then
                        v841 = v840:FindFirstChild("Humanoid")
                    else
                        v841 = v840
                    end
                    if v841 and (v841.Health > 0 and (not v840:FindFirstChildOfClass("Forcefield") and (not v_u_828 or v841 == v_u_828))) and true or false then
                        if not v_u_1:GetPlayerFromCharacter(v840) then
                            return
                        end
                        v_u_828 = v841
                        v_u_825 = v_u_825 + p831
                        if v_u_825 > 0.2 or (v_u_51.Mode == "Auto" or v_u_51.Mode == "Pump-Action") then
                            v_u_639()
                            return
                        end
                    else
                        v_u_825 = 0
                        v_u_828 = nil
                        if not v_u_89 then
                            v_u_88 = false
                            return
                        end
                    end
                else
                    v_u_825 = 0
                    v_u_828 = nil
                    if not v_u_89 then
                        v_u_88 = false
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local v_u_843 = v_u_17.SettingsFolder:FindFirstChild("autoFire")
local function v_u_845() -- name: connectAutoFire
    -- upvalues: (ref) v_u_827, (copy) v_u_843, (copy) v_u_4, (copy) v_u_842
    if v_u_827 then
        return
    elseif v_u_843.Value == true then
        v_u_827 = v_u_4.Heartbeat:Connect(function(p844)
            -- upvalues: (ref) v_u_842
            v_u_842(p844)
        end)
    end
end
local function v_u_846() -- name: disconnectAutoFire
    -- upvalues: (ref) v_u_827
    if v_u_827 then
        v_u_827:Disconnect()
        v_u_827 = nil
    end
end
if v_u_843 then
    v_u_843.Changed:Connect(function()
        -- upvalues: (copy) v_u_843, (ref) v_u_56, (ref) v_u_845, (ref) v_u_846
        if v_u_843.Value == true and v_u_56 then
            v_u_845()
        else
            v_u_846()
        end
    end)
end
v_u_6.InputBegan:Connect(function(p847, p848)
    -- upvalues: (ref) v_u_128, (ref) v_u_129, (copy) v_u_9, (ref) v_u_130, (ref) v_u_89, (copy) v_u_639, (ref) v_u_56, (ref) v_u_94, (copy) v_u_142, (copy) v_u_824, (ref) v_u_51, (copy) v_u_741
    if not p848 then
        v_u_128 = p847
        v_u_129 = v_u_9:IsVibrationSupported(p847.UserInputType)
        if v_u_129 then
            v_u_130 = v_u_9:IsMotorSupported(p847.UserInputType, Enum.VibrationMotor.Large)
        end
        if p847.KeyCode == Enum.KeyCode.ButtonR2 or p847.UserInputType == Enum.UserInputType.MouseButton1 then
            v_u_89 = true
            v_u_639(p847)
        end
        if p847.KeyCode == Enum.KeyCode.ButtonL2 or p847.UserInputType == Enum.UserInputType.MouseButton2 then
            aimGun(p847)
        end
        if (p847.KeyCode == Enum.KeyCode.ButtonX or p847.KeyCode == Enum.KeyCode.R) and v_u_56 then
            reloadGun()
        end
        if (p847.KeyCode == Enum.KeyCode.ButtonY or p847.KeyCode == Enum.KeyCode.F) and (v_u_56 and not v_u_94) then
            chamberGun()
        end
        if (p847.KeyCode == Enum.KeyCode.DPadUp or p847.KeyCode == Enum.KeyCode.T) and v_u_56 then
            if v_u_129 then
                coroutine.wrap(v_u_142)(p847, Enum.VibrationMotor.Small, math.random(100, 200) / 1000, 0.1)
            end
            v_u_824()
        end
        if (p847.KeyCode == Enum.KeyCode.DPadDown or p847.KeyCode == Enum.KeyCode.V) and (v_u_56 and v_u_51.FireModes.ChangeFiremode) then
            if v_u_129 then
                coroutine.wrap(v_u_142)(p847, Enum.VibrationMotor.Small, math.random(100, 200) / 1000, 0.1)
            end
            v_u_741()
        end
    end
end)
v_u_54.Died:connect(function()
    -- upvalues: (ref) v_u_129, (ref) v_u_130, (copy) v_u_142, (ref) v_u_128, (copy) v_u_144, (copy) v_u_54, (copy) v_u_219, (ref) v_u_592, (ref) v_u_119
    if v_u_129 and v_u_130 then
        coroutine.wrap(v_u_142)(v_u_128, Enum.VibrationMotor.Large, math.random(800, 1100) / 1000, 0.2)
    elseif v_u_129 then
        coroutine.wrap(v_u_142)(v_u_128, Enum.VibrationMotor.Small, math.random(800, 1100) / 1000, 0.2)
    end
    v_u_144()
    v_u_54:UnequipTools()
    v_u_219()
    v_u_592:Disconnect()
    for _, v849 in pairs(v_u_119) do
        v849:disconnect()
    end
    v_u_119 = {}
end)
local v_u_850 = true
task.delay(5, function()
    -- upvalues: (ref) v_u_850
    v_u_850 = false
end)
v137.Event:Connect(function(p851)
    -- upvalues: (ref) v_u_850
    v_u_850 = true
    task.delay(p851, function()
        -- upvalues: (ref) v_u_850
        v_u_850 = false
    end)
end)
local function v859(_, p852) -- name: onStateChanged
    -- upvalues: (ref) v_u_57, (ref) v_u_56, (ref) v_u_51, (copy) v_u_219, (copy) v_u_115, (ref) v_u_82, (copy) v_u_117, (copy) v_u_33, (copy) v_u_17, (ref) v_u_850, (copy) v_u_54, (copy) v_u_8, (ref) v_u_92, (copy) v_u_27, (ref) v_u_129, (ref) v_u_130, (copy) v_u_142, (ref) v_u_128
    if p852 == Enum.HumanoidStateType.Swimming then
        v_u_57 = true
        if v_u_56 and not v_u_51.AllowedInWater then
            v_u_219()
            v_u_115:UnequipTools()
        end
    else
        v_u_57 = false
    end
    if p852 == Enum.HumanoidStateType.Freefall and not v_u_82 then
        v_u_82 = true
        local v853 = 0
        local v854 = 0
        while v_u_82 do
            v854 = v_u_117.Velocity.magnitude
            v853 = v853 + 1
            task.wait()
        end
        local v855 = (v854 - v_u_33.MaxVelocity) * v_u_33.DamageMult
        if v855 > 5 and (v853 > 20 and (v_u_17.Team.Name ~= "Loading" and v_u_850 == false)) then
            local v856 = Instance.new("Sound")
            v856.SoundId = "rbxassetid://13592161628"
            local v857 = v855 / v_u_54.MaxHealth
            v856.Volume = math.clamp(v857, 0, 0.5)
            v856.Parent = v_u_17.PlayerGui
            v856:Play()
            v_u_8:AddItem(v856, v856.TimeLength + 2)
            task.spawn(function()
                -- upvalues: (ref) v_u_92, (ref) v_u_27
                local v_u_858 = false
                task.delay(100, function()
                    -- upvalues: (ref) v_u_858, (ref) v_u_92
                    if not v_u_858 then
                        v_u_92 = true
                    end
                end)
                v_u_27.FDMG.OnClientEvent:Wait()
                v_u_858 = true
            end)
            v_u_27.FDMG:FireServer((math.clamp(v855, 5, 400)))
            if v_u_129 and v_u_130 then
                coroutine.wrap(v_u_142)(v_u_128, Enum.VibrationMotor.Large, math.random(350, 600) / 1000, math.random(150, 200) / 1000)
                return
            end
            if v_u_129 then
                coroutine.wrap(v_u_142)(v_u_128, Enum.VibrationMotor.Small, math.random(350, 600) / 1000, math.random(150, 200) / 1000)
                return
            end
        end
    elseif p852 == Enum.HumanoidStateType.Landed or p852 == Enum.HumanoidStateType.Dead then
        v_u_82 = false
    end
end
v_u_54.Seated:Connect(function(p860, p861)
    -- upvalues: (copy) v_u_43, (copy) v_u_44, (copy) v_u_45, (ref) v_u_850, (copy) v_u_54
    if p860 and p861 then
        for _, v862 in p861:GetFullName():split(".") do
            if v_u_43[v862] or (v_u_44[v862] or v_u_45[v862]) then
                v_u_850 = true
                return
            end
        end
    elseif v_u_850 == true then
        task.wait(0.75)
        if v_u_54.Seated == true then
            return
        end
        v_u_850 = false
    end
end)
v_u_54.StateChanged:connect(v859)
function IdleAnim() -- name: IdleAnim
    -- upvalues: (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_96, (ref) v_u_97, (copy) v_u_120
    local v863 = coroutine.create(function()
        -- upvalues: (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_96, (ref) v_u_97
        v_u_52.IdleAnim(v_u_53, nil, {
            v_u_101,
            v_u_98,
            v_u_99,
            v_u_100.GripW,
            v_u_25,
            v_u_96,
            v_u_97
        })
    end)
    coroutine.resume(v863)
    local v864 = v_u_120
    table.insert(v864, v863)
end
function SprintAnim() -- name: SprintAnim
    -- upvalues: (ref) v_u_85, (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_96, (ref) v_u_97, (copy) v_u_120
    if not v_u_85 then
        local v865 = coroutine.create(function()
            -- upvalues: (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_96, (ref) v_u_97
            v_u_52.SprintAnim(v_u_53, nil, {
                v_u_101,
                v_u_98,
                v_u_99,
                v_u_100.GripW,
                v_u_25,
                v_u_96,
                v_u_97
            })
        end)
        coroutine.resume(v865)
        local v866 = v_u_120
        table.insert(v866, v865)
    end
end
function EquipAnim() -- name: EquipAnim
    -- upvalues: (ref) v_u_56, (ref) v_u_85, (ref) v_u_84, (ref) v_u_94, (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_96, (ref) v_u_97, (copy) v_u_120
    if v_u_56 ~= false then
        local v867 = coroutine.create(function()
            -- upvalues: (ref) v_u_85, (ref) v_u_84, (ref) v_u_94, (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_96, (ref) v_u_97
            v_u_85 = true
            v_u_84 = false
            v_u_94 = true
            v_u_52.EquipAnim(v_u_53, nil, {
                v_u_101,
                v_u_98,
                v_u_99,
                v_u_100.GripW,
                v_u_25,
                v_u_96,
                v_u_97
            })
            v_u_94 = false
            v_u_84 = true
            v_u_85 = false
        end)
        coroutine.resume(v867)
        local v868 = v_u_120
        table.insert(v868, v867)
        repeat
            task.wait()
        until v_u_85 == false or not v867
    end
end
function ChamberAnim(p_u_869) -- name: ChamberAnim
    -- upvalues: (ref) v_u_56, (ref) v_u_85, (copy) v_u_36, (ref) v_u_25, (copy) v_u_73, (ref) v_u_24, (ref) v_u_70, (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_51, (ref) v_u_97, (ref) v_u_96, (ref) v_u_83, (copy) v_u_125, (copy) v_u_177, (copy) v_u_120
    if v_u_56 ~= false then
        local v874 = coroutine.create(function()
            -- upvalues: (ref) v_u_85, (ref) v_u_36, (ref) v_u_25, (ref) v_u_73, (ref) v_u_24, (ref) v_u_70, (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_51, (ref) v_u_97, (ref) v_u_96, (copy) p_u_869, (ref) v_u_83, (ref) v_u_125, (ref) v_u_177
            v_u_85 = true
            if v_u_36.Value == true then
                local v_u_870 = v_u_25.Chamber:FindFirstChild("Shell") or v_u_25.Chamber:FindFirstChild("ShellANIM")
                if v_u_73[v_u_24] > 0 and (v_u_70.Value == true and v_u_870) then
                    task.delay(v_u_870.Delay.Value, function()
                        -- upvalues: (copy) v_u_870
                        v_u_870:Emit(1)
                    end)
                end
            end
            local v871 = v_u_70.Value
            v_u_70.Value = false
            v_u_52.ChamberAnim(v_u_53, nil, {
                v_u_101,
                v_u_98,
                v_u_99,
                v_u_100.GripW,
                v_u_25,
                v_u_51,
                v_u_97,
                v_u_96
            })
            if v_u_73[v_u_24] > 0 and (v871 == true and not p_u_869) then
                local v872 = v_u_73
                local v873 = v_u_24
                v872[v873] = v872[v873] - 1
            end
            v_u_83 = false
            if v_u_73[v_u_24] >= 1 then
                v_u_70.Value = true
            elseif not (p_u_869 or table.find(v_u_125, v_u_25.Name)) then
                v_u_70.Value = false
            end
            v_u_177(true)
            v_u_85 = false
        end)
        coroutine.resume(v874)
        local v875 = v_u_120
        table.insert(v875, v874)
        repeat
            task.wait()
        until v_u_85 == false or not v874
    end
end
function ChamberBKAnim() -- name: ChamberBKAnim
    -- upvalues: (ref) v_u_85, (ref) v_u_70, (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_51, (ref) v_u_96, (ref) v_u_97, (ref) v_u_83, (copy) v_u_73, (ref) v_u_24, (copy) v_u_177, (copy) v_u_120
    local v876 = coroutine.create(function()
        -- upvalues: (ref) v_u_85, (ref) v_u_70, (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_51, (ref) v_u_96, (ref) v_u_97, (ref) v_u_83, (ref) v_u_73, (ref) v_u_24, (ref) v_u_177
        v_u_85 = true
        v_u_70.Value = false
        v_u_52.ChamberBKAnim(v_u_53, nil, {
            v_u_101,
            v_u_98,
            v_u_99,
            v_u_100.GripW,
            v_u_25,
            v_u_51,
            v_u_96,
            v_u_97
        })
        v_u_83 = false
        if v_u_73[v_u_24] > 0 then
            v_u_70.Value = true
        end
        v_u_85 = false
        v_u_177(true)
    end)
    coroutine.resume(v876)
    local v877 = v_u_120
    table.insert(v877, v876)
    repeat
        task.wait()
    until v_u_85 == false or not v876
end
function ShellInsertAnim() -- name: ShellInsertAnim
    -- upvalues: (ref) v_u_85, (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_51, (ref) v_u_70, (ref) v_u_96, (ref) v_u_97, (copy) v_u_120
    local v878 = coroutine.create(function()
        -- upvalues: (ref) v_u_85, (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_51, (ref) v_u_70, (ref) v_u_96, (ref) v_u_97
        v_u_85 = true
        v_u_52.ShellInsertAnim(v_u_53, nil, {
            v_u_101,
            v_u_98,
            v_u_99,
            v_u_100.GripW,
            v_u_25,
            nil,
            nil,
            v_u_51,
            v_u_70,
            v_u_96,
            v_u_97
        })
        v_u_85 = false
    end)
    coroutine.resume(v878)
    local v879 = v_u_120
    table.insert(v879, v878)
    repeat
        task.wait()
    until v_u_85 == false or not v878
end
function ReloadAnim() -- name: ReloadAnim
    -- upvalues: (ref) v_u_85, (ref) v_u_51, (ref) v_u_76, (ref) v_u_24, (copy) v_u_177, (ref) v_u_52, (copy) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (copy) v_u_73, (ref) v_u_70, (ref) v_u_96, (ref) v_u_97, (copy) v_u_120
    if v_u_85 then
        warn("anim deb")
    else
        local v888 = coroutine.create(function()
            -- upvalues: (ref) v_u_51, (ref) v_u_76, (ref) v_u_24, (ref) v_u_177, (ref) v_u_85, (ref) v_u_52, (ref) v_u_53, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (ref) v_u_100, (ref) v_u_25, (ref) v_u_73, (ref) v_u_70, (ref) v_u_96, (ref) v_u_97
            if v_u_51 and v_u_51.Cooldown then
                v_u_76.AmmoText.Text = "Cooldown"
                local v880 = v_u_24:GetAttribute("Cooldown") or v_u_51.Cooldown
                local v881 = v_u_24:GetAttribute("LastCooldownTick") or tick()
                local v882 = v880 - (tick() - v881)
                local v883 = math.round(v882)
                if v883 > 0 then
                    for v884 = v883, 0, -1 do
                        v_u_24:SetAttribute("Cooldown", v884)
                        v_u_24:SetAttribute("LastCooldownTick", tick())
                        v_u_76.AmmoTextSecondary.Text = "- " .. v884
                        task.wait(1)
                    end
                    v_u_24:SetAttribute("Cooldown", nil)
                    v_u_24:SetAttribute("LastCooldownTick", nil)
                else
                    v_u_24:SetAttribute("Cooldown", nil)
                    v_u_24:SetAttribute("LastCooldownTick", nil)
                    v_u_177(true)
                end
            else
                v_u_85 = true
                v_u_52.ReloadAnim(v_u_53, nil, {
                    v_u_101,
                    v_u_98,
                    v_u_99,
                    v_u_100.GripW,
                    v_u_25,
                    nil,
                    v_u_73[v_u_24],
                    v_u_51,
                    v_u_70,
                    v_u_96,
                    v_u_97
                })
            end
            task.wait()
            local v885 = v_u_24:GetAttribute("Ammo") or v_u_51.Ammo
            if v_u_51.ReloadType == 1 then
                if v_u_73[v_u_24] > 0 and v_u_51.IncludeChamberedBullet == true then
                    v_u_73[v_u_24] = v885 + 1
                else
                    v_u_73[v_u_24] = v885
                end
            elseif v_u_51.ReloadType == 2 and v_u_73[v_u_24] < v885 then
                local v886 = v_u_73
                local v887 = v_u_24
                v886[v887] = v886[v887] + 1
            end
            v_u_177(true)
            v_u_85 = false
        end)
        coroutine.resume(v888)
        local v889 = v_u_120
        table.insert(v889, v888)
        repeat
            task.wait()
        until v_u_85 == false or not v888
    end
end
