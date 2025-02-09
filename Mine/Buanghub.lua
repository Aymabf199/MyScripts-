-- Function to duplicate units
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

-- Function to increase player's health
local function increaseHealth(player, amount)
    if not player or not player.Character then return end

    -- Find the Humanoid in the player's character
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        warn("Humanoid not found!")
        return
    end

    -- Increase MaxHealth and Health
    humanoid.MaxHealth = humanoid.MaxHealth + amount
    humanoid.Health = humanoid.Health + amount

    print("Increased health by " .. amount)
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

    -- List of units you want to duplicate (add your unit names here)
    local unitsToDuplicate = {"Ruffy", "Naruto", "Sasuke", "Goku"} -- Replace with your actual unit names
    local duplicationQuantity = 10 -- Number of duplicates per unit
    local healthIncreaseAmount = 500 -- Amount to increase health

    -- Duplicate each unit in the list
    for _, unitName in ipairs(unitsToDuplicate) do
        duplicateUnit(localPlayer, unitName, duplicationQuantity)
    end

    -- Increase player's health
    increaseHealth(localPlayer, healthIncreaseAmount)
end

-- Execute the main function
main()
