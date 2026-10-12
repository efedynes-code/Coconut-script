-- CoconutYZ TANRI MODU v3.0
-- Delta Executor için

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()
local lighting = game:GetService("Lighting")

-- 1. Speed Hack
humanoid.WalkSpeed = 500
humanoid.JumpPower = 500
humanoid.UseJumpPower = true

-- 2. Fly
local fly = Instance.new("BodyVelocity")
fly.MaxForce = Vector3.new(1e5, 1e5, 1e5)
fly.Velocity = Vector3.new(0, 0, 0)
fly.Parent = root

-- 3. Infinite Jump
UIS.JumpRequest:Connect(function()
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- 4. Fly Kontrol
RunService.RenderStepped:Connect(function()
    local move = Vector3.new()
    if UIS:IsKeyDown(Enum.KeyCode.W) then move += camera.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then move -= camera.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then move -= camera.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then move += camera.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
    fly.Velocity = move * 300
end)

-- 5. ESP
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= player and v.Character then
        local highlight = Instance.new("Highlight")
        highlight.Parent = v.Character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    end
end

-- 6. God Mode
humanoid.MaxHealth = math.huge
humanoid.Health = math.huge

-- 7. Teleport
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if mouse.Hit then
            root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
        end
    end
end)

-- 8. Anti-AFK
player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0))
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0))
end)

-- 9. Noclip
local noclip = true
RunService.Stepped:Connect(function()
    if noclip then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

-- 10. Fullbright
lighting.Ambient = Color3.fromRGB(255, 255, 255)
lighting.Brightness = 2
lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)

-- 11. Aimbot
local aimbot = true
RunService.RenderStepped:Connect(function()
    if aimbot then
        local closest = nil
        local dist = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
                local d = (v.Character.Head.Position - camera.CFrame.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = v.Character.Head
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
        end
    end
end)

-- 12. Silent Aim
local silent = true
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if silent and method == "FireServer" then
        local args = {...}
        local closest = nil
        local dist = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
                local d = (v.Character.Head.Position - root.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = v.Character.Head
                end
            end
        end
        if closest then
            args[1] = closest.Position
        end
        return oldNamecall(self, unpack(args))
    end
    return oldNamecall(self, ...)
end)

-- 13. Auto Farm
local farm = true
while farm do
    wait(1)
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BasePart") and (v.Name == "Coin" or v.Name == "Cash" or v.Name == "Money") then
            root.CFrame = v.CFrame
            wait(0.1)
        end
    end
end

-- 14. Kill All
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
        v.Character.Humanoid.Health = 0
    end
end

-- 15. Freeze All
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
        v.Character.HumanoidRootPart.Anchored = true
    end
end

-- 16. Invisible
for _, v in pairs(char:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Transparency = 1
    end
end

-- 17. Fly to Player
local target = game.Players:GetPlayers()[2]
if target and target.Character then
    root.CFrame = target.Character.HumanoidRootPart.CFrame
end

-- 18. Bring Player
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= player and v.Character then
        v.Character.HumanoidRootPart.CFrame = root.CFrame
    end
end

-- 19. Server Hop
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

-- 20. Chat Spam
for i = 1, 10 do
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("CoconutYZ burada!", "All")
    wait(0.5)
end

-- 21. Music Player
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://1837879082"
sound.Parent = workspace
sound:Play()

-- 22. Infinite Money
if player:FindFirstChild("leaderstats") then
    for _, v in pairs(player.leaderstats:GetChildren()) do
        v.Value = 999999999
    end
end

-- 23. Anti-Ban (Sadece bazı oyunlarda)
pcall(function()
    game:GetService("Players").LocalPlayer:Kick("")
end)

print("CoconutYZ TANRI MODU yüklendi. İyi eğlenceler.")
