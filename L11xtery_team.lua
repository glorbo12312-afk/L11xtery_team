-- ============================================================
-- L11xtery Team SS (FULLY FIXED)
-- Версия: 2.0
-- Разработчик: L11xteryTeam
-- РАБОТАЕТ НА ЛЮБОМ ИНЖЕКТОРЕ
-- ============================================================

-- === СЕРВИСЫ ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- === ПРОВЕРКА ЗАГРУЗКИ ===
if not LocalPlayer then
    error("[L11xtery] LocalPlayer не найден!")
end

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

-- === ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ===
_G.L11xterySS = {
    Key = "L11xteryteam001",
    Access = false,
    GUI = nil
}

-- === ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ===
local function getHumanoid(player)
    if not player or not player.Character then return nil end
    return player.Character:FindFirstChild("Humanoid")
end

local function getHRP(player)
    if not player or not player.Character then return nil end
    return player.Character:FindFirstChild("HumanoidRootPart")
end

-- === СОЗДАНИЕ ГЛАВНОГО GUI ===
local function createMainGUI()
    local success, err = pcall(function()
        -- Удаляем старый GUI если есть
        local oldGui = LocalPlayer.PlayerGui:FindFirstChild("L11xterySS")
        if oldGui then oldGui:Destroy() end
        
        -- ОСНОВНОЙ ЭКРАН
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "L11xterySS"
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        -- ГЛАВНОЕ ОКНО
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 450, 0, 350)
        mainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        mainFrame.BackgroundTransparency = 0.05
        mainFrame.BorderSizePixel = 2
        mainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
        mainFrame.Active = true
        mainFrame.Draggable = true
        mainFrame.ClipsDescendants = true
        mainFrame.Parent = screenGui
        
        -- ЗАГОЛОВОК
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 45)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        title.BorderSizePixel = 0
        title.Text = "🎄 L11xtery Team SS"
        title.TextColor3 = Color3.fromRGB(255, 215, 0)
        title.TextSize = 24
        title.Font = Enum.Font.GothamBold
        title.Parent = mainFrame
        
        -- ПОДЗАГОЛОВОК
        local subtitle = Instance.new("TextLabel")
        subtitle.Size = UDim2.new(1, 0, 0, 20)
        subtitle.Position = UDim2.new(0, 0, 0, 45)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "by L11xteryTeam"
        subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        subtitle.TextSize = 12
        subtitle.Font = Enum.Font.Gotham
        subtitle.Parent = mainFrame
        
        -- РАЗДЕЛИТЕЛЬ
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, -20, 0, 2)
        line.Position = UDim2.new(0, 10, 0, 70)
        line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        line.BorderSizePixel = 0
        line.Parent = mainFrame
        
        -- СТАТУС
        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(0.9, 0, 0, 30)
        status.Position = UDim2.new(0.05, 0, 0.2, 0)
        status.BackgroundTransparency = 1
        status.Text = "🔑 ВВЕДИТЕ КЛЮЧ ДОСТУПА"
        status.TextColor3 = Color3.fromRGB(255, 215, 0)
        status.TextSize = 16
        status.Font = Enum.Font.GothamBold
        status.Parent = mainFrame
        
        -- ПОЛЕ ВВОДА КЛЮЧА
        local keyBox = Instance.new("TextBox")
        keyBox.Size = UDim2.new(0.7, 0, 0, 40)
        keyBox.Position = UDim2.new(0.15, 0, 0.3, 0)
        keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        keyBox.BorderSizePixel = 1
        keyBox.BorderColor3 = Color3.fromRGB(255, 50, 50)
        keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        keyBox.PlaceholderText = "Введите ключ..."
        keyBox.Text = ""
        keyBox.Font = Enum.Font.Gotham
        keyBox.TextSize = 18
        keyBox.ClearTextOnFocus = true
        keyBox.Parent = mainFrame
        
        -- КНОПКА АКТИВАЦИИ
        local activateBtn = Instance.new("TextButton")
        activateBtn.Size = UDim2.new(0.4, 0, 0, 40)
        activateBtn.Position = UDim2.new(0.3, 0, 0.45, 0)
        activateBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        activateBtn.BorderSizePixel = 0
        activateBtn.Text = "🎄 АКТИВИРОВАТЬ"
        activateBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        activateBtn.TextSize = 18
        activateBtn.Font = Enum.Font.GothamBold
        activateBtn.Parent = mainFrame
        
        -- КНОПКИ ДЕЙСТВИЙ (появляются после активации)
        local actionsFrame = Instance.new("Frame")
        actionsFrame.Size = UDim2.new(1, -20, 0, 100)
        actionsFrame.Position = UDim2.new(0, 10, 0, 0.55)
        actionsFrame.BackgroundTransparency = 1
        actionsFrame.Visible = false
        actionsFrame.Parent = mainFrame
        
        -- КНОПКА УБИТЬ ВСЕХ
        local killBtn = Instance.new("TextButton")
        killBtn.Size = UDim2.new(0.4, 0, 0, 35)
        killBtn.Position = UDim2.new(0.05, 0, 0, 0)
        killBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        killBtn.BorderSizePixel = 1
        killBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
        killBtn.Text = "💀 Убить всех"
        killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        killBtn.TextSize = 14
        killBtn.Font = Enum.Font.Gotham
        killBtn.Parent = actionsFrame
        
        killBtn.MouseButton1Click:Connect(function()
            if not _G.L11xterySS.Access then return end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local hum = getHumanoid(player)
                    if hum and hum.Health > 0 then
                        hum.Health = 0
                    end
                end
            end
            status.Text = "💀 Все игроки убиты!"
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
        end)
        
        -- КНОПКА ВЫЛЕЧИТЬСЯ
        local healBtn = Instance.new("TextButton")
        healBtn.Size = UDim2.new(0.4, 0, 0, 35)
        healBtn.Position = UDim2.new(0.55, 0, 0, 0)
        healBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
        healBtn.BorderSizePixel = 1
        healBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
        healBtn.Text = "❤️ Вылечиться"
        healBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        healBtn.TextSize = 14
        healBtn.Font = Enum.Font.Gotham
        healBtn.Parent = actionsFrame
        
        healBtn.MouseButton1Click:Connect(function()
            if not _G.L11xterySS.Access then return end
            local hum = getHumanoid(LocalPlayer)
            if hum then
                hum.Health = hum.MaxHealth
                status.Text = "❤️ Вылечен!"
                status.TextColor3 = Color3.fromRGB(0, 255, 0)
            end
        end)
        
        -- КНОПКА ТЕЛЕПОРТ
        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0.4, 0, 0, 35)
        tpBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
        tpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
        tpBtn.BorderSizePixel = 1
        tpBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
        tpBtn.Text = "📍 Телепорт"
        tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpBtn.TextSize = 14
        tpBtn.Font = Enum.Font.Gotham
        tpBtn.Parent = actionsFrame
        
        tpBtn.MouseButton1Click:Connect(function()
            if not _G.L11xterySS.Access then return end
            local hrp = getHRP(LocalPlayer)
            if hrp then
                hrp.CFrame = CFrame.new(0, 10, 0)
                status.Text = "📍 Телепорт на спавн!"
                status.TextColor3 = Color3.fromRGB(0, 150, 255)
            end
        end)
        
        -- КНОПКА INFINITE YIELD
        local iyBtn = Instance.new("TextButton")
        iyBtn.Size = UDim2.new(0.4, 0, 0, 35)
        iyBtn.Position = UDim2.new(0.55, 0, 0.55, 0)
        iyBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 80)
        iyBtn.BorderSizePixel = 1
        iyBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
        iyBtn.Text = "🔄 Infinite Yield"
        iyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        iyBtn.TextSize = 14
        iyBtn.Font = Enum.Font.Gotham
        iyBtn.Parent = actionsFrame
        
        iyBtn.MouseButton1Click:Connect(function()
            if not _G.L11xterySS.Access then return end
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end)
            status.Text = "🔄 Infinite Yield загружен!"
            status.TextColor3 = Color3.fromRGB(255, 215, 0)
        end)
        
        -- КНОПКА ЗАКРЫТИЯ
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 80, 0, 30)
        closeBtn.Position = UDim2.new(1, -90, 1, -40)
        closeBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        closeBtn.BorderSizePixel = 1
        closeBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
        closeBtn.Text = "Закрыть"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextSize = 14
        closeBtn.Font = Enum.Font.Gotham
        closeBtn.Parent = mainFrame
        
        closeBtn.MouseButton1Click:Connect(function()
            screenGui:Destroy()
            print("[L11xtery] GUI закрыт")
        end)
        
        -- === ЛОГИКА АКТИВАЦИИ ===
        activateBtn.MouseButton1Click:Connect(function()
            if keyBox.Text == _G.L11xterySS.Key then
                _G.L11xterySS.Access = true
                status.Text = "✅ ДОСТУП ОТКРЫТ!"
                status.TextColor3 = Color3.fromRGB(0, 255, 0)
                activateBtn.Visible = false
                keyBox.Visible = false
                actionsFrame.Visible = true
                
                -- Анимация расширения
                local targetSize = UDim2.new(0, 450, 0, 480)
                local targetPos = UDim2.new(0.5, -225, 0.5, -240)
                local sizeTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = targetSize,
                    Position = targetPos
                })
                sizeTween:Play()
                
                print("[L11xtery] ✅ ДОСТУП АКТИВИРОВАН!")
                print("[L11xtery] 📌 Добро пожаловать, L11xteryTeam!")
            else
                status.Text = "❌ НЕВЕРНЫЙ КЛЮЧ!"
                status.TextColor3 = Color3.fromRGB(255, 0, 0)
                
                -- Анимация тряски
                local shakeX = 0
                local shakeY = 0
                local shakeCount = 0
                local shakeCon = RunService.Heartbeat:Connect(function()
                    if shakeCount < 10 then
                        shakeX = (math.random() - 0.5) * 10
                        shakeY = (math.random() - 0.5) * 10
                        mainFrame.Position = UDim2.new(0.5, -225 + shakeX, 0.5, -175 + shakeY)
                        shakeCount = shakeCount + 1
                    else
                        mainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
                        shakeCon:Disconnect()
                    end
                end)
            end
        end)
        
        -- ВВОД ПО ENTER
        keyBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                activateBtn.MouseButton1Click:Fire()
            end
        end)
        
        -- ПЕРЕТАСКИВАНИЕ ОКНА
        local dragging = false
        local dragOffset = nil
        
        title.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local absPos = mainFrame.AbsolutePosition
                dragOffset = Vector2.new(
                    absPos.X - input.Position.X,
                    absPos.Y - input.Position.Y
                )
            end
        end)
        
        title.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local newX = input.Position.X + dragOffset.X
                local newY = input.Position.Y + dragOffset.Y
                local viewportX = game:GetService("Workspace").CurrentCamera.ViewportSize.X
                local viewportY = game:GetService("Workspace").CurrentCamera.ViewportSize.Y
                
                newX = math.clamp(newX, 0, viewportX - mainFrame.Size.X.Offset)
                newY = math.clamp(newY, 0, viewportY - mainFrame.Size.Y.Offset)
                
                mainFrame.Position = UDim2.new(0, newX, 0, newY)
            end
        end)
        
        title.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        print("[L11xtery] ✅ GUI создан!")
        print("[L11xtery] 🎄 Ключ: " .. _G.L11xterySS.Key)
        
        return screenGui
    end)
    
    if not success then
        warn("[L11xtery] Ошибка создания GUI: " .. tostring(err))
        -- Альтернативный запуск без GUI
        print("[L11xtery] GUI не создан. Используйте консольные команды.")
        print("[L11xtery] _G.L11xterySS.Key = 'L11xteryteam001'")
    end
end

-- === ЗАПУСК GUI ===
local function start()
    local success, err = pcall(createMainGUI)
    if not success then
        print("[L11xtery] Критическая ошибка: " .. tostring(err))
    end
end

-- === ЗАПУСК С ЗАДЕРЖКОЙ (ДЛЯ MADIUM) ===
task.wait(0.5)
start()

-- === ИНФОРМАЦИЯ В КОНСОЛИ ===
print("========================================")
print("L11xtery Team SS v2.0")
print("Разработчик: L11xteryTeam")
print("========================================")
print("🔑 КЛЮЧ: L11xteryteam001")
print("📌 GUI появится автоматически")
print("========================================")
