-- Script to duplicate units in Anime Defenders map in Roblox

-- Function to duplicate a unit
local function duplicateUnit(unit)
    local clone = unit:Clone()
    clone.Parent = unit.Parent
    clone:SetPrimaryPartCFrame(unit.PrimaryPart.CFrame * CFrame.new(math.random(-10, 10), 0, math.random(-10, 10)))
end

-- Function to find all units in the map and duplicate them
local function duplicateAllUnits()
    local units = game.Workspace:FindFirstChild("Units")
    if units then
        for _, unit in pairs(units:GetChildren()) do
            duplicateUnit(unit)
        end
    end
end

-- Function to create a simple UI for activation
local function createUI()
    local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    local ActivateButton = Instance.new("TextButton", Frame)
    
    ScreenGui.Name = "DuplicateUnitsGui"
    
    Frame.Name = "DuplicateUnitsFrame"
    Frame.Size = UDim2.new(0, 200, 0, 100)
    Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Draggable = true
    Frame.Active = true
    
    ActivateButton.Name = "ActivateButton"
    ActivateButton.Size = UDim2.new(1, 0, 1, 0)
    ActivateButton.Position = UDim2.new(0, 0, 0, 0)
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ActivateButton.Text = "Activate Duplication"
    
    return ActivateButton
end

-- Function to handle button click
local function onButtonClick()
    while true do
        wait(5)
        duplicateAllUnits()
    end
end

-- Main script execution
local function main()
    local ActivateButton = createUI()
    ActivateButton.MouseButton1Click:Connect(onButtonClick)
end

-- Run the main function
main()
