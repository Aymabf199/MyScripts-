-- Function to duplicate a unit
local function duplicateUnit(player, unitName, quantity)
    if not player or not player.Backpack then return end

    -- Find the original unit in the player's Backpack
    local originalUnit = player.Backpack:FindFirstChild(unitName)
    if not originalUnit then
        warn("Unit '" .. unitName .. "' not found!")
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
    mainFrame.Size = UDim2.new(0, 300, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
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

    -- Create Unit Name TextBox
    local unitTextBox = Instance.new("TextBox")
    unitTextBox.PlaceholderText = "Enter Unit Name..."
    unitTextBox.Font = Enum.Font.Gotham
    unitTextBox.TextSize = 16
    unitTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    unitTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    unitTextBox.Size = UDim2.new(1, -20, 0, 30)
    unitTextBox.Position = UDim2.new(0, 10, 0, 40)
    unitTextBox.ClearTextOnFocus = false
    unitTextBox.Parent = mainFrame

    -- Create Quantity TextBox
    local quantityTextBox = Instance.new("TextBox")
    quantityTextBox.PlaceholderText = "Enter Quantity..."
    quantityTextBox.Font = Enum.Font.Gotham
    quantityTextBox.TextSize = 16
    quantityTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    quantityTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    quantityTextBox.Size = UDim2.new(1, -20, 0, 30)
    quantityTextBox.Position = UDim2.new(0, 10, 0, 80)
    quantityTextBox.ClearTextOnFocus = false
    quantityTextBox.Parent = mainFrame

    -- Create Duplicate Button
    local duplicateButton = Instance.new("TextButton")
    duplicateButton.Text = "Duplicate"
    duplicateButton.Font = Enum.Font.GothamBold
    duplicateButton.TextSize = 16
    duplicateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    duplicateButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    duplicateButton.Size = UDim2.new(1, -20, 0, 40)
    duplicateButton.Position = UDim2.new(0, 10, 0, 120)
    duplicateButton.Parent = mainFrame

    -- Button Click Event
    duplicateButton.MouseButton1Click:Connect(function()
        local unitName = unitTextBox.Text
        local quantity = tonumber(quantityTextBox.Text)

        if unitName == "" then
            warn("Please enter a valid unit name!")
            return
        end

        if not quantity or quantity <= 0 then
            warn("Please enter a valid quantity!")
            return
        end

        duplicateUnit(player, unitName, quantity)
    end)
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
