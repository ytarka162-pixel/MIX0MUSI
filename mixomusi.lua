--[[
    Mix0musi
    Scorched Earth
    UI Only + RightShift Toggle
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- Цвета
local Colors = {
    Background = Color3.fromRGB(12, 12, 16),
    Sidebar = Color3.fromRGB(18, 18, 24),
    Card = Color3.fromRGB(28, 28, 36),
    Accent = Color3.fromRGB(190, 40, 55),
    AccentDark = Color3.fromRGB(120, 25, 35),
    Text = Color3.fromRGB(245, 245, 250),
    TextDim = Color3.fromRGB(160, 160, 175),
    ToggleOn = Color3.fromRGB(190, 40, 55),
    ToggleOff = Color3.fromRGB(45, 45, 55)
}

-- Удаляем старое меню
pcall(function()
    local old = game:GetService("CoreGui"):FindFirstChild("Mix0musi")
    if old then old:Destroy() end
end)

pcall(function()
    local old = Player.PlayerGui:FindFirstChild("Mix0musi")
    if old then old:Destroy() end
end)

-- Создаём ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Mix0musi"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = true

local success = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not success then
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

-- Главное окно
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(620, 420)
Main.Position = UDim2.new(0.5, -310, 0.5, -210)
Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Accent
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.3
MainStroke.Parent = Main

-- ===== SIDEBAR =====
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Colors.Sidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

-- Логотип
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, -20, 0, 50)
Logo.Position = UDim2.fromOffset(10, 12)
Logo.BackgroundTransparency = 1
Logo.Text = "Mix0musi"
Logo.TextColor3 = Colors.Text
Logo.TextSize = 22
Logo.Font = Enum.Font.GothamBold
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Sidebar

local SubLogo = Instance.new("TextLabel")
SubLogo.Size = UDim2.new(1, -20, 0, 18)
SubLogo.Position = UDim2.fromOffset(12, 42)
SubLogo.BackgroundTransparency = 1
SubLogo.Text = "SCORCHED EARTH"
SubLogo.TextColor3 = Colors.Accent
SubLogo.TextSize = 11
SubLogo.Font = Enum.Font.Gotham
SubLogo.TextXAlignment = Enum.TextXAlignment.Left
SubLogo.Parent = Sidebar

-- Красные капли
local function CreateDrop(parent, x, y, height)
    local drop = Instance.new("Frame")
    drop.Size = UDim2.fromOffset(5, height)
    drop.Position = UDim2.fromOffset(x, y)
    drop.BackgroundColor3 = Colors.Accent
    drop.BorderSizePixel = 0
    drop.BackgroundTransparency = 0.15
    drop.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = drop
end

CreateDrop(Sidebar, 18, 68, 14)
CreateDrop(Sidebar, 32, 68, 9)
CreateDrop(Sidebar, 46, 68, 17)
CreateDrop(Sidebar, 60, 68, 11)
CreateDrop(Sidebar, 74, 68, 15)

-- Кнопки навигации
local NavButtons = {}
local Pages = {}

local Categories = {
    {Name = "NOVEMBER", Icon = "⚔"},
    {Name = "VISUALS", Icon = "👁"},
    {Name = "COMBAT", Icon = "🎯"}
}

local function CreateNavButton(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 42)
    btn.Position = UDim2.fromOffset(10, 100 + (order - 1) * 50)
    btn.BackgroundColor3 = Colors.Card
    btn.BorderSizePixel = 0
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Colors.TextDim
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = Sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    NavButtons[name] = btn
    return btn
end

for i, cat in ipairs(Categories) do
    CreateNavButton(cat.Name, cat.Icon, i)
end

-- ===== CONTENT =====
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -170, 1, -20)
Content.Position = UDim2.fromOffset(170, 10)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Colors.Accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 15)
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = page

    Pages[name] = page
    return page
end

for _, cat in ipairs(Categories) do
    CreatePage(cat.Name)
end

local function AddPageTitle(page, text)
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = text
    title.TextColor3 = Colors.Text
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.LayoutOrder = 0
    title.Parent = page
end

AddPageTitle(Pages.NOVEMBER, "NOVEMBER")
AddPageTitle(Pages.VISUALS, "VISUALS")
AddPageTitle(Pages.COMBAT, "COMBAT")

local function AddPlaceholder(page, text)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 50)
    card.BackgroundColor3 = Colors.Card
    card.BorderSizePixel = 0
    card.Parent = page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = card

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.fromOffset(15, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Colors.TextDim
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card
end

AddPlaceholder(Pages.NOVEMBER, "Скоро здесь будут функции...")
AddPlaceholder(Pages.VISUALS, "ESP, Boxes, Names и т.д.")
AddPlaceholder(Pages.COMBAT, "Aimbot, Triggerbot, No Recoil...")

-- Навигация
local function OpenPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = (pageName == name)
    end

    for btnName, btn in pairs(NavButtons) do
        if btnName == name then
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Colors.Accent,
                TextColor3 = Colors.Text
            }):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Colors.Card,
                TextColor3 = Colors.TextDim
            }):Play()
        end
    end
end

for name, btn in pairs(NavButtons) do
    btn.MouseButton1Click:Connect(function()
        OpenPage(name)
    end)
end

OpenPage("NOVEMBER")

-- Перетаскивание
local Dragging = false
local DragStart
local StartPos

local DragZone = Instance.new("Frame")
DragZone.Size = UDim2.new(1, 0, 0, 60)
DragZone.BackgroundTransparency = 1
DragZone.Parent = Main

DragZone.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = Main.Position
    end
end)

DragZone.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - DragStart
        Main.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + delta.Y
        )
    end
end)

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(32, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 12)
CloseBtn.BackgroundColor3 = Colors.Card
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Main

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- ===== RIGHT SHIFT TOGGLE =====
local MenuVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.RightShift then
        MenuVisible = not MenuVisible
        ScreenGui.Enabled = MenuVisible
    end
end)

print("Mix0musi UI Loaded | RightShift to toggle")
