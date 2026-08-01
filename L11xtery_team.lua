--[[
	L11xteryTeam FE Script Editor
	Разработчик: L11xteryTeam
	Версия: 1.0
]]

-- === СЕРВИСЫ ===
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- === СОЗДАНИЕ REMOTE ===
local Remote = ReplicatedStorage:FindFirstChild("L11XTERY_REMOTE") or Instance.new("RemoteEvent", ReplicatedStorage)
Remote.Name = "L11XTERY_REMOTE"

-- === GUI ===
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "L11xteryTeam_Editor"
ScreenGui.ResetOnSpawn = false

-- === ЭФФЕКТ РАЗМЫТИЯ ===
local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
blur.Size = 12
task.delay(6, function()
	blur:Destroy()
end)

-- === ГЛАВНОЕ ОКНО ===
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 450, 0, 400)
Main.Position = UDim2.new(0.5, -225, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BorderSizePixel = 3
Main.BorderColor3 = Color3.fromRGB(255, 50, 50)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = ScreenGui
Main.Active = true
Main.Draggable = true
Main.BackgroundTransparency = 0.1

-- === АНИМАЦИЯ ПОЯВЛЕНИЯ ===
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 450, 0, 400)
}):Play()

-- === ЗАГОЛОВОК ===
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Text = "L11xteryTeam FE Script Editor"
Title.TextColor3 = Color3.fromRGB(255, 70, 70)
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- === ПАНЕЛЬ КНОПОК ===
local ButtonsFrame = Instance.new("Frame", Main)
ButtonsFrame.Size = UDim2.new(1, 0, 0.18, 0)
ButtonsFrame.Position = UDim2.new(0, 0, 0.1, 0)
ButtonsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ButtonsFrame.BorderSizePixel = 1
ButtonsFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)

local function makeButton(parent, pos, text, color)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0.23, 0, 1, 0)
	btn.Position = UDim2.new(pos, 0, 0, 0)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = color
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 1
	btn.BorderColor3 = Color3.fromRGB(255, 50, 50)
	return btn
end

local ServerButton = makeButton(ButtonsFrame, 0.01, "Server", Color3.fromRGB(40, 0, 0))
local LocalButton = makeButton(ButtonsFrame, 0.25, "Local", Color3.fromRGB(0, 0, 40))
local ExecuteButton = makeButton(ButtonsFrame, 0.50, "Execute", Color3.fromRGB(0, 100, 0))
local ResetButton = makeButton(ButtonsFrame, 0.75, "Reset", Color3.fromRGB(100, 0, 0))

-- === ТЕКСТОВЫЕ ПОЛЯ ===
local ServerBox = Instance.new("TextBox", Main)
ServerBox.Size = UDim2.new(1, -10, 0.55, 0)
ServerBox.Position = UDim2.new(0, 5, 0.28, 0)
ServerBox.Text = ""
ServerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ServerBox.TextScaled = true
ServerBox.TextXAlignment = Enum.TextXAlignment.Left
ServerBox.TextYAlignment = Enum.TextYAlignment.Top
ServerBox.Font = Enum.Font.Code
ServerBox.PlaceholderText = "Напишите ServerScript здесь..."
ServerBox.BorderSizePixel = 1
ServerBox.BorderColor3 = Color3.fromRGB(255, 50, 50)
ServerBox.ClearTextOnFocus = false

local LocalBox = ServerBox:Clone()
LocalBox.Parent = Main
LocalBox.Visible = false
LocalBox.PlaceholderText = "Напишите LocalScript здесь..."

-- === ПЕРЕКЛЮЧЕНИЕ ВИДИМОСТИ ===
ServerButton.MouseButton1Click:Connect(function()
	ServerBox.Visible = true
	LocalBox.Visible = false
end)

LocalButton.MouseButton1Click:Connect(function()
	ServerBox.Visible = false
	LocalBox.Visible = true
end)

-- === ВЫПОЛНЕНИЕ КОДА ===
ExecuteButton.MouseButton1Click:Connect(function()
	local code = ServerBox.Visible and ServerBox.Text or LocalBox.Text
	if code and code ~= "" then
		local success, err = pcall(function()
			loadstring(code)()
		end)
		if success then
			print("[L11xteryTeam] ✅ Код выполнен успешно!")
		else
			warn("[L11xteryTeam] ❌ Ошибка: " .. err)
		end
	end
end)

-- === СБРОС ===
ResetButton.MouseButton1Click:Connect(function()
	ServerBox.Text = ""
	LocalBox.Text = ""
	print("[L11xteryTeam] Текст сброшен")
end)

-- === ИНЖЕКТ RMT BYPASS ===
local InjectBtn = Instance.new("TextButton", Main)
InjectBtn.Size = UDim2.new(0.35, 0, 0.1, 0)
InjectBtn.Position = UDim2.new(0.65, 0, 0.9, 0)
InjectBtn.Text = "⚡ RMT Bypass"
InjectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 200)
InjectBtn.TextScaled = true
InjectBtn.Font = Enum.Font.GothamBold
InjectBtn.BorderSizePixel = 1
InjectBtn.BorderColor3 = Color3.fromRGB(50, 50, 255)

InjectBtn.MouseButton1Click:Connect(function()
	Remote:FireServer("BYPASS_NOW", "DeleteTarget")
	print("[L11xteryTeam] ⚡ RMT Bypass отправлен на сервер!")
end)

-- === КНОПКА ЗАКРЫТИЯ ===
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 60, 0, 25)
CloseBtn.Position = UDim2.new(1, -70, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
CloseBtn.BorderSizePixel = 1
CloseBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Main

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	print("[L11xteryTeam] GUI закрыт")
end)

-- === ИНФОРМАЦИЯ ===
print("========================================")
print("L11xteryTeam FE Script Editor загружен!")
print("Разработчик: L11xteryTeam")
print("========================================")
print("📌 Функции:")
print("  - Server/Local скрипты")
print("  - Выполнение кода")
print("  - RMT Bypass")
print("  - Редактор с подсветкой")
print("========================================")
