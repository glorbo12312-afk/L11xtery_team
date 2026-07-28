-- ============================================
-- SWILL ULTIMATE PRO v2 - L11xtery Team SS
-- Ключ: Yrdhhdbxxnvdb
-- ============================================
local player = game:GetService("Players").LocalPlayer
local guiService = player:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local KeySystem = {
    ValidKey = "Yrdhhdbxxnvdb",
    Active = false,
    Hidden = false,
    Dragging = false,
    DragStart = nil,
    DragOffset = nil
}

-- Функция сканирования на бекдоры
local function ScanForBackdoors()
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
        "task%.wait", "task%.delay", "task%.spawn", "task%.defer", "task%.sync", "task%.wake"
    }

    local function ScanInstance(instance, path)
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
                    Name = instance.Name,
                    Path = path,
                    Class = instance.ClassName,
                    Backdoors = found,
                    Risk = #found > 5 and "Высокий" or #found > 2 and "Средний" or "Низкий"
                })
            end
        end
        for _, child in ipairs(instance:GetChildren()) do
            ScanInstance(child, path .. " > " .. child.Name)
        end
    end

    ScanInstance(game, "game")
    return results
end

-- СОЗДАНИЕ GUI
local function CreateGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "SWILL_KeyGUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = guiService

    -- Основной фрейм (скруглённый)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 600, 0, 520)
    frame.Position = UDim2.new(0.5, -300, 0.5, -260)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = true
    frame.Parent = gui

    -- Скругление углов (корневое)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    -- Анимация появления
    local appearTween = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Position = UDim2.new(0.5, -300, 0.5, -260)
    })
    frame.BackgroundTransparency = 1
    appearTween:Play()

    -- Градиентный фон
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 40))
    })
    gradient.Parent = frame

    -- ВЕРХНЯЯ ЧАСТЬ: L11xtery Team SS
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 55)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(45, 30, 80)
    header.BorderSizePixel = 0
    header.Parent = frame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    -- Заголовок L11xtery Team SS
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "L11xtery Team SS"
    title.TextColor3 = Color3.fromRGB(200, 180, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = header

    -- Подзаголовок
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 30)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Secure System"
    subtitle.TextColor3 = Color3.fromRGB(150, 130, 200)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = header

    -- Панель содержимого
    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, 0, 1, -55)
    contentPanel.Position = UDim2.new(0, 0, 0, 55)
    contentPanel.BackgroundTransparency = 1
    contentPanel.Parent = frame

    -- Кнопка скрыть/показать (в заголовке)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 70, 0, 25)
    toggleBtn.Position = UDim2.new(0.82, 0, 0.02, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
    toggleBtn.Text = "Скрыть"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextScaled = true
    toggleBtn.Parent = header

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleBtn

    -- Поле для ключа (скруглённое)
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.6, 0, 0, 40)
    keyBox.Position = UDim2.new(0.2, 0, 0.08, 0)
    keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.Parent = contentPanel

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox

    -- Кнопка проверки (скруглённая)
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.2, 0, 0, 40)
    checkBtn.Position = UDim2.new(0.4, 0, 0.2, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    checkBtn.Text = "Активировать"
    checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextScaled = true
    checkBtn.Parent = contentPanel

    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 8)
    checkCorner.Parent = checkBtn

    -- Кнопка сканирования (скруглённая)
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0.3, 0, 0, 40)
    scanBtn.Position = UDim2.new(0.35, 0, 0.45, 0)
    scanBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    scanBtn.Text = "Сканировать бекдоры"
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.Visible = false
    scanBtn.Parent = contentPanel

    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanBtn

    -- Результаты сканирования
    local resultsBox = Instance.new("ScrollingFrame")
    resultsBox.Size = UDim2.new(0.9, 0, 0.25, 0)
    resultsBox.Position = UDim2.new(0.05, 0, 0.7, 0)
    resultsBox.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    resultsBox.BorderSizePixel = 0
    resultsBox.Visible = false
    resultsBox.Parent = contentPanel

    local resultsCorner = Instance.new("UICorner")
    resultsCorner.CornerRadius = UDim.new(0, 6)
    resultsCorner.Parent = resultsBox

    local resultsList = Instance.new("UIListLayout")
    resultsList.Padding = UDim.new(0, 2)
    resultsList.Parent = resultsBox

    -- Статус
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.8, 0, 0, 30)
    status.Position = UDim2.new(0.1, 0, 0.35, 0)
    status.BackgroundTransparency = 1
    status.Text = "Ожидание ключа..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.Parent = contentPanel

    -- Кнопка закрытия (скруглённая)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -40, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.Parent = header

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    -- Кнопка сворачивания (скруглённая)
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -75, 0, 2)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
    minimizeBtn.Text = "─"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextScaled = true
    minimizeBtn.Parent = header

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minimizeBtn

    -- ============================================
    -- ПЕРЕТАСКИВАНИЕ GUI
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
            frame.Position = UDim2.new(0, newX, 0, newY)
        end
    end

    local function EndDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            KeySystem.Dragging = false
        end
    end

    -- Перетаскивание через заголовок
    header.InputBegan:Connect(StartDrag)
    header.InputChanged:Connect(UpdateDrag)
    header.InputEnded:Connect(EndDrag)

    -- Для всех элементов в заголовке (кроме кнопок)
    for _, child in ipairs(header:GetChildren()) do
        if child:IsA("TextButton") then
            child.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    input:StopPropagation()
                end
            end)
        end
    end

    -- ============================================
    -- ЛОГИКА СКРЫТИЯ
    -- ============================================
    local isHidden = false
    toggleBtn.MouseButton1Click:Connect(function()
        isHidden = not isHidden
        local targetSize = isHidden and UDim2.new(0, 0, 0, 0) or UDim2.new(1, 0, 1, -55)
        
        local hideTween = TweenService:Create(contentPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = targetSize,
            BackgroundTransparency = isHidden and 0 or 1
        })
        hideTween:Play()
        
        toggleBtn.Text = isHidden and "Показать" or "Скрыть"
        local newSize = isHidden and UDim2.new(0, 200, 0, 55) or UDim2.new(0, 600, 0, 520)
        local newPos = isHidden and UDim2.new(1, -210, 0, 10) or UDim2.new(0.5, -300, 0.5, -260)
        
        local resizeTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = newSize,
            Position = newPos
        })
        resizeTween:Play()
    end)

    minimizeBtn.MouseButton1Click:Connect(function()
        toggleBtn.MouseButton1Click:Fire()
    end)

    -- ============================================
    -- ЛОГИКА КЛЮЧА
    -- ============================================
    checkBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == KeySystem.ValidKey then
            KeySystem.Active = true
            status.Text = "Доступ открыт!"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
            checkBtn.Visible = false
            keyBox.Visible = false
            scanBtn.Visible = true
        else
            status.Text = "Неверный ключ!"
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)

    -- ============================================
    -- СКАНИРОВАНИЕ
    -- ============================================
    scanBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then return end
        status.Text = "Сканирование..."
        status.TextColor3 = Color3.fromRGB(255, 200, 0)
        resultsBox.Visible = false
        
        for _, child in ipairs(resultsBox:GetChildren()) do
            if child:IsA("TextLabel") then child:Destroy() end
        end
        
        local results = ScanForBackdoors()
        
        if #results == 0 then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 30)
            label.Text = "✅ Бекдоров не найдено!"
            label.TextColor3 = Color3.fromRGB(0, 255, 0)
            label.TextScaled = true
            label.Parent = resultsBox
        else
            for i, res in ipairs(results) do
                if i > 20 then break end
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 25)
                label.Text = string.format("[%s] %s (%s) - %s", res.Risk, res.Name, res.Class, table.concat(res.Backdoors, ", "))
                label.TextColor3 = res.Risk == "Высокий" and Color3.fromRGB(255, 0, 0) or 
                                    res.Risk == "Средний" and Color3.fromRGB(255, 200, 0) or 
                                    Color3.fromRGB(0, 255, 0)
                label.TextScaled = true
                label.Font = Enum.Font.Gotham
                label.Parent = resultsBox
            end
        end
        
        resultsBox.Visible = true
        status.Text = string.format("Найдено скриптов с бекдорами: %d", #results)
        status.TextColor3 = #results > 0 and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 0)
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
            -- Создаём иконку "L" для открытия
            CreateToggleIcon()
        end)
    end)
end

-- ============================================
-- ИКОНКА "L" ДЛЯ ОТКРЫТИЯ
-- ============================================
local function CreateToggleIcon()
    local iconGui = Instance.new("ScreenGui")
    iconGui.Name = "SWILL_Icon"
    iconGui.ResetOnSpawn = false
    iconGui.IgnoreGuiInset = true
    iconGui.Parent = guiService

    local iconBtn = Instance.new("TextButton")
    iconBtn.Size = UDim2.new(0, 50, 0, 50)
    iconBtn.Position = UDim2.new(0.95, -55, 0.05, 0)
    iconBtn.BackgroundColor3 = Color3.fromRGB(45, 30, 80)
    iconBtn.Text = "L"
    iconBtn.TextColor3 = Color3.fromRGB(200, 180, 255)
    iconBtn.Font = Enum.Font.GothamBold
    iconBtn.TextScaled = true
    iconBtn.Parent = iconGui

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 12)
    iconCorner.Parent = iconBtn

    -- Анимация появления
    iconBtn.BackgroundTransparency = 1
    local appear = TweenService:Create(iconBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    appear:Play()

    -- Открытие GUI при нажатии
    iconBtn.MouseButton1Click:Connect(function()
        iconGui:Destroy()
        CreateGUI()
    end)

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
end

-- ============================================
-- ЗАПУСК
-- ============================================
-- Проверяем, есть ли уже GUI
if guiService:FindFirstChild("SWILL_KeyGUI") then
    guiService.SWILL_KeyGUI:Destroy()
end

-- Проверяем, есть ли иконка
if guiService:FindFirstChild("SWILL_Icon") then
    guiService.SWILL_Icon:Destroy()
end

CreateGUI()
print("[SWILL] L11xtery Team SS загружен. Ключ: Yrdhhdbxxnvdb")
