--[[
    Mix0musi
    Scorched Earth
    Working ESP integrated
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

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

-- ===================== ТВОЙ РАБОЧИЙ ESP =====================
local ESP = {
    Enabled = false,
    Boxes = true,
    BoxShift = CFrame.new(0, -1.5, 0),
    BoxSize = Vector3.new(4, 6, 0),
    Color = Color3.fromRGB(255, 50, 50), -- красный для врагов
    Thickness = 2,
    AttachShift = 1,
    
    Objects = setmetatable({}, {__mode="kv"}),
    Overrides = {}
}

local cam = workspace.CurrentCamera
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local V3new = Vector3.new
local WorldToViewportPoint = cam.WorldToViewportPoint

local function Draw(obj, props)
    local new = Drawing.new(obj)
    props = props or {}
    for i, v in pairs(props) do
        new[i] = v
    end
    return new
end

function ESP:GetColor(obj)
    local ov = self.Overrides.GetColor
    if ov then
        return ov(obj)
    end
    local p = self:GetPlrFromChar(obj)
    return p and self.Color
end

function ESP:GetPlrFromChar(char)
    local ov = self.Overrides.GetPlrFromChar
    if ov then
        return ov(char)
    end
    return plrs:GetPlayerFromCharacter(char)
end

function ESP:Toggle(bool)
    self.Enabled = bool
    if not bool then
        for i, v in pairs(self.Objects) do
            if v.Type == "Box" then
                if v.Temporary then
                    v:Remove()
                else
                    for i, v in pairs(v.Components) do
                        v.Visible = false
                    end
                end
            end
        end
    end
end

function ESP:GetBox(obj)
    return self.Objects[obj]
end

function ESP:AddObjectListener(parent, options)
    if not parent then return end

    local function NewListener(c)
        if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
            if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
                if not options.Validator or options.Validator(c) then
                    if c.Parent and workspace:IsAncestorOf(c) then
                        local box = ESP:Add(c, {
                            PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c),
                            Color = type(options.Color) == "function" and options.Color(c) or options.Color,
                            ColorDynamic = options.ColorDynamic,
                            IsEnabled = options.IsEnabled,
                            RenderInNil = options.RenderInNil
                        })
                        if options.OnAdded then
                            coroutine.wrap(options.OnAdded)(box)
                        end
                    end
                end
            end
        end
    end
    
    if options.Recursive then
        parent.DescendantAdded:Connect(NewListener)
        for i, v in pairs(parent:GetDescendants()) do
            NewListener(v)
        end
    else
        parent.ChildAdded:Connect(NewListener)
        for i, v in pairs(parent:GetChildren()) do
            NewListener(v)
        end
    end
end

local boxBase = {}
boxBase.__index = boxBase

function boxBase:Remove()
    ESP.Objects[self.Object] = nil
    for i, v in pairs(self.Components) do
        if v then
            v.Visible = false
            v:Remove()
            self.Components[i] = nil
        end
    end
end

function boxBase:Update()
    if not self.PrimaryPart then
        return self:Remove()
    end

    local allow = true

    if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
        allow = false
    end

    if self.IsEnabled and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
        allow = false
    end

    if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
        allow = false
    end

    if not allow then
        for i, v in pairs(self.Components) do
            if v then
                v.Visible = false
            end
        end
        return
    end

    -- Фильтр только врагов
    local player = self.Player
    if player and player.Team and plr.Team and player.Team == plr.Team then
        for i, v in pairs(self.Components) do
            if v then v.Visible = false end
        end
        return
    end

    local size = self.Size
    local cf = self.PrimaryPart.CFrame

    local locs = {
        TopLeft = WorldToViewportPoint(cam, (cf * ESP.BoxShift * CFrame.new(size.X / 2, size.Y / 2, 0)).Position),
        TopRight = WorldToViewportPoint(cam, (cf * ESP.BoxShift * CFrame.new(-size.X / 2, size.Y / 2, 0)).Position),
        BottomLeft = WorldToViewportPoint(cam, (cf * ESP.BoxShift * CFrame.new(size.X / 2, -size.Y / 2, 0)).Position),
        BottomRight = WorldToViewportPoint(cam, (cf * ESP.BoxShift * CFrame.new(-size.X / 2, -size.Y / 2, 0)).Position)
    }

    if self.Components.Quad then
        if locs.TopRight.Z > 0 and locs.TopLeft.Z > 0 and locs.BottomLeft.Z > 0 and locs.BottomRight.Z > 0 then
            self.Components.Quad.Visible = true
            self.Components.Quad.PointA = Vector2.new(locs.TopRight.X, locs.TopRight.Y)
            self.Components.Quad.PointB = Vector2.new(locs.TopLeft.X, locs.TopLeft.Y)
            self.Components.Quad.PointC = Vector2.new(locs.BottomLeft.X, locs.BottomLeft.Y)
            self.Components.Quad.PointD = Vector2.new(locs.BottomRight.X, locs.BottomRight.Y)
            self.Components.Quad.Color = self.Color or ESP.Color
        else
            self.Components.Quad.Visible = false
        end
        self.Components.Quad.Color = self.Color or ESP.Color
    end
end

function ESP:Add(obj, options)
    if not obj.Parent and not options.RenderInNil then
        return
    end

    local box = setmetatable({
        Type = "Box",
        Color = options.Color,
        Size = options.Size or self.BoxSize,
        Object = obj,
        Player = options.Player or plrs:GetPlayerFromCharacter(obj),
        PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj,
        Components = {},
        IsEnabled = options.IsEnabled,
        Temporary = options.Temporary,
        ColorDynamic = options.ColorDynamic,
        RenderInNil = options.RenderInNil
    }, boxBase)

    if not box.PrimaryPart then
        return
    end

    if self:GetBox(obj) then
        self:GetBox(obj):Remove()
    end

    box.Components["Quad"] = Draw("Quad", {
        Thickness = self.Thickness,
        Color = box.Color,
        Transparency = 1,
        Filled = false,
        Visible = self.Enabled and self.Boxes
    })

    self.Objects[obj] = box

    obj.AncestryChanged:Connect(function(_, parent)
        if parent == nil and ESP.AutoRemove ~= false then
            box:Remove()
        end
    end)

    obj:GetPropertyChangedSignal("Parent"):Connect(function()
        if obj.Parent == nil and ESP.AutoRemove ~= false then
            box:Remove()
        end
    end)

    local hum = obj:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Died:Connect(function()
            if ESP.AutoRemove ~= false then
                box:Remove()
            end
        end)
    end

    return box
end

local function CharAdded(char)
    local p = plrs:GetPlayerFromCharacter(char)
    if not char:FindFirstChild("HumanoidRootPart") then
        local ev
        ev = char.ChildAdded:Connect(function(c)
            if c.Name == "HumanoidRootPart" then
                ev:Disconnect()
                ESP:Add(char, {
                    Player = p,
                    PrimaryPart = c
                })
            end
        end)
    else
        ESP:Add(char, {
            Player = p,
            PrimaryPart = char.HumanoidRootPart
        })
    end
end

local function PlayerAdded(p)
    p.CharacterAdded:Connect(CharAdded)
    if p.Character then
        coroutine.wrap(CharAdded)(p.Character)
    end
end

plrs.PlayerAdded:Connect(PlayerAdded)
for i, v in pairs(plrs:GetPlayers()) do
    if v ~= plr then
        PlayerAdded(v)
    end
end

RunService.RenderStepped:Connect(function()
    cam = workspace.CurrentCamera
    for i, v in pairs(ESP.Objects) do
        if v.Update then
            pcall(v.Update, v)
        end
    end
end)

-- Ищем папку с персонажами (как в твоём скрипте)
local charBodies
for _, folder in pairs(workspace:GetChildren()) do
    if folder:IsA("Folder") then
        local humanoidFound = false
        for _, model in pairs(folder:GetChildren()) do
            if model:FindFirstChildOfClass("Humanoid") then
                humanoidFound = true
                break
            end
        end
        if humanoidFound then
            charBodies = folder
            break
        end
    end
end

if charBodies then
    ESP:AddObjectListener(charBodies, {
        Type = "Model",
        Color = Color3.fromRGB(255, 50, 50),
        PrimaryPart = function(obj)
            return obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildOfClass("BasePart")
        end, 
        Validator = function(obj)
            return true 
        end, 
        IsEnabled = "player"
    })
    ESP.player = true
end

-- Тоггл в меню
CreateToggle(Pages.VISUALS, "Box ESP (Enemies)", false, function(state)
    ESP:Toggle(state)
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

print("Mix0musi | Working ESP Loaded")
