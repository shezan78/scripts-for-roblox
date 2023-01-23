local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shezan78/ShezanLib/main/ShezansUILibSource.lua'))()
local Window = Rayfield:CreateWindow({
	Name = "For Khurshed",
	LoadingTitle = "Loading Shezans GUI",
	LoadingSubtitle = "by Shezan",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Shezanscool",
		FileName = "Shezans Lib"
	},
	KeySystem = true, -- Set this to true to use their key system
	KeySettings = {
		Title = "Shezan Hub",
		Subtitle = "Key System",
		Note = "Key hint: Do we smoke notti?",
		SaveKey = false,
		Key = "yes"
	}
})

Rayfield:Notify("Whitelist", "Checking for whitelist. . .", 4483362458)

local Tab = Window:CreateTab("khurshed is a bbg", 4483362458) -- Title, Image

local Section = Tab:CreateSection("da hood only bbg")

local Button = Tab:CreateButton({
	Name = "silent aim - aims closest to cursur",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/shezan78/ALotOfRobloxScripts/main/Roblox%20Scripts/STREAMABLE_1.lua", true))()
	end,
})

local Button = Tab:CreateButton({
	Name = "Aimbot - Press C on someone to aimbot on them",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/shezan78/ALotOfRobloxScripts/main/Roblox%20Scripts/SmoothLock.lua", true))()
	end,
})

local Button = Tab:CreateButton({
	Name = "Hat gui - gives free limiteds to you that you can only see",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/shezan78/ALotOfRobloxScripts/main/Roblox%20Scripts/Hat%20Gui.lua", true))()
	end,
})
