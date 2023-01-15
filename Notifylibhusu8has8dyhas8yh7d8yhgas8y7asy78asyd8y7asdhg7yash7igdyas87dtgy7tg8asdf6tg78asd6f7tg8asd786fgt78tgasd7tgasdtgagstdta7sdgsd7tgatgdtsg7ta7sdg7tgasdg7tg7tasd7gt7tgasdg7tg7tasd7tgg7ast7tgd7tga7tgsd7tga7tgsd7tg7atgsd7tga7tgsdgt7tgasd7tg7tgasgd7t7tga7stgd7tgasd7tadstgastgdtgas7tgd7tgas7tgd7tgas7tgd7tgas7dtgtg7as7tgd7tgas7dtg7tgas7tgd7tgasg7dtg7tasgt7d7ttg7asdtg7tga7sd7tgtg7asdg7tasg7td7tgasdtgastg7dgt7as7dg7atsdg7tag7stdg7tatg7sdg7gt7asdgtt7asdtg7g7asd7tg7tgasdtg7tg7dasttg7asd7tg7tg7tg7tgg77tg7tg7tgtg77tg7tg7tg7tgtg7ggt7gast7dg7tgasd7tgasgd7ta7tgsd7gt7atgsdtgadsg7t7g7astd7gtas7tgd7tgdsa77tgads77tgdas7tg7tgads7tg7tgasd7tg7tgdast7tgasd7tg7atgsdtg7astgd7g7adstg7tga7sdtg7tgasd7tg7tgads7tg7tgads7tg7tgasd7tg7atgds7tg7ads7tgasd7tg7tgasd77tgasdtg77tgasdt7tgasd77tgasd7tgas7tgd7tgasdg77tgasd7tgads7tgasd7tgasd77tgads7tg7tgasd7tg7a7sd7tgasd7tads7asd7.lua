local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local TextService = game:GetService("TextService");

local Player = game:GetService("Players").LocalPlayer;

local NotifGui = Instance.new("ScreenGui");
NotifGui.Name = "AkaliNotif";
NotifGui.Parent = RunService:IsStudio() and Player.PlayerGui or game:GetService("CoreGui");

local Container = Instance.new("Frame");
Container.Name = "Container";
Container.Position = UDim2.new(0, 20, 0.5, -20);
Container.Size = UDim2.new(0, 300, 0.5, 0);
Container.BackgroundTransparency = 1;
Container.Parent = NotifGui;

local function Image(ID, Button)
	local NewImage = Instance.new(string.format("Image%s", Button and "Button" or "Label"));
	NewImage.Image = ID;
	NewImage.BackgroundTransparency = 1;
	return NewImage;
end

local function Round2px()
	local NewImage = Image("http://www.roblox.com/asset/?id=5761488251");
	NewImage.ScaleType = Enum.ScaleType.Slice;
	NewImage.SliceCenter = Rect.new(2, 2, 298, 298);
	NewImage.ImageColor3 = Color3.fromRGB(30, 30, 30);
	return NewImage;
end

local function Shadow2px()
	local NewImage = Image("http://www.roblox.com/asset/?id=5761498316");
	NewImage.ScaleType = Enum.ScaleType.Slice;
	NewImage.SliceCenter = Rect.new(17, 17, 283, 283);
	NewImage.Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30);
	NewImage.Position = -UDim2.fromOffset(15, 15);
	NewImage.ImageColor3 = Color3.fromRGB(30, 30, 30);
	return NewImage;
end

local Padding = 10;
local DescriptionPadding = 10;
local InstructionObjects = {};
local TweenTime = 1;
local TweenStyle = Enum.EasingStyle.Sine;
local TweenDirection = Enum.EasingDirection.Out;

local LastTick = tick();

local function CalculateBounds(TableOfObjects)
	local TableOfObjects = typeof(TableOfObjects) == "table" and TableOfObjects or {};
	local X, Y = 0, 0;
	for _, Object in next, TableOfObjects do
		X += Object.AbsoluteSize.X;
		Y += Object.AbsoluteSize.Y;
	end
	return {X = X, Y = Y, x = X, y = Y};
end

local CachedObjects = {};

local function Update()
	local DeltaTime = tick() - LastTick;
	local PreviousObjects = {};
	for CurObj, Object in next, InstructionObjects do
		local Label, Delta, Done = Object[1], Object[2], Object[3];
		if (not Done) then
			if (Delta < TweenTime) then
				Object[2] = math.clamp(Delta + DeltaTime, 0, 1);
				Delta = Object[2];
			else
				Object[3] = true;
			end
		end
		local NewValue = TweenService:GetValue(Delta, TweenStyle, TweenDirection);
		local CurrentPos = Label.Position;
		local PreviousBounds = CalculateBounds(PreviousObjects);
		local TargetPos = UDim2.new(0, 0, 0, PreviousBounds.Y + (Padding * #PreviousObjects));
		Label.Position = CurrentPos:Lerp(TargetPos, NewValue);
		table.insert(PreviousObjects, Label);
	end
	CachedObjects = PreviousObjects;
	LastTick = tick();
end

RunService:BindToRenderStep("UpdateList", 0, Update);

local TitleSettings = {
	Font = Enum.Font.GothamSemibold;
	Size = 14;
}

local DescriptionSettings = {
	Font = Enum.Font.Gotham;
	Size = 14;
}

local MaxWidth = (Container.AbsoluteSize.X - Padding - DescriptionPadding);

local function Label(Text, Font, Size, Button)
	local Label = Instance.new(string.format("Text%s", Button and "Button" or "Label"));
	Label.Text = Text;
	Label.Font = Font;
	Label.TextSize = Size;
	Label.BackgroundTransparency = 1;
	Label.TextXAlignment = Enum.TextXAlignment.Left;
	Label.RichText = true;
	Label.TextColor3 = Color3.fromRGB(255, 255, 255);
	return Label;
end

local function TitleLabel(Text)
	return Label(Text, TitleSettings.Font, TitleSettings.Size);
end

local function DescriptionLabel(Text)
	return Label(Text, DescriptionSettings.Font, DescriptionSettings.Size);
end

local PropertyTweenOut = {
	Text = "TextTransparency",
	Fram = "BackgroundTransparency",
	Imag = "ImageTransparency"
}

local function FadeProperty(Object)
	local Prop = PropertyTweenOut[string.sub(Object.ClassName, 1, 4)];
	TweenService:Create(Object, TweenInfo.new(0.25, TweenStyle, TweenDirection), {
		[Prop] = 1;
	}):Play();
end

local function SearchTableFor(Table, For)
	for _, v in next, Table do
		if (v == For) then
			return true;
		end
	end
	return false;
end

local function FindIndexByDependency(Table, Dependency)
	for Index, Object in next, Table do
		if (typeof(Object) == "table") then
			local Found = SearchTableFor(Object, Dependency);
			if (Found) then
				return Index;
			end
		else
			if (Object == Dependency) then
				return Index;
			end
		end
	end
end

local function ResetObjects()
	for _, Object in next, InstructionObjects do
		Object[2] = 0;
		Object[3] = false;
	end
end

local function FadeOutAfter(Object, Seconds)
	wait(Seconds);
	FadeProperty(Object);
	for _, SubObj in next, Object:GetDescendants() do
		FadeProperty(SubObj);
	end
	wait(0.25);
	table.remove(InstructionObjects, FindIndexByDependency(InstructionObjects, Object));
	ResetObjects();
end

return {
	Notify = function(Properties)
		local Properties = typeof(Properties) == "table" and Properties or {};
		local Title = Properties.Title;
		local Description = Properties.Description;
		local Duration = Properties.Duration or 5;
		if (Title) or (Description) then -- Check that user has provided title and/or description
			local Y = Title and 26 or 0;
			if (Description) then
				local TextSize = TextService:GetTextSize(Description, DescriptionSettings.Size, DescriptionSettings.Font, Vector2.new(0, 0));
				for i = 1, math.ceil(TextSize.X / MaxWidth) do
					Y += TextSize.Y;
				end
				Y += 8;
			end
			local NewLabel = Round2px();
			NewLabel.Size = UDim2.new(1, 0, 0, Y);
			NewLabel.Position = UDim2.new(-1, 20, 0, CalculateBounds(CachedObjects).Y + (Padding * #CachedObjects));
			if (Title) then
				local NewTitle = TitleLabel(Title);
				NewTitle.Size = UDim2.new(1, -10, 0, 26);
				NewTitle.Position = UDim2.fromOffset(10, 0);
				NewTitle.Parent = NewLabel;
			end
			if (Description) then
				local NewDescription = DescriptionLabel(Description);
				NewDescription.TextWrapped = true;
				NewDescription.Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(-DescriptionPadding, Title and -26 or 0);
				NewDescription.Position = UDim2.fromOffset(10, Title and 26 or 0);
				NewDescription.TextYAlignment = Enum.TextYAlignment[Title and "Top" or "Center"];
				NewDescription.Parent = NewLabel;
			end
			Shadow2px().Parent = NewLabel;
			NewLabel.Parent = Container;
			table.insert(InstructionObjects, {NewLabel, 0, false});
			coroutine.wrap(FadeOutAfter)(NewLabel, Duration);
		end
	end,
}
