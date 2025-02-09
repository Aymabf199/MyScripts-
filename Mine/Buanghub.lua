-- Function to duplicate a unit
local function duplicateUnit(player, unitName, quantity)
    if not player or not player.Backpack then
        warn("Player or Backpack not found!")
        return
    end

    -- Search for the unit in multiple locations
    local possibleLocations = {player.Backpack, workspace, game:GetService("ReplicatedStorage")}
    local originalUnit = nil

    for _, location in ipairs(possibleLocations) do
        originalUnit = location:FindFirstChild(unitName)
        if originalUnit then break end
    end

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
    screenGui.Name = "AdvancedUnitDuplicator"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Create Title Label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "Advanced Unit Duplicator"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Parent = mainFrame

    -- Create Search TextBox
    local searchBox = Instance.new("TextBox")
    searchBox.PlaceholderText = "Search Units..."
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 16
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    searchBox.Size = UDim2.new(1, -20, 0, 30)
    searchBox.Position = UDim2.new(0, 10, 0, 40)
    searchBox.ClearTextOnFocus = false
    searchBox.Parent = mainFrame

    -- Create ScrollFrame for Units List
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 0, 250)
    scrollFrame.Position = UDim2.new(0, 10, 0, 80)
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
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                button.Size = UDim2.new(1, 0, 0, 30)
                button.Parent = scrollFrame

                -- Button Click Event
                button.MouseButton1Click:Connect(function()
                    searchBox.Text = unit.Name -- Auto-fill search box with selected unit
                end)
            end
        end
    end

    -- Populate units list initially
    populateUnitsList()

    -- Update units list when Backpack changes
    player.Backpack.ChildAdded:Connect(populateUnitsList)
    player.Backpack.ChildRemoved:Connect(populateUnitsList)

    -- Handle search functionality
    searchBox.Changed:Connect(function(prop)
        if prop == "Text" then
            local query = searchBox.Text:lower()
            for _, button in ipairs(scrollFrame:GetChildren()) do
                if button:IsA("TextButton") then
                    button.Visible = string.find(button.Text:lower(), query, 1, true) ~= nil
                end
            end
        end
    end)

    -- Create Quantity TextBox
    local quantityTextBox = Instance.new("TextBox")
    quantityTextBox.PlaceholderText = "Enter Quantity..."
    quantityTextBox.Font = Enum.Font.Gotham
    quantityTextBox.TextSize = 16
    quantityTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    quantityTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    quantityTextBox.Size = UDim2.new(1, -20, 0, 30)
    quantityTextBox.Position = UDim2.new(0, 10, 0, 340)
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
    duplicateButton.Position = UDim2.new(0, 10, 0, 380)
    duplicateButton.Parent = mainFrame

    -- Button Click Event
    duplicateButton.MouseButton1Click:Connect(function()
        local unitName = searchBox.Text
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
