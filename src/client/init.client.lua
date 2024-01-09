local GameTimer = game.ReplicatedStorage.GameTimer
local playerHumanoid = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("Humanoid")
local TextLabel = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui").TextLabel

GameTimer.OnClientEvent:Connect(function(time, timeType)
    if timeType == "Intermission" then  
        TextLabel.Text = "Intermission: " .. time .. " seconds left"
    end
    if timeType == "gameRound" then
        TextLabel.Text = time .. " seconds left"
    end
    if timeType ~= "Intermission" and timeType ~= "gameRound" then
        TextLabel.Text = "Chosen Disaster: " .. timeType
    end

end)