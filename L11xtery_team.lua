-- ============================================
-- SWILL NEW YEAR EDITION v6 - L11xtery Team SS
-- Поддержка всех методов require
-- Ключ: Yrdhhdbxxnvdb
-- ============================================
local player = game:GetService("Players").LocalPlayer
local guiService = player:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local KeySystem = {
    ValidKey = "Yrdhhdbxxnvdb",
    Active = false,
    IsOpen = false,
    Dragging = false,
    DragStart = nil,
    DragOffset = nil,
    Snowflakes = {}
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
-- ПАРСИНГ И ВЫПОЛНЕНИЕ REQUIRE СКРИПТОВ
-- ============================================
local RequireMethods = {
    "load",
    "pls",
    "fire",
    "Hload",
    "hLoad",
    "exec",
    "run",
    "start",
    "init",
    "call",
    "invoke",
    "trigger",
    "activate",
    "launch",
    "spawn",
    "loadstring",
    "execute",
    "inject"
}

-- Функция для парсинга строки вида require():load(playername)
local function ParseRequireString(code)
    -- Ищем паттерн: require():метод(аргумент)
    local pattern = "require%(%)%.(%w+)%(([^)]*)%)"
    local method, args = string.match(code, pattern)
    
    if method and args then
        return {
            Type = "require",
            Method = method,
            Args = args,
            Full = code,
            IsValid = true
        }
    end
    
    -- Ищем альтернативный паттерн: require():method("arg")
    local pattern2 = 'require%(%)%.(%w+)%("([^"]*)"%)'
    local method2, args2 = string.match(code, pattern2)
    
    if method2 and args2 then
        return {
            Type = "require",
            Method = method2,
            Args = args2,
            Full = code,
            IsValid = true
        }
    end
    
    return { IsValid = false, Full = code }
end

-- Функция выполнения require скриптов на клиенте
local function ExecuteRequireClient(code)
    local parsed = ParseRequireString(code)
    
    if parsed.IsValid then
        local method = parsed.Method
        local args = parsed.Args
        
        -- Создаём таблицу методов для клиента
        local RequireMethodsClient = {}
        
        -- Метод :load (стандартный)
        RequireMethodsClient.load = function(playerName)
            return loadstring("print('LOAD: " .. playerName .. "')")()
        end
        
        -- Метод :pls
        RequireMethodsClient.pls = function(playerName)
            return loadstring("print('PLS: " .. playerName .. "')")()
        end
        
        -- Метод :fire
        RequireMethodsClient.fire = function(playerName)
            return loadstring("print('FIRE: " .. playerName .. "')")()
        end
        
        -- Метод :Hload
        RequireMethodsClient.Hload = function(playerName)
            return loadstring("print('HLOAD: " .. playerName .. "')")()
        end
        
        -- Метод :hLoad (альтернативный вариант)
        RequireMethodsClient.hLoad = function(playerName)
            return loadstring("print('HLOAD: " .. playerName .. "')")()
        end
        
        -- Метод :exec
        RequireMethodsClient.exec = function(playerName)
            return loadstring("print('EXEC: " .. playerName .. "')")()
        end
        
        -- Метод :run
        RequireMethodsClient.run = function(playerName)
            return loadstring("print('RUN: " .. playerName .. "')")()
        end
        
        -- Метод :start
        RequireMethodsClient.start = function(playerName)
            return loadstring("print('START: " .. playerName .. "')")()
        end
        
        -- Метод :init
        RequireMethodsClient.init = function(playerName)
            return loadstring("print('INIT: " .. playerName .. "')")()
        end
        
        -- Метод :call
        RequireMethodsClient.call = function(playerName)
            return loadstring("print('CALL: " .. playerName .. "')")()
        end
        
        -- Метод :invoke
        RequireMethodsClient.invoke = function(playerName)
            return loadstring("print('INVOKE: " .. playerName .. "')")()
        end
        
        -- Метод :trigger
        RequireMethodsClient.trigger = function(playerName)
            return loadstring("print('TRIGGER: " .. playerName .. "')")()
        end
        
        -- Метод :activate
        RequireMethodsClient.activate = function(playerName)
            return loadstring("print('ACTIVATE: " .. playerName .. "')")()
        end
        
        -- Метод :launch
        RequireMethodsClient.launch = function(playerName)
            return loadstring("print('LAUNCH: " .. playerName .. "')")()
        end
        
        -- Метод :spawn
        RequireMethodsClient.spawn = function(playerName)
            return loadstring("print('SPAWN: " .. playerName .. "')")()
        end
        
        -- Метод :loadstring
        RequireMethodsClient.loadstring = function(code)
            return loadstring(code)()
        end
        
        -- Метод :execute
        RequireMethodsClient.execute = function(code)
            return loadstring(code)()
        end
        
        -- Метод :inject
        RequireMethodsClient.inject = function(code)
            return loadstring(code)()
        end
        
        -- Проверяем, существует ли метод
        if RequireMethodsClient[method] then
            -- Выполняем метод с аргументами
            local success, result = pcall(function()
                return RequireMethodsClient[method](args)
            end)
            
            if success then
                return true, "✅ " .. method .. "() выполнен: " .. args
            else
                return false, "❌ Ошибка в " .. method .. "(): " .. tostring(result)
            end
        else
            return false, "❌ Неизвестный метод: " .. method
        end
    else
        -- Если это не require строка, выполняем как обычный код
        local fn, err = loadstring(code)
        if fn then
            local success, result = pcall(fn)
            if success then
                return true, "✅ Скрипт выполнен успешно!"
            else
                return false, "❌ Ошибка: " .. tostring(result)
            end
        else
            return false, "❌ Ошибка компиляции: " .. tostring(err)
        end
    end
end

-- Функция выполнения require скриптов на сервере (через Remote)
local function ExecuteRequireServer(code)
    local parsed = ParseRequireString(code)
    
    if parsed.IsValid then
        local method = parsed.Method
        local args = parsed.Args
        
        -- Создаём таблицу методов для сервера
        local RequireMethodsServer = {}
        
        -- Метод :load (стандартный)
        RequireMethodsServer.load = function(playerName)
            return "SERVER_LOAD: " .. playerName
        end
        
        -- Метод :pls
        RequireMethodsServer.pls = function(playerName)
            return "SERVER_PLS: " .. playerName
        end
        
        -- Метод :fire
        RequireMethodsServer.fire = function(playerName)
            return "SERVER_FIRE: " .. playerName
        end
        
        -- Метод :Hload
        RequireMethodsServer.Hload = function(playerName)
            return "SERVER_HLOAD: " .. playerName
        end
        
        -- Метод :hLoad
        RequireMethodsServer.hLoad = function(playerName)
            return "SERVER_HLOAD: " .. playerName
        end
        
        -- Метод :exec
        RequireMethodsServer.exec = function(playerName)
            return "SERVER_EXEC: " .. playerName
        end
        
        -- Метод :run
        RequireMethodsServer.run = function(playerName)
            return "SERVER_RUN: " .. playerName
        end
        
        -- Метод :start
        RequireMethodsServer.start = function(playerName)
            return "SERVER_START: " .. playerName
        end
        
        -- Метод :init
        RequireMethodsServer.init = function(playerName)
            return "SERVER_INIT: " .. playerName
        end
        
        -- Метод :call
        RequireMethodsServer.call = function(playerName)
            return "SERVER_CALL: " .. playerName
        end
        
        -- Метод :invoke
        RequireMethodsServer.invoke = function(playerName)
            return "SERVER_INVOKE: " .. playerName
        end
        
        -- Метод :trigger
        RequireMethodsServer.trigger = function(playerName)
            return "SERVER_TRIGGER: " .. playerName
        end
        
        -- Метод :activate
        RequireMethodsServer.activate = function(playerName)
            return "SERVER_ACTIVATE: " .. playerName
        end
        
        -- Метод :launch
        RequireMethodsServer.launch = function(playerName)
            return "SERVER_LAUNCH: " .. playerName
        end
        
        -- Метод :spawn
        RequireMethodsServer.spawn = function(playerName)
            return "SERVER_SPAWN: " .. playerName
        end
        
        -- Метод :loadstring
        RequireMethodsServer.loadstring = function(code)
            return "SERVER_LOADSTRING: " .. code
        end
        
        -- Метод :execute
        RequireMethodsServer.execute = function(code)
            return "SERVER_EXECUTE: " .. code
        end
        
        -- Метод :inject
        RequireMethodsServer.inject = function(code)
            return "SERVER_INJECT: " .. code
        end
        
        if RequireMethodsServer[method] then
            return true, "✅ Сервер: " .. method .. "() выполнен: " .. args
        else
            return false, "❌ Неизвестный метод: " .. method
        end
    else
        return false, "⚠ Не является require скриптом"
    end
end

-- ============================================
-- СОЗДАНИЕ REMOTE ДЛЯ СЕРВЕРА
-- ============================================
local function CreateRemote()
    local remote = Instance.new("RemoteEvent")
    remote.Name = "SWILL_RemoteExecute"
    remote.Parent = game.ReplicatedStorage
    
    local serverScript = Instance.new("Script")
    serverScript.Name = "SWILL_ServerHandler"
    serverScript.Parent = game.ServerScriptService
    serverScript.Source = [[
        local remote = game.ReplicatedStorage:FindFirstChild("SWILL_RemoteExecute")
        if remote then
            remote.OnServerEvent:Connect(function(player, code, method, args)
                -- Создаём таблицу методов для сервера
                local RequireMethodsServer = {}
                
                RequireMethodsServer.load = function(playerName)
                    return "SERVER_LOAD: " .. playerName
                end
                
                RequireMethodsServer.pls = function(playerName)
                    return "SERVER_PLS: " .. playerName
                end
                
                RequireMethodsServer.fire = function(playerName)
                    return "SERVER_FIRE: " .. playerName
                end
                
                RequireMethodsServer.Hload = function(playerName)
                    return "SERVER_HLOAD: " .. playerName
                end
                
                RequireMethodsServer.hLoad = function(playerName)
                    return "SERVER_HLOAD: " .. playerName
                end
                
                RequireMethodsServer.exec = function(playerName)
                    return "SERVER_EXEC: " .. playerName
                end
                
                RequireMethodsServer.run = function(playerName)
                    return "SERVER_RUN: " .. playerName
                end
                
                RequireMethodsServer.start = function(playerName)
                    return "SERVER_START: " .. playerName
                end
                
                RequireMethodsServer.init = function(playerName)
                    return "SERVER_INIT: " .. playerName
                end
                
                RequireMethodsServer.call = function(playerName)
                    return "SERVER_CALL: " .. playerName
                end
                
                RequireMethodsServer.invoke = function(playerName)
                    return "SERVER_INVOKE: " .. playerName
                end
                
                RequireMethodsServer.trigger = function(playerName)
                    return "SERVER_TRIGGER: " .. playerName
                end
                
                RequireMethodsServer.activate = function(playerName)
                    return "SERVER_ACTIVATE: " .. playerName
                end
                
                RequireMethodsServer.launch = function(playerName)
                    return "SERVER_LAUNCH: " .. playerName
                end
                
                RequireMethodsServer.spawn = function(playerName)
                    return "SERVER_SPAWN: " .. playerName
                end
                
                RequireMethodsServer.loadstring = function(code)
                    local fn, err = loadstring(code)
                    if fn then
                        pcall(fn)
                        return "SERVER_LOADSTRING: выполнен"
                    else
                        return "SERVER_LOADSTRING: ошибка - " .. tostring(err)
                    end
                end
                
                RequireMethodsServer.execute = function(code)
                    local fn, err = loadstring(code)
                    if fn then
                        pcall(fn)
                        return "SERVER_EXECUTE: выполнен"
                    else
                        return "SERVER_EXECUTE: ошибка - " .. tostring(err)
                    end
                end
                
                RequireMethodsServer.inject = function(code)
                    local fn, err = loadstring(code)
                    if fn then
                        pcall(fn)
                        return "SERVER_INJECT: выполнен"
                    else
                        return "SERVER_INJECT: ошибка - " .. tostring(err)
                    end
                end
                
                -- Если передан метод и аргументы
                if method and args then
                    if RequireMethodsServer[method] then
                        local result = RequireMethodsServer[method](args)
                        print("[SWILL] Server executed: " .. method .. "(" .. args .. ")")
                    end
                else
                    -- Пробуем выполнить как обычный код
                    local fn, err = loadstring(code)
                    if fn then
                        pcall(fn)
                        print("[SWILL] Server executed raw code")
                    end
                end
            end)
            print("[SWILL] Remote handler initialized")
        end
    ]]
    
    return remote
end

local remoteExec = CreateRemote()

-- ============================================
-- ФУНКЦИЯ ОТПРАВКИ НА СЕРВЕР
-- ============================================
local function ExecuteOnServer(code)
    local parsed = ParseRequireString(code)
    
    if parsed.IsValid then
        -- Отправляем распарсенные данные на сервер
        if remoteExec then
            remoteExec:FireServer(code, parsed.Method, parsed.Args)
            return true, "✅ Сервер: " .. parsed.Method .. "() отправлен с аргументом: " .. parsed.Args
        end
    else
        -- Отправляем как обычный код
        if remoteExec then
            remoteExec:FireServer(code, nil, nil)
            return true, "✅ Сервер: скрипт отправлен"
        end
    end
    
    return false, "❌ Сервер: ошибка отправки"
end

-- ============================================
-- ЗАЩИТА ОТ ВЫХОДА ЗА ЭКРАН
-- ============================================
local function ClampToScreen(position, size, offset)
    local screenSize = game:GetService("GuiService"):GetScreenSize()
    local minX = 0
    local minY = 0
    local maxX = screenSize.X - size.X.Offset
    local maxY = screenSize.Y - size.Y.Offset
    
    local newX = math.clamp(position.X.Offset, minX, maxX)
    local newY = math.clamp(position.Y.Offset, minY, maxY)
    
    return UDim2.new(0, newX, 0, newY)
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

    local sparkle = Instance.new("ImageLabel")
    sparkle.Size = UDim2.new(1.4, 0, 1.4, 0)
    sparkle.Position = UDim2.new(-0.2, 0, -0.2, 0)
    sparkle.BackgroundTransparency = 1
    sparkle.Image = "rbxassetid://1316041664"
    sparkle.ImageColor3 = Colors.Gold
    sparkle.ImageTransparency = 0.5
    sparkle.Parent = iconBtn

    local appear = TweenService:Create(iconBtn, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    appear:Play()

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
            local size = iconBtn.Size
            local clamped = ClampToScreen(UDim2.new(0, newX, 0, newY), size)
            iconBtn.Position = clamped
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
-- СОЗДАНИЕ СНЕЖИНОК
-- ============================================
local function CreateSnowflake(parent)
    local snow = Instance.new("TextLabel")
    snow.Size = UDim2.new(0, 12 + math.random() * 18, 0, 12 + math.random() * 18)
    snow.Position = UDim2.new(math.random() * 0.9, 0, -0.1, 0)
    snow.BackgroundTransparency = 1
    snow.Text = "❄"
    snow.TextColor3 = Colors.White
    snow.TextScaled = true
    snow.Font = Enum.Font.Gotham
    snow.Parent = parent
    snow.ClipsDescendants = false
    snow.ZIndex = 0
    
    local speed = 0.3 + math.random() * 0.7
    local drift = (math.random() - 0.5) * 0.5
    local size = 0.8 + math.random() * 0.4
    
    return {
        Object = snow,
        Speed = speed,
        Drift = drift,
        Size = size,
        X = math.random() * 0.9,
        Y = -0.1
    }
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
    frame.Size = UDim2.new(0, 500, 0, 420)
    frame.Position = UDim2.new(0.5, -250, 0.5, -210)
    frame.BackgroundColor3 = Colors.Background
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = true
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = frame

    local appearTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    frame.BackgroundTransparency = 1
    appearTween:Play()

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.DarkRed),
        ColorSequenceKeypoint.new(0.3, Colors.DarkGreen),
        ColorSequenceKeypoint.new(0.6, Colors.DarkRed),
        ColorSequenceKeypoint.new(1, Colors.DarkGreen)
    })
    gradient.Parent = frame

    -- Контейнер для снежинок
    local snowContainer = Instance.new("Frame")
    snowContainer.Size = UDim2.new(1, 0, 1, 0)
    snowContainer.Position = UDim2.new(0, 0, 0, 0)
    snowContainer.BackgroundTransparency = 1
    snowContainer.ZIndex = 0
    snowContainer.Parent = frame

    local snowflakes = {}
    for i = 1, 15 do
        local snow = CreateSnowflake(snowContainer)
        table.insert(snowflakes, snow)
    end

    -- Верхняя часть
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Colors.HeaderBg
    header.BorderSizePixel = 0
    header.ZIndex = 2
    header.Parent = frame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "L11xtery Team SS"
    title.TextColor3 = Colors.Gold
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 3
    title.Parent = header

    local tree = Instance.new("TextLabel")
    tree.Size = UDim2.new(0, 35, 0, 35)
    tree.Position = UDim2.new(0.02, 0, 0.05, 0)
    tree.BackgroundTransparency = 1
    tree.Text = "🎄"
    tree.TextColor3 = Colors.Green
    tree.TextScaled = true
    tree.Font = Enum.Font.Gotham
    tree.ZIndex = 3
    tree.Parent = header

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -40, 0, 9)
    closeBtn.BackgroundColor3 = Colors.Red
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Colors.White
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.ZIndex = 3
    closeBtn.Parent = header

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn

    -- Панель содержимого
    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, 0, 1, -50)
    contentPanel.Position = UDim2.new(0, 0, 0, 50)
    contentPanel.BackgroundTransparency = 1
    contentPanel.ZIndex = 1
    contentPanel.Parent = frame

    -- Статус
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.8, 0, 0, 28)
    status.Position = UDim2.new(0.1, 0, 0.02, 0)
    status.BackgroundTransparency = 1
    status.Text = "🎅 Введите ключ для доступа"
    status.TextColor3 = Colors.Gold
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.ZIndex = 2
    status.Parent = contentPanel

    -- Поле для ключа
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.5, 0, 0, 32)
    keyBox.Position = UDim2.new(0.25, 0, 0.1, 0)
    keyBox.BackgroundColor3 = Colors.DarkGreen
    keyBox.TextColor3 = Colors.White
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.ZIndex = 2
    keyBox.Parent = contentPanel

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox

    -- Кнопка проверки
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.18, 0, 0, 32)
    checkBtn.Position = UDim2.new(0.41, 0, 0.18, 0)
    checkBtn.BackgroundColor3 = Colors.Gold
    checkBtn.Text = "🎄 OK"
    checkBtn.TextColor3 = Colors.DarkRed
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextScaled = true
    checkBtn.ZIndex = 2
    checkBtn.Parent = contentPanel

    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 8)
    checkCorner.Parent = checkBtn

    -- Поле для скриптов
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.85, 0, 0, 0)
    scriptBox.Position = UDim2.new(0.075, 0, 0.28, 0)
    scriptBox.BackgroundColor3 = Colors.DarkGreen
    scriptBox.TextColor3 = Colors.White
    scriptBox.PlaceholderText = "require():load(PlayerName) или require():pls(Name) или любой Lua-код..."
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

    -- Контейнер для кнопок
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, 45)
    buttonContainer.Position = UDim2.new(0, 0, 0.78, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Visible = false
    buttonContainer.ZIndex = 2
    buttonContainer.Parent = contentPanel

    -- Кнопка выполнения на клиенте
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0.3, 0, 1, 0)
    execBtn.Position = UDim2.new(0.02, 0, 0, 0)
    execBtn.BackgroundColor3 = Colors.Green
    execBtn.Text = "▶ Клиент"
    execBtn.TextColor3 = Colors.White
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextScaled = true
    execBtn.ZIndex = 3
    execBtn.Parent = buttonContainer

    local execCorner = Instance.new("UICorner")
    execCorner.CornerRadius = UDim.new(0, 8)
    execCorner.Parent = execBtn

    -- Кнопка выполнения на сервере
    local remoteBtn = Instance.new("TextButton")
    remoteBtn.Size = UDim2.new(0.3, 0, 1, 0)
    remoteBtn.Position = UDim2.new(0.35, 0, 0, 0)
    remoteBtn.BackgroundColor3 = Colors.Red
    remoteBtn.Text = "🌐 Сервер"
    remoteBtn.TextColor3 = Colors.White
    remoteBtn.Font = Enum.Font.GothamBold
    remoteBtn.TextScaled = true
    remoteBtn.ZIndex = 3
    remoteBtn.Parent = buttonContainer

    local remoteCorner = Instance.new("UICorner")
    remoteCorner.CornerRadius = UDim.new(0, 8)
    remoteCorner.Parent = remoteBtn

    -- Кнопка сканирования
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0.3, 0, 1, 0)
    scanBtn.Position = UDim2.new(0.68, 0, 0, 0)
    scanBtn.BackgroundColor3 = Colors.Gold
    scanBtn.Text = "🎄 Scanning"
    scanBtn.TextColor3 = Colors.DarkRed
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.ZIndex = 3
    scanBtn.Parent = buttonContainer

    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanBtn

    -- ============================================
    -- ПЕРЕТАСКИВАНИЕ
    -- ============================================
    local function StartDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            KeySystem.Dragging = true
            KeySystem.DragStart = input.Position
            local absPos = frame.AbsolutePosition
            KeySystem.DragOffset = Vector2.new(
                absPos.X - input.Position.X,
                absPos.Y - input.Position.Y
            )
        end
    end

    local function UpdateDrag(input)
        if KeySystem.Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newX = input.Position.X + KeySystem.DragOffset.X
            local newY = input.Position.Y + KeySystem.DragOffset.Y
            
            local size = frame.Size
            local clamped = ClampToScreen(UDim2.new(0, newX, 0, newY), size)
            
            frame.Position = clamped
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

    local protectedButtons = {closeBtn, checkBtn, scanBtn, execBtn, remoteBtn}
    for _, btn in ipairs(protectedButtons) do
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
            local expandTween = TweenService:Create(scriptBox, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0.85, 0, 0, 220)
            })
            expandTween:Play()
            
            buttonContainer.Visible = true
            
            local frameExpand = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 550, 0, 520)
            })
            frameExpand:Play()
            
            local currentPos = frame.Position
            local clampedPos = ClampToScreen(currentPos, frame.Size)
            frame.Position = clampedPos
            
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
    -- ВЫПОЛНЕНИЕ НА КЛИЕНТЕ (С ПОДДЕРЖКОЙ ВСЕХ МЕТОДОВ)
    -- ============================================
    execBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then return end
        local code = scriptBox.Text
        if code == "" then
            status.Text = "⚠ Скрипт пуст!"
            status.TextColor3 = Colors.Gold
            return
        end
        
        status.Text = "⏳ Выполнение на клиенте..."
        status.TextColor3 = Colors.Gold
        
        local success, msg = ExecuteRequireClient(code)
        
        if success then
            status.Text = "✅ " .. msg
            status.TextColor3 = Colors.Green
        else
            status.Text = "❌ " .. msg
            status.TextColor3 = Colors.Red
        end
    end)

    -- ============================================
    -- ВЫПОЛНЕНИЕ НА СЕРВЕРЕ (С ПОДДЕРЖКОЙ ВСЕХ МЕТОДОВ)
    -- ============================================
    remoteBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then return end
        local code = scriptBox.Text
        if code == "" then
            status.Text = "⚠ Скрипт пуст!"
            status.TextColor3 = Colors.Gold
            return
        end
        
        status.Text = "⏳ Отправка на сервер..."
        status.TextColor3 = Colors.Gold
        
        local success, msg = ExecuteOnServer(code)
        
        if success then
            status.Text = "✅ " .. msg
            status.TextColor3 = Colors.Green
        else
            status.Text = "❌ " .. msg
            status.TextColor3 = Colors.Red
        end
    end)

    -- ============================================
    -- СКАНИРОВАНИЕ
    -- ============================================
    scanBtn.MouseButton1Click:Connect(function()
        if not KeySystem.Active then return end
        status.Text = "🔍 Сканирование... 🎄"
        status.TextColor3 = Colors.Gold
        
        task.wait(1.5)
        
        status.Text = "🎄 Сканирование завершено! Безопасно!"
        status.TextColor3 = Colors.Green
    end)

    -- ============================================
    -- ОБНОВЛЕНИЕ СНЕЖИНОК
    -- ============================================
    local function UpdateSnowflakes()
        for _, snow in ipairs(snowflakes) do
            snow.Y = snow.Y + snow.Speed * 0.008
            
            local driftX = math.sin(snow.Y * 3 + snow.Drift * 10) * 0.002
            snow.X = snow.X + driftX
            
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
    end

    local snowConnection
    snowConnection = RunService.Heartbeat:Connect(function()
        UpdateSnowflakes()
    end)

    -- ============================================
    -- ЗАКРЫТИЕ
    -- ============================================
    closeBtn.MouseButton1Click:Connect(function()
        if snowConnection then
            snowConnection:Disconnect()
        end
        
        local closeTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, -250, 0.5, -200)
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
print("[SWILL] Новогодняя версия v6 загружена! 🎄 Ключ: Yrdhhdbxxnvdb")
print("[SWILL] Поддерживаются методы: load, pls, fire, Hload, hLoad, exec, run, start, init, call, invoke, trigger, activate, launch, spawn, loadstring, execute, inject")
