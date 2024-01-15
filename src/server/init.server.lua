local GameLoop = require(script.gameloop)
local IntermissionTimer = game.ServerStorage.IntermissionTimer
local RoundTimer = game.ServerStorage.RoundTimer
local mapSelected = false
local selectedMap
local playersTeleported = false
local disasterSelected = false
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local roundOver = false
local lobbySpawn = game.Workspace.Lobby.SpawnLocation

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
           if CollectionService:HasTag(player, "Survivor") then
                CollectionService:RemoveTag(player, "Survivor")
           end
        end)
    end)
end)

while task.wait(0.1) do
    if roundOver then
       local players = Players:GetPlayers()
       
       for index, player in ipairs(players) do
        if CollectionService:HasTag(player, "Survivor") then
            player.Character:FindFirstChild("HumanoidRootPart").CFrame = lobbySpawn.CFrame
            player.Character:FindFirstChild("Humanoid").Health = 100
       end
            CollectionService:AddTag(player, "Survivor")
       end
        roundOver = false
    end
    if IntermissionTimer.Value > 0 then
        local players = Players:GetPlayers()
        for index, player in ipairs(players) do
            CollectionService:AddTag(player, "Survivor")
           end
        GameLoop.intermission()
        if disasterSelected then
            disasterSelected = false
        end
    end
    if IntermissionTimer.Value <= 10 and not mapSelected then
       mapSelected, selectedMap = GameLoop.selectMap()
    end
    if IntermissionTimer.Value <= 0 then 
        GameLoop.gameRound(selectedMap)
        if playersTeleported == false then
            playersTeleported = GameLoop.teleportPlayers(selectedMap)
        end
    end
    if RoundTimer.Value <= 200 and RoundTimer.Value >= 150 and not disasterSelected then
        GameLoop.chooseDisaster()
        disasterSelected = true
    end
    if RoundTimer.Value <= 0 then
        mapSelected = GameLoop.roundOver(selectedMap)
        roundOver = true
        playersTeleported = false
    end
end