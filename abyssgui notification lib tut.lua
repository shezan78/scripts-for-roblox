local NotificationLibrary = {}

local AbyssGUI = Instance.new("ScreenGui"); AbyssGUI.Name = "Abyss"; AbyssGUI.Parent = game.CoreGui; AbyssGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function NotificationLibrary:Notify(TitleText, Desc, Delay)
    local Notification = Instance.new("Frame")
	local Line = Instance.new("Frame")
	local Warning = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local Description = Instance.new("TextLabel")

	Notification.Name = "Notification"
	Notification.Parent = AbyssGUI
	Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Notification.BackgroundTransparency = 0.400
	Notification.BorderSizePixel = 0
	Notification.Position = UDim2.new(1, 5, 0, 75)
	Notification.Size = UDim2.new(0, 450, 0, 60)

	Line.Name = "Line"
	Line.Parent = Notification
	Line.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 0.938461304, 0)
	Line.Size = UDim2.new(0, 0, 0, 4)

	Warning.Name = "Warning"
	Warning.Parent = Notification
	Warning.BackgroundTransparency = 1.000
	Warning.Position = UDim2.new(0.0258302614, 0, 0.0897435844, 0)
	Warning.Size = UDim2.new(0, 44, 0, 49)
	Warning.Image = "rbxassetid://109251560"
	Warning.ImageColor3 = Color3.fromRGB(255, 248, 220)
	Warning.ScaleType = Enum.ScaleType.Fit

	UICorner.CornerRadius = UDim.new(0, 20)
	UICorner.Parent = Warning

	Title.Name = "Title"
	Title.Parent = Notification
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.161, 0, 0.155, 0)
	Title.Size = UDim2.new(0, 205, 0, 15)
	Title.Text = TitleText
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 12.000
	Title.TextStrokeTransparency = 0.500
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Description.Name = "Description"
	Description.Parent = Notification
	Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Description.BackgroundTransparency = 1.000
	Description.Position = UDim2.new(0.161, 0, 0.483, 0)
	Description.Size = UDim2.new(0, 205, 0, 18)
	Description.Text = Desc
	Description.TextColor3 = Color3.fromRGB(199, 199, 199)
	Description.TextSize = 12.000
	Description.TextStrokeTransparency = 0.500
	Description.TextXAlignment = Enum.TextXAlignment.Left

    Notification:TweenPosition(UDim2.new(1, -400, 0, 75), "Out", "Sine", 0.35)
    wait(0.35)
    Line:TweenSize(UDim2.new(0, 450, 0, 4), "Out", "Linear", Delay)
    wait(Delay)
    Notification:TweenPosition(UDim2.new(1, 5, 0, 75), "Out", "Sine", 0.35)
    wait(0.35)
    Notification:Destroy()
end

return NotificationLibrary
