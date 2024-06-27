-- Load the Notify library
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/dxhooknotify/src.lua", true))()
local AtCheckpoint = false

-- Function to check if the local player is in a pilot seat of any plane
local function getPlayerPlane()
    for _, plane in pairs(game.Workspace.Aircraft:GetChildren()) do
        local pilotSeat = plane:FindFirstChild("Main"):FindFirstChild("Seats"):FindFirstChild("PilotSeat")
        if pilotSeat and pilotSeat.Occupant and pilotSeat.Occupant.Parent and pilotSeat.Occupant.Parent.Name == game.Players.LocalPlayer.Name then
            return plane
        end
    end
    return nil
end

-- Function to teleport the plane to a checkpoint
local function teleportPlaneToCheckpoint(plane, checkpoint)
    local nose = plane:FindFirstChild("Body"):FindFirstChild("Nose")
    if nose and checkpoint then
        AtCheckpoint = true
        -- Keep the plane upright by setting the CFrame without rotation
        nose.CFrame = checkpoint.CFrame
        -- the plane sometimes doesnt like to unanchor pls fix this
        print("Anchoring nose part...")
        nose.Anchored = false
        wait(1)
        print(nose.Anchored)
        nose.Anchored = true

        wait(1) -- Allow some time for the teleportation to take effect
        AtCheckpoint = false
    else
        NotifyLib:Notify("MissionExploit", "Plane nose is not found!", 2)
        return false
    end
end

-- Function to get all checkpoints and return them in a numerically sorted order
local function getAllCheckpoints(mission)
    local checkpoints = mission:GetChildren()
    table.sort(checkpoints, function(a, b)
        local aNum = tonumber(a.Name:match("%d+"))
        local bNum = tonumber(b.Name:match("%d+"))
        return aNum < bNum
    end)
    return checkpoints
end

-- Debugging function
local function debugMessage(message)
    print("[DEBUG] " .. message)
end

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("MissionStatusGui") then
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("MissionStatusGui"):Destroy()
end

-- Gui to Lua
-- Version: 3.2

-- Instances:

local MissionStatusGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local aircraftLabel = Instance.new("TextLabel")
local missionLabel = Instance.new("TextLabel")
local checkpointLabel = Instance.new("TextLabel")
local unanchorButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local GetMission = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local GetAircraft = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UICorner_5 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local TextLabel_5 = Instance.new("TextLabel")
local statusLabel = Instance.new("TextLabel")
local TextLabel_6 = Instance.new("TextLabel")
local missionsLabel = Instance.new("TextLabel")

--Properties:

MissionStatusGui.Name = "MissionStatusGui"
MissionStatusGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MissionStatusGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = MissionStatusGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.134310141, 0, 0.577694237, 0)
Frame.Size = UDim2.new(0, 344, 0, 319)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.208245218, 0, 0.0188087765, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 36)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.Text = "PTFS HUB"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(-0.00105711468, 0, 0.128865212, 0)
TextLabel_2.Size = UDim2.new(0, 200, 0, 36)
TextLabel_2.Font = Enum.Font.SourceSansSemibold
TextLabel_2.Text = "Aircraft"
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

TextLabel_3.Parent = Frame
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(-0.00105711468, 0, 0.363134772, 0)
TextLabel_3.Size = UDim2.new(0, 200, 0, 36)
TextLabel_3.Font = Enum.Font.SourceSansSemibold
TextLabel_3.Text = "Mission"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

TextLabel_4.Parent = Frame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(-0.00105711468, 0, 0.56605649, 0)
TextLabel_4.Size = UDim2.new(0, 200, 0, 36)
TextLabel_4.Font = Enum.Font.SourceSansSemibold
TextLabel_4.Text = "Checkpoint"
TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

aircraftLabel.Name = "aircraftLabel"
aircraftLabel.Parent = Frame
aircraftLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aircraftLabel.BackgroundTransparency = 1.000
aircraftLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
aircraftLabel.BorderSizePixel = 0
aircraftLabel.Position = UDim2.new(-0.00105711468, 0, 0.269730419, 0)
aircraftLabel.Size = UDim2.new(0, 200, 0, 21)
aircraftLabel.Font = Enum.Font.SourceSansSemibold
aircraftLabel.Text = "N/A"
aircraftLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
aircraftLabel.TextScaled = true
aircraftLabel.TextSize = 14.000
aircraftLabel.TextWrapped = true

missionLabel.Name = "missionLabel"
missionLabel.Parent = Frame
missionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
missionLabel.BackgroundTransparency = 1.000
missionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
missionLabel.BorderSizePixel = 0
missionLabel.Position = UDim2.new(-0.00105711468, 0, 0.478921622, 0)
missionLabel.Size = UDim2.new(0, 200, 0, 21)
missionLabel.Font = Enum.Font.SourceSansSemibold
missionLabel.Text = "N/A"
missionLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
missionLabel.TextScaled = true
missionLabel.TextSize = 14.000
missionLabel.TextWrapped = true

checkpointLabel.Name = "checkpointLabel"
checkpointLabel.Parent = Frame
checkpointLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
checkpointLabel.BackgroundTransparency = 1.000
checkpointLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
checkpointLabel.BorderSizePixel = 0
checkpointLabel.Position = UDim2.new(-0.00105711468, 0, 0.678708434, 0)
checkpointLabel.Size = UDim2.new(0, 200, 0, 21)
checkpointLabel.Font = Enum.Font.SourceSansSemibold
checkpointLabel.Text = "N/A"
checkpointLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
checkpointLabel.TextScaled = true
checkpointLabel.TextSize = 14.000
checkpointLabel.TextWrapped = true

unanchorButton.Name = "unanchorButton"
unanchorButton.Parent = Frame
unanchorButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
unanchorButton.BackgroundTransparency = 0.800
unanchorButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
unanchorButton.BorderSizePixel = 0
unanchorButton.Position = UDim2.new(0.208245218, 0, 0.877078235, 0)
unanchorButton.Size = UDim2.new(0, 200, 0, 30)
unanchorButton.Font = Enum.Font.SourceSansSemibold
unanchorButton.Text = "Fix Plane"
unanchorButton.TextColor3 = Color3.fromRGB(0, 0, 0)
unanchorButton.TextScaled = true
unanchorButton.TextSize = 14.000
unanchorButton.TextWrapped = true

UICorner.Parent = unanchorButton

GetMission.Name = "GetMission"
GetMission.Parent = Frame
GetMission.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GetMission.BackgroundTransparency = 0.800
GetMission.BorderColor3 = Color3.fromRGB(0, 0, 0)
GetMission.BorderSizePixel = 0
GetMission.Position = UDim2.new(0.606501043, 0, 0.253253818, 0)
GetMission.Size = UDim2.new(0, 108, 0, 30)
GetMission.Font = Enum.Font.SourceSansSemibold
GetMission.Text = "Get Mission"
GetMission.TextColor3 = Color3.fromRGB(0, 0, 0)
GetMission.TextScaled = true
GetMission.TextSize = 14.000
GetMission.TextWrapped = true

UICorner_2.Parent = GetMission

GetAircraft.Name = "GetAircraft"
GetAircraft.Parent = Frame
GetAircraft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GetAircraft.BackgroundTransparency = 0.800
GetAircraft.BorderColor3 = Color3.fromRGB(0, 0, 0)
GetAircraft.BorderSizePixel = 0
GetAircraft.Position = UDim2.new(0.606501043, 0, 0.146670729, 0)
GetAircraft.Size = UDim2.new(0, 108, 0, 30)
GetAircraft.Font = Enum.Font.SourceSansSemibold
GetAircraft.Text = "Get Aircraft"
GetAircraft.TextColor3 = Color3.fromRGB(0, 0, 0)
GetAircraft.TextScaled = true
GetAircraft.TextSize = 14.000
GetAircraft.TextWrapped = true

UICorner_3.Parent = GetAircraft

CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundTransparency = 0.800
CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.789640546, 0, 0.0369528644, 0)
CloseButton.Size = UDim2.new(0, 62, 0, 24)
CloseButton.Modal = true
CloseButton.Font = Enum.Font.SourceSansSemibold
CloseButton.Text = "Close"
CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextScaled = true
CloseButton.TextSize = 14.000
CloseButton.TextWrapped = true

UICorner_4.Parent = CloseButton

UICorner_5.CornerRadius = UDim.new(0, 4)
UICorner_5.Parent = Frame

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(48, 192, 188)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(248, 189, 50))}
UIGradient.Parent = Frame

TextLabel_5.Parent = Frame
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 1.000
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.472780108, 0, 0.390507907, 0)
TextLabel_5.Size = UDim2.new(0, 200, 0, 36)
TextLabel_5.Font = Enum.Font.SourceSansSemibold
TextLabel_5.Text = "Status"
TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14.000
TextLabel_5.TextWrapped = true

statusLabel.Name = "statusLabel"
statusLabel.Parent = Frame
statusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.BackgroundTransparency = 1.000
statusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
statusLabel.BorderSizePixel = 0
statusLabel.Position = UDim2.new(0.472780108, 0, 0.503159881, 0)
statusLabel.Size = UDim2.new(0, 200, 0, 21)
statusLabel.Font = Enum.Font.SourceSansSemibold
statusLabel.Text = "N/A"
statusLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
statusLabel.TextScaled = true
statusLabel.TextSize = 14.000
statusLabel.TextWrapped = true

TextLabel_6.Parent = Frame
TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.BackgroundTransparency = 1.000
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.BorderSizePixel = 0
TextLabel_6.Position = UDim2.new(0.472780108, 0, 0.56605649, 0)
TextLabel_6.Size = UDim2.new(0, 200, 0, 36)
TextLabel_6.Font = Enum.Font.SourceSansSemibold
TextLabel_6.Text = "Missions"
TextLabel_6.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 14.000
TextLabel_6.TextWrapped = true

missionsLabel.Name = "missionsLabel"
missionsLabel.Parent = Frame
missionsLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
missionsLabel.BackgroundTransparency = 1.000
missionsLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
missionsLabel.BorderSizePixel = 0
missionsLabel.Position = UDim2.new(0.472780108, 0, 0.678708434, 0)
missionsLabel.Size = UDim2.new(0, 200, 0, 21)
missionsLabel.Font = Enum.Font.SourceSansSemibold
missionsLabel.Text = "N/A"
missionsLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
missionsLabel.TextScaled = true
missionsLabel.TextSize = 14.000
missionsLabel.TextWrapped = true

UICorner_2.Parent = unanchorButton

-- Unanchor plane function
local function unanchorPlane()
    local playerPlane = getPlayerPlane()
    if playerPlane then
        playerPlane.Body.Nose.Anchored = false
        NotifyLib:Notify("Plane Control", "Plane unanchored.", 2)
        wait(1)
        playerPlane.Body.Nose.Anchored = true
    else
        NotifyLib:Notify("Error", "No plane found to unanchor.", 2)
    end
end
-- Connect the Unanchor Button to the function
unanchorButton.MouseButton1Click:Connect(unanchorPlane)

-- Main function to run the mission logic
local function runMissions()
    local missionComplete = false
    statusLabel.Text = 'Getting Mission...'

    while not missionComplete do
        local activeMissionFolder = game.Workspace:FindFirstChild("ActiveMission")
        
        -- Check if there is an active mission folder
        if not activeMissionFolder or #activeMissionFolder:GetChildren() == 0 then
            debugMessage("No active mission found.")
            wait(5)
        else
            for _, mission in pairs(activeMissionFolder:GetChildren()) do
                if mission then
                    statusLabel.Text = 'Got Mission'
                    wait(1)
                    statusLabel.Text = 'Getting Plane...'
                    wait(1)
                    
                    local playerPlane = getPlayerPlane()
                    if playerPlane then
                        local playerplanetemp = getPlayerPlane()
                        if playerplanetemp then
                            statusLabel.Text = 'Got Plane'
                            aircraftLabel.Text = playerplanetemp.Name
                            missionLabel.Text = mission.Name
                        end
                    else
                        debugMessage("Not in plane or not found")
                        wait(5)
                        continue
                    end

                    local checkpoints = getAllCheckpoints(mission)
                    local allCheckpointsReached = true
                    for index, checkpoint in pairs(checkpoints) do
                        statusLabel.Text = 'Got Checkpoint Data...'
                         statusLabel.Text = 'Completeting Mission...'
                        if checkpoint:FindFirstChild("Detector") then
                            wait(1)
                            local detector = checkpoint.Detector
                            local success = teleportPlaneToCheckpoint(playerPlane, detector)
                            local checkpointsinMission = game.Players.LocalPlayer.PlayerGui.MissionsGui.MissionInfo.Checkpoints.CurrentCheckpoint
                            repeat
                                task.wait()
                            until AtCheckpoint == false
                            local status = "Checkpoint: " .. checkpointsinMission.Text
                            statusLabel.Text = "Teleported to ".. tostring(checkpoint)
                            checkpointLabel.Text = status
                        else
                            debugMessage("Detector not found in " .. checkpoint.Name)
                            allCheckpointsReached = false
                        end
                    end

                    if allCheckpointsReached then
                        missionComplete = true
                        debugMessage("Teleporting to GR...")
                        playerPlane:Destroy()
                        debugMessage("Teleporting...")
                        game.Players.LocalPlayer.Character.Humanoid.Health = 0
                        game.Players.LocalPlayer.CharacterAdded:Wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns:FindFirstChild("AGreator Rockford").CFrame
                        debugMessage("Mission completed successfully.")
                        missionsLabel.Text = tostring(game.Players.LocalPlayer.leaderstats.Missions.Value)
                    else
                        debugMessage("Failed to complete all checkpoints.")
                    end
                    break
                end
            end
        end
    end
end

-- Start the mission runner with debugging
debugMessage("Starting mission runner...")
debugMessage("Getting Current Missions...")
missionsLabel.Text = tostring(game.Players.LocalPlayer.leaderstats.Missions.Value)
runMissions()
