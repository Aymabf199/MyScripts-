local desiredCharacters = {"Ruffy (5th Form)","Devil","Legendary Leader Mysterious X","Spin Master"}

local function giveCharacters(player)
 if not player then return end
 local characterStorage = nil
 for _, location in ipairs({workspace, game:GetService("ReplicatedStorage"), game:GetService("ServerStorage")}) do
  if location:FindFirstChild("Characters") or location:FindFirstChild("CharacterSelection") then
   characterStorage = location
   break
  end
 end
 if not characterStorage then return end
 if not player:FindFirstChild("Backpack") then return end
 for _, characterName in ipairs(desiredCharacters) do
  local character = characterStorage:FindFirstChild(characterName)
  if character then
   if character:IsA("Tool") or character:IsA("Model") or character:IsA("Folder") then
    local success, err = pcall(function()
     local newChar = character:Clone()
     newChar.Parent = player.Backpack
    end)
    if not success then warn("Failed to give "..characterName.." Error: "..tostring(err)) end
   else warn("Invalid type for "..characterName) end
  else warn("Character not found: "..characterName) end
 end
end

local function waitForPlayerData(player)
 if not player then return end
 repeat wait(1) until player.Character and player:FindFirstChild("Backpack")
end

local localPlayer = game:GetService("Players").LocalPlayer
if localPlayer then
 spawn(function()
  waitForPlayerData(localPlayer)
  giveCharacters(localPlayer)
 end)
else warn("Local player not found!") end
