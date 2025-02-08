local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local HS = game:GetService("HttpService")
local Run = game:GetService("RunService")

local Player = Players.LocalPlayer
local _G = getgenv()
_G.UnitList = {}

local function GenID()
    return string.format("%X|%X|%X", 
        math.random(0x10000000,0xFFFFFFFF), 
        math.random(0x1000,0xFFFF), 
        os.time()
    )
end

local SecretUnits = {
    ["Golden Adult"] = "UR_001",
    ["Radiant Monarch"] = "SSR_002",
    ["Crimson Tyrant"] = "SSR_011",
    ["Poseidon"] = "LR_003",
    ["Dragon Mage"] = "UR_004",
    ["Abyssal Warden"] = "LR_006",
    ["Elf Saint"] = "UR_007",
    ["Celestial Guardian"] = "SSR_008",
    ["Voidwalker"] = "LR_009",
    ["Prime Leader"] = "UR_010",
    ["Stormcaller"] = "LR_012",
    ["Eternal Phoenix"] = "UR_013",
    ["Timekeeper"] = "SSR_014",
    ["Lightbringer"] = "LR_015",
    ["∞ Celestial King"] = "GOD_001",
    ["Ω Void Titan"] = "GOD_002"
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "MobileHub_"..GenID()
GUI.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0.95,0,0.9,0)
Main.Position = UDim2.new(0.5,0,0.5,0)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.Parent = GUI

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-10,1,-60)
Scroll.Position = UDim2.new(0,5,0,5)
Scroll.CanvasSize = UDim2.new(0,0,0,#SecretUnits*70)
Scroll.ScrollBarThickness = 5
Scroll.Parent = Main

for idx, (unitName, unitCode) in pairs(SecretUnits) do
    local btn = Instance.new("TextButton")
    btn.Text = unitName.."\n"..unitCode
    btn.Size = UDim2.new(1,-10,0,65)
    btn.Position = UDim2.new(0,5,0,(idx-1)*70)
    btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    btn.Parent = Scroll

    btn.MouseButton1Click:Connect(function()
        _G.UnitList[1] = {N=unitName, C=unitCode}
    end)
end

local Claim = Instance.new("TextButton")
Claim.Text = "🚀 INSTANT UNLOCK"
Claim.Size = UDim2.new(1,-10,0,50)
Claim.Position = UDim2.new(0,5,1,-55)
Claim.BackgroundColor3 = Color3.fromRGB(0,120,200)
Claim.Font = Enum.Font.GothamBlack
Claim.TextColor3 = Color3.new(1,1,1)
Claim.TextSize = 16
Claim.Parent = Main

Claim.MouseButton1Click:Connect(function()
    if _G.UnitList[1] then
        local args = {
            _G.UnitList[1].C,
            "Secret",
            GenID(),
            os.time(),
            HS:GenerateGUID(false)
        }

        local success = pcall(function()
            RS.RemoteEvents.UnitPurchase:FireServer(unpack(args))
            RS.RemoteEvents.UnitConfirmation:FireServer(args[3])
            if not Player.Backpack:FindFirstChild(args[1]) then
                local tool = Instance.new("Tool")
                tool.Name = args[1]
                tool.Parent = Player.Backpack
            end
        end)

        GUI:Destroy()
    end
end)

coroutine.wrap(function()
    while task.wait(math.random(2,5)) do
        GUI.Name = "MH_"..GenID()
    end
end)()
