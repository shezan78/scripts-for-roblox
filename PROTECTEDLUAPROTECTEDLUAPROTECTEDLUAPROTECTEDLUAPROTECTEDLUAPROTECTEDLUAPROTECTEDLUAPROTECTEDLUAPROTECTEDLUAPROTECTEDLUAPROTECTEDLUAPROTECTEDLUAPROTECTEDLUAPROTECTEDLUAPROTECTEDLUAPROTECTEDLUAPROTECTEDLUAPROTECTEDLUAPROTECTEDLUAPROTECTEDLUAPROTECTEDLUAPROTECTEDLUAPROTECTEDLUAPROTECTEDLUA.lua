local Space = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Camera = Space.CurrentCamera

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

--LUA CACHED FUNCTIONS
local clamp = math.clamp
local round = math.round
local abs = math.abs
local huge = math.huge
local random = math.random
local floor = math.floor
local rad = math.rad

local match = string.match
local sub = string.sub

local V3 = Vector3.new
local V3 = Vector2.new
local u2 = UDim2.new
local CF = CFrame.new
local RGB = Color3.fromRGB
local tween = TweenInfo.new

local DRAWING = Drawing.new

local ESP_API = {}
ESP_API.NewText = function(info)
    local t = DRAWING("Text")
    t.Visible = info.Visible or false
    t.Transparency = info.Transparency or 1
    t.Color = info.Color or RGB(0,0,0)

    t.Text = info.Text or ""
    t.Size = info.Size or 14
    t.Center = info.Center or false
    t.Outline = info.Outline or false
    t.OutlineColor = info.OutlineColor or RGB(0,0,0)
    t.Font = info.Font or 3

    return t
end

ESP_API.NewLine = function(info)
    local l = DRAWING("Line")
    l.Visible = info.Visible or false
    l.Transparency = info.Transparency or 1
    l.Color = info.Color or RGB(0,0,0) 

    l.Thickness = info.Thickness or 1
    return l
end

ESP_API.NewSquare = function(info)
    local q = DRAWING("Square")
    q.Visible = info.Visible or false
    q.Transparency = info.Transparency or 1
    q.Color = info.Color or RGB(0,0,0)  

    q.Thickness = info.Thickness or 1
    q.Filled = info.Filled or false
    return q
end

ESP_API.NewCircle = function(info)
    local c = DRAWING("Circle")
    c.Visible = info.Visible or false
    c.Transparency = info.Transparency or 1
    c.Color = info.Color or RGB(0,0,0)  

    c.Thickness = info.Thickness or 1
    c.NumSides = info.NumSides or 50
    c.Radius = info.Radius or 100
    c.Filled = info.Filled or false
    return c
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/NAVY-RCX-UI/main/src.lua"))()

local DESTROY = false

local RCX = {
    ESP = {
        Toggle = true;

        Info = false;
        Max_Info_Distance = 100;
        Hover_Info = false;

        Names = false;
        Health = false;
        Distance = false;

        Boxes = false;
        Boxes_Mode = "Corners";
        Boxes_Distance = 100;
        Health_Bar = false;
        Health_Bar_Distance = 100;

        Color = {R = 255, G = 255, B = 0};

        Show_Target = false;
        Target_Color = {R = 255, G = 255, B = 255};

        Team_Check = false;
        Team_Color = {R = 255, G = 255, B = 0};
        Enemy_Color = {R = 255, G = 0, B = 0};

        View_Tracer = false;
        View_Tracer_Length = 10;
        View_Tracer_Distance = 100;
    };

    AIMBOT = {
        Toggle = false;
        Bone = "Head";
        Smoothness = 0.5;

        Distance_Type = "Mouse";
        Aim_Key = "Q";
        Aim_Mode = "Key";

        Team_Check = false;

        FOV = false;
        FOV_Radius = 50;
        FOV_Color = {R = 255, G = 255, B = 0};
    };

    UI = {
        UI_Toggle_Key = "End";
        Save_Settings_Key = "Home";
        Window_Size = {X = 750, Y = 550}
    };
} 

local HttpService = game:GetService("HttpService")
local RCXFile = "coolprohax.dat"

local function LoadRCX()
    local u, Result = pcall(readfile, RCXFile)
    if u then
        local x, Table = pcall(HttpService.JSONDecode, HttpService, Result)
        if x then
            for i, v in pairs(Table) do
                if RCX[i] ~= nil then
                    RCX[i] = v
                    pcall(RCX[i], v)
                end
            end
        end
    end
end

LoadRCX()

local RCX_Window = Library.NewWindow("Cool Pro Hax", {window_size = V3(RCX.UI.Window_Size.X, RCX.UI.Window_Size.Y), window_size_func = function(new_ui_size)
    RCX.UI.Window_Size = {X = new_ui_size.X, Y = new_ui_size.Y}
end, scalable = true, exit_func = function()
    DESTROY = true
end})

-- ESP
local ESP_Page = RCX_Window.NewPage("Visuals")

-- MAIN
local MAIN_ESP_Category = ESP_Page.NewCategory("Main")

MAIN_ESP_Category.NewToggle("Master Switch", function(bool) 
    RCX.ESP.Toggle = bool
end, {default = RCX.ESP.Toggle})

do
    local temp = RCX.ESP.Color
    MAIN_ESP_Category.NewColorpicker("Color", function(col)
        RCX.ESP.Color = {R = col.R*255, G = col.G*255, B = col.B*255}
    end, {default = RGB(temp.R, temp.G, temp.B)})
end

MAIN_ESP_Category.NewToggle("Team Check", function(bool) 
    RCX.ESP.Team_Check = bool
end, {default = RCX.ESP.Team_Check})

do
    local temp = RCX.ESP.Team_Color
    MAIN_ESP_Category.NewColorpicker("Team", function(col)
        RCX.ESP.Team_Color = {R = col.R*255, G = col.G*255, B = col.B*255}
    end, {default = RGB(temp.R, temp.G, temp.B)})
end

do
    local temp = RCX.ESP.Enemy_Color
    MAIN_ESP_Category.NewColorpicker("Enemies", function(col)
        RCX.ESP.Enemy_Color = {R = col.R*255, G = col.G*255, B = col.B*255}
    end, {default = RGB(temp.R, temp.G, temp.B)})
end

MAIN_ESP_Category.NewToggle("Show Target", function(bool) 
    RCX.ESP.Show_Target = bool
end, {default = RCX.ESP.Show_Target})

do
    local temp = RCX.ESP.Target_Color
    MAIN_ESP_Category.NewColorpicker("Target", function(col)
        RCX.ESP.Target_Color = {R = col.R*255, G = col.G*255, B = col.B*255}
    end, {default = RGB(temp.R, temp.G, temp.B)})
end

-- NAMES
local PLR_INFO_Category = ESP_Page.NewCategory("Player Info")

PLR_INFO_Category.NewToggle("Toggle", function(bool) 
    RCX.ESP.Info = bool
end, {default = RCX.ESP.Info})

PLR_INFO_Category.NewSlider("Max Info Distance", function(newvalue)
    RCX.ESP.Max_Info_Distance = newvalue
end, {default = RCX.ESP.Max_Info_Distance, min = 50, max = 5000, decimals = 0, suffix = " studs"})

PLR_INFO_Category.NewToggle("Hover Only", function(bool) 
    RCX.ESP.Hover_Info = bool
end, {default = RCX.ESP.Hover_Info})

PLR_INFO_Category.NewToggle("Names", function(bool) 
    RCX.ESP.Names = bool
end, {default = RCX.ESP.Names})

PLR_INFO_Category.NewToggle("Health", function(bool) 
    RCX.ESP.Health = bool
end, {default = RCX.ESP.Health})

PLR_INFO_Category.NewToggle("Distance", function(bool) 
    RCX.ESP.Distance = bool
end, {default = RCX.ESP.Distance})

-- BOXES
local BOXES_Category = ESP_Page.NewCategory("Boxes")

BOXES_Category.NewToggle("Toggle", function(bool) 
    RCX.ESP.Boxes = bool
end, {default = RCX.ESP.Boxes})

do
    local default_option
    local list = {
        "Corners";
        "Outline";
    }
    for i = 1, #list do
        local v = list[i]
        if v == RCX.ESP.Boxes_Mode then
            default_option = i
        end
    end
    BOXES_Category.NewDropdown("Box Type", function(option)
        RCX.ESP.Boxes_Mode = option
    end, {options = list, default = default_option})
end

BOXES_Category.NewSlider("Max Box Distance", function(newvalue)
    RCX.ESP.Boxes_Distance = newvalue
end, {default = RCX.ESP.Boxes_Distance, min = 50, max = 5000, decimals = 0, suffix = " studs"})

BOXES_Category.NewToggle("Health Bar", function(bool) 
    RCX.ESP.Health_Bar = bool
end, {default = RCX.ESP.Health_Bar})

BOXES_Category.NewSlider("Max Bar Distance", function(newvalue)
    RCX.ESP.Health_Bar_Distance = newvalue
end, {default = RCX.ESP.Health_Bar_Distance, min = 50, max = 5000, decimals = 0, suffix = " studs"})

-- VIEW TRACER
local VIEW_TRACER_Category = ESP_Page.NewCategory("View Tracers")

VIEW_TRACER_Category.NewToggle("Toggle", function(bool) 
    RCX.ESP.View_Tracer = bool
end, {default = RCX.ESP.View_Tracer})

VIEW_TRACER_Category.NewSlider("Length", function(newvalue)
    RCX.ESP.View_Tracer_Length = newvalue
end, {default = RCX.ESP.View_Tracer_Length, min = 1, max = 50, decimals = 0, suffix = " studs"})

VIEW_TRACER_Category.NewSlider("Max Tracer Distance", function(newvalue)
    RCX.ESP.View_Tracer_Distance = newvalue
end, {default = RCX.ESP.View_Tracer_Distance, min = 50, max = 5000, decimals = 0, suffix = " studs"})

-- AIMBOT
local AIMBOT_Page = RCX_Window.NewPage("Aimbot")

local MAIN_AIMBOT_Category = AIMBOT_Page.NewCategory("Main")

MAIN_AIMBOT_Category.NewToggle("Toggle", function(bool) 
    RCX.AIMBOT.Toggle = bool
end, {default = RCX.AIMBOT.Toggle})

do
    local default_option
    local list = {
        "Key";
        "Mouse";
    }
    for i = 1, #list do
        local v = list[i]
        if v == RCX.AIMBOT.Aim_Mode then
            default_option = i
        end
    end
    MAIN_AIMBOT_Category.NewDropdown("Aim Mode", function(option)
        RCX.AIMBOT.Aim_Mode = option
    end, {options = list, default = default_option})
end

MAIN_AIMBOT_Category.NewKeybind("Aim Key", function()end, function(new) 
    RCX.AIMBOT.Aim_Key = sub(tostring(new), 14, #tostring(new))
end, {default = Enum.KeyCode[RCX.AIMBOT.Aim_Key]})

MAIN_AIMBOT_Category.NewSlider("Smoothness", function(newvalue)
    RCX.AIMBOT.Smoothness = newvalue
end, {default = RCX.AIMBOT.Smoothness, min = 0.01, max = 1, decimals = 2, suffix = " factor"})

do
    local default_option
    local list =  {
        "Head"; 
        "Neck";
        "Torso"; 
        "Feet"; 
        "Random";
    }
    for i = 1, #list do
        local v = list[i]
        if v == RCX.AIMBOT.Bone then
            default_option = i
        end
    end
    MAIN_AIMBOT_Category.NewDropdown("Bone", function(option)
        RCX.AIMBOT.Bone = option
    end, {options = list, default = default_option})
end

do
    local default_option
    local list =  {
        "Mouse";
        "Character";
    }
    for i = 1, #list do
        local v = list[i]
        if v == RCX.AIMBOT.Distance_Type then
            default_option = i
        end
    end
    MAIN_AIMBOT_Category.NewDropdown("Aim Mode", function(option)
        RCX.AIMBOT.Distance_Type = option
    end, {options = list, default = default_option})
end

MAIN_AIMBOT_Category.NewToggle("Team Check", function(bool) 
    RCX.AIMBOT.Team_Check = bool
end, {default = RCX.AIMBOT.Team_Check})

local FOV_Category = AIMBOT_Page.NewCategory("FOV")

FOV_Category.NewToggle("Toggle", function(bool) 
    RCX.AIMBOT.FOV = bool
end, {default = RCX.AIMBOT.FOV})

FOV_Category.NewSlider("Radius", function(newvalue)
    RCX.AIMBOT.FOV_Radius = newvalue
end, {default = RCX.AIMBOT.FOV_Radius, min = 0, max = 500, decimals = 0, suffix = " px"})

do
    local temp = RCX.AIMBOT.FOV_Color
    FOV_Category.NewColorpicker("Color", function(col)
        RCX.AIMBOT.FOV_Color = {R = col.R*255, G = col.G*255, B = col.B*255}
    end, {default = RGB(temp.R, temp.G, temp.B)})
end

-- SETTINGS
local SETTINGS_Page = RCX_Window.NewPage("Settings")

local MAIN_SETTINGS_Category = SETTINGS_Page.NewCategory("Main")

MAIN_SETTINGS_Category.NewKeybind("Hide Key", function()
    RCX_Window.Hide()
end, function(new) 
    RCX.UI.UI_Toggle_Key = sub(tostring(new), 14, #tostring(new))
end, {default = Enum.KeyCode[RCX.UI.UI_Toggle_Key]})

MAIN_SETTINGS_Category.NewButton("Save Settings", function()
    writefile(RCXFile, game:GetService("HttpService"):JSONEncode(RCX))
end)

MAIN_SETTINGS_Category.NewKeybind("Save Settings Keybind", function()
    writefile(RCXFile, game:GetService("HttpService"):JSONEncode(RCX))
end, function(new) 
    RCX.UI.Save_Settings_Key = sub(tostring(new), 14, #tostring(new))
end, {default = Enum.KeyCode[RCX.UI.Save_Settings_Key]})

-- SCRIPT
local LerpColorModule = loadstring(game:HttpGet("https://pastebin.com/raw/wRnsJeid"))()
local HealthBarLerp = LerpColorModule:Lerp(RGB(255, 0, 0), RGB(0, 255, 0))

local Selected_Player = nil
local inset = game:GetService("GuiService"):GetGuiInset()

-- DETECT STUCTURE
local Character_Folder = Space
local Player_Characters = {}

do
    local t = Space:GetDescendants()
    for i = 1, #t do
        local v = t[i]
        if v:IsA("Model") and Players:FindFirstChild(v.Name) and (v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart ~= nil) then
            Character_Folder = v.Parent
        end
    end
end

warn("Found Character Folder: "..Character_Folder.Name)

local function ResetStructure()
    Player_Characters = {}

    local temp = {}
    do
        local t = Players:GetChildren() 
        for i = 1, #t do
            local v = t[i]
            temp[v.Name] = v.Name
        end
    end

    local t = Character_Folder:GetChildren()
    for i = 1, #t do
        local v = t[i]
        if temp[v.Name] ~= nil then
            Player_Characters[v.Name] = v
        end
    end
end

coroutine.wrap(function()
    coroutine.wrap(ResetStructure)()
    while wait(5) do
        if DESTROY then
            coroutine.yield()
        else
            coroutine.wrap(ResetStructure)()
        end
    end
end)()

-- ESP PLAYERS
ESP_API.AddPlayer = function(plr_name)
    repeat wait() until Player_Characters[plr_name] ~= nil and Player_Characters[plr_name]:FindFirstChildOfClass("Humanoid")

    local INFO = ESP_API.NewText({})
    INFO.Center = true

    local Bar = ESP_API.NewLine({Color = RGB(10, 10, 10), Thickness = 3, Transparency = 0.4})

    local Health_Bar = ESP_API.NewLine({Color = RGB(0, 255, 0), Thickness = 1})

    local Box_Lines = {}
    for i = 1, 8 do
        Box_Lines[i] = ESP_API.NewLine({})
    end

    local viewTracer = ESP_API.NewLine({Color = RGB(0, 255, 0), Thickness = 1})

    local function Box_Vis(state, mode)
        if state == false then
            for i = 1, 8 do
                Box_Lines[i].Visible = false
            end
        elseif state and mode == 1 then
            for i = 1, 4 do
                Box_Lines[i].Visible = true
            end
            for i = 5, 8 do
                Box_Lines[i].Visible = false
            end
        elseif state and mode == 2 then
            for i = 1, 8 do
                Box_Lines[i].Visible = true
            end
        end
    end

    local function Destroy_ESP()
        INFO:Remove()
        Bar:Remove()
        Health_Bar:Remove()
        viewTracer:Remove()
        for i = 1, #Box_Lines do
            Box_Lines[i]:Remove()
        end
    end

    local function Lines_Color(col)
        viewTracer.Color = col
        for i = 1, #Box_Lines do
            Box_Lines[i].Color = col
        end
    end

    local function Update_ESP()
        local prevhealth = nil
        local Character = nil

        local hide_name = Enum.HumanoidDisplayDistanceType.None
        local show_name = Enum.HumanoidDisplayDistanceType.Viewer

        local connection; connection = RS.RenderStepped:Connect(function()
            if DESTROY then
                Destroy_ESP()
                connection:Disconnect()
            else
                Character = Player_Characters[plr_name]

                if RCX.ESP.Toggle and Player.Character and Character and Character:FindFirstChildOfClass("Humanoid") and Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                    local localrootpart = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character.PrimaryPart
                    local root_part = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
                    local hum = Character:FindFirstChildOfClass("Humanoid")
                    if localrootpart and root_part then
                        local dist = (root_part.Position - localrootpart.Position).magnitude

                        Camera = Space.CurrentCamera
                        local root_pos, onscreen = Camera:WorldToViewportPoint(root_part.Position)

                        if RCX.ESP.View_Tracer and dist < RCX.ESP.View_Tracer_Distance and Character:FindFirstChild("Head") then
                            local Head = Character.Head

                            local headpos, vis = Camera:WorldToViewportPoint(Head.Position)
                            if vis then
                                local dirpos = Camera:WorldToViewportPoint((Head.CFrame*CF(0,0,-RCX.ESP.View_Tracer_Length)).p)

                                viewTracer.From = V3(headpos.X, headpos.Y)
                                viewTracer.To = V3(dirpos.X, dirpos.Y)

                                viewTracer.Visible = true
                            else
                                viewTracer.Visible = false
                            end
                        else
                            viewTracer.Visible = false
                        end

                        if onscreen then
                            -- TEAM CHECK
                            local Current_Color
                            if RCX.ESP.Team_Check and Players:FindFirstChild(plr_name):IsA("Player") and Player:IsA("Player") then
                                if Players:FindFirstChild(plr_name).TeamColor == Player.TeamColor then
                                    Current_Color = RCX.ESP.Team_Color
                                else 
                                    Current_Color = RCX.ESP.Enemy_Color
                                end
                            else
                                Current_Color = RCX.ESP.Color
                            end

                            INFO.Color = RGB(Current_Color.R, Current_Color.G, Current_Color.B)

                            if RCX.AIMBOT.Toggle and RCX.ESP.Show_Target and Selected_Player ~= nil and plr_name == Selected_Player.Name then
                                Current_Color = RCX.ESP.Target_Color
                            end

                            Current_Color = RGB(Current_Color.R, Current_Color.G, Current_Color.B)

                            Lines_Color(Current_Color)

                            local ratio = 2500/root_pos.Z

                            local newsize_x = ratio/2 
                            local newsize_y = ratio * 1.75 / 2
                            
                            local root_x = root_pos.X
                            local root_y = root_pos.Y

                            -- BOXES
                            if RCX.ESP.Boxes and dist < RCX.ESP.Boxes_Distance then
                                local box_mode = RCX.ESP.Boxes_Mode

                                local TL = V3(root_x-newsize_x, root_y-newsize_y)
                                local TR = V3(root_x+newsize_x, root_y-newsize_y)
                                local BL = V3(root_x-newsize_x, root_y+newsize_y)
                                local BR = V3(root_x+newsize_x, root_y+newsize_y)

                                if RCX.ESP.Health_Bar and dist < RCX.ESP.Health_Bar_Distance then
                                    local Hum_Health = hum.Health
                                    local Hum_MaxHealth = hum.MaxHealth

                                    local offsetX = clamp(round(200/root_pos.Z), 4, 8)

                                    local Right = root_x + newsize_x
                                    local Top = root_y - newsize_y
                                    local Bottom = root_y + newsize_y

                                    local barPos = Right + offsetX

                                    Bar.From = V3(barPos, Top)
                                    Bar.To = V3(barPos, Bottom)

                                    local HealthRatio = Hum_Health / Hum_MaxHealth
                                    local Length = abs((Bottom - 1) - (Top + 1))
                                        
                                    local HealthLength = Length * HealthRatio
                                    Health_Bar.From = V3(barPos, Bottom - 1 - HealthLength)
                                    Health_Bar.To = V3(barPos, Bottom - 1)

                                    if Hum_Health ~= prevhealth then
                                        Health_Bar.Color = HealthBarLerp(HealthRatio)
                                        prevhealth = Hum_Health
                                    end

                                    Health_Bar.Visible = true
                                    Bar.Visible = true
                                else 
                                    Health_Bar.Visible = false
                                    Bar.Visible = false
                                end

                                if box_mode == "Corners" then
                                    local Dir1 = V3(ratio/4, 0)
                                    local Dir2 = V3(0, ratio/4)

                                    -- 1
                                    Box_Lines[1].From = TL
                                    Box_Lines[1].To = TL + Dir1

                                    Box_Lines[2].From = TL
                                    Box_Lines[2].To = TL + Dir2

                                    -- 2
                                    Box_Lines[3].From = TR
                                    Box_Lines[3].To = TR - Dir1

                                    Box_Lines[4].From = TR
                                    Box_Lines[4].To = TR + Dir2

                                    -- 3
                                    Box_Lines[5].From = BL
                                    Box_Lines[5].To = BL + Dir1

                                    Box_Lines[6].From = BL
                                    Box_Lines[6].To = BL - Dir2

                                    -- 4
                                    Box_Lines[7].From = BR
                                    Box_Lines[7].To = BR - Dir1

                                    Box_Lines[8].From = BR
                                    Box_Lines[8].To = BR - Dir2

                                    if Box_Lines[8].Visible == false or Box_Lines[1].Visible == false then
                                        Box_Vis(true, 2)
                                    end
                                else
                                    -- 1
                                    Box_Lines[1].From = TR
                                    Box_Lines[1].To = TL

                                    Box_Lines[2].From = TL
                                    Box_Lines[2].To = BL

                                    -- 2
                                    Box_Lines[3].From = BL
                                    Box_Lines[3].To = BR

                                    Box_Lines[4].From = BR
                                    Box_Lines[4].To = TR

                                    if Box_Lines[8].Visible == true or Box_Lines[1].Visible == false then
                                        Box_Vis(true, 1)
                                    end
                                end
                            else 
                                Health_Bar.Visible = false
                                Bar.Visible = false
                                Box_Vis(false)
                            end

                            if RCX.ESP.Info then
                                local function show_info()
                                    if dist ~= nil and dist < RCX.ESP.Max_Info_Distance  then
                                        INFO.Position = V3(root_x, root_y-newsize_y-INFO.TextBounds.Y)
                                        INFO.Text = ""

                                        hum.DisplayDistanceType = hide_name

                                        if RCX.ESP.Names then
                                            INFO.Text = plr_name
                                        end

                                        if RCX.ESP.Health then
                                            INFO.Text = tostring(round(hum.Health/hum.MaxHealth*100)).."% ".. INFO.Text
                                        end

                                        if RCX.ESP.Distance then
                                            INFO.Text = INFO.Text.." ("..tostring(round(dist))..")"
                                        end        
                                        
                                        INFO.Visible = true
                                    else
                                        INFO.Visible = false
                                    end
                                end

                                if RCX.ESP.Hover_Info then
                                    if (V3(Mouse.X, Mouse.Y + inset.Y) - V3(root_x, root_y)).magnitude < clamp(ratio*1.25, 5, huge) then
                                        show_info()
                                    else 
                                        INFO.Visible = false
                                    end
                                else
                                    show_info()
                                end
                            else
                                INFO.Visible = false
                                hum.DisplayDistanceType = show_name
                            end
                        else
                            Box_Vis(false)
                            INFO.Visible = false
                            Health_Bar.Visible = false
                            Bar.Visible = false
                            hum.DisplayDistanceType = show_name
                        end
                    else
                        Box_Vis(false)
                        INFO.Visible = false
                        Health_Bar.Visible = false
                        Bar.Visible = false
                        viewTracer.Visible = false
                        hum.DisplayDistanceType = show_name
                    end
                else    
                    Box_Vis(false)
                    INFO.Visible = false
                    Health_Bar.Visible = false
                    Bar.Visible = false
                    viewTracer.Visible = false
                    if Players:FindFirstChild(plr_name) == nil then
                        Destroy_ESP()
                        connection:Disconnect()
                    end
                end
            end
        end)
    end
    coroutine.wrap(Update_ESP)()
end

do
    local t = Players:GetChildren()
    for i = 1, #t do
        local v = t[i]
        if v.Name ~= Player.Name then
            coroutine.wrap(ESP_API.AddPlayer)(v.Name)
        end
    end
end

Players.ChildAdded:Connect(function(v)
    ResetStructure()

    coroutine.wrap(ESP_API.AddPlayer)(v.Name)
end)

-- AIMBOT PLAYERS

local Aiming = false
local random_part

local aim_c_1
aim_c_1 = UIS.InputBegan:Connect(function(input)
    if DESTROY then
        aim_c_1:Disconnect()
    elseif RCX.AIMBOT.Aim_Mode == "Key" and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode[RCX.AIMBOT.Aim_Key] then
        random_part = random(1, 3)
        Aiming = true
    elseif RCX.AIMBOT.Aim_Mode == "Mouse" and input.UserInputType == Enum.UserInputType.MouseButton2 then
        random_part = random(1, 3)
        Aiming = true
    end
end)

local aim_c_2
aim_c_2 = UIS.InputEnded:Connect(function(input)
    if DESTROY then
        aim_c_1:Disconnect()
        Aiming = false
    elseif RCX.AIMBOT.Aim_Mode == "Key" and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode[RCX.AIMBOT.Aim_Key] then
        random_part = 0
        Aiming = false
    elseif RCX.AIMBOT.Aim_Mode == "Mouse" and input.UserInputType == Enum.UserInputType.MouseButton2 then
        random_part = 0
        Aiming = false
    end
end)

local FOV = DRAWING("Circle")
FOV.Visible = false
FOV.Color = RGB(RCX.AIMBOT.FOV_Color.R, RCX.AIMBOT.FOV_Color.G, RCX.AIMBOT.FOV_Color.B)
FOV.Position = V3(0, 0)
FOV.Transparency = 0.6
FOV.NumSides = 75
FOV.Radius = RCX.AIMBOT.FOV_Radius
FOV.Filled = false
FOV.Thickness = 1

local function SameTeam(plr_name)
    local plr = Players:FindFirstChild(plr_name)
    local deb = false
    if plr ~= nil and RCX.AIMBOT.Team_Check and plr:IsA("Player") and Player:IsA("Player") then
        if plr.TeamColor == Player.TeamColor then
            deb = true
        else 
            deb = false
        end
    else
        deb = false
    end
    return deb
end

local function GetClosest()
    Camera = Space.CurrentCamera
    local min = huge
    local closest = nil
    if RCX.AIMBOT.Distance_Type == "Mouse" then
        for i, v in pairs(Player_Characters) do
            local Character = v

            if v.Name ~= Player.Name and Character ~= nil and Character:FindFirstChildOfClass("Humanoid") and Character:FindFirstChildOfClass("Humanoid").Health > 0 and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart ~= nil) and SameTeam(v.Name) == false then
                local rootpart = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
                local pos, vis
                local part = RCX.AIMBOT.Bone
                if part == "Head" and Character:FindFirstChild("Head") then
                    pos, vis = Camera:WorldToViewportPoint(Character.Head.Position)
                elseif part == "Neck" and Character:FindFirstChild("Head") then
                    pos, vis = Camera:WorldToViewportPoint(Character.Head.Position - V3(0, Character.Head.Size.Y/2, 0))
                elseif part == "Torso" then
                    pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                elseif part == "Feet" then
                    pos, vis = Camera:WorldToViewportPoint(rootpart.Position - V3(0, 2.5, 0))
                elseif part == "Random" then
                    if random_part == 1 and Character:FindFirstChild("Head") then
                        pos, vis = Camera:WorldToViewportPoint(Character.Head.Position)
                    elseif random_part == 2 then
                        pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                    elseif random_part == 3 then
                        pos, vis = Camera:WorldToViewportPoint(rootpart.Position - V3(0, 2.5, 0))
                    else
                        pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                    end
                else
                    pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                end
                local dist = (V3(Mouse.X+inset.X, Mouse.Y+inset.Y) - V3(pos.X, pos.Y)).magnitude
                if vis then
                    local d = (V3(pos.X, pos.Y) - FOV.Position).magnitude
                    if d <= FOV.Radius and dist < min then
                        min = dist
                        closest = v
                    end
                end
            end
        end
    elseif RCX.AIMBOT.Distance_Type == "Character" then
        for i, v in pairs(Player_Characters) do
            local Character = v

            if v.Name ~= Player.Name and Character ~= nil and Character:FindFirstChildOfClass("Humanoid") and Character:FindFirstChildOfClass("Humanoid").Health > 0 and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart ~= nil) and SameTeam(v.Name) == false then
                local rootpart = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
                local localrootpart = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character.PrimaryPart
                local dist = (localrootpart.Position - rootpart.Position).magnitude
                local pos, vis
                local part = RCX.AIMBOT.Bone
                if part == "Head" and Character:FindFirstChild("Head") then
                    pos, vis = Camera:WorldToViewportPoint(Character.Head.Position)
                elseif part == "Neck" and Character:FindFirstChild("Head") then
                    pos, vis = Camera:WorldToViewportPoint(Character.Head.Position - V3(0, Character.Head.Size.Y/2, 0))
                elseif part == "Torso" then
                    pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                elseif part == "Feet" then
                    pos, vis = Camera:WorldToViewportPoint(rootpart.Position - V3(0, 2.5, 0))
                elseif part == "Random" then
                    if random_part == 1 and Character:FindFirstChild("Head") then
                        pos, vis = Camera:WorldToViewportPoint(Character.Head.Position)
                    elseif random_part == 2 then
                        pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                    elseif random_part == 3 then
                        pos, vis = Camera:WorldToViewportPoint(rootpart.Position - V3(0, 2.5, 0))
                    else
                        pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                    end
                else
                    pos, vis = Camera:WorldToViewportPoint(rootpart.Position)
                end
                if vis then
                    local d = (V3(pos.X, pos.Y) - FOV.Position).magnitude
                    if d <= FOV.Radius and dist < min then
                        min = dist
                        closest = v
                    end
                end
            end
        end
    end
    return closest
end

coroutine.wrap(function()
    local c_selected
    c_selected = RS.RenderStepped:Connect(function()
        if DESTROY then
            c_selected:Disconnect()
        else
            Selected_Player = GetClosest()
        end
    end)
end)()

local inset = game:GetService("GuiService"):GetGuiInset()

local function Aimbot_Start()
    local c
    c = RS.RenderStepped:Connect(function()
        Camera = Space.CurrentCamera
        if DESTROY then
            FOV:Remove()
            c:Disconnect()
        elseif RCX.AIMBOT.Toggle then
            
            if RCX.AIMBOT.FOV then
                FOV.Radius = RCX.AIMBOT.FOV_Radius
                FOV.Thickness = 1
                local fov_col = RCX.AIMBOT.FOV_Color
                FOV.Color = RGB(fov_col.R, fov_col.G, fov_col.B)
    
                FOV.Position = V3(Mouse.X, Mouse.Y + 36)
                FOV.Visible = true
            else 
                FOV.Radius = 2000
    
                FOV.Position = Camera.ViewportSize / 2
                FOV.Visible = false
            end

            if Aiming and Selected_Player ~= nil then
                local rootpart = Selected_Player:FindFirstChild("HumanoidRootPart") or Selected_Player.PrimaryPart
                local Character = Selected_Player
                local pos
                local part = RCX.AIMBOT.Bone
                if part == "Head" and Character:FindFirstChild("Head") then
                    pos = Camera:WorldToViewportPoint(Character.Head.Position)
                elseif part == "Neck" and Character:FindFirstChild("Head") then
                    pos = Camera:WorldToViewportPoint(Character.Head.Position - V3(0, Character.Head.Size.Y/2, 0))
                elseif part == "Torso" then
                    pos = Camera:WorldToViewportPoint(rootpart.Position)
                elseif part == "Feet" then
                    pos = Camera:WorldToViewportPoint(rootpart.Position - V3(0, 2.5, 0))
                elseif part == "Random" then
                    if random_part == 1 and Character:FindFirstChild("Head") then
                        pos = Camera:WorldToViewportPoint(Character.Head.Position)
                    elseif random_part == 2 then
                        pos = Camera:WorldToViewportPoint(rootpart.Position)
                    elseif random_part == 3 then
                        pos = Camera:WorldToViewportPoint(rootpart.Position - V3(0, 2.5, 0))
                    else
                        pos = Camera:WorldToViewportPoint(rootpart.Position)
                    end
                else
                    pos = Camera:WorldToViewportPoint(rootpart.Position)
                end
                local sens = clamp(1-RCX.AIMBOT.Smoothness, 0.01, 1)/1.5
                mousemoverel((pos.X - Mouse.X) * sens, (pos.Y - Mouse.Y - inset.Y) * sens)
            end
        elseif RCX.AIMBOT.Toggle == false then
            FOV.Visible = false
        end
    end)
end
coroutine.wrap(Aimbot_Start)()
