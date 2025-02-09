local function duplicateUnit(player, unitName, quantity)
 if not player or not player.Backpack then return end
 local originalUnit = player.Backpack:FindFirstChild(unitName)
 if not originalUnit then warn("Unit not found!"); return end
 for i = 1, quantity do
  local newUnit = originalUnit:Clone()
  newUnit.Parent = player.Backpack
 end
 print("Duplicated " .. unitName .. " x" .. quantity)
end

local function increaseHealth(player, amount)
 if not player or not player.Character then return end
 local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
 if not humanoid then warn("Humanoid not found!"); return end
 humanoid.MaxHealth = humanoid.MaxHealth + amount
 humanoid.Health = humanoid.Health + amount
 print("Increased health by " .. amount)
end

local localPlayer = game:GetService("Players").LocalPlayer
if localPlayer then
 duplicateUnit(localPlayer, "unit name", 10)
 increaseHealth(localPlayer, 500)
else warn("Local player not found!") end
