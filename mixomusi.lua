--[[
    Mix0musi
    Scorched Earth
    Fixed Box ESP (Enemies Only)
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Player = Players.LocalPlayer

-- Цвета
local Colors = {
    Background = Color3.fromRGB(12, 12, 16),
    Sidebar = Color3.fromRGB(18, 18, 24),
    Card = Color3.fromRGB(28, 28, 36),
    Accent = Color3.fromRGB(190, 40, 55),
    Text = Color3.fromRGB(245, 245, 250),
    TextDim = Color3.fromRGB(160, 160, 175),
    ToggleOn = Color3.fromRGB(190, 40, 55),
    ToggleOff = Color3.fromRGB(45, 45, 55)
}

-- Удаляем старое
pcall(function()
    local old = game:GetService("CoreGui"):FindFirstChild("Mix0musi")
    if old then old:Destroy() end
end)
pcall(function()
    local old = Player.PlayerGui:FindFirstChild("Mix0musi")
    if old then old:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Mix0musi"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = true

pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(620, 420)
Main.Position = UDim2.new(0.5, -310, 0.5, -210)
Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", Main)
stroke.Color = Colors.Accent
stroke.Thickness = 1.2
stroke.Transparency = 0.3

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Colors.Sidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

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

local function CreateDrop(x, y, h)
    local d = Instance.new("Frame")
    d.Size = UDim2.fromOffset(5, h)
    d.Position = UDim2.fromOffset(x, y)
    d.BackgroundColor3 = Colors.Accent
    d.BorderSizePixel = 0
    d.BackgroundTransparency = 0.15
    d.Parent = Sidebar
    Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
end
CreateDrop(18, 68, 14)
CreateDrop(32, 68, 9)
CreateDrop(46, 68, 17)
CreateDrop(60, 68, 11)
CreateDrop(74, 68, 15)

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
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    NavButtons[name] = btn
end

for i, cat in ipairs(Categories) do
    CreateNavButton(cat.Name, cat.Icon, i)
end

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
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 5)
    pad.PaddingLeft = UDim.new(0, 5)
    pad.PaddingRight = UDim.new(0, 10)
    pad.Parent = page

    Pages[name] = page
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
    title.Parent = page
end

AddPageTitle(Pages.NOVEMBER, "NOVEMBER")
AddPageTitle(Pages.VISUALS, "VISUALS")
AddPageTitle(Pages.COMBAT, "COMBAT")

-- Toggle
local function CreateToggle(page, name, default, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 48)
    card.BackgroundColor3 = Colors.Card
    card.BorderSizePixel = 0
    card.Parent = page
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.fromOffset(15, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Colors.Text
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.fromOffset(42, 22)
    toggleBg.Position = UDim2.new(1, -55, 0.5, -11)
    toggleBg.BackgroundColor3 = default and Colors.ToggleOn or Colors.ToggleOff
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = card
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromOffset(16, 16)
    circle.Position = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggleBg
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local enabled = default
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = card

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {
            BackgroundColor3 = enabled and Colors.ToggleOn or Colors.ToggleOff
        }):Play()
        TweenService:Create(circle, TweenInfo.new(0.2), {
            Position = enabled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        }):Play()
        if callback then callback(enabled) end
    end)
end

-- ===== BOX ESP (ИСПРАВЛЕННЫЙ) =====
local BoxESPEnabled = false
local Boxes = {}

local function IsEnemy(plr)
    if plr == Player then return false end
    if not plr.Character then return false end
    if not Player.Team or not plr.Team then return true end
    return plr.Team ~= Player.Team
end

local function GetBoxData(character)
    local root = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    if not root then return nil end

    local topPos = head and head.Position or (root.Position + Vector3.new(0, 2.5, 0))
    local bottomPos = root.Position - Vector3.new(0, 3, 0)

    local top, topOnScreen = Camera:WorldToViewportPoint(topPos)
    local bottom, bottomOnScreen = Camera:WorldToViewportPoint(bottomPos)

    if not topOnScreen and not bottomOnScreen then
        return nil
    end

    local height = math.abs(top.Y - bottom.Y)
    local width = height * 0.65

    return {
        Position = Vector2.new(top.X - width / 2, top.Y),
        Size = Vector2.new(width, height)
    }
end

local function ClearAllBoxes()
    for _, box in pairs(Boxes) do
        pcall(function() box:Remove() end)
    end
    table.clear(Boxes)
end

CreateToggle(Pages.VISUALS, "Box ESP (Enemies)", false, function(state)
    BoxESPEnabled = state
    if not state then
        ClearAllBoxes()
    end
end)

RunService.RenderStepped:Connect(function()
    if not BoxESPEnabled then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if IsEnemy(plr) and plr.Character then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local data = GetBoxData(plr.Character)

                if data then
                    if not Boxes[plr] then
                        local box = Drawing.new("Square")
                        box.Thickness = 1.5
                        box.Filled = false
                        box.Color = Color3.fromRGB(255, 40, 40)
                        box.Transparency = 1
                        Boxes[plr] = box
                    end

                    local box = Boxes[plr]
                    box.Position = data.Position
                    box.Size = data.Size
                    box.Visible = true
                else
                    if Boxes[plr] then
                        Boxes[plr].Visible = false
                    end
                end
            end
        else
            if Boxes[plr] then
                Boxes[plr].Visible = false
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if Boxes[plr] then
        pcall(function() Boxes[plr]:Remove() end)
        Boxes[plr] = nil
    end
end)

-- Заглушки
local function AddPlaceholder(page, text)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 48)
    card.BackgroundColor3 = Colors.Card
    card.BorderSizePixel = 0
    card.Parent = page
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

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
AddPlaceholder(Pages.COMBAT, "Aimbot, Triggerbot, No Recoil...")

-- Навигация
local function OpenPage(name)
    for n, p in pairs(Pages) do
        p.Visible = (n == name)
    end
    for n, btn in pairs(NavButtons) do
        if n == name then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Accent, TextColor3 = Colors.Text}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Card, TextColor3 = Colors.TextDim}):Play()
        end
    end
end

for name, btn in pairs(NavButtons) do
    btn.MouseButton1Click:Connect(function()
        OpenPage(name)
    end)
end

OpenPage("VISUALS")

-- Drag
local dragging, dragStart, startPos
local dragZone = Instance.new("Frame")
dragZone.Size = UDim2.new(1, 0, 0, 60)
dragZone.BackgroundTransparency = 1
dragZone.Parent = Main

dragZone.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

dragZone.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Close
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -42, 0, 12)
close.BackgroundColor3 = Colors.Card
close.Text = "×"
close.TextColor3 = Colors.Text
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.Parent = Main
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
close.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- RightShift
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("Mix0musi | Fixed Box ESP")
