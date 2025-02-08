local Player = game:GetService("Players").LocalPlayer
local GUI = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

GUI.Name = "6StarSystem"
GUI.Parent = Player:WaitForChild("PlayerGui")

Button.Name = "GetAll6Star"
Button.Size = UDim2.new(0.45, 0, 0.12, 0)
Button.Position = UDim2.new(0.275, 0, 0.8, 0)
Button.Text = "GET ALL 6★ CHARACTERS"
Button.BackgroundColor3 = Color3.new(0, 0.6, 0)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextScaled = true
Button.Parent = GUI

local Characters = {
    ["Gojo"] = {Stars = 6, ModelId = "rbxassetid://000001"},
    ["Zoro"] = {Stars = 6, ModelId = "rbxassetid://000002"},
    ["Luffy"] = {Stars = 6, ModelId = "rbxassetid://000003"},
    ["Naruto"] = {Stars = 6, ModelId = "rbxassetid://000004"},
    ["Sasuke"] = {Stars = 6, ModelId = "rbxassetid://000005"},
    ["Tanjiro"] = {Stars = 6, ModelId = "rbxassetid://000006"},
    ["Levi"] = {Stars = 6, ModelId = "rbxassetid://000007"},
    ["Goku"] = {Stars = 6, ModelId = "rbxassetid://000008"}
}

local function AddCharacters()
    if not Player.Backpack then
        Instance.new("Backpack").Parent = Player
    end
    
    Player.Backpack:Clear()
    
    for CharName, Data in pairs(Characters) do
        local Tool = Instance.new("Tool")
        Tool.Name = CharName
        
        local StarsValue = Instance.new("IntValue")
        StarsValue.Name = "Stars"
        StarsValue.Value = 6
        StarsValue.Parent = Tool
        
        local Handle = Instance.new("Part")
        Handle.Name = "Handle"
        Handle.Size = Vector3.new(2, 2, 2)
        Handle.Parent = Tool
        
        Tool.Parent = Player.Backpack
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SUCCESS!",
        Text = #Player.Backpack:GetChildren().." 6★ Added",
        Duration = 3
    })
end

Button.MouseButton1Click:Connect(AddCharacters)
