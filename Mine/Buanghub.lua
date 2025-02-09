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
    local unitsToDuplicate = {"Crimson Tyrant", "Ruffy", "Naruto", "Sasuke"} -- Add your units here
    local duplicationQuantity = 10 -- Number of duplicates per unit

    -- Duplicate each unit in the list
    for _, unitName in ipairs(unitsToDuplicate) do
        duplicateUnit(localPlayer, unitName, duplicationQuantity)
    end
end

-- Execute the main function
main()
