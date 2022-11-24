 _G.KEY = "b"
_G.PART = "Head", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "HumanoidRootPart", "LeftUpperLeg", "RightLowerLeg", "RightFoot", "LowerTorso"
_G.PRED = 0.032
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuizzyisbackV2LOL/GuizzyLuaThusk4t5345345/main/LuaObf"))()




--Reslover

--Remove reslover if u dont like


-- I add the whatever

---------------------


local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    pcall(function()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local hrp = v.Character.HumanoidRootPart
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)   
            end
        end
    end)
end)