local GameLoop = require(script.gameloop)
local IntermissionTimer = game.ServerStorage.IntermissionTimer
local RoundTimer = game.ServerStorage.RoundTimer
local mapSelected = false
local selectedMap
local playersTeleported = false

while task.wait(0.1) do 
    if IntermissionTimer.Value > 0 then
        GameLoop.intermission()
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
    if RoundTimer.Value <= 0 then
        mapSelected, playersTeleported = GameLoop.roundOver(selectedMap)
    end
end