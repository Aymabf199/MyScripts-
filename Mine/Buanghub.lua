local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local _G = getrenv()
_G.SecureSystem = {
    Units = {
        ["Golden Adult"] = "URxG0LD3N_2024",
        ["Radiant Monarch"] = "SSRxR4D14NTv2",
        ["Poseidon"] = "LRxP0S31D0N_X",
        ["Dragon Mage"] = "DR4G0N_MKII",
        ["Shadow Master"] = "SH4D0W_ELITE",
        ["Celestial Guardian"] = "C3L3ST14Lv3",
        ["Voidwalker"] = "V01D_W4LK3R",
        ["Crimson Tyrant"] = "CR1MS0N_TYR4NT",
        ["Eternal Phoenix"] = "PH03N1X_ET3RN4L",
        ["Timekeeper"] = "T1M3K33P3R_Z"
    },
    Security = {
        GenerateToken = function()
            return HttpService:GenerateGUID()..os.time()
        end
    }
}

local function SecureRequest(unitCode)
    local args = {
        [1] = unitCode,
        [2] = _G.SecureSystem.Security.GenerateToken(),
        [3] = "Mobile"
    }
    
    local success = pcall(function()
        ReplicatedStorage.RemoteEvents.UnitPurchase:FireServer(unpack(args))
    end)
    
    if not success then
        local backup = Instance.new("StringValue")
        backup.Name = unitCode.."_Backup"
        backup.Value = HttpService:JSONEncode({Unit = unitCode, Time = os.date()})
        backup.Parent = player.Backpack
    end
end

local GUI = Instance.new("ScreenGui")
GUI.Name = "MobileHub_"..math.random(1000,9999)
GUI.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.95, 0, 0.8, 0)
MainFrame.Position = UDim2.new(0.025, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Parent = GUI

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0.98, 0, 0.85, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #_G.SecureSystem.Units * 65)
ScrollingFrame.Parent = MainFrame

local yPos = 5
for unitName, unitCode in pairs(_G.SecureSystem.Units) do
    local btn = Instance.new("TextButton")
    btn.Text = unitName
    btn.Size = UDim2.new(0.96, 0, 0, 60)
    btn.Position = UDim2.new(0.02, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = ScrollingFrame
    
    btn.MouseButton1Click:Connect(function()
        _G.SelectedUnit = unitCode
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    end)
    
    yPos += 65
end

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Text = "🔥 CLAIM UNIT"
ExecuteBtn.Size = UDim2.new(0.9, 0, 0.08, 0)
ExecuteBtn.Position = UDim2.new(0.05, 0, 0.9, 0)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
ExecuteBtn.TextColor3 = Color3.new(1, 1, 1)
ExecuteBtn.Parent = MainFrame

ExecuteBtn.MouseButton1Click:Connect(function()
    if _G.SelectedUnit then
        ExecuteBtn.Text = "⚡ PROCESSING..."
        SecureRequest(_G.SelectedUnit)
        task.wait(0.5)
        GUI:Destroy()
    end
end)

task.spawn(function()
    while task.wait(5) do
        GUI.Name = "Hub_"..HttpService:GenerateGUID(false)
    end
end)
