-- Function to duplicate a unit
local function duplicateUnit(player, unitName, quantity)
    if not player or not player.Backpack then
        warn("Player or Backpack not found!")
        return
    end

    -- Find the original unit in the player's Backpack
    local originalUnit = player.Backpack:FindFirstChild(unitName)
    if not originalUnit then
        warn("Unit '" .. unitName .. "' not found in Backpack!")
        return
    end

    -- Duplicate the unit
    for i = 1, quantity do
        local newUnit = originalUnit:Clone()
        newUnit.Parent = player.Backpack
    end

    print("Successfully duplicated " .. unitName .. " x" .. quantity)
end

-- Function to create the GUI
local function createGui(player)
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UnitDuplicator"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 350) -- Adjusted size for mobile
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -175) -- Centered on screen
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Create Title Label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "Unit Duplicator"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Parent = mainFrame

    -- Create ScrollFrame for Units List
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 0, 200) -- Adjusted height
    scrollFrame.Position = UDim2.new(0, 10, 0, 40)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.Parent = mainFrame

    -- Function to populate the units list
    local function populateUnitsList()
        scrollFrame:ClearAllChildren()

        for _, unit in ipairs(player.Backpack:GetChildren()) do
            if unit:IsA("Tool") or unit:IsA("Model") then
                local button = Instance.new("TextButton")
                button.Text = unit.Name
                button.Font = Enum.Font.Gotham
                button.TextSize = 16
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                button.Size = UDim2.new(1, 0, 0, 30)
                button.Parent = scrollFrame

                -- Button Click Event
                button.MouseButton1Click:Connect(function()
                    local quantityTextBox = Instance.new("TextBox")
                    quantityTextBox.PlaceholderText = "Enter Quantity..."
                    quantityTextBox.Font = Enum.Font.Gotham
                    quantityTextBox.TextSize = 16
                    quantityTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    quantityTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    quantityTextBox.Size = UDim2.new(1, -20, 0, 30)
                    quantityTextBox.Position = UDim2.new(0, 10, 0, 250)
                    quantityTextBox.ClearTextOnFocus = false
                    quantityTextBox.Parent = mainFrame

                    local duplicateButton = Instance.new("TextButton")
                    duplicateButton.Text = "Duplicate"
                    duplicateButton.Font = Enum.Font.GothamBold
                    duplicateButton.TextSize = 16
                    duplicateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    duplicateButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                    duplicateButton.Size = UDim2.new(1, -20, 0, 40)
                    duplicateButton.Position = UDim2.new(0, 10, 0, 290)
                    duplicateButton.Parent = mainFrame

                    duplicateButton.MouseButton1Click:Connect(function()
                        local quantity = tonumber(quantityTextBox.Text)
                        if not quantity or quantity <= 0 then
                            warn("Please enter a valid quantity!")
                            return
                        end

                        duplicateUnit(player, unit.Name, quantity)
                    end)
                end)
            end
        end
    end

    -- Populate units list initially
    populateUnitsList()

    -- Update units list when Backpack changes
    player.Backpack.ChildAdded:Connect(populateUnitsList)
    player.Backpack.ChildRemoved:Connect(populateUnitsList)
end

-- Main function to execute the script
local function main()
    local localPlayer = game:GetService("Players").LocalPlayer
    if not localPlayer then
        warn("Local player not found!")
        return
    end

    -- Wait until the player's character and Backpack are loaded
    repeat wait() until localPlayer.Character and localPlayer:FindFirstChild("Backpack")

    -- Create the GUI
    createGui(localPlayer)
end

-- Execute the main function
main()
