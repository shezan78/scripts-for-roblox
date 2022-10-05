function Animation(Character)
    Character:WaitForChild'Animate'
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    for i, player in ipairs(game.Players:GetChildren()) do
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782841498"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=616165109"
        Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=616166655"
        game.Players.LocalPlayer.Character.Humanoid.Jump = false
    end
    wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end
Animation(game.Players.LocalPlayer.Character)
game.Players.LocalPlayer.CharacterAdded:Connect(Animation)
