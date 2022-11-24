local L_1_ = "t"
local L_2_ = game.Players.LocalPlayer:GetMouse()
L_2_.KeyDown:Connect(
	function(L_22_arg0)
		if L_22_arg0 == L_1_ then
			if DaHoodSettings.SilentAim == true then
				DaHoodSettings.SilentAim = false
			else
				DaHoodSettings.SilentAim = true
			end
		end
	end
)
game:GetService("RunService").RenderStepped:Connect(
function()
	for L_23_forvar0, L_24_forvar1 in pairs(game.CoreGui:GetChildren()) do
		if L_24_forvar1.Name == "PostmansAutoRob" then
			L_24_forvar1:Destroy()
		end
	end
	for L_25_forvar0, L_26_forvar1 in pairs(game.CoreGui:GetChildren()) do
		if L_26_forvar1.Name == "WarningGUI" then
			L_26_forvar1:Destroy()
		end
	end
end
)

--- Notifications ---
game.StarterGui:SetCore(
	"SendNotification",
	{
		Title = "shezan.paste",
		Text = "Loading . . .",
	}
)
wait(1)
game.StarterGui:SetCore(
	"SendNotification",
	{
		Title = "Made by",
		Text = "(shezans dev team)",
	}
)
wait(1)
game.StarterGui:SetCore(
	"SendNotification",
	{
		Title = "shezan.paste",
		Text = "Loaded!",
	}
)

--- ui lib and shit ---

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/slattisbabygirl/cattoware/main/Wcatto.lua"))()
    local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))()
    local Notify = NotifyLibrary.Notify
    Library.theme.accentcolor = Color3.fromRGB(255, 0, 0)
    Library.theme.accentcolor2 = Color3.fromRGB(255, 0, 0)

--- TABS  ---
    local Window = Library:CreateWindow("shezan.paste 📌", Vector2.new(492, 598), Enum.KeyCode.RightShift)
    local AimingTab = Window:CreateTab("AimLock")




--- Aimlock settings ---

getgenv().OldAimPart = "HumanoidRootPart"
getgenv().AimPart = "HumanoidRootPart" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}
getgenv().AimlockKey = "q"
getgenv().AimRadius = 50 -- How far away from someones character you want to lock on at
getgenv().ThirdPerson = true
getgenv().FirstPerson = true
getgenv().TeamCheck = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
getgenv().PredictMovement = true -- Predicts if they are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed
getgenv().PredictionVelocity = 9
getgenv().CheckIfJumped = false
getgenv().AutoPrediction = false
local L_13_, L_14_, L_15_, L_16_ = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
local L_17_, L_18_, L_19_, L_20_, L_21_, L_22_, L_23_ = L_13_.LocalPlayer, L_13_.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
local L_24_, L_25_, L_26_ = false, false, false;
local L_27_;
local L_28_;
getgenv().WorldToViewportPoint = function(L_91_arg0)
	return L_19_:WorldToViewportPoint(L_91_arg0)
end
getgenv().WorldToScreenPoint = function(L_92_arg0)
	return L_19_.WorldToScreenPoint(L_19_, L_92_arg0)
end
getgenv().GetObscuringObjects = function(L_93_arg0)
	if L_93_arg0 and L_93_arg0:FindFirstChild(getgenv().AimPart) and L_17_ and L_17_.Character:FindFirstChild("Head") then
		local L_94_ = workspace:FindPartOnRay(L_21_(
                L_93_arg0[getgenv().AimPart].Position, L_17_.Character.Head.Position)
            )
		if L_94_ then
			return L_94_:IsDescendantOf(L_93_arg0)
		end
	end
end
getgenv().GetNearestTarget = function()
    
	local L_95_ = {}
	local L_96_  = {}
	local L_97_ = {}
	for L_99_forvar0, L_100_forvar1 in pairs(L_13_:GetPlayers()) do
		if L_100_forvar1 ~= L_17_ then
			table.insert(L_95_, L_100_forvar1)
		end
	end
	for L_101_forvar0, L_102_forvar1 in pairs(L_95_) do
		if L_102_forvar1.Character ~= nil then
			local L_103_ = L_102_forvar1.Character:FindFirstChild("Head")
			if getgenv().TeamCheck == true and L_102_forvar1.Team ~= L_17_.Team then
				local L_104_ = (L_102_forvar1.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
				local L_105_ = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (L_18_.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * L_104_)
				local L_106_, L_107_ = game.Workspace:FindPartOnRay(L_105_, game.Workspace)
				local L_108_ = math.floor((L_107_ - L_103_.Position).magnitude)
				L_96_[L_102_forvar1.Name .. L_101_forvar0] = {}
				L_96_[L_102_forvar1.Name .. L_101_forvar0].dist = L_104_
				L_96_[L_102_forvar1.Name .. L_101_forvar0].plr = L_102_forvar1
				L_96_[L_102_forvar1.Name .. L_101_forvar0].diff = L_108_
				table.insert(L_97_, L_108_)
			elseif getgenv().TeamCheck == false and L_102_forvar1.Team == L_17_.Team then
				local L_109_ = (L_102_forvar1.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
				local L_110_ = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (L_18_.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * L_109_)
				local L_111_, L_112_ = game.Workspace:FindPartOnRay(L_110_, game.Workspace)
				local L_113_ = math.floor((L_112_ - L_103_.Position).magnitude)
				L_96_[L_102_forvar1.Name .. L_101_forvar0] = {}
				L_96_[L_102_forvar1.Name .. L_101_forvar0].dist = L_109_
				L_96_[L_102_forvar1.Name .. L_101_forvar0].plr = L_102_forvar1
				L_96_[L_102_forvar1.Name .. L_101_forvar0].diff = L_113_
				table.insert(L_97_, L_113_)
			end
		end
	end
	if unpack(L_97_) == nil then
		return nil
	end
	local L_98_ = math.floor(math.min(unpack(L_97_)))
	if L_98_ > getgenv().AimRadius then
		return nil
	end
	for L_114_forvar0, L_115_forvar1 in pairs(L_96_) do
		if L_115_forvar1.diff == L_98_ then
			return L_115_forvar1.plr
		end
	end
	return nil
end
L_18_.KeyDown:Connect(function(L_116_arg0)
	if not (L_14_:GetFocusedTextBox()) then
		if L_116_arg0 == AimlockKey and L_27_ == nil then
			pcall(function()
				if L_25_ ~= true then
					L_25_ = true
				end
				local L_117_;
				L_117_ = GetNearestTarget()
				if L_117_ ~= nil then
					L_27_ = L_117_
				end
			end)
		elseif L_116_arg0 == AimlockKey and L_27_ ~= nil then
			if L_27_ ~= nil then
				L_27_ = nil
			end
			if L_25_ ~= false then
				L_25_ = false
			end
		end
	end
end)
L_15_.RenderStepped:Connect(function()
	if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then
		if (L_19_.Focus.p - L_19_.CoordinateFrame.p).Magnitude > 1 or (L_19_.Focus.p - L_19_.CoordinateFrame.p).Magnitude <= 1 then
			L_26_ = true
		else
			L_26_ = false
		end
	elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then
		if (L_19_.Focus.p - L_19_.CoordinateFrame.p).Magnitude > 1 then
			L_26_ = true
		else
			L_26_ = false
		end
	elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then
		if (L_19_.Focus.p - L_19_.CoordinateFrame.p).Magnitude <= 1 then
			L_26_ = true
		else
			L_26_ = false
		end
	end
	if L_24_ == true and L_25_ == true then
		if L_27_ and L_27_.Character and L_27_.Character:FindFirstChild(getgenv().AimPart) then
			if getgenv().FirstPerson == true then
				if L_26_ == true then
					if getgenv().PredictMovement == true then
						L_19_.CFrame = L_20_(L_19_.CFrame.p, L_27_.Character[getgenv().AimPart].Position + L_27_.Character[getgenv().AimPart].Velocity / PredictionVelocity)
					elseif getgenv().PredictMovement == false then
						L_19_.CFrame = L_20_(L_19_.CFrame.p, L_27_.Character[getgenv().AimPart].Position)
					end
				end
			elseif getgenv().ThirdPerson == true then
				if L_26_ == true then
					if getgenv().PredictMovement == true then
						L_19_.CFrame = L_20_(L_19_.CFrame.p, L_27_.Character[getgenv().AimPart].Position + L_27_.Character[getgenv().AimPart].Velocity / PredictionVelocity)
					elseif getgenv().PredictMovement == false then
						L_19_.CFrame = L_20_(L_19_.CFrame.p, L_27_.Character[getgenv().AimPart].Position)
					end
				end
			end
		end
	end
	if CheckIfJumped == true then
		if L_27_.Character.Humanoid.FloorMaterial == Enum.Material.Air then
			getgenv().AimPart = "RightFoot"
		else
			getgenv().AimPart = getgenv().OldAimPart
		end
	end
end)







 -- Aimbot Setion --
    
 local Wsector = AimingTab:CreateSector("AimLock", "left")

 Wsector:AddToggle("Aimlock",false,function(L_122_arg0)
     L_24_ = L_122_arg0
     end)
     

 Wsector:AddToggle("Airshot Function",false,function(L_131_arg0)
     CheckIfJumped =  L_131_arg0
     end)
         
         
 Wsector:AddToggle("Auto Prediction",false,function(L_132_arg0)
     AutoPrediction = L_132_arg0
     end)

     Wsector:AddTextbox("Aimlock Keybind",false,function(L_123_arg0)
         AimlockKey = L_123_arg0
         end)
         
         Wsector:AddTextbox("Prediction Velocity",false,function(L_124_arg0)
         PredictionVelocity = L_124_arg0
         end)
         
         
         
         Wsector:AddDropdown("Hitbox",{"Head";"UpperTorso";"HumanoidRootPart", "LowerTorso"},"Head",false, function(L_125_arg0)
         getgenv().AimPart = L_125_arg0
         getgenv().OldAimPart = L_125_arg0
         end)




         local WAimlockfov1ref = AimingTab:CreateSector("Aimlock FOV", "left")


local L_10_ = game.Players.LocalPlayer
local L_11_ = L_10_:GetMouse()
local L_12_ = game:GetService("RunService")

circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255, 0, 0)
circle.Thickness = 0.1
circle.NumSides = 3500
circle.Radius = 50
circle.Visible = false
circle.Filled = false
circle.Transparency = 0.5

L_12_.RenderStepped:Connect(function()
	circle.Position = Vector2.new(L_11_.X, L_11_.Y + 35)
end)

WAimlockfov1ref:AddToggle("Aimlock Fov", false, function(L_127_arg0)
	circle.Visible = L_127_arg0
end)




WAimlockfov1ref:AddToggle("Filled Fov", false, function(L_129_arg0)
	circle.Filled = L_129_arg0
end)


WAimlockfov1ref:AddToggle("Square Fov", false, function()
	circle.NumSides = 4
end)

WAimlockfov1ref:AddToggle("Circle Fov", false, function()
	circle.NumSides = 350
end)

WAimlockfov1ref:AddSlider("Size Fov", 0, 1, 250, 30, function(L_130_arg0)
	circle.Radius = L_130_arg0
end)



 --- test setings ---

 local L_1_ = "t"
local L_2_ = game.Players.LocalPlayer:GetMouse()
L_2_.KeyDown:Connect(
	function(L_22_arg0)
		if L_22_arg0 == L_1_ then
			if DaHoodSettings.SilentAim == true then
				DaHoodSettings.SilentAim = false
			else
				DaHoodSettings.SilentAim = true
			end
		end
	end
)
game:GetService("RunService").RenderStepped:Connect(
function()
	for L_23_forvar0, L_24_forvar1 in pairs(game.CoreGui:GetChildren()) do
		if L_24_forvar1.Name == "PostmansAutoRob" then
			L_24_forvar1:Destroy()
		end
	end
	for L_25_forvar0, L_26_forvar1 in pairs(game.CoreGui:GetChildren()) do
		if L_26_forvar1.Name == "WarningGUI" then
			L_26_forvar1:Destroy()
		end
	end
end
)


local sonnedLlololol = AimingTab:CreateSector("Silent Aim", "right")

sonnedLlololol:AddToggle("SilentAim",false,function(uwu)
    local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/slattisbabygirl/W-project/main/1", true))()
end)

sonnedLlololol:AddToggle("Toggle Fov",false,function(L_75_arg0)
    Aiming.ShowFOV = L_75_arg0
end)

sonnedLlololol:AddToggle("100% airshot",false,function()
    
end)


local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    SilentAim = true,
    AimLock = false,
    Prediction = 0.157,
    AimLockKeybind = Enum.KeyCode.E
}
getgenv().DaHoodSettings = DaHoodSettings

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)


sonnedLlololol:AddTextbox("Prediction Velocity",false,function(L_72_arg0)
    DaHoodSettings.Prediction = L_72_arg0
    end)

    

    sonnedLlololol:AddSlider("HitChance", 0, 75, 100, 30, function(value)
        Aiming.HitChance = value
    end)
    
  

    sonnedLlololol:AddSlider("SilentAim Fov Size", 0, 50, 250, 30, function(L_74_arg0)
        Aiming.FOV = L_74_arg0
        end)

    sonnedLlololol:AddDropdown("Hitbox",{"Head";"UpperTorso";"HumanoidRootPart", "LowerTorso"},"HumanoidRootPart",false, function(L_73_arg0)
        Aiming.TargetPart = L_73_arg0
    end)







    --- misc tabs ---

    local Misctablolxdrawruwu = Window:CreateTab("Misc")
    local sector11 = Misctablolxdrawruwu:CreateSector("Others (1)", "left")

    sector11:AddButton("Spinbot (C)", function(L_165_)
        local L_165_ = false
        local L_166_ = game:GetService("UserInputService");
        L_166_.InputBegan:Connect(function(L_167_arg0, L_168_arg1)
            if (L_167_arg0.KeyCode == Enum.KeyCode.C and L_168_arg1 == false) then
                if L_165_ == false then
                    L_165_ = true
                    wait()
                    getgenv().urspeed = 500
                    local L_169_ = game.Players.LocalPlayer.Character
                    while wait() do
                        L_169_.HumanoidRootPart.CFrame = L_169_.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(urspeed), 0)
                    end
                else
                    L_165_ = false
                    getgenv().urspeed = 0
                end
            end
        end);
        game:GetService('RunService').Stepped:connect(function()
            if L_165_ == true then
            end
        end)
        game:GetService('RunService').Stepped:connect(function()
            if L_165_ == false then
                stopTracks();
            end
        end)
    end)
    
    sector11:AddButton("Lay Spinbot (T) ", function()
        local L_383_ = false
        local L_384_ = game:GetService("UserInputService");
        L_384_.InputBegan:Connect(function(L_385_arg0, L_386_arg1)
            if (L_385_arg0.KeyCode == Enum.KeyCode.T and L_386_arg1 == false) then
                if L_383_ == false then
                    L_383_ = true
                    wait()
                    getgenv().urspeed = 500
                    local L_387_ = game.Players.LocalPlayer.Character
                    while wait() do
                        L_387_.HumanoidRootPart.CFrame = L_387_.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(urspeed), 0)
                    end
                else
                    L_383_ = false
                    getgenv().urspeed = 0
                end
            end
        end);
        game:GetService('RunService').Stepped:connect(function()
            if L_383_ == true then
                local L_388_ = Instance.new("Animation");
                function stopTracks()
                    for L_389_forvar0, L_390_forvar1 in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks(
        
            ) do
                        if (L_390_forvar1.Animation.AnimationId:match("rbxassetid")) then
                            L_390_forvar1:Stop();
                        end;
                    end;
                end;
                function loadAnimation(L_391_arg0)
                    if L_388_.AnimationId == L_391_arg0 then
                        L_388_.AnimationId = "1";
                    else
                        L_388_.AnimationId = L_391_arg0;
                        local L_392_ =
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(
                    L_388_
                );
                        L_392_:Play();
                    end;
                end;
                loadAnimation("rbxassetid://3152378852");
                wait(1.2)
            end
        end)
        game:GetService('RunService').Stepped:connect(function()
            if L_383_ == false then
                stopTracks();
            end
        end)
    end)
    
    
    
        
        sector11:AddButton("No Recoil", function()
            function isframework(L_158_arg0)
            if tostring(L_158_arg0) == "Framework" then
                return true
            end
            return false
        end
        function checkArgs(L_159_arg0, L_160_arg1)
            if tostring(L_159_arg0):lower():find("camera") and tostring(L_160_arg1) == "CFrame" then
                return true
            end
            return false
        end
        newindex = hookmetamethod(game, "__newindex", function(L_161_arg0, L_162_arg1, L_163_arg2)
            local L_164_ = getcallingscript()
            if isframework(L_164_) and checkArgs(L_161_arg0, L_162_arg1) then
                return;
            end
            return newindex(L_161_arg0, L_162_arg1, L_163_arg2)
        end)
        end)
        
        sector11:AddButton("Server Hop", function()
           local x = {}
                for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
                    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                        x[#x + 1] = v.id
                    end
                end
                if #x > 0 then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
                else
                 game.StarterGui:SetCore("SendNotification", {
        Title = "Kzumaki";
        Text = "Failed 2 Find Server";
        Duration = 3;
    })
    wait(0)
                end
            end)
    
    sector11:AddButton("Underground (P,O)", function()
    underground = false
            plr = game.Players.LocalPlayer
            mouse = plr:GetMouse()
            mouse.KeyDown:connect(function(key)
            
            if key == "o" then
            
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-9,0)
            game:GetService('RunService').Stepped:connect(function()
            if underground then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end
            end)
            end
            end)
            wait()
            
            plr = game.Players.LocalPlayer
            mouse = plr:GetMouse()
            mouse.KeyDown:connect(function(key)
            
            if key == "p" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,11,0)
            underground = not underground
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end
            end)
    end)
    
    sector11:AddButton("Buy Armor", function()
    local plr = game.Players.LocalPlayer
        local savedarmourpos = plr.Character.HumanoidRootPart.Position
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-938.476685, -25.2498264, 570.100159, -0.0353576206, 9.85617206e-08, -0.999374807, -2.69198441e-09, 1, 9.871858e-08, 0.999374807, 6.18077589e-09, -0.0353576206)
        wait(.2)
    
        fireclickdetector(game.Workspace.Ignored.Shop['[High-Medium Armor] - $2300'].ClickDetector)
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
    end)
    
    sector11:AddButton("Double Barrel Ammo", function()
    local L_506_ = game.Workspace.Ignored.Shop['18 [Double-Barrel SG Ammo] - $60']
        local L_507_ = L_10_.Character.HumanoidRootPart.Position
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = L_506_.Head.CFrame + Vector3.new(0, 3, 0)
        wait(0.5)
        fireclickdetector(game.Workspace.Ignored.Shop['18 [Double-Barrel SG Ammo] - $60'].ClickDetector)
        fireclickdetector(game.Workspace.Ignored.Shop['18 [Double-Barrel SG Ammo] - $60'].ClickDetector)
        L_10_.Character.HumanoidRootPart.CFrame = CFrame.new(L_507_)
        L_10_.Character.HumanoidRootPart.CFrame = CFrame.new(L_507_)
    end)
    sector11:AddButton("Revolver Ammo", function()
        L_10_ = game:GetService'Players'.LocalPlayer
            local L_501_ = '12 [Revolver Ammo] - $75'
            local L_502_ = game.Workspace.Ignored.Shop[L_501_]
            local L_503_ = L_10_.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = L_502_.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop[L_501_].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop[L_501_].ClickDetector)
            L_10_.Character.HumanoidRootPart.CFrame = CFrame.new(L_503_)
            L_10_.Character.HumanoidRootPart.CFrame = CFrame.new(L_503_)
        end)

        sector11:AddButton("Animation Pack", function()
            local FreeAnimationPack = Instance.new("ScreenGui")
                            local AnimationPack = Instance.new("TextButton")
                            local Animations = Instance.new("ScrollingFrame")
                            local UIListLayout = Instance.new("UIListLayout")
                            local Lean = Instance.new("TextButton")
                            local Lay = Instance.new("TextButton")
                            local Dance1 = Instance.new("TextButton")
                            local Dance2 = Instance.new("TextButton")
                            local Greet = Instance.new("TextButton")
                            local ChestPump = Instance.new("TextButton")
                            local Praying = Instance.new("TextButton")
                            local Stop = Instance.new("TextButton")
                            local UniversalAnimation = Instance.new("Animation");
            
                            function stopTracks()
                                for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
                                    if (v.Animation.AnimationId:match("rbxassetid")) then
                                        v:Stop();
                                    end;
                                end;
                            end;
            
                            function loadAnimation(id)
                                if UniversalAnimation.AnimationId == id then
                                    stopTracks();
                                    UniversalAnimation.AnimationId = "1";
                                else
                                    UniversalAnimation.AnimationId = id;
                                    local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation);
                                    animationTrack:Play();
                                end;
                            end;
            
                            FreeAnimationPack.Name = "FreeAnimationPack"
                            FreeAnimationPack.Parent = game.CoreGui;
                            FreeAnimationPack.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
                            AnimationPack.Name = "AnimationPack"
                            AnimationPack.Parent = FreeAnimationPack
                            AnimationPack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            AnimationPack.BorderSizePixel = 0
                            AnimationPack.Position = UDim2.new(0, 0, 0.388007045, 0)
                            AnimationPack.Size = UDim2.new(0, 100, 0, 20)
                            AnimationPack.Font = Enum.Font.SourceSansBold
                            AnimationPack.Text = "Animations"
                            AnimationPack.TextColor3 = Color3.fromRGB(0, 0, 0)
                            AnimationPack.TextSize = 18.000
                            AnimationPack.MouseButton1Click:Connect(function()
                                if (Animations.Visible == false) then
                                    Animations.Visible = true;
                                end;
                            end);
            
                            Animations.Name = "Animations"
                            Animations.Parent = AnimationPack
                            Animations.Active = true
                            Animations.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
                            Animations.Position = UDim2.new(-0.104712225, 0, -1.54173493, 0)
                            Animations.Size = UDim2.new(0, 120, 0, 195)
                            Animations.Visible = false
                            Animations.CanvasPosition = Vector2.new(0, 60.0000305)
                            Animations.CanvasSize = UDim2.new(0, 0, 1, 235)
            
                            UIListLayout.Parent = Animations
                            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                            UIListLayout.Padding = UDim.new(0, 2)
            
                            Lean.Name = "Lean"
                            Lean.Parent = Animations
                            Lean.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Lean.Size = UDim2.new(1, 0, 0, 30)
                            Lean.Font = Enum.Font.SourceSansBold
                            Lean.Text = "Lean"
                            Lean.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Lean.TextSize = 14.000
                            Lean.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3152375249");
                            end);
            
                            Lay.Name = "Lay"
                            Lay.Parent = Animations
                            Lay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Lay.Size = UDim2.new(1, 0, 0, 30)
                            Lay.Font = Enum.Font.SourceSansBold
                            Lay.Text = "Lay"
                            Lay.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Lay.TextSize = 14.000
                            Lay.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3152378852");
                            end);
            
                            Dance1.Name = "Dance1"
                            Dance1.Parent = Animations
                            Dance1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Dance1.Size = UDim2.new(1, 0, 0, 30)
                            Dance1.Font = Enum.Font.SourceSansBold
                            Dance1.Text = "Dance1"
                            Dance1.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Dance1.TextSize = 14.000
                            Dance1.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3189773368");
                            end);
            
                            Dance2.Name = "Dance2"
                            Dance2.Parent = Animations
                            Dance2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Dance2.Size = UDim2.new(1, 0, 0, 30)
                            Dance2.Font = Enum.Font.SourceSansBold
                            Dance2.Text = "Dance2"
                            Dance2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Dance2.TextSize = 14.000
                            Dance2.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3189776546");
                            end);
            
                            Greet.Name = "Greet"
                            Greet.Parent = Animations
                            Greet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Greet.Size = UDim2.new(1, 0, 0, 30)
                            Greet.Font = Enum.Font.SourceSansBold
                            Greet.Text = "Greet"
                            Greet.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Greet.TextSize = 14.000
                            Greet.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3189777795");
                            end);
            
                            ChestPump.Name = "ChestPump"
                            ChestPump.Parent = Animations
                            ChestPump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ChestPump.Size = UDim2.new(1, 0, 0, 30)
                            ChestPump.Font = Enum.Font.SourceSansBold
                            ChestPump.Text = "Chest Pump"
                            ChestPump.TextColor3 = Color3.fromRGB(0, 0, 0)
                            ChestPump.TextSize = 14.000
                            ChestPump.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3189779152");
                            end);
            
                            Praying.Name = "Praying"
                            Praying.Parent = Animations
                            Praying.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Praying.Size = UDim2.new(1, 0, 0, 30)
                            Praying.Font = Enum.Font.SourceSansBold
                            Praying.Text = "Praying"
                            Praying.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Praying.TextSize = 14.000
                            Praying.MouseButton1Click:Connect(function()
                                stopTracks();
                                loadAnimation("rbxassetid://3487719500");
                            end);
            
                            Stop.Name = "Stop"
                            Stop.Parent = Animations
                            Stop.BackgroundColor3 = Color3.fromRGB(255, 112, 112)
                            Stop.Size = UDim2.new(1, 0, 0, 30)
                            Stop.Font = Enum.Font.SourceSansBold
                            Stop.Text = "Stop Animation"
                            Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Stop.TextSize = 14.000
                            Stop.MouseButton1Click:Connect(function()
                                stopTracks();
                            end);
                            --scripts
                            local plr = game.Players.LocalPlayer
            
                            plr:GetMouse().KeyDown:Connect(function(K)
                                if K == "p" then
                                    Animations.Visible = false
                                end
                            end)
            end)
            
            sector11:AddButton("No Fog", function()
            while true do
                            wait()
                            game.Lighting.FogEnd = 1000000
                            wait()
                            end
            end)
            
            sector11:AddButton("Rejoin", function()
             local tpservice= game:GetService("TeleportService")
                        local plr = game.Players.LocalPlayer
            
                        tpservice:Teleport(game.PlaceId, plr)
            end)

            sector11:AddButton("Chat Spy", function()
                -- // Initialise
          --if (getgenv().ChatSpy) then return getgenv().ChatSpy; end;
          repeat wait() until game:GetService("ContentProvider").RequestQueueSize == 0;
          repeat wait() until game:IsLoaded();
  
          -- // Vars
          local Players = game:GetService("Players");
          local StarterGui = game:GetService("StarterGui");
          local ReplicatedStorage = game:GetService("ReplicatedStorage");
          local LocalPlayer = Players.LocalPlayer;
          local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
          local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents");
          local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest");
          local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering");
          getgenv().ChatSpy = {
              Enabled = true,
              SpyOnSelf = true,
              Public = false,
              Chat = {
                  Colour  = Color3.fromRGB(255, 0, 0),
                  Font = Enum.Font.SourceSans,
                  TextSize = 18,
                  Text = "",
              },
              IgnoreList = {
                  {Message = ":part/1/1/1", ExactMatch = true},
                  {Message = ":part/10/10/10", ExactMatch = true},
                  {Message = "A?????????", ExactMatch = false},
                  {Message = ":colorshifttop 10000 0 0", ExactMatch = true},
                  {Message = ":colorshiftbottom 10000 0 0", ExactMatch = true},
                  {Message = ":colorshifttop 0 10000 0", ExactMatch = true},
                  {Message = ":colorshiftbottom 0 10000 0", ExactMatch = true},
                  {Message = ":colorshifttop 0 0 10000", ExactMatch = true},
                  {Message = ":colorshiftbottom 0 0 10000", ExactMatch = true},
              },
          };
  
          -- // Function
          function ChatSpy.checkIgnored(message)
              for i = 1, #ChatSpy.IgnoreList do
                  local v = ChatSpy.IgnoreList[i];
                  if (v.ExactMatch and message == v.Message) or (not v.ExactMatch and string.match(v.Message, message)) then
                      return true;
                  end;
              end;
              return false;
          end;
  
          function ChatSpy.onChatted(targetPlayer, message)
              if (targetPlayer == LocalPlayer and string.lower(message):sub(1, 4) == "/spy") then
                  ChatSpy.Enabled = not ChatSpy.Enabled; wait(0.3);
                  ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");
  
                  StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);
              elseif (ChatSpy.Enabled and (ChatSpy.SpyOnSelf or targetPlayer ~= LocalPlayer)) then
                  local message = message:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ');
  
                  local Hidden = true;
                  local Connection = OnMessageDoneFiltering.OnClientEvent:Connect(function(packet, channel)
                      if (packet.SpeakerUserId == targetPlayer.UserId and packet.Message == message:sub(#message - #packet.Message + 1) and (channel == "All" or (channel == "Team" and not ChatSpy.Public and Players[packet.FromSpeaker].Team == LocalPlayer.Team))) then
                          Hidden = false;
                      end;
                  end);
  
                  wait(1);
                  Connection:Disconnect();
  
                  if (Hidden and ChatSpy.Enabled and not ChatSpy.checkIgnored(message)) then
                      if (#message > 1200) then
                          message = message:sub(1200) .. "...";
                      end;
                      ChatSpy.Chat.Text = "[SPY] - ["..targetPlayer.Name.."]: " .. message;
                      if (ChatSpy.Public) then SayMessageRequest:FireServer(ChatSpy.Chat.Text, "All"); else StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat); end;
                  end;
              end;
          end;
  
          -- // Handling Chats
          local AllPlayers = Players:GetPlayers();
          for i = 1, #AllPlayers do
              local player = AllPlayers[i];
              player.Chatted:Connect(function(message)
                  ChatSpy.onChatted(player, message);
              end);
          end;
  
          Players.PlayerAdded:Connect(function(player)
              player.Chatted:Connect(function(message)
                  ChatSpy.onChatted(player, message);
              end);
          end);
  
          -- // Initialise Text
          ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");
          StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);
  
          -- // Update Chat Frame
          local chatFrame = LocalPlayer.PlayerGui.Chat.Frame;
          chatFrame.ChatChannelParentFrame.Visible = true;
          chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y);
          end)
      
      sector11:AddButton("Speed Glitch (X)", function()
          local Player = game:GetService("Players").LocalPlayer
              local Mouse = Player:GetMouse()
              local SpeedGlitch = false
              local Wallet = Player.Backpack:FindFirstChild("Wallet")
  
              local UniversalAnimation = Instance.new("Animation")
  
              function stopTracks()
                  for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
                      if (v.Animation.AnimationId:match("rbxassetid")) then
                          v:Stop()
                      end
                  end
              end
  
              function loadAnimation(id)
                  if UniversalAnimation.AnimationId == id then
                      stopTracks()
                      UniversalAnimation.AnimationId = "1"
                  else
                      UniversalAnimation.AnimationId = id
                      local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation)
                      animationTrack:Play()
                  end
              end
  
              Mouse.KeyDown:Connect(function(Key)
                  if Key == "x" then
                      SpeedGlitch = not SpeedGlitch
                      if SpeedGlitch == true then
                          stopTracks()
                          loadAnimation("rbxassetid://3189777795")
                          wait(1.5)
                          Wallet.Parent = Player.Character
                          wait(0.15)
                          Player.Character:FindFirstChild("Wallet").Parent = Player.Backpack
                          wait(0.05)
                          repeat game:GetService("RunService").Heartbeat:wait()
                              keypress(0x49)
                              game:GetService("RunService").Heartbeat:wait()
                              keypress(0x4F)
                              game:GetService("RunService").Heartbeat:wait()
                              keyrelease(0x49)
                              game:GetService("RunService").Heartbeat:wait()
                              keyrelease(0x4F)
                              game:GetService("RunService").Heartbeat:wait()
                          until SpeedGlitch == false
                      end
                  end
              end)
      end)
      






    local sector12 = Misctablolxdrawruwu:CreateSector("Others (2)", "left")


sector12:AddButton("Anti Slow", function(L_178_arg0)
antislow = L_175_arg0
	repeat
		wait(0.1)
		local L_176_ = game.Players.LocalPlayer
		local L_177_ = L_176_.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or L_176_.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk') or L_176_.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed')
		if L_177_ then
			L_177_:Destroy()
		end
		if L_176_.Character.BodyEffects.Reload.Value == true then
			L_176_.Character.BodyEffects.Reload.Value = false
		end
	until antislow == false
end)

sector12:AddButton("Trashtalk (J)", function(L_178_arg0)
   local plr = game.Players.LocalPlayer
                repeat wait() until plr.Character
                local char = plr.Character

                local garbage = {
                "ur bad";
                "nice try bud";
                "ez";
                "my grandma has more skill than you";
                "gun user";
                "bunny hopper";
                "trash";
                "LOL";
                "LMAO";
                "imagine being you right now";
                "xd";
                "you smell";
                "ur bad";
                "why do you even try";
                "I didn't think being this bad was possible";
                "leave";
                "no skill";
                "you thought";
                "bad";
                "you're nothing";
                "lol";
                "so trash";
                "dog water";
                "ur salty";
                "salty";
                "ur mad son";
                "cry more";
                "keep crying";
                "cry baby";
                "hahaha I won";
                "no one likes u";
                "darn";
                "thank you for your time";
                "you were so close!";
                "better luck next time!";
                "rodent";
                "ur so bad ur my seed";
                "/e dab";
                "/e dab";
                "time to take out the trash";
                "did you get worse?";
                "I'm surprised you haven't quit yet";
                "sonned";
                 "lightwork";
            }
                function TrashTalk(inputObject, gameProcessedEvent)
                 if inputObject.KeyCode == Enum.KeyCode.J and gameProcessedEvent == false then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                garbage[math.random(1,#garbage)],
                "All"
                )
                     end
                end
                game:GetService("UserInputService").InputBegan:connect(TrashTalk)
                end)


sector12:AddButton("Infinite Zoom",false,function()
game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = math.huge
end)




    sector12:AddButton("CFrame Speed (N)", function()
	repeat
		wait()
	until game:IsLoaded()
	local L_134_ = game:service('Players')
	local L_135_ = L_134_.LocalPlayer
	repeat
		wait()
	until L_135_.Character
	local L_136_ = game:service('UserInputService')
	local L_137_ = game:service('RunService')
	getgenv().Multiplier = 0.5
	local L_138_ = true
	local L_139_
	L_136_.InputBegan:connect(function(L_140_arg0)
		if L_140_arg0.KeyCode == Enum.KeyCode.LeftBracket then
			Multiplier = Multiplier + 0.01
			print(Multiplier)
			wait(0.2)
			while L_136_:IsKeyDown(Enum.KeyCode.LeftBracket) do
				wait()
				Multiplier = Multiplier + 0.01
				print(Multiplier)
			end
		end
		if L_140_arg0.KeyCode == Enum.KeyCode.RightBracket then
			Multiplier = Multiplier - 0.01
			print(Multiplier)
			wait(0.2)
			while L_136_:IsKeyDown(Enum.KeyCode.RightBracket) do
				wait()
				Multiplier = Multiplier - 0.01
				print(Multiplier)
			end
		end
		if L_140_arg0.KeyCode == Enum.KeyCode.N then
			L_138_ = not L_138_
			if L_138_ == true then
				repeat
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * Multiplier
					game:GetService("RunService").Stepped:wait()
				until L_138_ == false
			end
		end
	end)
end)   

 sector12:AddTextbox("CFrame Speed", "", function(L_142_arg0)
	getgenv().Multiplier = L_142_arg0
    end)
    
    








     local sector17 = Misctablolxdrawruwu:CreateSector("Misc Main", "right")
    
            sector17:AddButton("Fly (X)", function()
                local plr = game.Players.LocalPlayer
                local mouse = plr:GetMouse()
                
                localplayer = plr
                
                if workspace:FindFirstChild("Core") then
                workspace.Core:Destroy()
                end
                
                local Core = Instance.new("Part")
                Core.Name = "Core"
                Core.Size = Vector3.new(0.05, 0.05, 0.05)
                
                spawn(function()
                Core.Parent = workspace
                local Weld = Instance.new("Weld", Core)
                Weld.Part0 = Core
                Weld.Part1 = localplayer.Character.LowerTorso
                Weld.C0 = CFrame.new(0, 0, 0)
                end)
                
                workspace:WaitForChild("Core")
                
                local torso = workspace.Core
                flying = true
                local speed=10
                local keys={a=false,d=false,w=false,s=false}
                local e1
                local e2
                local function start()
                local pos = Instance.new("BodyPosition",torso)
                local gyro = Instance.new("BodyGyro",torso)
                pos.Name="EPIXPOS"
                pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.position = torso.Position
                gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                gyro.cframe = torso.CFrame
                repeat
                wait()
                localplayer.Character.Humanoid.PlatformStand=true
                local new=gyro.cframe - gyro.cframe.p + pos.position
                if not keys.w and not keys.s and not keys.a and not keys.d then
                speed=5
                end
                if keys.w then
                new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed=speed+0
                end
                if keys.s then
                new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed=speed+0
                end
                if keys.d then
                new = new * CFrame.new(speed,0,0)
                speed=speed+0
                end
                if keys.a then
                new = new * CFrame.new(-speed,0,0)
                speed=speed+0
                end
                if speed>10 then
                speed=5
                end
                pos.position=new.p
                if keys.w then
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
                elseif keys.s then
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
                else
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                end
                until flying == false
                if gyro then gyro:Destroy() end
                if pos then pos:Destroy() end
                flying=false
                localplayer.Character.Humanoid.PlatformStand=false
                speed=10
                end
                e1=mouse.KeyDown:connect(function(key)
                if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
                if key=="w" then
                keys.w=true
                elseif key=="s" then
                keys.s=true
                elseif key=="a" then
                keys.a=true
                elseif key=="d" then
                keys.d=true
                elseif key=="x" then
                if flying==true then
                flying=false
                else
                flying=true
                start()
                end
                end
                end)
                e2=mouse.KeyUp:connect(function(key)
                if key=="w" then
                keys.w=false
                elseif key=="s" then
                keys.s=false
                elseif key=="a" then
                keys.a=false
                elseif key=="d" then
                keys.d=false
                end
                end)
                start()
            end)
    
            sector17:AddButton("Real Macro (B)", function()
                local Player = game:GetService("Players").LocalPlayer
                local Mouse = Player:GetMouse()
                local SpeedGlitch = false
                local Wallet = Player.Backpack:FindFirstChild("Wallet")
     
                local UniversalAnimation = Instance.new("Animation")
     
                function stopTracks()
                    for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
                        if (v.Animation.AnimationId:match("rbxassetid")) then
                            v:Stop()
                        end
                    end
                end
     
                function loadAnimation(id)
                    if UniversalAnimation.AnimationId == id then
                        stopTracks()
                        UniversalAnimation.AnimationId = "1"
                    else
                        UniversalAnimation.AnimationId = id
                        local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation)
                        animationTrack:Play()
                    end
                end
     
                Mouse.KeyDown:Connect(function(Key)
                    if Key == "b" then
                        SpeedGlitch = not SpeedGlitch
                        if SpeedGlitch == true then
                            loadAnimation("rbxassetid://3189777795")
                            wait(1.5)
                            Wallet.Parent = Player.Character
                            wait(0.15)
                            Player.Character:FindFirstChild("Wallet").Parent = Player.Backpack
                            wait(0.05)
                            repeat game:GetService("RunService").Heartbeat:wait()
                                keypress(0x49)
                                game:GetService("RunService").Heartbeat:wait()
                                keypress(0x4F)
                                game:GetService("RunService").Heartbeat:wait()
                                keyrelease(0x49)
                                game:GetService("RunService").Heartbeat:wait()
                                keyrelease(0x4F)
                                game:GetService("RunService").Heartbeat:wait()
                            until SpeedGlitch == false
                        end
                    end
                end)
            end)

    
    
            sector17:AddButton("Fake macro (Z)", function()
                superhuman = false
                plr = game.Players.LocalPlayer
                mouse = plr:GetMouse()
                mouse.KeyDown:connect(function(key)
                    if key == "z" and superhuman == false then
                        superhuman = true
                        game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
                        game.Players.LocalPlayer.Character.Humz.WalkSpeed = 150
                        game.Players.LocalPlayer.Character.Humz.JumpPower = 50
                    elseif key == "z" and superhuman == true then
                        superhuman = false
                        game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
                        game.Players.LocalPlayer.Character.Humz.JumpPower = 50
                        game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"
                    end
                end)
            end)
    
            sector17:AddButton('Normal Fov', function()
                workspace.CurrentCamera.FieldOfView = 70
            end)
            
            sector17:AddButton('Pro Fov', function()
                workspace.CurrentCamera.FieldOfView = 120
            end)
             
            local Fov = sector17:AddSlider("Fov Slider", 70, 0, 120, 5, function(value) 
                game:GetService'Workspace'.Camera.FieldOfView = value
            end)
            
            
            
            local sector18 = Misctablolxdrawruwu:CreateSector("Client Sided Character", "right")
    
            sector18:AddButton("Korblox", function()
                local ply = game.Players.LocalPlayer
                local chr = ply.Character
                chr.RightLowerLeg.MeshId = "902942093"
                chr.RightLowerLeg.Transparency = "1"
                chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
                chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
                chr.RightFoot.MeshId = "902942089"
                chr.RightFoot.Transparency = "1"
            end)
    
            sector18:AddButton("Headless", function()
                game.Players.LocalPlayer.Character.Head.Transparency = 1
                for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
                if (v:IsA("Decal")) then
                v:Destroy()
                end
                end
            end)
            
            local sector19 = Misctablolxdrawruwu:CreateSector("Client Sided Faces", "right")
            
            sector19:AddButton("Super Super Happy Face", function()
                game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://7150793967"
            end)
    
            sector19:AddButton("Yum!", function()
                game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://720921501"
            end)
    
           
    
            sector19:AddButton("Beast Mode", function()
                game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://265790768"
            end)
    
            sector19:AddButton("Playful Vampire", function()
                game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://6982506164"
            end)
