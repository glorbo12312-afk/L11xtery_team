-- ============================================
-- SERVER SIDE GUI + KEY SYSTEM (SWILL)
-- Ключ: Yrdhhdbxxnvdb
-- Текстовое поле для require():load(playername)
-- ============================================

local KeySystem = {}
KeySystem.ValidKey = "Yrdhhdbxxnvdb"
KeySystem.Sessions = {} -- игроки с подтверждённым ключом

-- Создаём GUI-интерфейс на сервере (через RemoteEvent для клиента, но сам скрипт серверный)
-- В данном примере используем встроенный серверный GUI через PlayerGui (если среда поддерживает)
-- Или создаём удалённые вызовы. Для чистоты — сервер создаёт GUI у клиента.

local function CreateServerGUI(player)
    local gui = Instance.new("ScreenGui")
    gui.Name = "KeySystemGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    -- Фон
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 500, 0, 400)
    frame.Position = UDim2.new(0.5, -250, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    title.Text = "SWILL KEY SYSTEM"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    -- Поле для ввода ключа
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 40)
    keyBox.Position = UDim2.new(0.1, 0, 0.25, 0)
    keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.Parent = frame

    -- Кнопка проверки ключа
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.3, 0, 0, 40)
    checkBtn.Position = UDim2.new(0.35, 0, 0.45, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    checkBtn.Text = "Активировать"
    checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextScaled = true
    checkBtn.Parent = frame

    -- Текстовое поле для скриптов (require():load(playername))
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.9, 0, 0, 100)
    scriptBox.Position = UDim2.new(0.05, 0, 0.6, 0)
    scriptBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    scriptBox.TextColor3 = Color3.fromRGB(0, 255, 200)
    scriptBox.PlaceholderText = "Вставьте require():load(playername) или любой другой скрипт..."
    scriptBox.Text = ""
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextScaled = false
    scriptBox.MultiLine = true
    scriptBox.ClearTextOnFocus = false
    scriptBox.Parent = frame

    -- Кнопка выполнения скрипта (доступна только после ключа)
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0.3, 0, 0, 40)
    execBtn.Position = UDim2.new(0.35, 0, 0.85, 0)
    execBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    execBtn.Text = "Выполнить"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextScaled = true
    execBtn.Visible = false  -- станет видимой после ввода ключа
    execBtn.Parent = frame

    -- Статус
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.8, 0, 0, 30)
    status.Position = UDim2.new(0.1, 0, 0.38, 0)
    status.BackgroundTransparency = 1
    status.Text = "Ожидание ключа..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.Parent = frame

    -- Логика проверки ключа (локально на сервере, но через клик)
    checkBtn.MouseButton1Click:Connect(function()
        local inputKey = keyBox.Text
        if inputKey == KeySystem.ValidKey then
            KeySystem.Sessions[player.UserId] = true
            status.Text = "Ключ принят! Доступ открыт."
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
            execBtn.Visible = true
            checkBtn.Visible = false
            keyBox.Visible = false
        else
            status.Text = "Неверный ключ! Попробуйте снова."
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)

    -- Выполнение скрипта из текстового поля (только после ключа)
    execBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Sessions[player.UserId] then
            status.Text = "Сначала активируйте ключ!"
            return
        end
        local scriptCode = scriptBox.Text
        if scriptCode == "" or scriptCode == nil then
            status.Text = "Скрипт пуст!"
            return
        end
        -- Безопасное выполнение на сервере (loadstring)
        local fn, err = loadstring(scriptCode)
        if fn then
            local success, result = pcall(fn)
            if success then
                status.Text = "Скрипт выполнен успешно."
                status.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                status.Text = "Ошибка выполнения: " .. tostring(result)
                status.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        else
            status.Text = "Ошибка компиляции: " .. tostring(err)
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
end

-- Подключение к игрокам при входе
game.Players.PlayerAdded:Connect(function(player)
    task.wait(0.5) -- ждём загрузку клиента
    CreateServerGUI(player)
end)

-- Опционально: очистка сессий при уходе
game.Players.PlayerRemoving:Connect(function(player)
    KeySystem.Sessions[player.UserId] = nil
end)

print("[SWILL] Key System GUI загружен. Ключ: Yrdhhdbxxnvdb")
