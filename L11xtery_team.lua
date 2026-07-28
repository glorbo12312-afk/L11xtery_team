-- ============================================
-- SWILL - АВТОНОМНЫЙ ГУИ С KEY SYSTEM (ТОЛЬКО ЭКЗЕКУТОР)
-- Ключ: Yrdhhdbxxnvdb
-- Не требует загрузки в Roblox Studio
-- ============================================

local player = game.Players.LocalPlayer
local KeySystem = {}
KeySystem.ValidKey = "Yrdhhdbxxnvdb"
KeySystem.Active = false
KeySystem.ScriptToExecute = ""

-- 1. СОЗДАЁМ REMOTEEVENT НА ЛЕТУ (через клиентский инстанс)
local Remote = Instance.new("RemoteEvent")
Remote.Name = "SWILL_ActivateGUI"
Remote.Parent = game.ReplicatedStorage

-- 2. СОЗДАЁМ GUI НА КЛИЕНТЕ (без участия сервера)
local function CreateGUI()
    -- Удаляем старый GUI, если есть
    local oldGui = player.PlayerGui:FindFirstChild("SWILL_KeyGUI")
    if oldGui then oldGui:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "SWILL_KeyGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    -- Основной фрейм
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 580, 0, 480)
    frame.Position = UDim2.new(0.5, -290, 0.5, -240)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    title.Text = "SWILL KEY SYSTEM (Экзектор)"
    title.TextColor3 = Color3.fromRGB(200, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    -- Поле для ключа
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 45)
    keyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
    keyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.Parent = frame

    -- Кнопка проверки
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.3, 0, 0, 45)
    checkBtn.Position = UDim2.new(0.35, 0, 0.4, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    checkBtn.Text = "Активировать"
    checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextScaled = true
    checkBtn.Parent = frame

    -- Текстовое поле для скриптов (require():load(playername))
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.9, 0, 0, 130)
    scriptBox.Position = UDim2.new(0.05, 0, 0.55, 0)
    scriptBox.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
    scriptBox.TextColor3 = Color3.fromRGB(0, 255, 200)
    scriptBox.PlaceholderText = "Вставьте require():load(playername) или любой Lua-код..."
    scriptBox.Text = ""
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextScaled = false
    scriptBox.MultiLine = true
    scriptBox.ClearTextOnFocus = false
    scriptBox.Parent = frame

    -- Кнопка выполнения (появляется после ключа)
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0.3, 0, 0, 45)
    execBtn.Position = UDim2.new(0.35, 0, 0.85, 0)
    execBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    execBtn.Text = "Выполнить"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextScaled = true
    execBtn.Visible = false
    execBtn.Parent = frame

    -- Статус
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.8, 0, 0, 35)
    status.Position = UDim2.new(0.1, 0, 0.33, 0)
    status.BackgroundTransparency = 1
    status.Text = "Ожидание ключа..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.Parent = frame

    -- Кнопка закрытия (крестик)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -45, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- Логика проверки ключа
    checkBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == KeySystem.ValidKey then
            KeySystem.Active = true
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

    -- Выполнение скрипта из текстового поля (КЛИЕНТСКИЙ loadstring)
    execBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then
            status.Text = "Сначала активируйте ключ!"
            return
        end
        local code = scriptBox.Text
        if code == "" or code == nil then
            status.Text = "Скрипт пуст!"
            return
        end
        
        -- Запоминаем скрипт для выполнения
        KeySystem.ScriptToExecute = code
        
        -- Выполняем через loadstring на клиенте
        local fn, err = loadstring(code)
        if fn then
            local success, result = pcall(fn)
            if success then
                status.Text = "Скрипт выполнен успешно (клиент)."
                status.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                status.Text = "Ошибка: " .. tostring(result)
                status.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        else
            status.Text = "Ошибка компиляции: " .. tostring(err)
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)

    -- Доп. фича: выполнение скрипта через Enter в текстовом поле
    scriptBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and KeySystem.Active then
            execBtn.MouseButton1Click:Fire()
        end
    end)
end

-- 3. АКТИВАЦИЯ GUI (вызывается при запуске скрипта)
print("[SWILL] Автономная система запущена. Ключ: Yrdhhdbxxnvdb")

-- Создаём GUI сразу
CreateGUI()

-- 4. ОПЦИОНАЛЬНО: если хочешь выполнить скрипт автоматически после вставки (для удобства)
-- Раскомментируй, если нужно:
--[[
local function AutoExecute()
    while not KeySystem.Active do
        task.wait(1)
    end
    task.wait(0.5)
    local scriptBox = player.PlayerGui.SWILL_KeyGUI:FindFirstChild("Frame"):FindFirstChild("TextBox", true)
    if scriptBox and scriptBox.Text ~= "" then
        local execBtn = player.PlayerGui.SWILL_KeyGUI:FindFirstChild("Frame"):FindFirstChild("TextButton", true)
        if execBtn then
            execBtn.MouseButton1Click:Fire()
        end
    end
end
coroutine.wrap(AutoExecute)()
--]]

print("[SWILL] GUI создан. Введи ключ и вставь require():load(playername)")

-- 5. ЗАЩИТА ОТ СБОЕВ: если экзекутор упадёт, пересоздаём GUI
local function RecreateGUI()
    local gui = player.PlayerGui:FindFirstChild("SWILL_KeyGUI")
    if not gui then
        print("[SWILL] Пересоздание GUI...")
        CreateGUI()
    end
end

-- Периодическая проверка (каждые 5 секунд)
game:GetService("RunService").Heartbeat:Connect(function()
    if not player.PlayerGui:FindFirstChild("SWILL_KeyGUI") then
        RecreateGUI()
    end
end)
