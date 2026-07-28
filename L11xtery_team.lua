-- ============================================
-- SWILL NEW YEAR EDITION - L11xtery Team SS
-- Ключ: Yrdhhdbxxnvdb
-- ============================================
local player = game:GetService("Players").LocalPlayer
local guiService = player:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local KeySystem = {
    ValidKey = "Yrdhhdbxxnvdb",
    Active = false,
    IsOpen = false,
    Dragging = false,
    DragStart = nil,
    DragOffset = nil
}

-- ============================================
-- НОВОГОДНИЕ ЦВЕТА
-- ============================================
local Colors = {
    Red = Color3.fromRGB(220, 30, 30),
    DarkRed = Color3.fromRGB(180, 20, 20),
    Green = Color3.fromRGB(30, 220, 30),
    DarkGreen = Color3.fromRGB(20, 180, 20),
    Gold = Color3.fromRGB(255, 215, 0),
    DarkGold = Color3.fromRGB(200, 170, 0),
    White = Color3.fromRGB(255, 255, 255),
    Snow = Color3.fromRGB(240, 248, 255),
    Sparkle = Color3.fromRGB(255, 255, 200),
    Background = Color3.fromRGB(10, 30, 10),
    HeaderBg = Color3.fromRGB(30, 60, 30)
}

-- ============================================
-- СКАНИРОВАНИЕ ВСЕХ ФАЙЛОВ ПЛЕЙСА
-- ============================================
local function ScanAllForBackdoors()
    local results = {}
    local backdoorPatterns = {
        "loadstring", "getfenv", "setfenv", "getrenv", "getgenv",
        "synapse", "krnl", "scriptware", "require%(", "http%.get", "http%.post",
        "game:HttpGet", "game:Post", "firetouchinterest", "fireclickdetector",
        "remote%.FireServer", "remote%.InvokeServer", "localplayer%.Character",
        "workspace%.CurrentCamera", "shared%.", "game%.Players%.LocalPlayer",
        "getupvalue", "setupvalue", "newcclosure", "checkcaller", "iscclosure",
        "isexecutorclosure", "getcallingscript", "getscriptclosure", "getcustomasset",
        "getloadedmodules", "getmodulescript", "getsenv", "getreg", "getgc",
        "getnamecallmethod", "getrawmetatable", "setrawmetatable", "hookfunction",
        "hookmetamethod", "newproxy", "make_writeable", "make_readonly",
        "debug%.getinfo", "debug%.getupvalue", "debug%.setupvalue", "debug%.traceback",
        "coroutine%.wrap", "coroutine%.resume", "pcall", "xpcall", "spawn", "delay",
        "task%.wait", "task%.delay", "task%.spawn", "task%.defer", "task%.sync", "task%.wake",
        "bit%.", "string%.dump", "table%.", "math%.", "Vector3", "CFrame",
        "Raycast", "TweenService", "Bindable", "RemoteEvent", "RemoteFunction",
        "UnreliableRemote", "ReplicatedStorage", "ServerScriptService"
    }

    -- Сканирование всех объектов
    local function ScanInstance(instance, path, level)
        if level > 50 then return end -- Защита от бесконечной рекурсии
        
        -- Проверяем скрипты
        if instance:IsA("LocalScript") or instance:IsA("ModuleScript") or instance:IsA("Script") then
            local code = instance.Source or ""
            local found = {}
            for _, pattern in ipairs(backdoorPatterns) do
                if string.find(code, pattern) then
                    table.insert(found, pattern)
                end
            end
            if #found > 0 then
                table.insert(results, {
                    Type = "Скрипт",
                    Name = instance.Name,
                    Path = path,
                    Class = instance.ClassName,
                    Backdoors = found,
                    Risk = #found > 8 and "КРИТИЧНЫЙ" or #found > 5 and "Высокий" or #found > 2 and "Средний" or "Низкий"
                })
            end
        end
        
        -- Проверяем RemoteEvent/RemoteFunction (потенциальные бекдоры)
        if instance:IsA("RemoteEvent") or instance:IsA("RemoteFunction") then
            table.insert(results, {
                Type = "Remote",
                Name = instance.Name,
                Path = path,
                Class = instance.ClassName,
                Backdoors = {"Потенциальный бекдор через Remote"},
                Risk = "Высокий"
            })
        end
        
        -- Проверяем ModuleScripts в ReplicatedStorage
        if instance:IsA("ModuleScript") and instance.Parent and instance.Parent.Name == "ReplicatedStorage" then
            table.insert(results, {
                Type = "Модуль",
                Name = instance.Name,
                Path = path,
                Class = instance.ClassName,
                Backdoors = {"Может использоваться для инжекта"},
                Risk = "Средний"
            })
        end
        
        -- Обходим детей
        for _, child in ipairs(instance:GetChildren()) do
            local newPath = path .. " > " .. child.Name
            ScanInstance(child, newPath, level + 1)
        end
    end

    -- Сканируем всё
    ScanInstance(game, "game", 0)
    
    -- Дополнительно сканируем CoreGui (часто используется для бекдоров)
    local coreGui = game:FindFirstChild("CoreGui")
    if coreGui then
        ScanInstance(coreGui, "CoreGui", 0)
    end
    
    return results
end

-- ============================================
-- ИКОНКА "L"
-- ============================================
local function CreateToggleIcon()
    local oldIcon = guiService:FindFirstChild("SWILL_Icon")
    if oldIcon then oldIcon:Destroy() end
    
    local iconGui = Instance.new("ScreenGui")
    iconGui.Name = "SWILL_Icon"
    iconGui.ResetOnSpawn = false
    iconGui.IgnoreGuiInset = true
    iconGui.Parent = guiService

    local iconBtn = Instance.new("TextButton")
    iconBtn.Size = UDim2.new(0, 60, 0, 60)
    iconBtn.Position = UDim2.new(0.95, -70, 0.05, 0)
    iconBtn.BackgroundColor3 = Colors.Red
    iconBtn.Text = "L"
    iconBtn.TextColor3 = Colors.Gold
    iconBtn.Font = Enum.Font.GothamBold
    iconBtn.TextScaled = true
    iconBtn.BackgroundTransparency = 1
    iconBtn.Parent = iconGui

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 16)
    iconCorner.Parent = iconBtn

    -- Новогодний блеск на иконке
    local sparkle = Instance.new("ImageLabel")
    sparkle.Size = UDim2.new(1.4, 0, 1.4, 0)
    sparkle.Position = UDim2.new(-0.2, 0, -0.2, 0)
    sparkle.BackgroundTransparency = 1
    sparkle.Image = "rbxassetid://1316041664"
    sparkle.ImageColor3 = Colors.Gold
    sparkle.ImageTransparency = 0.5
    sparkle.Parent = iconBtn

    -- Анимация появления
    local appear = TweenService:Create(iconBtn, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    appear:Play()

    -- Перетаскивание иконки
    local dragging = false
    local dragStart = nil
    local dragOffset = nil

    iconBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            dragOffset = Vector2.new(
                iconBtn.AbsolutePosition.X - input.Position.X,
                iconBtn.AbsolutePosition.Y - input.Position.Y
            )
        end
    end)

    iconBtn.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newX = input.Position.X + dragOffset.X
            local newY = input.Position.Y + dragOffset.Y
            iconBtn.Position = UDim2.new(0, newX, 0, newY)
        end
    end)

    iconBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    iconBtn.MouseButton1Click:Connect(function()
        if not KeySystem.IsOpen then
            iconGui:Destroy()
            CreateMainGUI()
        end
    end)
end

-- ============================================
-- ОСНОВНОЙ GUI
-- ============================================
local function CreateMainGUI()
    KeySystem.IsOpen = true
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "SWILL_KeyGUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = guiService

    -- Основной фрейм
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 600, 0, 550)
    frame.Position = UDim2.new(0.5, -300, 0.5, -275)
    frame.BackgroundColor3 = Colors.Background
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = true
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = frame

    -- Анимация появления
    local appearTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    frame.BackgroundTransparency = 1
    appearTween:Play()

    -- Новогодний градиент
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.DarkRed),
        ColorSequenceKeypoint.new(0.3, Colors.DarkGreen),
        ColorSequenceKeypoint.new(0.6, Colors.DarkRed),
        ColorSequenceKeypoint.new(1, Colors.DarkGreen)
    })
    gradient.Parent = frame

    -- Новогодние снежинки (декор)
    local function CreateSnowflake(x, y, size, speed)
        local snow = Instance.new("TextLabel")
        snow.Size = UDim2.new(0, size, 0, size)
        snow.Position = UDim2.new(x, 0, y, 0)
        snow.BackgroundTransparency = 1
        snow.Text = "❄"
        snow.TextColor3 = Colors.White
        snow.TextScaled = true
        snow.Font = Enum.Font.Gotham
        snow.Parent = frame
        return snow
    end
    
    -- Добавляем снежинки
    for i = 1, 8 do
        local snow = CreateSnowflake(math.random() * 0.9, math.random() * 0.9, 15 + math.random() * 15, 1 + math.random() * 2)
    end

    -- Верхняя часть: L11xtery Team SS (без подзаголовка)
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 55)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Colors.HeaderBg
    header.BorderSizePixel = 0
    header.Parent = frame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "L11xtery Team SS"
    title.TextColor3 = Colors.Gold
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = header

    -- Новогодняя ёлочка в заголовке
    local tree = Instance.new("TextLabel")
    tree.Size = UDim2.new(0, 40, 0, 40)
    tree.Position = UDim2.new(0.02, 0, 0.05, 0)
    tree.BackgroundTransparency = 1
    tree.Text = "🎄"
    tree.TextColor3 = Colors.Green
    tree.TextScaled = true
    tree.Font = Enum.Font.Gotham
    tree.Parent = header

    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -45, 0, 10)
    closeBtn.BackgroundColor3 = Colors.Red
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Colors.White
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.Parent = header

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn

    -- Панель содержимого
    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, 0, 1, -55)
    contentPanel.Position = UDim2.new(0, 0, 0, 55)
    contentPanel.BackgroundTransparency = 1
    contentPanel.Parent = frame

    -- Поле для ключа
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.5, 0, 0, 40)
    keyBox.Position = UDim2.new(0.25, 0, 0.05, 0)
    keyBox.BackgroundColor3 = Colors.DarkGreen
    keyBox.TextColor3 = Colors.White
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.Parent = contentPanel

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox

    -- Кнопка проверки
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.2, 0, 0, 40)
    checkBtn.Position = UDim2.new(0.4, 0, 0.15, 0)
    checkBtn.BackgroundColor3 = Colors.Gold
    checkBtn.Text = "🎄 Активировать"
    checkBtn.TextColor3 = Colors.DarkRed
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextScaled = true
    checkBtn.Parent = contentPanel

    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 8)
    checkCorner.Parent = checkBtn

    -- Поле для выполнения скриптов
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.8, 0, 0, 60)
    scriptBox.Position = UDim2.new(0.1, 0, 0.25, 0)
    scriptBox.BackgroundColor3 = Colors.DarkGreen
    scriptBox.TextColor3 = Colors.White
    scriptBox.PlaceholderText = "Вставьте скрипт: require():load(PlayerName) или любой Lua-код..."
    scriptBox.Text = ""
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextScaled = false
    scriptBox.MultiLine = true
    scriptBox.ClearTextOnFocus = false
    scriptBox.Visible = false
    scriptBox.Parent = contentPanel

    local scriptCorner = Instance.new("UICorner")
    scriptCorner.CornerRadius = UDim.new(0, 8)
    scriptCorner.Parent = scriptBox

    -- Кнопка выполнения скрипта
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0.2, 0, 0, 40)
    execBtn.Position = UDim2.new(0.4, 0, 0.4, 0)
    execBtn.BackgroundColor3 = Colors.Green
    execBtn.Text = "▶ Выполнить"
    execBtn.TextColor3 = Colors.White
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextScaled = true
    execBtn.Visible = false
    execBtn.Parent = contentPanel

    local execCorner = Instance.new("UICorner")
    execCorner.CornerRadius = UDim.new(0, 8)
    execCorner.Parent = execBtn

    -- Кнопка сканирования
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0.3, 0, 0, 40)
    scanBtn.Position = UDim2.new(0.35, 0, 0.55, 0)
    scanBtn.BackgroundColor3 = Colors.Red
    scanBtn.Text = "🔍 Сканировать всё"
    scanBtn.TextColor3 = Colors.White
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.Visible = false
    scanBtn.Parent = contentPanel

    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanBtn

    -- Результаты сканирования
    local resultsBox = Instance.new("ScrollingFrame")
    resultsBox.Size = UDim2.new(0.92, 0, 0.28, 0)
    resultsBox.Position = UDim2.new(0.04, 0, 0.68, 0)
    resultsBox.BackgroundColor3 = Colors.DarkGreen
    resultsBox.BorderSizePixel = 0
    resultsBox.Visible = false
    resultsBox.Parent = contentPanel

    local resultsCorner = Instance.new("UICorner")
    resultsCorner.CornerRadius = UDim.new(0, 8)
    resultsCorner.Parent = resultsBox

    local resultsList = Instance.new("UIListLayout")
    resultsList.Padding = UDim.new(0, 2)
    resultsList.Parent = resultsBox

    -- Статус
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.8, 0, 0, 30)
    status.Position = UDim2.new(0.1, 0, 0.2, 0)
    status.BackgroundTransparency = 1
    status.Text = "🎅 Введите ключ для доступа"
    status.TextColor3 = Colors.Gold
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.Parent = contentPanel

    -- ============================================
    -- ПЕРЕТАСКИВАНИЕ
    -- ============================================
    local function StartDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            KeySystem.Dragging = true
            KeySystem.DragStart = input.Position
            KeySystem.DragOffset = Vector2.new(
                frame.AbsolutePosition.X - input.Position.X,
                frame.AbsolutePosition.Y - input.Position.Y
            )
        end
    end

    local function UpdateDrag(input)
        if KeySystem.Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newX = input.Position.X + KeySystem.DragOffset.X
            local newY = input.Position.Y + KeySystem.DragOffset.Y
            local dragTween = TweenService:Create(frame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0, newX, 0, newY)
            })
            dragTween:Play()
        end
    end

    local function EndDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            KeySystem.Dragging = false
        end
    end

    header.InputBegan:Connect(StartDrag)
    header.InputChanged:Connect(UpdateDrag)
    header.InputEnded:Connect(EndDrag)

    -- Защита кнопок
    local buttons = {closeBtn, checkBtn, scanBtn, execBtn, keyBox, scriptBox}
    for _, btn in ipairs(buttons) do
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                input:StopPropagation()
            end
        end)
    end

    -- ============================================
    -- ЛОГИКА КЛЮЧА
    -- ============================================
    checkBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == KeySystem.ValidKey then
            KeySystem.Active = true
            status.Text = "🎄 Доступ открыт! С Новым Годом!"
            status.TextColor3 = Colors.Green
            checkBtn.Visible = false
            keyBox.Visible = false
            scriptBox.Visible = true
            execBtn.Visible = true
            scanBtn.Visible = true
            
            -- Анимация
            local pulse = TweenService:Create(status, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                TextScaled = true
            })
            pulse:Play()
        else
            status.Text = "❌ Неверный ключ!"
            status.TextColor3 = Colors.Red
        end
    end)

    -- ============================================
    -- ВЫПОЛНЕНИЕ СКРИПТОВ
    -- ============================================
    execBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then return end
        local code = scriptBox.Text
        if code == "" or code == nil then
            status.Text = "⚠ Скрипт пуст!"
            status.TextColor3 = Colors.Gold
            return
        end
        
        status.Text = "⏳ Выполнение..."
        status.TextColor3 = Colors.Gold
        
        local fn, err = loadstring(code)
        if fn then
            local success, result = pcall(fn)
            if success then
                status.Text = "✅ Скрипт выполнен успешно!"
                status.TextColor3 = Colors.Green
            else
                status.Text = "❌ Ошибка: " .. tostring(result)
                status.TextColor3 = Colors.Red
            end
        else
            status.Text = "❌ Ошибка компиляции: " .. tostring(err)
            status.TextColor3 = Colors.Red
        end
    end)

    -- Выполнение по Enter
    scriptBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and KeySystem.Active then
            execBtn.MouseButton1Click:Fire()
        end
    end)

    -- ============================================
    -- СКАНИРОВАНИЕ ВСЕГО
    -- ============================================
    scanBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then return end
        status.Text = "🔍 Сканирование всех файлов..."
        status.TextColor3 = Colors.Gold
        resultsBox.Visible = false
        
        for _, child in ipairs(resultsBox:GetChildren()) do
            if child:IsA("TextLabel") then child:Destroy() end
        end
        
        local results = ScanAllForBackdoors()
        
        if #results == 0 then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 30)
            label.Text = "✅ Бекдоров не найдено! 🎄"
            label.TextColor3 = Colors.Green
            label.TextScaled = true
            label.Font = Enum.Font.Gotham
            label.Parent = resultsBox
        else
            local count = 0
            for i, res in ipairs(results) do
                if i > 30 then break end
                count = count + 1
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 25)
                local riskIcon = res.Risk == "КРИТИЧНЫЙ" and "🔥" or 
                                res.Risk == "Высокий" and "⚠" or 
                                res.Risk == "Средний" and "⚡" or "✅"
                label.Text = string.format("%s [%s] %s (%s) - %s", 
                    riskIcon,
                    res.Risk, 
                    res.Name, 
                    res.Type or res.Class,
                    table.concat(res.Backdoors, ", "))
                label.TextColor3 = res.Risk == "КРИТИЧНЫЙ" and Colors.Red or 
                                    res.Risk == "Высокий" and Colors.Gold or 
                                    res.Risk == "Средний" and Color3.fromRGB(255, 165, 0) or 
                                    Colors.Green
                label.TextScaled = true
                label.Font = Enum.Font.Gotham
                label.Parent = resultsBox
            end
        end
        
        resultsBox.Visible = true
        status.Text = string.format("🎄 Найдено угроз: %d", #results)
        status.TextColor3 = #results > 0 and Colors.Gold or Colors.Green
    end)

    -- ============================================
    -- ЗАКРЫТИЕ
    -- ============================================
    closeBtn.MouseButton1Click:Connect(function()
        local closeTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, -300, 0.5, -200)
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            gui:Destroy()
            KeySystem.IsOpen = false
            CreateToggleIcon()
        end)
    end)
end

-- ============================================
-- ЗАПУСК
-- ============================================
local oldGUI = guiService:FindFirstChild("SWILL_KeyGUI")
if oldGUI then oldGUI:Destroy() end

local oldIcon = guiService:FindFirstChild("SWILL_Icon")
if oldIcon then oldIcon:Destroy() end

CreateMainGUI()
print("[SWILL] Новогодняя версия загружена! 🎄 Ключ: Yrdhhdbxxnvdb")
