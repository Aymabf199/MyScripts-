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

    -- Create Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 150)
    frame.Position = UDim2.new(0.5, -125, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- Create Title Label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "Unit Duplicator"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Parent = frame

    -- Create TextBox for Unit Name
    local textBox = Instance.new("TextBox")
    textBox.PlaceholderText = "Enter Unit Name"
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.Size = UDim2.new(1, -20, 0, 30)
    textBox.Position = UDim2.new(0, 10, 0, 40)
    textBox.ClearTextOnFocus = false
    textBox.Parent = frame

    -- Create Duplicate Button
    local duplicateButton = Instance.new("TextButton")
    duplicateButton.Text = "Duplicate"
    duplicateButton.Font = Enum.Font.GothamBold
    duplicateButton.TextSize = 16
    duplicateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    duplicateButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    duplicateButton.Size = UDim2.new(1, -20, 0, 40)
    duplicateButton.Position = UDim2.new(0, 10, 0, 80)
    duplicateButton.Parent = frame

    -- Button Click Event
    duplicateButton.MouseButton1Click:Connect(function()
        local unitName = textBox.Text
        if unitName ~= "" then
            duplicateUnit(player, unitName, 10) -- Change '10' to desired quantity
        else
            warn("Please enter a valid unit name!")
        end
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
