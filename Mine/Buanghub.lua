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

-- Main function to execute the script
local function main()
    local localPlayer = game:GetService("Players").LocalPlayer
    if not localPlayer then
        warn("Local player not found!")
        return
    end

    -- Wait until the player's character and Backpack are loaded
    repeat wait() until localPlayer.Character and localPlayer:FindFirstChild("Backpack")

    -- Define the unit to duplicate
    local unitToDuplicate = "Crimson Tyrant" -- Name of the unit
    local duplicationQuantity = 10 -- Number of duplicates

    -- Duplicate the specified unit
    duplicateUnit(localPlayer, unitToDuplicate, duplicationQuantity)
end

-- Execute the main function
main()
