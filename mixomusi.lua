
--[[
    MIX0MUSI v2.2
    RED KING EDITION
    TELEPORT + R6 FLY
    Single LocalScript
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

-- SETTINGS
local FlySpeed = 55
local MinSpeed = 10
local MaxSpeed = 500
local SpeedStep = 5

local Flying = false
local FlyConnection
local NoclipConnection
local BodyVelocity
local BodyGyro
local FlyHumanoid
local OldAutoRotate
local OriginalPhysics = {}

-- TELEPORT LOCATIONS
local Teleports = {
    {
        name = "MAGAZ 1",
        x = 561.20,
        y = 29.02,
        z = -1280.40
    },
    {
        name = "DVOR 1",
        x = 623.46,
        y = 28.97,
        z = -1268.77
    },
    {
        name = "KFC",
        x = 593.15,
        y = 33.67,
        z = -1323.75
    },
    {
        name = "DOSTAVKA",
        x = 303.24,
        y = 1.97,
        z = -244.22
    },
    {
        name = "BILETY",
        x = 341.02,
        y = 20.40,
        z = -1217.81
    },
    {
        name = "ZHENSHINA",
        x = 212.07,
        y = 23.89,
        z = -9441.04
    },
    {
        name = "MUZHIK",
        x = 135.19,
        y = 25.03,
        z = 9943.62
    }
}

-- COLORS
local C = {
    Black = Color3.fromRGB(12, 9, 13),
    Panel = Color3.fromRGB(25, 15, 21),
    Card = Color3.fromRGB(39, 21, 29),
    Red = Color3.fromRGB(190, 42, 57),
    DarkRed = Color3.fromRGB(105, 25, 37),
    White = Color3.fromRGB(245, 237, 239),
    Gray = Color3.fromRGB(165, 145, 152),
    Gold = Color3.fromRGB(235, 184, 72)
}

-- GUI PARENT
local function GetParent()
    local ok, result = pcall(function()
        return gethui()
    end)

    if ok and result then
        return result
    end

    return Player:WaitForChild("PlayerGui")
end

local GuiParent = GetParent()

-- REMOVE OLD GUI
pcall(function()
    local old = GuiParent:FindFirstChild("MIX0MUSI_V2")
    if old then old:Destroy() end
end)

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "MIX0MUSI_V2"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = GuiParent

-- UI HELPERS
local function Round(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
end

local function AddStroke(obj, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Parent = obj
end

local function MakeLabel(parent, text, pos, size, textSize, color)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = pos
    label.Size = size
    label.Text = text
    label.TextColor3 = color or C.White
    label.TextSize = textSize or 14
    label.Font = Enum.Font.GothamBold
    label.Parent = parent
    return label
end

local function MakeButton(parent, text, pos, size)
    local button = Instance.new("TextButton")
    button.Position = pos
    button.Size = size
    button.BackgroundColor3 = C.Card
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = C.White
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = false
    button.Parent = parent

    Round(button, 8)
    AddStroke(button, C.DarkRed)

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = C.DarkRed}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = C.Card}
        ):Play()
    end)

    return button
end

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(650, 450)
Main.Position = UDim2.new(0.5, -325, 0.5, -225)
Main.BackgroundColor3 = C.Black
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

Round(Main, 14)
AddStroke(Main, C.Red, 1.5)

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 68)
Header.BackgroundColor3 = C.Panel
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main

-- BIRD MASCOT
local Bird = Instance.new("Frame")
Bird.Size = UDim2.fromOffset(45, 45)
Bird.Position = UDim2.fromOffset(16, 11)
Bird.BackgroundColor3 = C.Red
Bird.BorderSizePixel = 0
Bird.Parent = Header

Round(Bird, 25)
AddStroke(Bird, C.Gold)

for i = 1, 2 do
    local eye = Instance.new("Frame")
    eye.Size = UDim2.fromOffset(11, 13)
    eye.Position = UDim2.fromOffset(9 + (i - 1) * 15, 11)
    eye.BackgroundColor3 = C.White
    eye.BorderSizePixel = 0
    eye.Parent = Bird
    Round(eye, 6)
end

MakeLabel(
    Bird,
    "▼",
    UDim2.fromOffset(12, 23),
    UDim2.fromOffset(24, 17),
    12,
    C.Gold
)

MakeLabel(
    Header,
    "MIX0MUSI",
    UDim2.fromOffset(75, 7),
    UDim2.fromOffset(220, 32),
    24,
    C.White
)

MakeLabel(
    Header,
    "RED KING EDITION",
    UDim2.fromOffset(78, 39),
    UDim2.fromOffset(200, 16),
    10,
    C.Red
)

MakeLabel(
    Header,
    "♛",
    UDim2.new(1, -130, 0, 12),
    UDim2.fromOffset(35, 35),
    26,
    C.Gold
)

-- RED DROPS
for i = 1, 5 do
    local drop = Instance.new("Frame")
    drop.Size = UDim2.fromOffset(6, 15 + (i % 3) * 3)
    drop.Position = UDim2.new(1, -145 + i * 18, 0, 3)
    drop.BackgroundColor3 = C.Red
    drop.BorderSizePixel = 0
    drop.Parent = Header
    Round(drop, 6)
end

-- WINDOW BUTTONS
local Close = MakeButton(
    Header,
    "X",
    UDim2.new(1, -43, 0, 18),
    UDim2.fromOffset(30, 30)
)

local Minimize = MakeButton(
    Header,
    "—",
    UDim2.new(1, -81, 0, 18),
    UDim2.fromOffset(30, 30)
)

-- BODY
local Body = Instance.new("Frame")
Body.Position = UDim2.fromOffset(0, 68)
Body.Size = UDim2.new(1, 0, 1, -68)
Body.BackgroundTransparency = 1
Body.Parent = Main

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = C.Panel
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Body

MakeLabel(
    Sidebar,
    "MENU",
    UDim2.fromOffset(18, 16),
    UDim2.fromOffset(110, 22),
    11,
    C.Gray
)

local Names = {
    "NOVEMBER",
    "FARM",
    "TROLL",
    "TELEPORT"
}

local NavButtons = {}
local Pages = {}

-- CONTENT
local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(165, 12)
Content.Size = UDim2.new(1, -180, 1, -24)
Content.BackgroundTransparency = 1
Content.Parent = Body

-- CREATE PAGES
for i, name in ipairs(Names) do

    NavButtons[name] = MakeButton(
        Sidebar,
        name,
        UDim2.fromOffset(10, 48 + (i - 1) * 52),
        UDim2.fromOffset(130, 42)
    )

    local page = Instance.new("Frame")
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = Content

    Pages[name] = page
end

-- ==================================
-- NOVEMBER PAGE
-- ==================================

local November = Pages.NOVEMBER

MakeLabel(
    November,
    "NOVEMBER",
    UDim2.fromOffset(5, 3),
    UDim2.fromOffset(300, 35),
    22
)

MakeLabel(
    November,
    "FLIGHT CONTROL",
    UDim2.fromOffset(7, 36),
    UDim2.fromOffset(250, 20),
    11,
    C.Gray
)

local FlyCard = Instance.new("Frame")
FlyCard.Position = UDim2.fromOffset(0, 68)
FlyCard.Size = UDim2.new(1, -5, 0, 205)
FlyCard.BackgroundColor3 = C.Panel
FlyCard.BorderSizePixel = 0
FlyCard.Parent = November

Round(FlyCard, 12)
AddStroke(FlyCard, C.DarkRed)

MakeLabel(
    FlyCard,
    "R6 FLY",
    UDim2.fromOffset(18, 14),
    UDim2.fromOffset(180, 26),
    17
)

MakeLabel(
    FlyCard,
    "MOVEMENT SYSTEM",
    UDim2.fromOffset(19, 39),
    UDim2.fromOffset(180, 18),
    10,
    C.Gray
)

local FlyButton = MakeButton(
    FlyCard,
    "FLY: OFF",
    UDim2.fromOffset(18, 70),
    UDim2.fromOffset(230, 43)
)

MakeLabel(
    FlyCard,
    "FLIGHT SPEED",
    UDim2.fromOffset(18, 128),
    UDim2.fromOffset(150, 20),
    11,
    C.Gray
)

local Minus = MakeButton(
    FlyCard,
    "-",
    UDim2.fromOffset(18, 155),
    UDim2.fromOffset(43, 34)
)

local SpeedLabel = MakeLabel(
    FlyCard,
    "55 / 500",
    UDim2.fromOffset(70, 154),
    UDim2.fromOffset(130, 35),
    22,
    C.Gold
)

local Plus = MakeButton(
    FlyCard,
    "+",
    UDim2.fromOffset(205, 155),
    UDim2.fromOffset(43, 34)
)

MakeLabel(
    November,
    "WASD - MOVE   SPACE - UP   CTRL - DOWN",
    UDim2.fromOffset(4, 284),
    UDim2.new(1, -10, 0, 20),
    10,
    C.Gray
)

-- ==================================
-- TELEPORT PAGE
-- ==================================

local TeleportPage = Pages.TELEPORT

MakeLabel(
    TeleportPage,
    "TELEPORT",
    UDim2.fromOffset(5, 3),
    UDim2.fromOffset(300, 35),
    22
)

MakeLabel(
    TeleportPage,
    "SELECT DESTINATION",
    UDim2.fromOffset(7, 36),
    UDim2.fromOffset(250, 18),
    10,
    C.Gray
)

local TeleportList = Instance.new("ScrollingFrame")
TeleportList.Position = UDim2.fromOffset(0, 60)
TeleportList.Size = UDim2.new(1, -5, 0, 275)
TeleportList.BackgroundColor3 = C.Panel
TeleportList.BorderSizePixel = 0
TeleportList.ScrollBarThickness = 5
TeleportList.ScrollBarImageColor3 = C.Red
TeleportList.AutomaticCanvasSize = Enum.AutomaticSize.Y
TeleportList.CanvasSize = UDim2.new(0, 0, 0, 0)
TeleportList.Parent = TeleportPage

Round(TeleportList, 10)
AddStroke(TeleportList, C.DarkRed)

local ListPadding = Instance.new("UIPadding")
ListPadding.PaddingTop = UDim.new(0, 8)
ListPadding.PaddingBottom = UDim.new(0, 8)
ListPadding.PaddingLeft = UDim.new(0, 8)
ListPadding.PaddingRight = UDim.new(0, 8)
ListPadding.Parent = TeleportList

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 7)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = TeleportList

local TeleportStatus = MakeLabel(
    TeleportPage,
    "Choose a destination",
    UDim2.fromOffset(5, 342),
    UDim2.new(1, -10, 0, 20),
    11,
    C.Gray
)

local function TeleportTo(point)
    local character = Player.Character
    if not character then
        TeleportStatus.Text = "Character not found"
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root or humanoid.Health <= 0 then
        TeleportStatus.Text = "Character unavailable"
        return
    end

    local destination = Vector3.new(
        point.x,
        point.y,
        point.z
    )

    local success, err = pcall(function()
        character:PivotTo(CFrame.new(destination))
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end)

    if success then
        TeleportStatus.Text = "Requested: " .. point.name
    else
        TeleportStatus.Text = "Teleport error"
        warn("[MIX0MUSI] Teleport error:", err)
    end
end

for i, destination in ipairs(Teleports) do

    local point = destination

    local TeleportButton = MakeButton(
        TeleportList,
        point.name .. "     [ TELEPORT ]",
        UDim2.new(0, 0, 0, 0),
        UDim2.new(1, -6, 0, 43)
    )

    TeleportButton.LayoutOrder = i

    TeleportButton.MouseButton1Click:Connect(function()
        TeleportTo(point)
    end)
end

-- ==================================
-- OTHER PAGES
-- ==================================

for _, name in ipairs({"FARM", "TROLL"}) do

    local page = Pages[name]

    MakeLabel(
        page,
        name,
        UDim2.fromOffset(5, 8),
        UDim2.fromOffset(300, 35),
        22
    )

    local coming = Instance.new("Frame")
    coming.Position = UDim2.fromOffset(0, 68)
    coming.Size = UDim2.new(1, -5, 0, 130)
    coming.BackgroundColor3 = C.Panel
    coming.BorderSizePixel = 0
    coming.Parent = page

    Round(coming, 12)
    AddStroke(coming, C.DarkRed)

    MakeLabel(
        coming,
        "COMING SOON",
        UDim2.fromScale(0, 0.35),
        UDim2.fromScale(1, 0.25),
        18,
        C.Red
    )

    MakeLabel(
        coming,
        "FUNCTIONS WILL BE ADDED",
        UDim2.fromScale(0, 0.60),
        UDim2.fromScale(1, 0.20),
        10,
        C.Gray
    )
end

-- ==================================
-- NAVIGATION
-- ==================================

local function OpenPage(name)

    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end

    for buttonName, nav in pairs(NavButtons) do

        if buttonName == name then
            nav.BackgroundColor3 = C.Red
            nav.TextColor3 = C.White
        else
            nav.BackgroundColor3 = C.Card
            nav.TextColor3 = C.Gray
        end
    end
end

for name, nav in pairs(NavButtons) do
    nav.MouseButton1Click:Connect(function()
        OpenPage(name)
    end)
end

OpenPage("NOVEMBER")

-- ==================================
-- LOCAL NOCLIP
-- ==================================

local function ApplyNoClip(character)

    for _, part in ipairs(character:GetDescendants()) do

        if part:IsA("BasePart") then

            if not OriginalPhysics[part] then
                OriginalPhysics[part] = {
                    CanCollide = part.CanCollide,
                    CanTouch = part.CanTouch
                }
            end

            part.CanCollide = false
            part.CanTouch = false
        end
    end
end

local function StopNoClip()

    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end

    for part, properties in pairs(OriginalPhysics) do

        if part and part.Parent then
            pcall(function()
                part.CanCollide = properties.CanCollide
                part.CanTouch = properties.CanTouch
            end)
        end
    end

    table.clear(OriginalPhysics)
end

local function StartNoClip(character)

    StopNoClip()
    ApplyNoClip(character)

    NoclipConnection = RunService.Stepped:Connect(function()

        if not character or not character.Parent then
            StopNoClip()
            return
        end

        ApplyNoClip(character)
    end)
end

-- ==================================
-- FLY
-- ==================================

local function StopFly()

    Flying = false

    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end

    if BodyVelocity then
        BodyVelocity:Destroy()
        BodyVelocity = nil
    end

    if BodyGyro then
        BodyGyro:Destroy()
        BodyGyro = nil
    end

    StopNoClip()

    if FlyHumanoid and FlyHumanoid.Parent then
        FlyHumanoid.AutoRotate = OldAutoRotate
        FlyHumanoid:ChangeState(
            Enum.HumanoidStateType.GettingUp
        )
    end

    FlyHumanoid = nil
    OldAutoRotate = nil

    FlyButton.Text = "FLY: OFF"
    FlyButton.BackgroundColor3 = C.Card
end

local function StartFly()

    local character = Player.Character
    if not character then return false end

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    local root =
        character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root then return false end

    if humanoid.RigType ~= Enum.HumanoidRigType.R6 then
        return false
    end

    if humanoid.Health <= 0 then return false end

    FlyHumanoid = humanoid
    OldAutoRotate = humanoid.AutoRotate

    humanoid.AutoRotate = false

    StartNoClip(character)

    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(
        1000000000,
        1000000000,
        1000000000
    )
    BodyVelocity.Velocity = Vector3.zero
    BodyVelocity.Parent = root

    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(
        1000000000,
        1000000000,
        1000000000
    )
    BodyGyro.P = 90000
    BodyGyro.D = 1000
    BodyGyro.CFrame = workspace.CurrentCamera.CFrame
    BodyGyro.Parent = root

    Flying = true

    FlyButton.Text = "FLY: ON"
    FlyButton.BackgroundColor3 = C.Red

    FlyConnection = RunService.RenderStepped:Connect(function()

        if not Flying then return end

        if not root.Parent or humanoid.Health <= 0 then
            StopFly()
            return
        end

        local camera = workspace.CurrentCamera
        if not camera then return end

        if UIS:GetFocusedTextBox() then
            BodyVelocity.Velocity = Vector3.zero
            return
        end

        local forward = 0
        local side = 0
        local vertical = 0

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            forward += 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.S) then
            forward -= 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.D) then
            side += 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.A) then
            side -= 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            vertical += 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            vertical -= 1
        end

        local direction =
            camera.CFrame.LookVector * forward
            + camera.CFrame.RightVector * side
            + Vector3.new(0, vertical, 0)

        if direction.Magnitude > 1 then
            direction = direction.Unit
        end

        BodyVelocity.Velocity = direction * FlySpeed
        BodyGyro.CFrame = camera.CFrame
    end)

    return true
end

FlyButton.MouseButton1Click:Connect(function()

    if Flying then
        StopFly()
    else
        local success = StartFly()

        if not success then
            FlyButton.Text = "R6 REQUIRED"

            task.delay(1.5, function()
                if FlyButton.Parent and not Flying then
                    FlyButton.Text = "FLY: OFF"
                end
            end)
        end
    end
end)

-- ==================================
-- SPEED
-- ==================================

local function UpdateSpeed()
    SpeedLabel.Text = tostring(FlySpeed) .. " / 500"
end

Minus.MouseButton1Click:Connect(function()
    FlySpeed = math.max(MinSpeed, FlySpeed - SpeedStep)
    UpdateSpeed()
end)

Plus.MouseButton1Click:Connect(function()
    FlySpeed = math.min(MaxSpeed, FlySpeed + SpeedStep)
    UpdateSpeed()
end)

-- ==================================
-- MINIMIZE / CLOSE
-- ==================================

local Minimized = false

Minimize.MouseButton1Click:Connect(function()

    Minimized = not Minimized
    Body.Visible = not Minimized

    Main.Size = Minimized
        and UDim2.fromOffset(650, 68)
        or UDim2.fromOffset(650, 450)
end)

Close.MouseButton1Click:Connect(function()
    StopFly()
    Gui:Destroy()
end)

-- RESPAWN
Player.CharacterAdded:Connect(function()
    StopFly()
end)

Gui.Destroying:Connect(function()
    StopFly()
end)

-- ==================================
-- DRAG WINDOW
-- ==================================

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)

    if Dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + delta.Y
        )
    end
end)

print("MIX0MUSI v2.2 LOADED")
