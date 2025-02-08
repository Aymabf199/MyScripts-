local module = {}

local _ENV = getgenv()
local config = {
    ZoneMarker = "SummonZone",
    Units = {
        ["Radiant Monarch"] = 27159,
        ["Poseidon Sovereign"] = 44328,
        ["Six Eyes Sage"] = 54891,
        ["Shadow Igniter"] = 62904
    },
    RemotePath = "ReplicatedStorage.Remotes.Summon"
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
    gui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.2,0,0.5,0)
    frame.Position = UDim2.new(0.8,0,0.25,0)
    frame.Parent = gui

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.CanvasSize = UDim2.new(0,0,#config.Units*0.15,0)
    scroll.Parent = frame

    for name,id in pairs(config.Units) do
        local btn = Instance.new("TextButton")
        btn.Text = name.." | "..id
        btn.Size = UDim2.new(0.9,0,0.12,0)
        btn.MouseButton1Click:Connect(function()
            if ValidateZone() then
                pcall(function()
                    require(game:GetService("ReplicatedStorage")[config.RemotePath]):FireServer("Companion",id,game.Players.LocalPlayer)
                end)
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
