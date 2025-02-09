-- Script to duplicate selected unit in Anime Defenders map in Roblox

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
    local UnitsListFrame = Instance.new("Frame", Frame)
    local UnitsListButton = Instance.new("TextButton", Frame)
    local SelectedUnitLabel = Instance.new("TextLabel", Frame)
    local DuplicationCountTextBox = Instance.new("TextBox", Frame)
    local ActivateButton = Instance.new("TextButton", Frame)
    local UIListLayout = Instance.new("UIListLayout", UnitsListFrame)
    
    ScreenGui.Name = "DuplicateUnitsGui"
    
    Frame.Name = "DuplicateUnitsFrame"
    Frame.Size = UDim2.new(0, 300, 0, 400)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Draggable = true
    Frame.Active = true

    UnitsListFrame.Name = "UnitsListFrame"
    UnitsListFrame.Size = UDim2.new(1, 0, 0.6, 0)
    UnitsListFrame.Position = UDim2.new(0, 0, 0, 0)
    UnitsListFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UnitsListFrame.BackgroundTransparency = 0.5
    UnitsListFrame.Visible = false
    
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
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
    
    return UnitsListButton, UnitsListFrame, SelectedUnitLabel, DuplicationCountTextBox, ActivateButton
end

-- Function to update the units list in the UI
local function updateUnitsList(UnitsListFrame, SelectedUnitLabel)
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    for _, child in pairs(UnitsListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local UnitButton = Instance.new("TextButton", UnitsListFrame)
            UnitButton.Size = UDim2.new(1, -10, 0, 50)
            UnitButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            UnitButton.Text = item.Name
            UnitButton.MouseButton1Click:Connect(function()
                SelectedUnitLabel.Text = "Selected Unit: " .. item.Name
                SelectedUnitLabel:SetAttribute("SelectedUnit", item)
            end)
        end
    end
end

-- Main script execution
local function main()
    local UnitsListButton, UnitsListFrame, SelectedUnitLabel, DuplicationCountTextBox, ActivateButton = createUI()
    
    UnitsListButton.MouseButton1Click:Connect(function()
        UnitsListFrame.Visible = not UnitsListFrame.Visible
        if UnitsListFrame.Visible then
            updateUnitsList(UnitsListFrame, SelectedUnitLabel)
        end
    end)
    
    ActivateButton.MouseButton1Click:Connect(function()
        local count = tonumber(DuplicationCountTextBox.Text)
        local selectedUnit = SelectedUnitLabel:GetAttribute("SelectedUnit")
        if count and selectedUnit then
            duplicateUnit(selectedUnit, count)
        else
            print("Please select a unit and enter a valid number for duplication count.")
        end
    end)
end

-- Run the main function
main()
