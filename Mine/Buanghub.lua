if not game:IsLoaded() then
    game.Loaded:Wait()
end

task.wait(math.random())

local games = {
    [12229756] = 'https://api.luarmor.net/files/v3/loaders/223ebf430943b6eeb6b81a550e5dcd52.lua',
    [5292947] = 'https://api.luarmor.net/files/v3/loaders/5626ab81ffceae865d22d54cb5042edf.lua',
    [15022320] = 'https://api.luarmor.net/files/v3/loaders/5626ab81ffceae865d22d54cb5042edf.lua',
    [5102326] = 'https://api.luarmor.net/files/v3/loaders/1b4c42f5913d7a5b7be56ee7766eb814.lua',
    [34121350] = 'https://api.luarmor.net/files/v3/loaders/1b4c42f5913d7a5b7be56ee7766eb814.lua',
    [15762744] = 'https://api.luarmor.net/files/v3/loaders/b1b345a5367607ec2c5ee64e9abb4783.lua',
    [33859442] = 'https://raw.githubusercontent.com/buang5516/buanghub/main/BuangHub.lua',
    [17219742] = "https://raw.githubusercontent.com/buang5516/buanghub/refs/heads/main/HUB/FreeKeySystem.lua",
    [10611639] = 'https://api.luarmor.net/files/v3/loaders/ce6e71a549aa871fea32fee1da4361e0.lua'
}

if games[game.CreatorId] then
    task.wait(math.random())
    loadstring(game:HttpGet(games[game.CreatorId]))()
end
