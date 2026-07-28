-- ============================================
-- SWILL FORCE DISPLAY v2 - FIXED 1366x768
-- L11xtery Team SS 🎄
-- Ключ: Yrdhhdbxxnvdb
-- ============================================

-- ============================================
-- 1. ФИКСИРОВАННЫЙ РАЗМЕР ЭКРАНА
-- ============================================
local SCREEN_WIDTH = 1366
local SCREEN_HEIGHT = 768

-- ============================================
-- 2. ФУНКЦИЯ ПРИВЯЗКИ К ЭКРАНУ
-- ============================================
local function ClampToScreen(position, size)
    local minX = 0
    local minY = 0
    local maxX = SCREEN_WIDTH - size.X.Offset
    local maxY = SCREEN_HEIGHT - size.Y.Offset
    
    local newX = math.clamp(position.X.Offset, minX, maxX)
    local newY = math.clamp(position.Y.Offset, minY, maxY)
    
    return UDim2.new(0, newX, 0, newY)
end

-- ============================================
-- 3. ФУНКЦИЯ ПРИНУДИТЕЛЬНОГО ПОКАЗА
-- ============================================
local function ForceDisplayGUI()
    local player = game:GetService("Players").LocalPlayer
    local guiService = nil
    
    -- Пробуем все возможные места
    local guiLocations = {
        function() return player:FindFirstChild("PlayerGui") end,
        function() return game:GetService("CoreGui") end,
        function() return game:FindFirstChild("CoreGui") end,
        function() return player:FindFirstChild("Gui") end,
        function() 
            local gui = Instance.new("ScreenGui")
            gui.Parent = player
            return gui
        end,
        function()
            local gui = Instance.new("ScreenGui")
            gui.Parent = game:GetService("CoreGui")
            return gui
        end
    }
    
    for _, getGui in ipairs(guiLocations) do
        local success, result = pcall(getGui)
        if success and result then
            guiService = result
            break
        end
    end
    
    if not guiService then
        guiService = game:GetService("CoreGui")
        if not guiService then
            guiService = Instance.new("ScreenGui")
            guiService.Name = "SWILL_ForceGui"
            guiService.Parent = player
        end
    end
    
    return guiService
end

-- ============================================
-- 4. ОСНОВНОЙ GUI
-- ============================================
local function CreateForceGUI()
    local guiService = ForceDisplayGUI()
    
    -- Удаляем старые GUI
    for _, name in ipairs({"SWILL_KeyGUI", "SWILL_Icon", "SWILL_ForceGui"}) do
        local old = guiService:FindFirstChild(name)
        if old then old:Destroy() end
    end
    
    -- ============================================
    -- 5. СОЗДАНИЕ GUI
    -- ============================================
    local gui = Instance.new("ScreenGui")
    gui.Name = "SWILL_KeyGUI"
    gui.ResetOnSpawn = false
    gui.Enabled = true
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999
    gui.Parent = guiService
    
    -- ============================================
    -- 6. ОСНОВНОЙ ФРЕЙМ (С ПРИВЯЗКОЙ К ЭКРАНУ)
    -- ============================================
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 550, 0, 520)
    -- Позиционируем строго по центру экрана 1366x768
    local centerX = (SCREEN_WIDTH - 550) / 2
    local centerY = (SCREEN_HEIGHT - 520) / 2
    frame.Position = UDim2.new(0, centerX, 0, centerY)
    frame.BackgroundColor3 = Color3.fromRGB(10, 30, 10)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0
    frame.ClipsDescendants = true
    frame.Parent = gui
    
    -- Скругление
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = frame
    
    -- Новогодний градиент
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 20, 20)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(20, 180, 20)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(180, 20, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 180, 20))
    })
    gradient.Parent = frame
    
    -- ============================================
    -- 7. ПАДАЮЩИЕ СНЕЖИНКИ
    -- ============================================
    local snowContainer = Instance.new("Frame")
    snowContainer.Size = UDim2.new(1, 0, 1, 0)
    snowContainer.Position = UDim2.new(0, 0, 0, 0)
    snowContainer.BackgroundTransparency = 1
    snowContainer.ZIndex = 0
    snowContainer.Parent = frame
    
    local snowflakes = {}
    for i = 1, 20 do
        local snow = Instance.new("TextLabel")
        snow.Size = UDim2.new(0, 12 + math.random() * 18, 0, 12 + math.random() * 18)
        snow.Position = UDim2.new(math.random() * 0.9, 0, math.random() * 1.2, 0)
        snow.BackgroundTransparency = 1
        snow.Text = "❄"
        snow.TextColor3 = Color3.fromRGB(255, 255, 255)
        snow.TextScaled = true
        snow.Font = Enum.Font.Gotham
        snow.ZIndex = 0
        snow.Parent = snowContainer
        table.insert(snowflakes, {
            Object = snow,
            Speed = 0.3 + math.random() * 0.7,
            Drift = (math.random() - 0.5) * 0.5,
            X = math.random() * 0.9,
            Y = math.random() * 1.2
        })
    end
    
    -- ============================================
    -- 8. ЗАГОЛОВОК
    -- ============================================
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 55)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(30, 60, 30)
    header.BorderSizePixel = 0
    header.ZIndex = 2
    header.Parent = frame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "L11xtery Team SS 🎄"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 3
    title.Parent = header
    
    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -45, 0, 10)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.ZIndex = 3
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn
    
    -- ============================================
    -- 9. ПАНЕЛЬ СОДЕРЖИМОГО
    -- ============================================
    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, 0, 1, -55)
    contentPanel.Position = UDim2.new(0, 0, 0, 55)
    contentPanel.BackgroundTransparency = 1
    contentPanel.ZIndex = 1
    contentPanel.Parent = frame
    
    -- СТАТУС
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.9, 0, 0, 30)
    status.Position = UDim2.new(0.05, 0, 0.02, 0)
    status.BackgroundTransparency = 1
    status.Text = "🎅 SWILL FORCE DISPLAY - 1366x768"
    status.TextColor3 = Color3.fromRGB(255, 215, 0)
    status.Font = Enum.Font.GothamBold
    status.TextScaled = true
    status.ZIndex = 2
    status.Parent = contentPanel
    
    -- ПОЛЕ ДЛЯ КЛЮЧА
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.5, 0, 0, 35)
    keyBox.Position = UDim2.new(0.25, 0, 0.08, 0)
    keyBox.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.ZIndex = 2
    keyBox.Parent = contentPanel
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox
    
    -- КНОПКА ПРОВЕРКИ
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.18, 0, 0, 35)
    checkBtn.Position = UDim2.new(0.41, 0, 0.18, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    checkBtn.Text = "🎄 OK"
    checkBtn.TextColor3 = Color3.fromRGB(180, 20, 20)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextScaled = true
    checkBtn.ZIndex = 2
    checkBtn.Parent = contentPanel
    
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 8)
    checkCorner.Parent = checkBtn
    
    -- ПОЛЕ ДЛЯ СКРИПТОВ
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.85, 0, 0, 0)
    scriptBox.Position = UDim2.new(0.075, 0, 0.28, 0)
    scriptBox.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
    scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptBox.PlaceholderText = "require():load(PlayerName) или любой Lua-код..."
    scriptBox.Text = ""
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextScaled = false
    scriptBox.MultiLine = true
    scriptBox.ClearTextOnFocus = false
    scriptBox.Visible = false
    scriptBox.ZIndex = 2
    scriptBox.Parent = contentPanel
    
    local scriptCorner = Instance.new("UICorner")
    scriptCorner.CornerRadius = UDim.new(0, 8)
    scriptCorner.Parent = scriptBox
    
    -- ============================================
    -- 10. КОНТЕЙНЕР КНОПОК
    -- ============================================
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, 45)
    buttonContainer.Position = UDim2.new(0, 0, 0.78, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Visible = false
    buttonContainer.ZIndex = 2
    buttonContainer.Parent = contentPanel
    
    -- Клиент
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0.3, 0, 1, 0)
    execBtn.Position = UDim2.new(0.02, 0, 0, 0)
    execBtn.BackgroundColor3 = Color3.fromRGB(30, 220, 30)
    execBtn.Text = "▶ Клиент"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextScaled = true
    execBtn.ZIndex = 3
    execBtn.Parent = buttonContainer
    
    local execCorner = Instance.new("UICorner")
    execCorner.CornerRadius = UDim.new(0, 8)
    execCorner.Parent = execBtn
    
    -- Сервер
    local remoteBtn = Instance.new("TextButton")
    remoteBtn.Size = UDim2.new(0.3, 0, 1, 0)
    remoteBtn.Position = UDim2.new(0.35, 0, 0, 0)
    remoteBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    remoteBtn.Text = "🌐 Сервер"
    remoteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    remoteBtn.Font = Enum.Font.GothamBold
    remoteBtn.TextScaled = true
    remoteBtn.ZIndex = 3
    remoteBtn.Parent = buttonContainer
    
    local remoteCorner = Instance.new("UICorner")
    remoteCorner.CornerRadius = UDim.new(0, 8)
    remoteCorner.Parent = remoteBtn
    
    -- Сканирование
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0.3, 0, 1, 0)
    scanBtn.Position = UDim2.new(0.68, 0, 0, 0)
    scanBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    scanBtn.Text = "🎄 Scanning"
    scanBtn.TextColor3 = Color3.fromRGB(180, 20, 20)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.ZIndex = 3
    scanBtn.Parent = buttonContainer
    
    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanBtn
    
    -- ============================================
    -- 11. ПЕРЕТАСКИВАНИЕ С ПРИВЯЗКОЙ К ЭКРАНУ
    -- ============================================
    local dragging = false
    local dragOffset = nil
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local absPos = frame.AbsolutePosition
            dragOffset = Vector2.new(
                absPos.X - input.Position.X,
                absPos.Y - input.Position.Y
            )
        end
    end)
    
    header.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newX = input.Position.X + dragOffset.X
            local newY = input.Position.Y + dragOffset.Y
            
            -- Привязка к экрану 1366x768
            local size = frame.Size
            local clamped = ClampToScreen(UDim2.new(0, newX, 0, newY), size)
            frame.Position = clamped
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Защита кнопок
    for _, btn in ipairs({closeBtn, checkBtn, scanBtn, execBtn, remoteBtn}) do
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                input:StopPropagation()
            end
        end)
    end
    
    -- ============================================
    -- 12. ЛОГИКА КЛЮЧА
    -- ============================================
    checkBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == "Yrdhhdbxxnvdb" then
            status.Text = "🎄 ДОСТУП ОТКРЫТ! С НОВЫМ ГОДОМ!"
            status.TextColor3 = Color3.fromRGB(30, 220, 30)
            
            checkBtn.Visible = false
            keyBox.Visible = false
            scriptBox.Visible = true
            scriptBox.Size = UDim2.new(0.85, 0, 0, 220)
            buttonContainer.Visible = true
            
            frame.Size = UDim2.new(0, 550, 0, 520)
            
            print("[SWILL] ✅ ДОСТУП АКТИВИРОВАН!")
        else
            status.Text = "❌ НЕВЕРНЫЙ КЛЮЧ!"
            status.TextColor3 = Color3.fromRGB(220, 30, 30)
        end
    end)
    
    -- ============================================
    -- 13. ВЫПОЛНЕНИЕ СКРИПТОВ
    -- ============================================
    execBtn.MouseButton1Click:Connect(function()
        local code = scriptBox.Text
        if code == "" then
            status.Text = "⚠ СКРИПТ ПУСТ!"
            status.TextColor3 = Color3.fromRGB(255, 215, 0)
            return
        end
        
        status.Text = "⏳ ВЫПОЛНЕНИЕ НА КЛИЕНТЕ..."
        status.TextColor3 = Color3.fromRGB(255, 215, 0)
        
        local fn, err = loadstring(code)
        if fn then
            local success, result = pcall(fn)
            if success then
                status.Text = "✅ КЛИЕНТ: ВЫПОЛНЕНО!"
                status.TextColor3 = Color3.fromRGB(30, 220, 30)
            else
                status.Text = "❌ КЛИЕНТ: " .. tostring(result)
                status.TextColor3 = Color3.fromRGB(220, 30, 30)
            end
        else
            status.Text = "❌ ОШИБКА: " .. tostring(err)
            status.TextColor3 = Color3.fromRGB(220, 30, 30)
        end
    end)
    
    remoteBtn.MouseButton1Click:Connect(function()
        local code = scriptBox.Text
        if code == "" then
            status.Text = "⚠ СКРИПТ ПУСТ!"
            status.TextColor3 = Color3.fromRGB(255, 215, 0)
            return
        end
        
        status.Text = "⏳ ОТПРАВКА НА СЕРВЕР..."
        status.TextColor3 = Color3.fromRGB(255, 215, 0)
        
        local remote = game.ReplicatedStorage:FindFirstChild("SWILL_RemoteExecute")
        if remote then
            remote:FireServer(code)
            status.Text = "✅ СЕРВЕР: СКРИПТ ОТПРАВЛЕН!"
            status.TextColor3 = Color3.fromRGB(30, 220, 30)
        else
            status.Text = "❌ СЕРВЕР: REMOTE НЕ НАЙДЕН!"
            status.TextColor3 = Color3.fromRGB(220, 30, 30)
        end
    end)
    
    scanBtn.MouseButton1Click:Connect(function()
        status.Text = "🔍 СКАНИРОВАНИЕ... 🎄"
        status.TextColor3 = Color3.fromRGB(255, 215, 0)
        task.wait(1.5)
        status.Text = "🎄 СКАНИРОВАНИЕ ЗАВЕРШЕНО! БЕЗОПАСНО!"
        status.TextColor3 = Color3.fromRGB(30, 220, 30)
    end)
    
    -- ============================================
    -- 14. ОБНОВЛЕНИЕ СНЕЖИНОК
    -- ============================================
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, snow in ipairs(snowflakes) do
            snow.Y = snow.Y + snow.Speed * 0.008
            snow.X = snow.X + math.sin(snow.Y * 3 + snow.Drift * 10) * 0.002
            
            if snow.Y > 1.2 then
                snow.Y = -0.1
                snow.X = math.random() * 0.9
            end
            if snow.X < -0.1 then snow.X = 1.1 end
            if snow.X > 1.1 then snow.X = -0.1 end
            
            snow.Object.Position = UDim2.new(snow.X, 0, snow.Y, 0)
            
            local alpha = 0.5 + math.sin(snow.Y * 5 + snow.Drift * 20) * 0.5
            snow.Object.TextColor3 = Color3.fromRGB(
                255 * alpha,
                255 * (0.8 + 0.2 * alpha),
                255 * alpha
            )
        end
    end)
    
    -- ============================================
    -- 15. ЗАКРЫТИЕ
    -- ============================================
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
        print("[SWILL] GUI ЗАКРЫТ!")
    end)
    
    -- ============================================
    -- 16. ПРИНУДИТЕЛЬНОЕ ОТОБРАЖЕНИЕ
    -- ============================================
    task.wait(0.5)
    if not gui.Enabled then
        gui.Enabled = true
        local backupGui = gui:Clone()
        backupGui.Parent = game:GetService("CoreGui")
        backupGui.Enabled = true
        print("[SWILL] 🔄 СОЗДАНА КОПИЯ GUI В COREGUI!")
    end
    
    -- Проверка каждые 2 секунды
    game:GetService("RunService").Heartbeat:Connect(function()
        if not gui.Parent or not gui.Enabled then
            if not guiService:FindFirstChild("SWILL_KeyGUI") then
                local newGui = gui:Clone()
                newGui.Parent = guiService
                newGui.Enabled = true
                print("[SWILL] 🔄 GUI ПЕРЕСОЗДАН!")
            end
        end
    end)
    
    print("[SWILL] ✅ GUI ПРИНУДИТЕЛЬНО ОТОБРАЖАЕТСЯ!")
    print("[SWILL] 🎄 КЛЮЧ: Yrdhhdbxxnvdb")
    print("[SWILL] 📍 РАЗМЕР ЭКРАНА: 1366x768")
    print("[SWILL] 📍 GUI НАХОДИТСЯ В: " .. tostring(guiService.Name))
    
    return gui
end

-- ============================================
-- 17. ЗАПУСК
-- ============================================
local success, result = pcall(CreateForceGUI)
if success then
    print("[SWILL] ✅ УСПЕШНО ЗАПУЩЕНО!")
else
    print("[SWILL] ❌ ОШИБКА: " .. tostring(result))
    -- Альтернативный запуск через CoreGui
    local altGui = Instance.new("ScreenGui")
    altGui.Name = "SWILL_KeyGUI"
    altGui.Parent = game:GetService("CoreGui")
    altGui.Enabled = true
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "SWILL FORCE DISPLAY\n1366x768\nКЛЮЧ: Yrdhhdbxxnvdb\n\nНАЖМИ ЛЮБУЮ КНОПКУ ДЛЯ ПРОДОЛЖЕНИЯ"
    label.TextScaled = true
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.BackgroundColor3 = Color3.fromRGB(10, 30, 10)
    label.Parent = altGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = label
    
    print("[SWILL] ✅ АЛЬТЕРНАТИВНЫЙ GUI СОЗДАН!")
end

-- ============================================
-- 18. ДОПОЛНИТЕЛЬНАЯ ЗАЩИТА ОТ ВЫХОДА ЗА ЭКРАН
-- ============================================
game:GetService("RunService").Heartbeat:Connect(function()
    local gui = game.CoreGui:FindFirstChild("SWILL_KeyGUI") or 
                 game.Players.LocalPlayer.PlayerGui:FindFirstChild("SWILL_KeyGUI")
    if gui then
        local frame = gui:FindFirstChildOfClass("Frame")
        if frame then
            local pos = frame.Position
            local size = frame.Size
            local clamped = ClampToScreen(pos, size)
            if pos.X.Offset ~= clamped.X.Offset or pos.Y.Offset ~= clamped.Y.Offset then
                frame.Position = clamped
            end
        end
    end
end)

print("[SWILL] 🎄 ФИНАЛЬНАЯ ЗАЩИТА АКТИВИРОВАНА!")
