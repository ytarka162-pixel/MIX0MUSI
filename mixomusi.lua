
--[[
    MIX0MUSI V2.0
    RED KING EDITION
    Roblox Studio LocalScript
    R6 Fly
    Speed: 10 - 500
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- COLORS
local C = {
    Background = Color3.fromRGB(12, 9, 13),
    Panel = Color3.fromRGB(25, 15, 21),
    Card = Color3.fromRGB(36, 20, 27),
    Red = Color3.fromRGB(190, 42, 57),
    RedDark = Color3.fromRGB(105, 25, 37),
    White = Color3.fromRGB(245, 237, 239),
    Gray = Color3.fromRGB(165, 145, 152),
    Gold = Color3.fromRGB(235, 184, 72),
    Green = Color3.fromRGB(65, 190, 115)
}

-- SETTINGS
local FlySpeed = 55
local MinSpeed = 10
local MaxSpeed = 500
local SpeedStep = 5

local FlyEnabled = false
local FlyConnection = nil
local FlyAttachment = nil
local FlyVelocity = nil
local FlyOrientation = nil
local FlyHumanoid = nil
local OldAutoRotate = nil

-- CLEAN OLD GUI
local Old = PlayerGui:FindFirstChild("MIX0MUSI_V2")
if Old then
    Old:Destroy()
end

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "MIX0MUSI_V2"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 20
Gui.Parent = PlayerGui

local function Round(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius)
    Corner.Parent = Object
    return Corner
end

local function Stroke(Object, Color, Thickness)
    local S = Instance.new("UIStroke")
    S.Color = Color
    S.Thickness = Thickness or 1
    S.Parent = Object
    return S
end

local function Label(Parent, Text, Position, Size, TextSize, Color)
    local L = Instance.new("TextLabel")
    L.BackgroundTransparency = 1
    L.Position = Position
    L.Size = Size
    L.Text = Text
    L.TextColor3 = Color or C.White
    L.TextSize = TextSize or 14
    L.Font = Enum.Font.GothamBold
    L.Parent = Parent
    return L
end

local function Button(Parent, Text, Position, Size)
    local B = Instance.new("TextButton")
    B.Position = Position
    B.Size = Size
    B.BackgroundColor3 = C.Card
    B.BorderSizePixel = 0
    B.Text = Text
    B.TextColor3 = C.White
    B.TextSize = 14
    B.Font = Enum.Font.GothamBold
    B.AutoButtonColor = false
    B.Parent = Parent

    Round(B, 9)
    Stroke(B, C.RedDark, 1)

    B.MouseEnter:Connect(function()
        TweenService:Create(
            B,
            TweenInfo.new(0.15),
            {BackgroundColor3 = C.RedDark}
        ):Play()
    end)

    B.MouseLeave:Connect(function()
        TweenService:Create(
            B,
            TweenInfo.new(0.15),
            {BackgroundColor3 = C.Card}
        ):Play()
    end)

    return B
end

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(650, 410)
Main.Position = UDim2.new(0.5, -325, 0.5, -205)
Main.BackgroundColor3 = C.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

Round(Main, 14)
Stroke(Main, C.Red, 1.5)

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 68)
Header.BackgroundColor3 = C.Panel
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main

-- ORIGINAL RED BIRD MASCOT
local Bird = Instance.new("Frame")
Bird.Size = UDim2.fromOffset(45, 45)
Bird.Position = UDim2.fromOffset(17, 11)
Bird.BackgroundColor3 = C.Red
Bird.BorderSizePixel = 0
Bird.Parent = Header

Round(Bird, 25)
Stroke(Bird, C.Gold, 1)

for i = 1, 2 do
    local Eye = Instance.new("Frame")
    Eye.Size = UDim2.fromOffset(11, 13)
    Eye.Position = UDim2.fromOffset(10 + (i - 1) * 14, 11)
    Eye.BackgroundColor3 = C.White
    Eye.BorderSizePixel = 0
    Eye.Parent = Bird
    Round(Eye, 7)

    local Pupil = Instance.new("Frame")
    Pupil.Size = UDim2.fromOffset(4, 6)
    Pupil.Position = UDim2.fromOffset(4, 4)
    Pupil.BackgroundColor3 = C.Background
    Pupil.BorderSizePixel = 0
    Pupil.Parent = Eye
    Round(Pupil, 3)
end

Label(
    Bird,
    "▼",
    UDim2.fromOffset(13, 23),
    UDim2.fromOffset(22, 18),
    14,
    C.Gold
)

-- TITLE
Label(
    Header,
    "MIX0MUSI",
    UDim2.fromOffset(75, 10),
    UDim2.fromOffset(245, 31),
    24,
    C.White
)

Label(
    Header,
    "RED KING EDITION",
    UDim2.fromOffset(77, 40),
    UDim2.fromOffset(200, 16),
    10,
    C.Red
)

Label(
    Header,
    "♛",
    UDim2.new(1, -115, 0, 8),
    UDim2.fromOffset(35, 35),
    26,
    C.Gold
)

-- DECORATIVE DROPS
for i = 1, 5 do
    local Drop = Instance.new("Frame")
    Drop.Size = UDim2.fromOffset(5 + (i % 2) * 3, 13 + (i % 3) * 3)
    Drop.Position = UDim2.new(1, -145 + i * 17, 0, 3)
    Drop.BackgroundColor3 = C.Red
    Drop.BorderSizePixel = 0
    Drop.Parent = Header
    Round(Drop, 6)
end

-- CLOSE
local Close = Button(
    Header,
    "X",
    UDim2.new(1, -43, 0, 17),
    UDim2.fromOffset(30, 30)
)

-- MINIMIZE
local Minimize = Button(
    Header,
    "—",
    UDim2.new(1, -81, 0, 17),
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

local SideTitle = Label(
    Sidebar,
    "MENU",
    UDim2.fromOffset(18, 16),
    UDim2.fromOffset(110, 22),
    11,
    C.Gray
)

local NavNames = {
    "NOVEMBER",
    "FARM",
    "TROLL",
    "TELEPORT"
}

local NavButtons = {}
local Pages = {}

-- CONTENT AREA
local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(165, 12)
Content.Size = UDim2.new(1, -180, 1, -24)
Content.BackgroundTransparency = 1
Content.Parent = Body

-- CREATE PAGES
for i, Name in ipairs(NavNames) do
    local Nav = Button(
        Sidebar,
        Name,
        UDim2.fromOffset(10, 48 + (i - 1) * 52),
        UDim2.fromOffset(130, 42)
    )

    NavButtons[Name] = Nav

    local Page = Instance.new("Frame")
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = Content

    Pages[Name] = Page

    if Name == "NOVEMBER" then
        Label(
            Page,
            "NOVEMBER",
            UDim2.fromOffset(5, 3),
            UDim2.fromOffset(300, 35),
            22,
            C.White
        )

        Label(
            Page,
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
        FlyCard.Parent = Page

        Round(FlyCard, 12)
        Stroke(FlyCard, C.RedDark, 1)

        Label(
            FlyCard,
            "R6 FLY",
            UDim2.fromOffset(18, 14),
            UDim2.fromOffset(180, 26),
            17,
            C.White
        )

        Label(
            FlyCard,
            "MOVEMENT SYSTEM",
            UDim2.fromOffset(19, 39),
            UDim2.fromOffset(180, 18),
            10,
            C.Gray
        )

        local FlyButton = Button(
            FlyCard,
            "FLY: OFF",
            UDim2.fromOffset(18, 70),
            UDim2.fromOffset(190, 43)
        )

        -- SPEED
        Label(
            FlyCard,
            "FLIGHT SPEED",
            UDim2.fromOffset(18, 128),
            UDim2.fromOffset(150, 20),
            11,
            C.Gray
        )

        local Minus = Button(
            FlyCard,
            "−",
            UDim2.fromOffset(18, 155),
            UDim2.fromOffset(43, 34)
        )

        local SpeedValue = Label(
            FlyCard,
            tostring(FlySpeed),
            UDim2.fromOffset(70, 154),
            UDim2.fromOffset(105, 35),
            23,
            C.Gold
        )

        local Plus = Button(
            FlyCard,
            "+",
            UDim2.fromOffset(185, 155),
            UDim2.fromOffset(43, 34)
        )

        local MaxLabel = Label(
            FlyCard,
            "MIN 10                         MAX 500",
            UDim2.fromOffset(18, 191),
            UDim2.fromOffset(240, 14),
            9,
            C.Gray
        )

        -- CONTROLS
        Label(
            Page,
            "W A S D  - MOVE     SPACE - UP     CTRL - DOWN",
            UDim2.fromOffset(4, 284),
            UDim2.new(1, -10, 0, 20),
            10,
            C.Gray
        )

        -- SPEED EVENTS
        local function UpdateSpeed()
            SpeedValue.Text = tostring(FlySpeed)
        end

        Minus.MouseButton1Click:Connect(function()
            FlySpeed = math.max(
                MinSpeed,
                FlySpeed - SpeedStep
            )
            UpdateSpeed()
        end)

        Plus.MouseButton1Click:Connect(function()
            FlySpeed = math.min(
                MaxSpeed,
                FlySpeed + SpeedStep
            )
            UpdateSpeed()
        end)

        -- FLY FUNCTIONS
        local function UpdateFlyButton()
            if FlyEnabled then
                FlyButton.Text = "FLY: ON"
                FlyButton.BackgroundColor3 = C.Red
            else
                FlyButton.Text = "FLY: OFF"
                FlyButton.BackgroundColor3 = C.Card
            end
        end

        local function StopFly()
            FlyEnabled = false

            if FlyConnection then
                FlyConnection:Disconnect()
                FlyConnection = nil
            end

            if FlyVelocity then
                FlyVelocity:Destroy()
                FlyVelocity = nil
            end

            if FlyOrientation then
                FlyOrientation:Destroy()
                FlyOrientation = nil
            end

            if FlyAttachment then
                FlyAttachment:Destroy()
                FlyAttachment = nil
            end

            if FlyHumanoid and FlyHumanoid.Parent then
                FlyHumanoid.AutoRotate = OldAutoRotate
                FlyHumanoid:ChangeState(
                    Enum.HumanoidStateType.GettingUp
                )
            end

            FlyHumanoid = nil
            OldAutoRotate = nil

            UpdateFlyButton()
        end

        local function StartFly()
            local Character = Player.Character
            if not Character then
                return false
            end

            local Humanoid =
                Character:FindFirstChildOfClass("Humanoid")

            local Root =
                Character:FindFirstChild("HumanoidRootPart")

            if not Humanoid or not Root then
                return false
            end

            if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
                return false
            end

            local Camera = workspace.CurrentCamera
            if not Camera then
                return false
            end

            FlyHumanoid = Humanoid
            OldAutoRotate = Humanoid.AutoRotate
            Humanoid.AutoRotate = false

            -- ATTACHMENT
            FlyAttachment = Instance.new("Attachment")
            FlyAttachment.Name = "MIX0MUSI_FlyAttachment"
            FlyAttachment.Parent = Root

            -- LINEAR VELOCITY
            FlyVelocity = Instance.new("LinearVelocity")
            FlyVelocity.Name = "MIX0MUSI_FlyVelocity"
            FlyVelocity.Attachment0 = FlyAttachment
            FlyVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
            FlyVelocity.VelocityConstraintMode =
                Enum.VelocityConstraintMode.Vector
            FlyVelocity.VectorVelocity = Vector3.zero
            FlyVelocity.MaxForce = 100000000
            FlyVelocity.Parent = Root

            -- ORIENTATION
            FlyOrientation = Instance.new("AlignOrientation")
            FlyOrientation.Name = "MIX0MUSI_FlyOrientation"
            FlyOrientation.Mode =
                Enum.OrientationAlignmentMode.OneAttachment
            FlyOrientation.Attachment0 = FlyAttachment
            FlyOrientation.MaxTorque = 100000000
            FlyOrientation.Responsiveness = 25
            FlyOrientation.CFrame = Camera.CFrame.Rotation
            FlyOrientation.Parent = Root

            FlyEnabled = true
            Humanoid:ChangeState(
                Enum.HumanoidStateType.Physics
            )

            UpdateFlyButton()

            FlyConnection = RunService.RenderStepped:Connect(function()
                if not FlyEnabled then
                    return
                end

                if not Root.Parent or Humanoid.Health <= 0 then
                    StopFly()
                    return
                end

                local CurrentCamera = workspace.CurrentCamera
                if not CurrentCamera then
                    return
                end

                if UIS:GetFocusedTextBox() then
                    FlyVelocity.VectorVelocity = Vector3.zero
                    return
                end

                local Forward = 0
                local Side = 0
                local Vertical = 0

                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    Forward += 1
                end

                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    Forward -= 1
                end

                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    Side += 1
                end

                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    Side -= 1
                end

                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    Vertical += 1
                end

                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                    Vertical -= 1
                end

                local Direction =
                    CurrentCamera.CFrame.LookVector * Forward
                    + CurrentCamera.CFrame.RightVector * Side
                    + Vector3.new(0, Vertical, 0)

                if Direction.Magnitude > 1 then
                    Direction = Direction.Unit
                end

                -- LIVE SPEED CONTROL
                FlyVelocity.VectorVelocity =
                    Direction * FlySpeed

                FlyOrientation.CFrame =
                    CurrentCamera.CFrame.Rotation
            end)

            return true
        end

        FlyButton.MouseButton1Click:Connect(function()
            if FlyEnabled then
                StopFly()
            else
                if not StartFly() then
                    FlyButton.Text = "R6 REQUIRED"
                    task.delay(1.5, function()
                        if FlyButton.Parent and not FlyEnabled then
                            FlyButton.Text = "FLY: OFF"
                        end
                    end)
                end
            end
        end)

        -- CLEANUP ON RESPAWN
        Player.CharacterAdded:Connect(function()
            StopFly()
        end)

        -- CLEANUP WHEN GUI CLOSES
        Gui.Destroying:Connect(function()
            StopFly()
        end)

    else
        Label(
            Page,
            Name,
            UDim2.fromOffset(5, 8),
            UDim2.fromOffset(300, 35),
            22,
            C.White
        )

        local Coming = Instance.new("Frame")
        Coming.Position = UDim2.fromOffset(0, 68)
        Coming.Size = UDim2.new(1, -5, 0, 130)
        Coming.BackgroundColor3 = C.Panel
        Coming.BorderSizePixel = 0
        Coming.Parent = Page

        Round(Coming, 12)
        Stroke(Coming, C.RedDark, 1)

        Label(
            Coming,
            "COMING SOON",
            UDim2.fromScale(0, 0.35),
            UDim2.fromScale(1, 0.25),
            18,
            C.Red
        )

        Label(
            Coming,
            "FUNCTIONS WILL BE ADDED",
            UDim2.fromScale(0, 0.6),
            UDim2.fromScale(1, 0.2),
            10,
            C.Gray
        )
    end
end

-- NAVIGATION
local CurrentPage = "NOVEMBER"

local function OpenPage(Name)
    CurrentPage = Name

    for PageName, Page in pairs(Pages) do
        Page.Visible = PageName == Name
    end

    for ButtonName, Nav in pairs(NavButtons) do
        if ButtonName == Name then
            Nav.BackgroundColor3 = C.RedDark
            Nav.TextColor3 = C.White
        else
            Nav.BackgroundColor3 = C.Card
            Nav.TextColor3 = C.Gray
        end
    end
end

for Name, Nav in pairs(NavButtons) do
    Nav.MouseButton1Click:Connect(function()
        OpenPage(Name)
    end)
end

OpenPage("NOVEMBER")

-- MINIMIZE
local Minimized = false

Minimize.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    Body.Visible = not Minimized

    Main.Size = Minimized
        and UDim2.fromOffset(650, 68)
        or UDim2.fromOffset(650, 410)
end)

-- CLOSE
Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- DRAG
local Dragging = false
local DragStart = nil
local StartPosition = nil

Header.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position

        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

print("MIX0MUSI V2.0 LOADED")
