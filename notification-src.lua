-- variables
local tweenService, coreGui = game:GetService("TweenService"), game:GetService("CoreGui");

local insert, find, remove = table.insert, table.find, table.remove 
local format = string.format

local newInstance = Instance.new
local fromRGB = Color3.fromRGB

local notificationPositions = {
    ["Middle"] = UDim2.new(0.445, 0, 0.7, 0),
    ["MiddleRight"] = UDim2.new(0.85, 0, 0.7, 0),
    ["MiddleLeft"] = UDim2.new(0.01, 0, 0.7, 0),
    
    ["Top"] = UDim2.new(0.445, 0, 0.007, 0),
    ["TopLeft"] = UDim2.new(0.06, 0, 0.001, 0),
    ["TopRight"] = UDim2.new(0.8, 0, 0.001, 0),
}; 

-- functions 
function protectScreenGui(screenGui)
    if syn and syn.protect_gui then 
        syn.protect_gui(screenGui);
        screenGui.Parent = coreGui
    elseif gethui then 
        screenGui.Parent = gethui();
    else 
        screenGui.Parent = coreGui();
    end
end

function createObject(className, properties)
    local instance = newInstance(className);
    
    for index, value in next, properties do 
        instance[index] = value 
    end
    
    return instance
end

function fadeObject(object, onTweenCompleted)
    local tweenInformation = tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    });
    
    tweenInformation.Completed:Connect(onTweenCompleted);
    tweenInformation:Play();
end

local notifications = {}; do 
    function notifications.new(settings)
        assert(settings, "missing argument #1 in function notifications.new(settings)");
        assert(typeof(settings) == "table", format("expected table for argument #1 in function notifications.new(settings), got %s", typeof(settings)));
        
        local notificationSettings = {ui = {notificationsFrame = nil, notificationsFrame_UIListLayout = nil}};
        
        for setting, value in next, settings do 
            notificationSettings[setting] = value 
        end
        
        setmetatable(notificationSettings, {__index = notifications});
        return notificationSettings
    end

    function notifications:SetNotificationLifetime(number)
        assert(number, "missing argument #1 in function SetNotificationLifetime(number)");
        assert(typeof(number) == "number",  format("expected number for argument #1 in function SetNotificationLifetime, got %s", typeof(number)));
        
        self.NotificationLifetime = number 
    end

    function notifications:SetTextColor(color3)
        assert(color3, "missing argument #1 in function SetTextColor(Color3)");
        assert(typeof(color3) == "Color3", format("expected Color3 for argument #1 in function SetTextColor3, got %s", typeof(color3)));
        
        self.TextColor = color3 
    end
    
    function notifications:SetTextSize(number)
        assert(number, "missing argument #1 in function SetTextSize(number)");
        assert(typeof(number) == "number",  format("expected number for argument #1 in function SetTextSize, got %s", typeof(number)));
        
        self.TextSize = number 
    end
    
    function notifications:SetTextStrokeTransparency(number)
        assert(number, "missing argument #1 in function SetTextStrokeTransparency(number)");
        assert(typeof(number) == "number",  format("expected number for argument #1 in function SetTextStrokeTransparency, got %s", typeof(number)));
        
        self.TextStrokeTransparency = number 
    end

    function notifications:SetTextStrokeColor(color3)
        assert(color3, "missing argument #1 in function SetTextStrokeColor(Color3)");
        assert(typeof(color3) == "Color3", format("expected Color3 for argument #1 in function SetTextStrokeColor, got %s", typeof(color3)));
        
        self.TextStrokeColor = color3 
    end
    
    function notifications:SetTextFont(font)
        assert(font, "missing argument #1 in function SetTextFont(Font)");
        assert((typeof(font) == "string" or typeof(font) == "EnumItem"))
        
        self.TextFont = Enum.Font[font];
    end
    
    function notifications:BuildNotificationUI()
        if notifications_screenGui then 
            notifications_screenGui:Destroy();
        end
        
        getgenv().notifications_screenGui = createObject("ScreenGui", {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        }); protectScreenGui(notifications_screenGui);
    
        self.ui.notificationsFrame = createObject("Frame", {
            Name = "notificationsFrame",
            Parent = notifications_screenGui,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = notificationPositions[self.NotificationPosition],
            Size = UDim2.new(0, 236, 0, 215)
        });
    
        self.ui.notificationsFrame_UIListLayout = createObject("UIListLayout", {
            Name = "notificationsFrame_UIListLayout",
            Parent = self.ui.notificationsFrame,
            Padding = UDim.new(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
    end

    function notifications:Notify(text)
        local notification = createObject("TextLabel", {
            Name = "notification",
            Parent = self.ui.notificationsFrame,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Size = UDim2.new(0, 222, 0, 14),
            Text = text,
            
            Font = self.TextFont,
            TextColor3 = self.TextColor,
            TextSize = self.TextSize,
            TextStrokeColor3 = self.TextStrokeColor,
            TextStrokeTransparency = self.TextStrokeTransparency
        });  
    
        task.delay(self.NotificationLifetime, function()
            fadeObject(notification, function()
                notification:Destroy();
            end);
        end);
    end
end

return notifications 
