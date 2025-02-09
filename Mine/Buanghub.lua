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
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
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

    -- Create Search TextBox
    local searchBox = Instance.new("TextBox")
    searchBox.PlaceholderText = "Search Unit..."
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 16
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    searchBox.Size = UDim2.new(1, -20, 0, 30)
    searchBox.Position = UDim2.new(0, 10, 0, 40)
    searchBox.ClearTextOnFocus = false
    searchBox.Parent = frame

    -- Create ScrollFrame for Units List
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -100)
    scrollFrame.Position = UDim2.new(0, 10, 0, 80)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.Parent = frame

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
                    duplicateUnit(player, unit.Name, 10) -- Change '10' to desired quantity
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
