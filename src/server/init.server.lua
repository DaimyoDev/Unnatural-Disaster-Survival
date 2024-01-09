local GameLoop = require(script.gameloop)
local IntermissionTimer = game.ServerStorage.IntermissionTimer
local RoundTimer = game.ServerStorage.RoundTimer
local mapSelected = false
local selectedMap
local playersTeleported = false
local disasterSelected = false

while task.wait(0.1) do 
    if IntermissionTimer.Value > 0 then
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
            print("teleport")
            playersTeleported = GameLoop.teleportPlayers(selectedMap)
        end
    end
    if RoundTimer.Value <= 200 and RoundTimer.Value >= 150 and not disasterSelected then
        GameLoop.chooseDisaster()
        disasterSelected = true
    end
    if RoundTimer.Value <= 0 then
        mapSelected = GameLoop.roundOver(selectedMap)
        playersTeleported = false
    end
end