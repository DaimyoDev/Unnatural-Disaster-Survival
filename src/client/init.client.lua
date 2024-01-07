local GameTimer = game.ReplicatedStorage.GameTimer
local TextLabel = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui").TextLabel

GameTimer.OnClientEvent:Connect(function(time, timeType)
    
    if timeType == "Intermission" then
        
        TextLabel.Text = "Intermission: " .. time .. " seconds left"

    end

    if timeType == "gameRound" then
        
        TextLabel.Text = time .. " seconds left"

    end

end)