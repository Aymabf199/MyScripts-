local module = {}

local _ENV = getgenv()
local config = {
    ZoneMarker = "SummonZone",
    Units = {
        ["The Gamer"] = 88721,
        ["Chance Taker"] = 66534,
        ["Poseidon"] = 44328,
        ["Radiant Monarch"] = 27159,
        ["Sage"] = 54891,
        ["Shadow Master"] = 62904
    },
    RemotePath = "ReplicatedStorage.Remotes.SummonEvent"
}

local function ValidateZone()
    local zone = workspace:FindFirstChild(config.ZoneMarker)
    if not zone then return false end
    local char = game.Players.LocalPlayer.Character
    return char and (char:FindFirstChild("HumanoidRootPart").Position - zone.Position).Magnitude <= zone.Size.X/2
end

function module.CreateGUI()
    if not ValidateZone() then return end
    
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.25,0,0.6,0)
    frame.Position = UDim2.new(0.75,0,0.2,0)
    frame.BackgroundTransparency = 0.9
    frame.Parent = gui

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.95,0,0.95,0)
    scroll.CanvasSize = UDim2.new(0,0,#config.Units*0.2,0)
    scroll.Parent = frame

    for name,id in pairs(config.Units) do
        local btn = Instance.new("TextButton")
        btn.Text = name.." | "..id
        btn.Size = UDim2.new(0.98,0,0.18,0)
        btn.MouseButton1Click:Connect(function()
            if ValidateZone() then
                local args = {"Companion",id,game.Players.LocalPlayer}
                pcall(function() game:GetService("ReplicatedStorage").RemoteEvents.SummonEvent:FireServer(unpack(args)) end)
            else
                gui:Destroy()
            end
        end)
        btn.Parent = scroll
    end
end

if ValidateZone() then
    module.CreateGUI()
else
    game.Players.LocalPlayer.CharacterAdded:Connect(module.CreateGUI)
end

return module
