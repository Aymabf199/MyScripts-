local characters = { "Ruffy (5th Form)", "Devil", "Legendary Leader Mysterious X", "Spin Master" }

local function giveCharacters(player)
    if not player then return end
    local characterSelection = game:GetService("Workspace").CharacterSelection
    if not characterSelection then return end

    for _, characterName in ipairs(characters) do
        local character = characterSelection:FindFirstChild(characterName)
        if character then
            local success, err = pcall(function()
                character:Clone().Parent = player.Backpack
            end)
            if not success then
                warn("Failed to give character: " .. characterName .. ". Error: " .. tostring(err))
            end
        else
            warn("Character not found: " .. characterName)
        end
    end
end

local player = game.Players.LocalPlayer
if player then
    giveCharacters(player)
end
