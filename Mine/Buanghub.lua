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
 local textLabel = Instance.new("TextLabel")
 screenGui.Name = "CharacterButtonUI"
 screenGui.ResetOnSpawn = false
 screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
 button.Name = "GetCharactersButton"
 button.Size = UDim2.new(0, 200, 0, 50)
 button.Position = UDim2.new(0.5, -100, 0.8, 0)
 button.Text = "Get Characters"
 button.Font = Enum.Font.GothamBold
 button.TextSize = 18
 button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
 button.TextColor3 = Color3.fromRGB(255, 255, 255)
 button.Parent = screenGui
 textLabel.Name = "InfoLabel"
 textLabel.Size = UDim2.new(0, 200, 0, 30)
 textLabel.Position = UDim2.new(0.5, -100, 0.75, 0)
 textLabel.Text = "Click to get characters!"
 textLabel.Font = Enum.Font.GothamSemibold
 textLabel.TextSize = 16
 textLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
 textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
 textLabel.Parent = screenGui
 button.MouseButton1Click:Connect(function()
  giveCharacters(player)
  button.Text = "Characters Given!"
  wait(2)
  button.Text = "Get Characters"
 end)
 local dragging = false
 local dragInput, mousePos, framePos
 button.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
   dragging = true
   mousePos = Input.mousePosition
   framePos = screenGui.AbsolutePosition
  end
 end)
 button.InputEnded:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
   dragging = false
  end
 end)
 Input.InputChanged:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
   local delta = input.Position - mousePos
   screenGui.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
  end
 end)
end

local localPlayer = game:GetService("Players").LocalPlayer
if localPlayer then
 spawn(function()
  repeat wait() until localPlayer.Character
  createButtonUI(localPlayer)
 end)
else warn("Local player not found!") end
