-- Script to duplicate the "Crimson Tyrant" unit in Anime Defenders map in Roblox

-- Function to duplicate a unit a specified number of times
local function duplicateUnit(unit, count)
    for i = 1, count do
        local clone = unit:Clone()
        clone.Parent = unit.Parent
        clone:SetPrimaryPartCFrame(unit.PrimaryPart.CFrame * CFrame.new(math.random(-10, 10), 0, math.random(-10, 10)))
    end
end

-- Function to create a simple UI for unit duplication
local function createUI()
    local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    local SelectedUnitLabel = Instance.new("TextLabel", Frame)
    local DuplicationCountTextBox = Instance.new("TextBox", Frame)
    local ActivateButton = Instance.new("TextButton", Frame)
    
    ScreenGui.Name = "DuplicateCrimsonTyrantGui"
    
    Frame.Name = "DuplicateCrimsonTyrantFrame"
    Frame.Size = UDim2.new(0, 300, 0, 200)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Draggable = true
    Frame.Active = true
    
    SelectedUnitLabel.Name = "SelectedUnitLabel"
    SelectedUnitLabel.Size = UDim2.new(1, 0, 0.2, 0)
    SelectedUnitLabel.Position = UDim2.new(0, 0, 0.1, 0)
    SelectedUnitLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SelectedUnitLabel.Text = "Selected Unit: Crimson Tyrant"
    
    DuplicationCountTextBox.Name = "DuplicationCountTextBox"
    DuplicationCountTextBox.Size = UDim2.new(1, 0, 0.2, 0)
    DuplicationCountTextBox.Position = UDim2.new(0, 0, 0.4, 0)
    DuplicationCountTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DuplicationCountTextBox.Text = "Enter Duplication Count"
    
    ActivateButton.Name = "ActivateButton"
    ActivateButton.Size = UDim2.new(1, 0, 0.2, 0)
    ActivateButton.Position = UDim2.new(0, 0, 0.7, 0)
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ActivateButton.Text = "Activate Duplication"
    
    return SelectedUnitLabel, DuplicationCountTextBox, ActivateButton
end

-- Function to find the "Crimson Tyrant" unit in the player's backpack
local function getCrimsonTyrant()
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    for _, item in pairs(backpack:GetChildren()) do
        if item.Name == "Crimson Tyrant" then
            return item
        end
    end
    
    return nil
end

-- Main script execution
local function main()
    local SelectedUnitLabel, DuplicationCountTextBox, ActivateButton = createUI()
    
    ActivateButton.MouseButton1Click:Connect(function()
        local count = tonumber(DuplicationCountTextBox.Text)
        local crimsonTyrant = getCrimsonTyrant()
        if count and crimsonTyrant then
            duplicateUnit(crimsonTyrant, count)
        else
            print("Please ensure you have 'Crimson Tyrant' and enter a valid number for duplication count.")
        end
    end)
end

-- Run the main function
main()

-- Additional code to handle GUI functionality and improve user experience
-- Function to make the Frame draggable
local function makeFrameDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Apply draggable functionality to the main frame
makeFrameDraggable(script.Parent.DuplicateCrimsonTyrantFrame)
