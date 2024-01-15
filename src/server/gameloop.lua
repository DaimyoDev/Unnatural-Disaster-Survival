local GameLoop = {}
local GameTimer = game.ReplicatedStorage.GameTimer
local IntermissionTimer = game.ServerStorage.IntermissionTimer
local RoundTimer = game.ServerStorage.RoundTimer
local Map1, Map2, Map3 = game.ServerStorage.Maps.Map1, game.ServerStorage.Maps.Map2, game.ServerStorage.Maps.Map3
local maps = {Map1, Map2, Map3}
local roundStarted = false
local disasters = {"The Purge", "Raining Plastic", "Ban Hammer", "Giant Bacon"}
local lobbySpawn = game.Workspace.Lobby.SpawnLocation

function GameLoop.intermission()
    IntermissionTimer.Value -= 1
    GameTimer:FireAllClients(IntermissionTimer.Value, "Intermission")
end

function GameLoop.selectMap()
    local selectedMapIndex = math.random(1, 3)
    maps[selectedMapIndex].Parent = game.Workspace
    return true, maps[selectedMapIndex]
end

function GameLoop.chooseDisaster()

    local selectedDisasterIndex = math.random(1, 4)
    
    GameTimer:FireAllClients(RoundTimer.Value, disasters[selectedDisasterIndex])
    task.wait(3)

end

function GameLoop.teleportPlayers(selectedMap)
    local players = game:GetService("Players"):GetPlayers()
        for index, player in players do
            if selectedMap == Map1 then
                player.Character:FindFirstChild("HumanoidRootPart").CFrame = Map1.MapSpawn.CFrame
            end
            if selectedMap == Map2 then
                player.Character:FindFirstChild("HumanoidRootPart").CFrame = Map2.MapSpawn.CFrame
            end
            if selectedMap == Map3 then
                player.Character:FindFirstChild("HumanoidRootPart").CFrame = Map3.MapSpawn.CFrame
            end
        end
    return true
end

function GameLoop.Survivors(selectedMap)
    local survivorDetection
    if selectedMap == Map1 and RoundTimer.Value <= 0 then
        survivorDetection = Map1.SurvivorDetection
        survivorDetection.Touched:Connect(function(otherPart)
            if otherPart.Parent:FindFirstChild("Humanoid") then
                local players = game:GetService("Players"):GetPlayers()
                for index, player in players do
                    player.Character:FindFirstChild("HumanoidRootPart").CFrame = lobbySpawn.CFrame
                    player.Character:FindFirstChild("Humanoid").Health = player.Character:FindFirstChild("Humanoid").MaxHealth
                end
            end
        end)
    end
    if selectedMap == Map2 and RoundTimer.Value <= 0 then
        survivorDetection = Map2.SurvivorDetection
        survivorDetection.Touched:Connect(function(otherPart)
            if otherPart.Parent:FindFirstChild("Humanoid") then
                local players = game:GetService("Players"):GetPlayers()
                for index, player in players do
                    player.Character:FindFirstChild("HumanoidRootPart").CFrame = lobbySpawn.CFrame
                    player.Character:FindFirstChild("Humanoid").Health = player.Character:FindFirstChild("Humanoid").MaxHealth
                end
            end
        end)
    end
    if selectedMap == Map3 and RoundTimer.Value <= 0 then
        survivorDetection = Map3.SurvivorDetection
        survivorDetection.Touched:Connect(function(otherPart)
            if otherPart.Parent:FindFirstChild("Humanoid") then
                local players = game:GetService("Players"):GetPlayers()
                for index, player in players do
                    player.Character:FindFirstChild("HumanoidRootPart").CFrame = lobbySpawn.CFrame
                    player.Character:FindFirstChild("Humanoid").Health = player.Character:FindFirstChild("Humanoid").MaxHealth
                end
                
            end
        end)
    end
end

function GameLoop.gameRound(selectedMap)
    RoundTimer.Value -= 1
    GameTimer:FireAllClients(RoundTimer.Value, "gameRound")
    roundStarted = true
end

function GameLoop.roundOver(selectedMap)
    IntermissionTimer.Value = 30
    GameLoop.Survivors(selectedMap)
    task.wait(3)
    RoundTimer.Value = 240
    selectedMap.Parent = game.ServerStorage.Maps
    roundStarted = false
    return false
end

return GameLoop