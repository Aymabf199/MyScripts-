-- Script to duplicate the "Crimson Tyrant" unit in Anime Defenders map in Roblox

-- Function to duplicate a unit a specified number of times
local function duplicateUnit(unit, count)
    for i = 1, count do
        local clone = unit:Clone()
        clone.Parent = unit.Parent
        clone:SetPrimaryPartCFrame(unit.PrimaryPart.CFrame * CFrame.new(math.random(-10, 10), 0, math.random(-10, 10)))
    end
end

-- Function to create a simple UI for unit selection and activation
local function createUI()
    local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    local UnitsListButton = Instance.new("TextButton", Frame)
    local SelectedUnitLabel = Instance.new("TextLabel", Frame)
    local DuplicationCountTextBox = Instance.new("TextBox", Frame)
    local ActivateButton = Instance.new("TextButton", Frame)
    
    ScreenGui.Name = "DuplicateCrimsonTyrantGui"
    
    Frame.Name = "DuplicateCrimsonTyrantFrame"
    Frame.Size = UDim2.new(0, 300, 0, 400)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Draggable = true
    Frame.Active = true
    
    UnitsListButton.Name = "UnitsListButton"
    UnitsListButton.Size = UDim2.new(1, 0, 0.1, 0)
    UnitsListButton.Position = UDim2.new(0, 0, 0, 0)
    UnitsListButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    UnitsListButton.Text = "Show Units"
    
    SelectedUnitLabel.Name = "SelectedUnitLabel"
    SelectedUnitLabel.Size = UDim2.new(1, 0, 0.1, 0)
    SelectedUnitLabel.Position = UDim2.new(0, 0, 0.6, 0)
    SelectedUnitLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SelectedUnitLabel.Text = "Selected Unit: None"
    
    DuplicationCountTextBox.Name = "DuplicationCountTextBox"
    DuplicationCountTextBox.Size = UDim2.new(1, 0, 0.1, 0)
    DuplicationCountTextBox.Position = UDim2.new(0, 0, 0.7, 0)
    DuplicationCountTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DuplicationCountTextBox.Text = "Enter Duplication Count"
    
    ActivateButton.Name = "ActivateButton"
    ActivateButton.Size = UDim2.new(1, 0, 0.1, 0)
    ActivateButton.Position = UDim2.new(0, 0, 0.9, 0)
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ActivateButton.Text = "Activate Duplication"
    
    return UnitsListButton, SelectedUnitLabel, DuplicationCountTextBox, ActivateButton
end

-- Function to update the units list in the UI
local function updateUnitsList(SelectedUnitLabel)
    local player = game.Players.LocalPlayer
    local unitsFolder = game.Workspace:FindFirstChild("Units")
    
    if unitsFolder then
        for _, item in pairs(unitsFolder:GetChildren()) do
            if item.Name == "Crimson Tyrant" then
                SelectedUnitLabel.Text = "Selected Unit: " .. item.Name
                SelectedUnitLabel:SetAttribute("SelectedUnit", item)
                break
            end
        end
    end
end

-- Main script execution
local function main()
    local UnitsListButton, SelectedUnitLabel, DuplicationCountTextBox, ActivateButton = createUI()
    
    UnitsListButton.MouseButton1Click:Connect(function()
        updateUnitsList(SelectedUnitLabel)
    end)
    
    ActivateButton.MouseButton1Click:Connect(function()
        local count = tonumber(DuplicationCountTextBox.Text)
        local selectedUnit = SelectedUnitLabel:GetAttribute("SelectedUnit")
        if count and selectedUnit then
            duplicateUnit(selectedUnit, count)
        else
            print("Please select the 'Crimson Tyrant' unit and enter a valid number for duplication count.")
        end
    end)
end

-- Run the main function
main()
