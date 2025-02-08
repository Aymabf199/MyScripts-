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
 for _, characterName in ipairs(desiredCharacters) do
  local character = characterStorage:FindFirstChild(characterName)
  if character and (character:IsA("Tool") or character:IsA("Model")) then
   local success, err = pcall(function()
    local newChar = character:Clone()
    newChar.Parent = player.Backpack
   end)
   if not success then warn("Failed to give "..characterName.." Error: "..tostring(err)) end
  else warn("Character not found or invalid: "..characterName) end
 end
end

local function createButtonUI(player)
 local screenGui = Instance.new("ScreenGui")
 local button = Instance.new("TextButton")
 screenGui.Name = "CharacterButtonUI"
 screenGui.ResetOnSpawn = false
 screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
 button.Name = "GetCharactersButton"
 button.Size = UDim2.new(0, 150, 0, 40)
 button.Position = UDim2.new(0.5, -75, 0.8, 0)
 button.Text = "Get Characters"
 button.Font = Enum.Font.GothamBold
 button.TextSize = 16
 button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
 button.TextColor3 = Color3.fromRGB(255, 255, 255)
 button.Parent = screenGui
 button.MouseButton1Click:Connect(function()
  giveCharacters(player)
  button.Text = "Characters Given!"
  wait(2)
  button.Text = "Get Characters"
 end)
 local dragging = false
 local dragStart = nil
 local startPos = nil
 button.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
   dragging = true
   dragStart = input.Position
   startPos = screenGui.AbsolutePosition
  end
 end)
 button.InputEnded:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
   dragging = false
  end
 end)
 game:GetService("UserInputService").InputChanged:Connect(function(input)
  if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
   local delta = input.Position - dragStart
   screenGui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
  end
 end)
end

local localPlayer = game:GetService("Players").LocalPlayer
if localPlayer then
 spawn(function()
  repeat wait() until localPlayer.Character and localPlayer:FindFirstChild("Backpack")
  createButtonUI(localPlayer)
 end)
else warn("Local player not found!") end
