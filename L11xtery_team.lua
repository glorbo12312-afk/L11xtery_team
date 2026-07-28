-- ServerScript в ServerScriptService
-- Разработано L11xery Team | Новогодняя версия 2026 🎄
-- Ключевая система: L11xtery001
-- С GUI-интерфейсом на экране игрока

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- ========================================================
-- ═══════════════════════════════════════════════════════════
--  🔑 КЛЮЧЕВАЯ СИСТЕМА 🔑
-- ═══════════════════════════════════════════════════════════
-- ========================================================

local KeySystem = {
    MasterKey = "L11xtery001",
    AdditionalKeys = {},
    TemporaryKeys = {},
    ActivatedKeys = {},
    BannedUntil = {},
    Attempts = {},
    MaxAttempts = 3,
    BanTime = 60
}

function KeySystem:CheckKey(player, inputKey)
    if not inputKey or inputKey == "" then
        return false, "❄️ Введите ключ доступа!"
    end
    
    if self.BannedUntil[player.UserId] then
        if os.time() < self.BannedUntil[player.UserId] then
            local remaining = math.ceil(self.BannedUntil[player.UserId] - os.time())
            return false, "❄️ Вы заблокированы на " .. remaining .. " сек!"
        else
            self.BannedUntil[player.UserId] = nil
            self.Attempts[player.UserId] = 0
        end
    end
    
    if inputKey == self.MasterKey then
        self.ActivatedKeys[player.UserId] = true
        self.Attempts[player.UserId] = 0
        return true, "✅ Ключ принят! Добро пожаловать!"
    end
    
    for _, key in ipairs(self.AdditionalKeys) do
        if inputKey == key then
            self.ActivatedKeys[player.UserId] = true
            self.Attempts[player.UserId] = 0
            return true, "✅ Ключ принят! Добро пожаловать!"
        end
    end
    
    for key, expiry in pairs(self.TemporaryKeys) do
        if inputKey == key then
            if os.time() < expiry then
                self.ActivatedKeys[player.UserId] = true
                self.Attempts[player.UserId] = 0
                return true, "✅ Временный ключ принят!"
            else
                self.TemporaryKeys[key] = nil
                return false, "❄️ Ключ истёк!"
            end
        end
    end
    
    self.Attempts[player.UserId] = (self.Attempts[player.UserId] or 0) + 1
    
    if self.Attempts[player.UserId] >= self.MaxAttempts then
        self.BannedUntil[player.UserId] = os.time() + self.BanTime
        return false, "❄️ Блокировка на " .. self.BanTime .. " сек!"
    end
    
    local remaining = self.MaxAttempts - self.Attempts[player.UserId]
    return false, "❄️ Неверный ключ! Осталось: " .. remaining
end

function KeySystem:IsActivated(player)
    return self.ActivatedKeys[player.UserId] == true
end

-- ========================================================
-- ═══════════════════════════════════════════════════════════
--  🎄 ГЕНЕРАТОР GUI ДЛЯ ИГРОКА 🎄
-- ═══════════════════════════════════════════════════════════
-- ========================================================

local function CreatePlayerGUI(player)
    -- Создаём ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "L11xeryGUI"
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    
    -- ОСНОВНАЯ ТАБЛИЦА
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(0.5, -200, 0.5, -250)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(0, 200, 255)
    frame.ClipsDescendants = false
    frame.Parent = gui
    
    -- АНИМАЦИЯ ПОЯВЛЕНИЯ
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0.5, -200, 0.5, -350)
    
    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    local tween1 = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5, -200, 0.5, -250)})
    local tween2 = TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 0.1})
    tween1:Play()
    tween2:Play()
    
    -- ЗАГОЛОВОК
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    title.BackgroundTransparency = 0.3
    title.Text = "🎄 L11xery Team 🎄"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    -- ПОДЗАГОЛОВОК
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "🔑 Введите ключ для активации"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = frame
    
    -- ПОЛЕ ВВОДА КЛЮЧА
    local inputBox = Instance.new("TextBox")
    inputBox.Name = "KeyInput"
    inputBox.Size = UDim2.new(0.8, 0, 0, 40)
    inputBox.Position = UDim2.new(0.1, 0, 0, 90)
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Text = "L11xtery001"
    inputBox.TextScaled = true
    inputBox.Font = Enum.Font.Gotham
    inputBox.PlaceholderText = "Введите ключ..."
    inputBox.Parent = frame
    
    -- КНОПКА АКТИВАЦИИ
    local activateBtn = Instance.new("TextButton")
    activateBtn.Name = "ActivateBtn"
    activateBtn.Size = UDim2.new(0.8, 0, 0, 40)
    activateBtn.Position = UDim2.new(0.1, 0, 0, 140)
    activateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    activateBtn.Text = "🔑 АКТИВИРОВАТЬ"
    activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activateBtn.TextScaled = true
    activateBtn.Font = Enum.Font.GothamBold
    activateBtn.Parent = frame
    
    -- КНОПКА ВЫПОЛНИТЬ КОД
    local execBtn = Instance.new("TextButton")
    execBtn.Name = "ExecBtn"
    execBtn.Size = UDim2.new(0.38, 0, 0, 40)
    execBtn.Position = UDim2.new(0.05, 0, 0, 190)
    execBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    execBtn.Text = "▶ ВЫПОЛНИТЬ"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.TextScaled = true
    execBtn.Font = Enum.Font.GothamBold
    execBtn.Parent = frame
    execBtn.Visible = false
    
    -- ПОЛЕ ВВОДА КОДА
    local codeInput = Instance.new("TextBox")
    codeInput.Name = "CodeInput"
    codeInput.Size = UDim2.new(0.5, 0, 0, 40)
    codeInput.Position = UDim2.new(0.45, 0, 0, 190)
    codeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    codeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    codeInput.Text = "print('Hello World!')"
    codeInput.TextScaled = true
    codeInput.Font = Enum.Font.Gotham
    codeInput.PlaceholderText = "Введите код..."
    codeInput.Parent = frame
    codeInput.Visible = false
    
    -- КНОПКА ТЕЛЕПОРТ
    local tpBtn = Instance.new("TextButton")
    tpBtn.Name = "TPBtn"
    tpBtn.Size = UDim2.new(0.38, 0, 0, 40)
    tpBtn.Position = UDim2.new(0.05, 0, 0, 240)
    tpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    tpBtn.Text = "🌀 ТЕЛЕПОРТ"
    tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpBtn.TextScaled = true
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.Parent = frame
    tpBtn.Visible = false
    
    -- ПОЛЕ ВВОДА НИКА
    local nickInput = Instance.new("TextBox")
    nickInput.Name = "NickInput"
    nickInput.Size = UDim2.new(0.5, 0, 0, 40)
    nickInput.Position = UDim2.new(0.45, 0, 0, 240)
    nickInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    nickInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    nickInput.Text = "PlayerName"
    nickInput.TextScaled = true
    nickInput.Font = Enum.Font.Gotham
    nickInput.PlaceholderText = "Введите ник..."
    nickInput.Parent = frame
    nickInput.Visible = false
    
    -- КНОПКА КИКНУТЬ
    local kickBtn = Instance.new("TextButton")
    kickBtn.Name = "KickBtn"
    kickBtn.Size = UDim2.new(0.38, 0, 0, 40)
    kickBtn.Position = UDim2.new(0.05, 0, 0, 290)
    kickBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    kickBtn.Text = "👢 КИКНУТЬ"
    kickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickBtn.TextScaled = true
    kickBtn.Font = Enum.Font.GothamBold
    kickBtn.Parent = frame
    kickBtn.Visible = false
    
    -- ПОЛЕ ВВОДА НИКА ДЛЯ КИКА
    local kickNickInput = Instance.new("TextBox")
    kickNickInput.Name = "KickNickInput"
    kickNickInput.Size = UDim2.new(0.5, 0, 0, 40)
    kickNickInput.Position = UDim2.new(0.45, 0, 0, 290)
    kickNickInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    kickNickInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickNickInput.Text = "PlayerName"
    kickNickInput.TextScaled = true
    kickNickInput.Font = Enum.Font.Gotham
    kickNickInput.PlaceholderText = "Введите ник..."
    kickNickInput.Parent = frame
    kickNickInput.Visible = false
    
    -- ЛОГ СООБЩЕНИЙ
    local logFrame = Instance.new("Frame")
    logFrame.Name = "LogFrame"
    logFrame.Size = UDim2.new(0.9, 0, 0, 120)
    logFrame.Position = UDim2.new(0.05, 0, 0, 340)
    logFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    logFrame.BackgroundTransparency = 0.5
    logFrame.BorderSizePixel = 1
    logFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
    logFrame.Parent = frame
    
    local logText = Instance.new("TextLabel")
    logText.Name = "LogText"
    logText.Size = UDim2.new(1, -10, 1, -10)
    logText.Position = UDim2.new(0, 5, 0, 5)
    logText.BackgroundTransparency = 1
    logText.Text = "🎄 Добро пожаловать в L11xery Team!\n🔑 Введите ключ: L11xtery001"
    logText.TextColor3 = Color3.fromRGB(0, 255, 200)
    logText.TextScaled = false
    logText.TextSize = 14
    logText.Font = Enum.Font.Gotham
    logText.TextWrapped = true
    logText.TextXAlignment = Enum.TextXAlignment.Left
    logText.Parent = logFrame
    
    -- КНОПКА ЗАКРЫТИЯ
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    
    -- ПЕРЕМЕННЫЕ СОСТОЯНИЯ
    local isActivated = false
    local logQueue = {}
    
    -- ФУНКЦИЯ ДЛЯ ОБНОВЛЕНИЯ ЛОГА
    local function UpdateLog(message)
        table.insert(logQueue, message)
        if #logQueue > 10 then
            table.remove(logQueue, 1)
        end
        logText.Text = table.concat(logQueue, "\n")
    end
    
    -- ФУНКЦИЯ ДЛЯ ПОКАЗА/СКРЫТИЯ КНОПОК
    local function ShowAdminButtons(show)
        execBtn.Visible = show
        codeInput.Visible = show
        tpBtn.Visible = show
        nickInput.Visible = show
        kickBtn.Visible = show
        kickNickInput.Visible = show
        
        if show then
            subtitle.Text = "✅ Админ-панель активна!"
            subtitle.TextColor3 = Color3.fromRGB(0, 255, 100)
            activateBtn.Text = "✅ АКТИВИРОВАНО"
            activateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            UpdateLog("✅ Ключ активирован! Добро пожаловать!")
        end
    end
    
    -- ОБРАБОТЧИК КНОПКИ АКТИВАЦИИ
    activateBtn.MouseButton1Click:Connect(function()
        local key = inputBox.Text
        local success, message = KeySystem:CheckKey(player, key)
        
        if success then
            isActivated = true
            ShowAdminButtons(true)
            UpdateLog("✅ " .. message)
            
            -- Уведомление всем в чате
            for _, plr in pairs(Players:GetPlayers()) do
                plr:Chat("[L11xery]: Игрок " .. player.Name .. " активировал админ-панель!")
            end
        else
            UpdateLog("❌ " .. message)
            activateBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            task.wait(0.5)
            activateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end
    end)
    
    -- ОБРАБОТЧИК КНОПКИ ВЫПОЛНИТЬ КОД
    execBtn.MouseButton1Click:Connect(function()
        if not isActivated then return end
        local code = codeInput.Text
        if code and code ~= "" then
            local fn, err = loadstring(code)
            if fn then
                local success, result = pcall(fn)
                if success then
                    UpdateLog("✅ Код выполнен: " .. tostring(result))
                else
                    UpdateLog("❌ Ошибка: " .. tostring(result))
                end
            else
                UpdateLog("❌ Ошибка компиляции: " .. tostring(err))
            end
        end
    end)
    
    -- ОБРАБОТЧИК КНОПКИ ТЕЛЕПОРТ
    tpBtn.MouseButton1Click:Connect(function()
        if not isActivated then return end
        local targetName = nickInput.Text
        local target = Players:FindFirstChild(targetName)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                UpdateLog("🌀 Телепортирован к: " .. targetName)
            else
                UpdateLog("❌ У вас нет персонажа!")
            end
        else
            UpdateLog("❌ Игрок не найден: " .. targetName)
        end
    end)
    
    -- ОБРАБОТЧИК КНОПКИ КИКНУТЬ
    kickBtn.MouseButton1Click:Connect(function()
        if not isActivated then return end
        local targetName = kickNickInput.Text
        local target = Players:FindFirstChild(targetName)
        if target then
            target:Kick("🎄 Кикнут L11xery Team 🎄")
            UpdateLog("👢 Кикнут: " .. targetName)
        else
            UpdateLog("❌ Игрок не найден: " .. targetName)
        end
    end)
    
    -- ОБРАБОТЧИК КНОПКИ ЗАКРЫТИЯ
    closeBtn.MouseButton1Click:Connect(function()
        local tweenClose = TweenService:Create(frame, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -200, 0.5, -350),
            BackgroundTransparency = 1
        })
        tweenClose:Play()
        tweenClose.Completed:Connect(function()
            gui:Destroy()
        end)
    end)
    
    -- ПЕРЕТАСКИВАНИЕ ОКНА
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    title.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- ПЕРВОНАЧАЛЬНЫЙ ЛОГ
    UpdateLog("🎄 Добро пожаловать в L11xery Team!")
    UpdateLog("🔑 Введите ключ: L11xtery001")
    
    return gui
end

-- ========================================================
-- ═══════════════════════════════════════════════════════════
--  🎄 НОВОГОДНЯЯ ЁЛКА И ГИРЛЯНДА 🎄
-- ========================================================

local function CreateDecorations()
    print("🎄 Создание новогодних украшений...")
    
    -- ГИРЛЯНДА
    local colors = {
        Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0),
        Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(128, 0, 255), Color3.fromRGB(255, 0, 255)
    }
    
    for i = 1, 20 do
        local part = Instance.new("Part")
        part.Name = "Garland_" .. i
        part.Size = Vector3.new(0.5, 0.5, 0.5)
        part.Shape = Enum.PartType.Ball
        part.Material = Enum.Material.Neon
        part.Anchored = true
        part.CanCollide = false
        part.BrickColor = BrickColor.new(Color3.fromRGB(255, 255, 255))
        part.Parent = workspace
        
        local angle = (i / 20) * math.pi
        part.Position = Vector3.new(
            math.cos(angle) * 15,
            20 + math.sin(angle) * 3,
            math.sin(angle) * 5
        )
        
        local light = Instance.new("PointLight")
        light.Range = 10
        light.Brightness = 2
        light.Color = colors[(i % #colors) + 1]
        light.Parent = part
        
        -- Анимация
        task.spawn(function()
            local colorIdx = i % #colors + 1
            while true do
                colorIdx = colorIdx % #colors + 1
                light.Color = colors[colorIdx]
                light.Brightness = 1 + math.random() * 2
                task.wait(0.3 + math.random() * 0.2)
            end
        end)
    end
    
    -- ЁЛКА
    local treeColors = {
        Color3.fromRGB(0, 100, 0), Color3.fromRGB(0, 150, 0),
        Color3.fromRGB(0, 200, 0), Color3.fromRGB(34, 139, 34)
    }
    
    -- Ствол
    local trunk = Instance.new("Part")
    trunk.Name = "TreeTrunk"
    trunk.Size = Vector3.new(1, 3, 1)
    trunk.Position = Vector3.new(0, 1.5, 0)
    trunk.BrickColor = BrickColor.new("Brown")
    trunk.Material = Enum.Material.Wood
    trunk.Anchored = true
    trunk.CanCollide = false
    trunk.Parent = workspace
    
    -- Ярусы
    local layers = {
        {radius = 6, yOffset = 3},
        {radius = 5, yOffset = 5},
        {radius = 4, yOffset = 7},
        {radius = 3, yOffset = 8.5},
        {radius = 2, yOffset = 10},
        {radius = 1, yOffset = 11}
    }
    
    for _, layer in ipairs(layers) do
        for angle = 0, 360, 15 do
            local rad = math.rad(angle)
            local branch = Instance.new("Part")
            branch.Name = "Branch_" .. layer.yOffset .. "_" .. angle
            branch.Size = Vector3.new(0.3, 0.3, 0.3)
            branch.Position = Vector3.new(
                math.cos(rad) * layer.radius,
                layer.yOffset,
                math.sin(rad) * layer.radius
            )
            branch.BrickColor = BrickColor.new(treeColors[(layer.yOffset % #treeColors) + 1])
            branch.Material = Enum.Material.Glass
            branch.Anchored = true
            branch.CanCollide = false
            branch.Parent = workspace
            
            local glow = Instance.new("PointLight")
            glow.Range = 3
            glow.Brightness = 0.5
            glow.Color = Color3.fromRGB(0, 255, 0)
            glow.Parent = branch
        end
    end
    
    -- Звезда
    local star = Instance.new("Part")
    star.Name = "TreeStar"
    star.Size = Vector3.new(1.5, 1.5, 1.5)
    star.Shape = Enum.PartType.Ball
    star.Position = Vector3.new(0, 12.5, 0)
    star.BrickColor = BrickColor.new("Gold")
    star.Material = Enum.Material.Neon
    star.Anchored = true
    star.CanCollide = false
    star.Parent = workspace
    
    local starLight = Instance.new("PointLight")
    starLight.Range = 15
    starLight.Brightness = 3
    starLight.Color = Color3.fromRGB(255, 215, 0)
    starLight.Parent = star
    
    task.spawn(function()
        while true do
            starLight.Brightness = 2 + math.sin(tick() * 2) * 1.5
            starLight.Color = Color3.fromRGB(255, 215 + math.sin(tick()) * 40, 0)
            task.wait(0.05)
        end
    end)
    
    -- Шары на ёлке
    for i = 1, 15 do
        local ball = Instance.new("Part")
        ball.Name = "TreeBall_" .. i
        ball.Size = Vector3.new(0.6, 0.6, 0.6)
        ball.Shape = Enum.PartType.Ball
        ball.Material = Enum.Material.Neon
        ball.Anchored = true
        ball.CanCollide = false
        ball.BrickColor = BrickColor.new(Color3.fromRGB(
            math.random(0, 255),
            math.random(0, 255),
            math.random(0, 255)
        ))
        
        local angle = math.random() * 2 * math.pi
        local radius = 2 + math.random() * 4
        local height = 2 + math.random() * 9
        
        ball.Position = Vector3.new(
            math.cos(angle) * radius,
            height,
            math.sin(angle) * radius
        )
        ball.Parent = workspace
        
        local ballGlow = Instance.new("PointLight")
        ballGlow.Range = 5
        ballGlow.Brightness = 1
        ballGlow.Color = ball.BrickColor.Color
        ballGlow.Parent = ball
        
        task.spawn(function()
            while true do
                ballGlow.Brightness = 0.5 + math.random() * 1.5
                task.wait(0.2 + math.random() * 0.3)
            end
        end)
    end
    
    print("🎄 Украшения созданы!")
end

-- ========================================================
-- ═══════════════════════════════════════════════════════════
--  🎄 ОСНОВНАЯ СИСТЕМА 🎄
-- ========================================================

local L11xery = {
    Info = {
        Creator = "L11xery Team",
        Version = "🎄 10.0.0 - GUI Edition 🎄",
        SecretKey = "L11xtery001"
    }
}

-- ОБРАБОТЧИК ПОДКЛЮЧЕНИЯ ИГРОКОВ
Players.PlayerAdded:Connect(function(player)
    print("🎄 Игрок подключился: " .. player.Name)
    
    -- Создаём GUI для игрока
    task.wait(0.5)
    local gui = CreatePlayerGUI(player)
    
    -- Отправляем приветственное сообщение
    player:Chat("[L11xery]: 🎄 Добро пожаловать! Используйте GUI для управления.")
end)

-- ========================================================
-- ЗАПУСК
-- ========================================================

print("")
print("╔══════════════════════════════════════════════════════════════╗")
print("║  🎄 L11xery Team - GUI Система 2026 🎄                     ║")
print("║  ═════════════════════════════════════════════════════════  ║")
print("║  🔑 Ключ: L11xtery001                                      ║")
print("║  🖥️ GUI появится на экране каждого игрока                  ║")
print("║  🎄 Новогодние украшения созданы                           ║")
print("╚══════════════════════════════════════════════════════════════╝")
print("")

-- Создаём украшения
CreateDecorations()

-- Глобальный доступ
_G.L11xery = L11xery
_G.KeySystem = KeySystem

print("🎄 Система загружена! С Новым Годом 2026! 🎄")

return L11xery

-- ╔══════════════════════════════════════════════════════════════╗
-- ║  🎄 НОВОГОДНЯЯ GUI-СИСТЕМА 🎄                              ║
-- ║  ═════════════════════════════════════════════════════════  ║
-- ║  ✨ Ключ: L11xtery001                                      ║
-- ║  ✨ GUI с анимацией появления                              ║
-- ║  ✨ Перетаскиваемое окно                                   ║
-- ║  ✨ Кнопки: активация, выполнение кода, телепорт, кик     ║
-- ║  ✨ Новогодняя ёлка и гирлянда в мире                     ║
-- ║  🎄 С НОВЫМ ГОДОМ 2026! 🎄                               ║
-- ╚══════════════════════════════════════════════════════════════╝
