local Player = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local module = {
    _Zone = "SummonArea",
    _Remote = RS:WaitForChild("SummonRemote",10),
    _Units = {
        ["Ultra Instinct Goku"] = 70234,
        ["Six Eyes Gojo"] = 55661,
        ["Rinnegan Madara"] = 33445,
        ["Bankai Yamamoto"] = 88773
    }
}

local function Validate()
    local zone = workspace:FindFirstChild(module._Zone)
    if not zone then return false end
    if not Player.Character then return false end
    local root = Player.Character:FindFirstChild("HumanoidRootPart")
    return root and (root.Position - zone.Position).Magnitude <= (zone.Size.X * 1.2)
end

function module.CreateUI()
    if not Validate() then 
        warn("Summon zone not accessible")
        return 
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "SecretSummoner"
    gui.Parent = Player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.3,0,0.7,0)
    main.Position = UDim2.new(0.7,0,0.15,0)
    main.BackgroundTransparency = 0.85
    main.Parent = gui

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.95,0,0.95,0)
    scroll.CanvasSize = UDim2.new(0,0,#module._Units * 0.2,0)
    scroll.Parent = main

    for name,id in pairs(module._Units) do
        local btn = Instance.new("TextButton")
        btn.Text = name
        btn.Size = UDim2.new(0.98,0,0.15,0)
        
        btn.MouseButton1Click:Connect(function()
            if Validate() and module._Remote then
                local args = {
                    "SpecialSummon",
                    id,
                    os.clock(),
                    Player
                }
                
                task.spawn(function()
                    local s,err = pcall(function()
                        return module._Remote:FireServer(unpack(args))
                    end)
                    
                    if s then
                        game:GetService("StarterGui"):SetCore("SendNotification",{
                            Title = "SUCCESS",
                            Text = "Summoned: "..name,
                            Duration = 3
                        })
                    else
                        warn("Summon failed:", err)
                    end
                end)
            else
                gui:Destroy()
            end
        end)
        
        btn.Parent = scroll
    end
end

if Validate() then
    module.CreateUI()
else
    Player.CharacterAdded:Connect(function()
        task.wait(2) -- تأخير للتأكد من تحميل الموقع
        if Validate() then
            module.CreateUI()
        end
    end)
end

return module
