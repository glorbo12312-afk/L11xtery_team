local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("L11xteryTeamGui")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "L11xteryTeamGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 700, 0, 500)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.new(1, 1, 1)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "L11xteryTeam Gui F3X"
title.TextColor3 = Color3.fromRGB(255, 70, 70)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local function createButton(name, xOffset, yOffset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Position = UDim2.new(0, xOffset, 0, yOffset)
    btn.BackgroundColor3 = Color3.new(0, 0, 0)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.new(1, 1, 1)
    return btn
end

local btnR6 = createButton("r6", 10, 10)
local btnRe = createButton("re", 590, 10)
local btnDecal = createButton("decal", 10, 60)
local btnSkybox = createButton("skybox", 120, 60)
local btnDecal2 = createButton("decal 2", 230, 60)
local btnSkybox2 = createButton("skybox 2", 340, 60)
local btnTrippy = createButton("trippy skybox", 450, 60)
local btnDelete = createButton("delete skybox", 560, 60)
local btnFloatingPad = createButton("floating pad", 10, 110)
local btnDiscoMesh = createButton("disco mesh", 120, 110)
local btnHeadShake = createButton("head shake", 230, 110)
local btnUnanchor = createButton("unanchor", 340, 110)
local btnFace = createButton("face", 450, 110)
local btnBaseplate = createButton("Baseplate", 560, 110)
local btnRealm = createButton("realm", 10, 160)
local btnSpinMap = createButton("spin map", 120, 160)
local btnChickenArm = createButton("chicken arm", 230, 160)
local btnBtools = createButton("btools", 340, 160)
local btnRainRainbow = createButton("rain rainbow", 450, 160)
local btnQuestion = createButton("???", 560, 160)

local musicLabel = Instance.new("TextLabel")
musicLabel.Size = UDim2.new(0, 210, 0, 30)
musicLabel.Position = UDim2.new(0, 230, 0, 210)
musicLabel.BackgroundTransparency = 1
musicLabel.Text = "------music-----"
musicLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
musicLabel.TextScaled = true
musicLabel.Font = Enum.Font.SourceSansBold
musicLabel.Parent = frame

local btnTheme = createButton("theme", 10, 250)
local btnJumpstyle = createButton("jumpstyle", 120, 250)
local btnGooby = createButton("gooby", 230, 250)
local btnWtfGooby = createButton("wtf gooby", 340, 250)

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 200, 0, 200)
imageLabel.Position = UDim2.new(0.5, 0, 0, 300)
imageLabel.AnchorPoint = Vector2.new(0.5, 0)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://88437760194737"
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.Active = false
imageLabel.Parent = frame

btnR6.Parent = frame
btnRe.Parent = frame
btnDecal.Parent = frame
btnSkybox.Parent = frame
btnDecal2.Parent = frame
btnSkybox2.Parent = frame
btnTrippy.Parent = frame
btnDelete.Parent = frame
btnFloatingPad.Parent = frame
btnDiscoMesh.Parent = frame
btnHeadShake.Parent = frame
btnUnanchor.Parent = frame
btnFace.Parent = frame
btnBaseplate.Parent = frame
btnRealm.Parent = frame
btnSpinMap.Parent = frame
btnChickenArm.Parent = frame
btnBtools.Parent = frame
btnRainRainbow.Parent = frame
btnQuestion.Parent = frame
btnTheme.Parent = frame
btnJumpstyle.Parent = frame
btnGooby.Parent = frame
btnWtfGooby.Parent = frame

local function sendChatMessage(msg)
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local chatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local messageEvent = chatEvents:FindFirstChild("SayMessageRequest")
        if messageEvent and messageEvent:IsA("RemoteEvent") then
            messageEvent:FireServer(msg, "All")
        end
    else
        local textChatService = game:GetService("TextChatService")
        if textChatService and textChatService.ChatInputBarConfiguration.TargetTextChannel then
            textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
        else
            player:Chat(msg)
        end
    end
end

local function getF3X()
    local char = player.Character or player.CharacterAdded:Wait()
    local tool
    for i,v in player:GetDescendants() do
        if v.Name == "SyncAPI" then
            tool = v.Parent
        end
    end
    for i,v in game.ReplicatedStorage:GetDescendants() do
        if v.Name == "SyncAPI" then
            tool = v.Parent
        end
    end
    return tool
end

btnR6.MouseButton1Click:Connect(function()
    local args = { ";r6" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
end)

btnRe.MouseButton1Click:Connect(function()
    local args = { ";re" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
end)

btnDecal.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function SetLocked(part,boolean)
        local args = { [1] = "SetLocked", [2] = { [1] = part }, [3] = boolean }
        _(args)
    end
    local function SpawnDecal(part,side)
        local args = { [1] = "CreateTextures", [2] = { [1] = { ["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal" } } }
        _(args)
    end
    local function AddDecal(part,asset,side)
        local args = { [1] = "SyncTexture", [2] = { [1] = { ["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://".. asset } } }
        _(args)
    end

    local function spam(id)
        for i,v in game.workspace:GetDescendants() do
            if v:IsA("BasePart") then
                spawn(function()
                    SetLocked(v,false)
                    SpawnDecal(v,Enum.NormalId.Front)
                    AddDecal(v,id,Enum.NormalId.Front)
                    SpawnDecal(v,Enum.NormalId.Back)
                    AddDecal(v,id,Enum.NormalId.Back)
                    SpawnDecal(v,Enum.NormalId.Right)
                    AddDecal(v,id,Enum.NormalId.Right)
                    SpawnDecal(v,Enum.NormalId.Left)
                    AddDecal(v,id,Enum.NormalId.Left)
                    SpawnDecal(v,Enum.NormalId.Bottom)
                    AddDecal(v,id,Enum.NormalId.Bottom)
                    SpawnDecal(v,Enum.NormalId.Top)
                    AddDecal(v,id,Enum.NormalId.Top)
                end)
            end
        end 
    end
    spam("97268136195787")  
    print("[L11xteryTeam] Decal спам активирован!")
end)

btnSkybox.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function CreatePart(cf,parent)
        local args = { [1] = "CreatePart", [2] = "Normal", [3] = cf, [4] = parent }
        _(args)
    end
    local function SetName(part, stringg)
        local args = { [1] = "SetName", [2] = { [1] = part }, [3] = stringg }
        _(args)
    end
    local function AddMesh(part)
        local args = { [1] = "CreateMeshes", [2] = { [1] = { ["Part"] = part } } }
        _(args)
    end
    local function SetMesh(part,meshid)
        local args = { [1] = "SyncMesh", [2] = { [1] = { ["Part"] = part, ["MeshId"] = "rbxassetid://"..meshid } } }
        _(args)
    end
    local function SetTexture(part, texid)
        local args = { [1] = "SyncMesh", [2] = { [1] = { ["Part"] = part, ["TextureId"] = "rbxassetid://"..texid } } }
        _(args)
    end
    local function MeshResize(part,size)
        local args = { [1] = "SyncMesh", [2] = { [1] = { ["Part"] = part, ["Scale"] = size } } }
        _(args)
    end
    local function SetLocked(part,boolean)
        local args = { [1] = "SetLocked", [2] = { [1] = part }, [3] = boolean }
        _(args)
    end

    local function Sky(id)
        local e = char.HumanoidRootPart.CFrame.x
        local f = char.HumanoidRootPart.CFrame.y
        local g = char.HumanoidRootPart.CFrame.z
        CreatePart(CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),workspace)
        for i,v in game.Workspace:GetDescendants() do
            if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
                SetName(v,"L11xterySky")
                AddMesh(v)
                SetMesh(v,"111891702759441")
                SetTexture(v,id)
                MeshResize(v,Vector3.new(99999,99999,99999))
                SetLocked(v,true)
            end
        end
    end
    Sky("97268136195787")
    print("[L11xteryTeam] Skybox создан!")
end)

btnDecal2.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function SetLocked(part,boolean)
        local args = { [1] = "SetLocked", [2] = { [1] = part }, [3] = boolean }
        _(args)
    end
    local function SpawnDecal(part,side)
        local args = { [1] = "CreateTextures", [2] = { [1] = { ["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal" } } }
        _(args)
    end
    local function AddDecal(part,asset,side)
        local args = { [1] = "SyncTexture", [2] = { [1] = { ["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://".. asset } } }
        _(args)
    end

    local function spam(id)
        for i,v in game.workspace:GetDescendants() do
            if v:IsA("BasePart") then
                spawn(function()
                    SetLocked(v,false)
                    SpawnDecal(v,Enum.NormalId.Front)
                    AddDecal(v,id,Enum.NormalId.Front)
                    SpawnDecal(v,Enum.NormalId.Back)
                    AddDecal(v,id,Enum.NormalId.Back)
                    SpawnDecal(v,Enum.NormalId.Right)
                    AddDecal(v,id,Enum.NormalId.Right)
                    SpawnDecal(v,Enum.NormalId.Left)
                    AddDecal(v,id,Enum.NormalId.Left)
                    SpawnDecal(v,Enum.NormalId.Bottom)
                    AddDecal(v,id,Enum.NormalId.Bottom)
                    SpawnDecal(v,Enum.NormalId.Top)
                    AddDecal(v,id,Enum.NormalId.Top)
                end)
            end
        end 
    end
    spam("88437760194737")
    print("[L11xteryTeam] Decal 2 спам активирован!")
end)

btnSkybox2.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function CreatePart(cf,parent)
        local args = { [1] = "CreatePart", [2] = "Normal", [3] = cf, [4] = parent }
        _(args)
    end
    local function SetName(part, stringg)
        local args = { [1] = "SetName", [2] = { [1] = part }, [3] = stringg }
        _(args)
    end
    local function AddMesh(part)
        local args = { [1] = "CreateMeshes", [2] = { [1] = { ["Part"] = part } } }
        _(args)
    end
    local function SetMesh(part,meshid)
        local args = { [1] = "SyncMesh", [2] = { [1] = { ["Part"] = part, ["MeshId"] = "rbxassetid://"..meshid } } }
        _(args)
    end
    local function SetTexture(part, texid)
        local args = { [1] = "SyncMesh", [2] = { [1] = { ["Part"] = part, ["TextureId"] = "rbxassetid://"..texid } } }
        _(args)
    end
    local function MeshResize(part,size)
        local args = { [1] = "SyncMesh", [2] = { [1] = { ["Part"] = part, ["Scale"] = size } } }
        _(args)
    end
    local function SetLocked(part,boolean)
        local args = { [1] = "SetLocked", [2] = { [1] = part }, [3] = boolean }
        _(args)
    end

    local function Sky(id)
        local e = char.HumanoidRootPart.CFrame.x
        local f = char.HumanoidRootPart.CFrame.y
        local g = char.HumanoidRootPart.CFrame.z
        CreatePart(CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),workspace)
        for i,v in game.Workspace:GetDescendants() do
            if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
                SetName(v,"L11xterySky2")
                AddMesh(v)
                SetMesh(v,"111891702759441")
                SetTexture(v,id)
                MeshResize(v,Vector3.new(99999,99999,99999))
                SetLocked(v,true)
            end
        end
    end
    Sky("88437760194737")
    print("[L11xteryTeam] Skybox 2 создан!")
end)

btnTrippy.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function MovePart(part, cf)
        local args = { [1] = "SyncMove", [2] = { [1] = { ["Part"] = part, ["CFrame"] = cf } } }
        _(args)
    end
    
    local targetMeshId = "rbxassetid://111891702759441"
    local function FindTargetPart()
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                local mesh = part:FindFirstChildWhichIsA("SpecialMesh")
                if mesh and mesh.MeshId == targetMeshId then
                    return part
                end
                if part:IsA("MeshPart") and part.MeshId == targetMeshId then
                    return part
                end
            end
        end
        return nil
    end
    
    local skyPart = FindTargetPart()
    if not skyPart then
        repeat
            task.wait(1)
            skyPart = FindTargetPart()
        until skyPart
    end
    
    local baseCFrame = skyPart.CFrame
    local accumulatedYaw = 0
    local t = 0
    local runService = game:GetService("RunService")
    runService.Heartbeat:Connect(function(dt)
        if not skyPart or not skyPart.Parent then
            skyPart = FindTargetPart()
            if not skyPart then return end
            baseCFrame = skyPart.CFrame
            accumulatedYaw = 0
            t = 0
        end
        t = t + dt
        local yawSpeed = 30 + 15 * math.sin(t * 0.7)
        accumulatedYaw = accumulatedYaw + yawSpeed * dt
        local pitchAngle = 60 * math.sin(t * 2.5)
        local rollAngle = 15 * math.cos(t * 1.8)
        local newCF = baseCFrame * CFrame.Angles(0, math.rad(accumulatedYaw), 0)
        newCF = newCF * CFrame.Angles(math.rad(pitchAngle), 0, math.rad(rollAngle))
        MovePart(skyPart, newCF)
    end)
    print("[L11xteryTeam] Trippy skybox активирован!")
end)

btnDelete.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function DestroyPart(part)
        local args = { [1] = "Remove", [2] = { [1] = part } }
        _(args)
    end
    
    local targetMeshId = "rbxassetid://111891702759441"
    local destroyed = 0
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local mesh = part:FindFirstChildWhichIsA("SpecialMesh")
            if mesh and mesh.MeshId == targetMeshId then
                DestroyPart(part)
                destroyed = destroyed + 1
            elseif part:IsA("MeshPart") and part.MeshId == targetMeshId then
                DestroyPart(part)
                destroyed = destroyed + 1
            end
        end
    end
    print("[L11xteryTeam] Удалено skybox'ов: " .. destroyed)
end)

btnFloatingPad.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then 
        warn("[L11xteryTeam] Ошибка: нужно держать F3X в руках!")
        return 
    end
    local char = player.Character or player.CharacterAdded:Wait()
    local rootPart = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")
    local sync = tool.SyncAPI.ServerEndpoint
    
    local part = sync:InvokeServer("CreatePart", "Normal", rootPart.CFrame, game.Workspace)
    sync:InvokeServer("SyncResize", { {Part = part, CFrame = rootPart.CFrame, Size = Vector3.new(10, 1, 10)} })
    sync:InvokeServer("SyncColor", { {Part = part, Color = Color3.new(0, 0, 0)} })
    sync:InvokeServer("SyncMaterial", { {Part = part, Material = Enum.Material.SmoothPlastic} })
    
    local currentYOffset = -3.1
    local targetYOffset = -3.1
    task.spawn(function()
        while task.wait(0.03) do 
            if not part or not part.Parent then break end
            if humanoid.FloorMaterial == Enum.Material.Air then
                targetYOffset = -3.1
            else
                targetYOffset = -25
            end
            if currentYOffset > targetYOffset then
                currentYOffset = currentYOffset - 0.5 
            elseif currentYOffset < targetYOffset then
                currentYOffset = -3.1
            end
            sync:InvokeServer("SyncMove", { {Part = part, CFrame = rootPart.CFrame * CFrame.new(0, currentYOffset, 0)} })
        end
    end)
    print("[L11xteryTeam] Floating pad активирован!")
end)

btnDiscoMesh.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then 
        warn("[L11xteryTeam] Ошибка: нужно держать F3X в руках!")
        return 
    end
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local sync = tool.SyncAPI.ServerEndpoint
    local runService = game:GetService("RunService")
    
    local shapes = {
        Enum.MeshType.Sphere,
        Enum.MeshType.Cylinder,
        Enum.MeshType.Wedge,
        Enum.MeshType.Head,
        Enum.MeshType.Brick
    }
    
    local bodyParts = {}
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(bodyParts, v)
        end
    end
    
    local lastUpdate = 0
    local updateSpeed = 0.2
    local connection
    connection = runService.RenderStepped:Connect(function()
        if not char.Parent or not tool.Parent or humanoid.Health <= 0 then 
            connection:Disconnect()
            return 
        end
        local now = tick()
        if now - lastUpdate >= updateSpeed then
            lastUpdate = now
            local meshData = {}
            local colorData = {}
            for _, part in pairs(bodyParts) do
                local randomShape = shapes[math.random(1, #shapes)]
                table.insert(meshData, {Part = part, MeshType = randomShape})
                table.insert(colorData, {Part = part, Color = Color3.fromHSV(math.random(), 1, 1)})
            end
            sync:InvokeServer("CreateMeshes", meshData)
            sync:InvokeServer("SyncColor", colorData)
        end
    end)
    print("[L11xteryTeam] Disco mesh активирован!")
end)

btnHeadShake.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then 
        warn("[L11xteryTeam] Ошибка: нужно держать F3X в руках!")
        return 
    end
    local char = player.Character or player.CharacterAdded:Wait()
    local torso = char:WaitForChild("Torso")
    local head = char:WaitForChild("Head")
    local humanoid = char:WaitForChild("Humanoid")
    local sync = tool.SyncAPI.ServerEndpoint
    local runService = game:GetService("RunService")
    local ID_HINH = "98734867422780"
    
    head.Transparency = 1
    if head:FindFirstChildOfClass("Decal") then head:FindFirstChildOfClass("Decal").Transparency = 1 end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Accessory") then v:Destroy() end
    end
    
    local fakeHead = sync:InvokeServer("CreatePart", "Normal", torso.CFrame, game.Workspace)
    task.wait(0.1)
    if fakeHead then
        sync:InvokeServer("SyncResize", {{Part = fakeHead, Size = Vector3.new(1.2, 1.2, 1.2), CFrame = torso.CFrame}})
        sync:InvokeServer("SyncColor", {{Part = fakeHead, Color = head.Color}})
        sync:InvokeServer("SyncCollision", {{Part = fakeHead, CanCollide = false}})
        sync:InvokeServer("SyncAnchor", {{Part = fakeHead, Anchored = true}})
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.Head
        mesh.Scale = Vector3.new(1.2, 1.2, 1.2)
        mesh.Parent = fakeHead
        local decal = Instance.new("Decal")
        decal.Texture = "rbxassetid://" .. ID_HINH
        decal.Face = Enum.NormalId.Front
        decal.Parent = fakeHead
        
        local counter = 0
        local connection
        connection = runService.RenderStepped:Connect(function(deltaTime)
            if not char.Parent or not tool.Parent or humanoid.Health <= 0 then 
                sync:InvokeServer("RemoveParts", {fakeHead})
                connection:Disconnect()
                return 
            end
            counter = counter + (deltaTime * 1.5) 
            local slideOffset = math.sin(counter) * 1.8
            local tiltAngle = math.cos(counter) * math.rad(20)
            local finalCF = torso.CFrame * CFrame.new(slideOffset, 1.5, 0) * CFrame.Angles(0, 0, tiltAngle)
            sync:InvokeServer("SyncMove", {{Part = fakeHead, CFrame = finalCF}})
        end)
        print("[L11xteryTeam] Head shake активирован!")
    end
end)

btnUnanchor.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local sync = tool.SyncAPI.ServerEndpoint
    
    local function setanchor(part, state)
        sync:InvokeServer("SyncAnchor", { { Part = part, Anchored = state } })
    end
    
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("UnionOperation") then
            task.spawn(function()
                setanchor(v, false)
            end)
        end
    end
    print("[L11xteryTeam] Unanchor выполнен!")
end)

btnFace.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local sync = tool.SyncAPI.ServerEndpoint
    local IMAGE_ID = "88437760194737"
    local OFFSET_Y = 0.6
    local PLATE_SIZE = Vector3.new(3, 3, 0.2)
    
    local function CreatePart(cf, parent)
        sync:InvokeServer("CreatePart", "Normal", cf, parent)
    end
    local function Resize(part, size, cf)
        sync:InvokeServer("SyncResize", { { ["Part"] = part, ["CFrame"] = cf, ["Size"] = size } })
    end
    local function SetTrans(part, int)
        sync:InvokeServer("SyncMaterial", { { ["Part"] = part, ["Transparency"] = int } })
    end
    local function SetAnchor(boolean, part)
        sync:InvokeServer("SyncAnchor", { { ["Part"] = part, ["Anchored"] = boolean } })
    end
    local function SetCollision(part, boolean)
        sync:InvokeServer("SyncCollision", { { ["Part"] = part, ["CanCollide"] = boolean } })
    end
    local function Weld(part1, part2, lead)
        sync:InvokeServer("CreateWelds", { part1, part2 }, lead)
    end
    local function SpawnDecal(part, side)
        sync:InvokeServer("CreateTextures", { { ["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal" } })
    end
    local function AddDecal(part, asset, side)
        sync:InvokeServer("SyncTexture", { { ["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://"..asset } })
    end
    
    local function getNewPart(oldParts)
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not table.find(oldParts, v) then
                return v
            end
        end
        return nil
    end
    
    for _, targetPlayer in ipairs(game.Players:GetPlayers()) do
        local char = targetPlayer.Character
        if char and char:FindFirstChild("Head") then
            local head = char.Head
            SetTrans(head, 1)
            local pos = head.CFrame * CFrame.new(0, OFFSET_Y, 0)
            local beforeParts = {}
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    table.insert(beforeParts, v)
                end
            end
            CreatePart(pos, workspace)
            local squarePart = getNewPart(beforeParts)
            if squarePart then
                SetAnchor(true, squarePart)
                Resize(squarePart, PLATE_SIZE, squarePart.CFrame)
                task.spawn(function()
                    SpawnDecal(squarePart, Enum.NormalId.Front)
                    task.wait(0.1)
                    AddDecal(squarePart, IMAGE_ID, Enum.NormalId.Front)
                end)
                Weld(squarePart, head, head)
                SetAnchor(false, squarePart)
                SetCollision(squarePart, false)
            end
        end
    end
    print("[L11xteryTeam] Face добавлена всем игрокам!")
end)

btnBaseplate.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local remote = tool.SyncAPI.ServerEndpoint
    local function _(args) remote:InvokeServer(unpack(args)) end
    
    local function CreatePart(cf, parent, types)
        local args = { [1] = "CreatePart", [2] = types, [3] = cf, [4] = parent }
        _(args)
    end
    local function Resize(part, size, cf)
        local args = { [1] = "SyncResize", [2] = { [1] = { ["Part"] = part, ["CFrame"] = cf, ["Size"] = size } } }
        _(args)
    end
    local function SetLocked(part, boolean)
        local args = { [1] = "SetLocked", [2] = { [1] = part }, [3] = boolean }
        _(args)
    end
    local function Color(part, color)
        local args = { [1] = "SyncColor", [2] = { [1] = { ["Part"] = part, ["Color"] = color, ["UnionColoring"] = false } } }
        _(args)
    end
    local function toptexturecreate(part)
        local args = { [1] = "CreateTextures", [2] = { [1] = { ["Part"] = part, ["Face"] = Enum.NormalId.Top, ["TextureType"] = "Texture" } } }
        _(args)
    end
    local function toptextureadd(part)
        local args = { [1] = "SyncTexture", [2] = { [1] = { ["Part"] = part, ["Face"] = Enum.NormalId.Top, ["TextureType"] = "Texture", ["Texture"] = "rbxassetid://97268136195787", ["StudsPerTileV"] = 10, ["StudsPerTileU"] = 10 } } }
        _(args)
    end
    
    local hrpx = math.floor(char.HumanoidRootPart.CFrame.x)
    local hrpz = math.floor(char.HumanoidRootPart.CFrame.z)
    local hrpy = math.floor(char.HumanoidRootPart.CFrame.y)
    
    CreatePart(CFrame.new(hrpx, hrpy - 20, hrpz), workspace, "Spawn")
    for i, v in game.Workspace:GetChildren() do
        if v:IsA("BasePart") and v.CFrame.Y == hrpy - 20 and v.CFrame.X == hrpx then
            spawn(function()
                Resize(v, Vector3.new(1000, 2, 1000), CFrame.new(hrpx, hrpy - 20, hrpz))
                Color(v, Color3.fromRGB(0, 0, 0))
                toptexturecreate(v)
                toptextureadd(v)
                while wait(1) do
                    pcall(function()
                        SetLocked(v, true)
                    end)
                end
            end)
        end
    end
    print("[L11xteryTeam] Baseplate создан!")
end)

btnRealm.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hoquocluc9182-del/realm/refs/heads/main/realm.txt"))()
    print("[L11xteryTeam] Realm загружен!")
end)

btnSpinMap.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local sync = tool.SyncAPI.ServerEndpoint
    local runService = game:GetService("RunService")
    
    local mapParts = {}
    local function isPlayerPart(part)
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and part:IsDescendantOf(p.Character) then
                return true
            end
        end
        return false
    end
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not isPlayerPart(v) then
            table.insert(mapParts, v)
        end
    end
    
    task.spawn(function()
        local anchorData = {}
        for i, v in pairs(mapParts) do
            table.insert(anchorData, {Part = v, Anchored = true})
            if i % 100 == 0 then
                sync:InvokeServer("SyncAnchor", anchorData)
                anchorData = {}
                task.wait()
            end
        end
    end)
    
    local connection
    connection = runService.Heartbeat:Connect(function()
        if not tool.Parent then 
            connection:Disconnect()
            return 
        end
        local moveData = {}
        for i = 1, 40 do 
            local randomPart = mapParts[math.random(1, #mapParts)]
            if randomPart and randomPart.Parent then
                local newCF = randomPart.CFrame * CFrame.Angles(0, math.rad(45), 0)
                table.insert(moveData, {Part = randomPart, CFrame = newCF})
            end
        end
        if #moveData > 0 then
            pcall(function()
                sync:InvokeServer("SyncMove", moveData)
            end)
        end
    end)
    print("[L11xteryTeam] Spin map активирован!")
end)

btnChickenArm.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local sync = tool.SyncAPI.ServerEndpoint
    local runService = game:GetService("RunService")
    
    local leftArm = char:FindFirstChild("Left Arm")
    local rightArm = char:FindFirstChild("Right Arm")
    local torso = char:FindFirstChild("Torso")
    if leftArm and rightArm and torso then
        local animateScript = char:FindFirstChild("Animate")
        if animateScript then animateScript.Disabled = true end
        for _, v in pairs(humanoid:GetPlayingAnimationTracks()) do v:Stop() end
        
        local connection
        connection = runService.RenderStepped:Connect(function()
            if not char.Parent or not tool.Parent or humanoid.Health <= 0 then 
                connection:Disconnect()
                return 
            end
            local leftCF = torso.CFrame * CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(0, math.rad(180), math.rad(-90))
            local rightCF = torso.CFrame * CFrame.new(1.5, 0.5, 0) * CFrame.Angles(0, math.rad(180), math.rad(90))
            sync:InvokeServer("SyncMove", {
                {Part = leftArm, CFrame = leftCF},
                {Part = rightArm, CFrame = rightCF}
            })
        end)
        print("[L11xteryTeam] Chicken arm активирован!")
    end
end)

btnBtools.MouseButton1Click:Connect(function()
    local args = { ";buildingTools" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    print("[L11xteryTeam] Btools получены!")
end)

btnRainRainbow.MouseButton1Click:Connect(function()
    local tool = getF3X()
    if not tool then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local torso = char:WaitForChild("Torso")
    local sync = tool.SyncAPI.ServerEndpoint
    local runService = game:GetService("RunService")
    
    local connection
    local counter = 0
    connection = runService.Heartbeat:Connect(function()
        if not tool.Parent or not char.Parent then 
            connection:Disconnect()
            return 
        end
        counter = counter + 1
        if counter % 3 == 0 then
            local randomX = math.random(-60, 60)
            local randomZ = math.random(-60, 60)
            local spawnPos = torso.CFrame * CFrame.new(randomX, 120, randomZ)
            local part = sync:InvokeServer("CreatePart", "Normal", spawnPos, game.Workspace)
            if part then
                local randomColor = Color3.fromHSV(math.random(), 1, 1)
                local s = math.random(2, 5)
                local size = Vector3.new(s, s, s)
                sync:InvokeServer("SyncResize", {{Part = part, Size = size, CFrame = spawnPos}})
                sync:InvokeServer("SyncColor", {{Part = part, Color = randomColor}})
                sync:InvokeServer("SyncMaterial", {{Part = part, Material = Enum.Material.Neon}})
                sync:InvokeServer("SyncCollision", {{Part = part, CanCollide = false}})
                sync:InvokeServer("SyncAnchor", {{Part = part, Anchored = false}})
                task.delay(10, function()
                    pcall(function()
                        sync:InvokeServer("RemoveParts", {part})
                    end)
                end)
            end
        end
    end)
    print("[L11xteryTeam] Rain rainbow активирован!")
end)

btnQuestion.MouseButton1Click:Connect(function()
    sendChatMessage("هاهاها، سأذهب معكم جميعاً للقاء الله.")
    task.wait(2)
    sendChatMessage(";explode all")
    sendChatMessage(";music 247893371")
    sendChatMessage(";volume inf")
    task.wait(6)
    sendChatMessage(";unmusic")
    print("[L11xteryTeam] Взрыв активирован!")
end)

btnTheme.MouseButton1Click:Connect(function()
    local args = { ";music 1839270925 ;volume inf" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    print("[L11xteryTeam] Theme music включена!")
end)

btnJumpstyle.MouseButton1Click:Connect(function()
    local args = { ";music 1839246711 ;volume inf" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    print("[L11xteryTeam] Jumpstyle music включена!")
end)

btnGooby.MouseButton1Click:Connect(function()
    local args = { ";music 1847661821 ;volume inf" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    print("[L11xteryTeam] Gooby music включена!")
end)

btnWtfGooby.MouseButton1Click:Connect(function()
    local args = { ";music 113548699544058 ;volume inf" }
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(unpack(args))
    print("[L11xteryTeam] WTF Gooby music включена!")
end)

local dragging = false
local startPos = nil
local startGuiPos = nil

frame.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = input.Position
        startGuiPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - startPos
        frame.Position = UDim2.new(
            startGuiPos.X.Scale, startGuiPos.X.Offset + delta.X,
            startGuiPos.Y.Scale, startGuiPos.Y.Offset + delta.Y
        )
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

frame.Parent = screenGui
screenGui.Parent = playerGui

print("L11xteryTeam Gui F3X загружен!")
