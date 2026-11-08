
--[[
    MIX0MUSI v1.2
    GUI + R6 FLY + SPEED CONTROLLER
    Local movement / noclip prototype
]]

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- GUI PARENT
local function getGuiParent()
    local ok, result = pcall(function()
        return gethui()
    end)

    if ok and result then
        return result
    end

    return game:GetService("CoreGui")
end

local guiParent = getGuiParent()

-- REMOVE OLD GUI
pcall(function()
    local old = guiParent:FindFirstChild("MIX0MUSI_GUI")
    if old then
        old:Destroy()
    end
end)

-- COLORS
local BLACK = Color3.fromRGB(13, 13, 16)
local PANEL = Color3.fromRGB(22, 22, 27)
local BUTTON = Color3.fromRGB(32, 32, 39)
local WHITE = Color3.fromRGB(240, 240, 245)
local GRAY = Color3.fromRGB(155, 155, 165)

-- SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MIX0MUSI_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 430, 0, 300)
Main.Position = UDim2.new(0.5, -215, 0.5, -150)
Main.BackgroundColor3 = BLACK
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(65, 65, 75)
MainStroke.Thickness = 1
MainStroke.Parent = Main

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 44)
Header.BackgroundColor3 = PANEL
Header.BorderSizePixel = 0
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MIX0MUSI"
Title.TextColor3 = WHITE
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

-- CLOSE
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 34, 0, 30)
Close.Position = UDim2.new(1, -39, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(125, 40, 45)
Close.Text = "X"
Close.TextColor3 = WHITE
Close.TextSize = 15
Close.Font = Enum.Font.GothamBold
Close.BorderSizePixel = 0
Close.Parent = Header

Instance.new("UICorner", Close).CornerRadius =
    UDim.new(0, 6)

-- MINIMIZE
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 34, 0, 30)
Minimize.Position = UDim2.new(1, -77, 0, 7)
Minimize.BackgroundColor3 = BUTTON
Minimize.Text = "—"
Minimize.TextColor3 = WHITE
Minimize.TextSize = 15
Minimize.Font = Enum.Font.GothamBold
Minimize.BorderSizePixel = 0
Minimize.Parent = Header

Instance.new("UICorner", Minimize).CornerRadius =
    UDim.new(0, 6)

-- BODY
local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -44)
Body.Position = UDim2.new(0, 0, 0, 44)
Body.BackgroundColor3 = BLACK
Body.BorderSizePixel = 0
Body.Parent = Main

-- HOME
local Home = Instance.new("Frame")
Home.Size = UDim2.new(1, 0, 1, 0)
Home.BackgroundTransparency = 1
Home.Parent = Body

-- SECTION
local Section = Instance.new("Frame")
Section.Size = UDim2.new(1, 0, 1, 0)
Section.BackgroundTransparency = 1
Section.Visible = false
Section.Parent = Body

-- BUTTON CREATOR
local function CreateButton(parent, text, position, size)
    local button = Instance.new("TextButton")

    button.Size = size
    button.Position = position
    button.BackgroundColor3 = BUTTON
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = WHITE
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = false
    button.Parent = parent

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 7)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(65, 65, 75)
    stroke.Thickness = 1
    stroke.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Color3.fromRGB(50, 50, 60)
            }
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = BUTTON
            }
        ):Play()
    end)

    return button
end

-- HOME BUTTONS
local NovemberButton = CreateButton(
    Home,
    "NOVEMBER",
    UDim2.new(0, 24, 0, 25),
    UDim2.new(0, 250, 0, 48)
)

local FarmButton = CreateButton(
    Home,
    "FARM",
    UDim2.new(0, 24, 0, 85),
    UDim2.new(0, 250, 0, 48)
)

-- SECTION TITLE
local SectionTitle = Instance.new("TextLabel")
SectionTitle.Size = UDim2.new(1, -40, 0, 40)
SectionTitle.Position = UDim2.new(0, 20, 0, 15)
SectionTitle.BackgroundTransparency = 1
SectionTitle.Text = ""
SectionTitle.TextColor3 = WHITE
SectionTitle.TextSize = 21
SectionTitle.Font = Enum.Font.GothamBold
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
SectionTitle.Parent = Section

-- INFO
local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, -40, 0, 35)
Info.Position = UDim2.new(0, 20, 0, 65)
Info.BackgroundTransparency = 1
Info.Text = ""
Info.TextColor3 = GRAY
Info.TextSize = 13
Info.Font = Enum.Font.Gotham
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.Parent = Section

-- BACK
local Back = CreateButton(
    Section,
    "← BACK",
    UDim2.new(0, 20, 1, -58),
    UDim2.new(0, 110, 0, 38)
)

-- ==================================
-- NOVEMBER CONTROLS
-- ==================================

local FlyButton = CreateButton(
    Section,
    "FLY: OFF",
    UDim2.new(0, 20, 0, 110),
    UDim2.new(0, 250, 0, 42)
)

-- SPEED SETTINGS
local flySpeed = 55

local SpeedDown = CreateButton(
    Section,
    "-",
    UDim2.new(0, 20, 0, 160),
    UDim2.new(0, 42, 0, 32)
)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 160, 0, 32)
SpeedLabel.Position = UDim2.new(0, 70, 0, 160)
SpeedLabel.BackgroundColor3 = PANEL
SpeedLabel.TextColor3 = WHITE
SpeedLabel.Text = "SPEED: 55"
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.BorderSizePixel = 0
SpeedLabel.Parent = Section

Instance.new("UICorner", SpeedLabel).CornerRadius =
    UDim.new(0, 7)

local SpeedUp = CreateButton(
    Section,
    "+",
    UDim2.new(0, 238, 0, 160),
    UDim2.new(0, 42, 0, 32)
)

-- ==================================
-- FLY + LOCAL NOCLIP
-- ==================================

local flyEnabled = false
local flyConnection = nil
local noclipConnection = nil

local flyVelocity = nil
local flyGyro = nil
local flyHumanoid = nil

local oldAutoRotate = nil
local originalPhysics = {}

-- NOCLIP
local function ApplyNoClip(character)

    for _, part in ipairs(character:GetDescendants()) do

        if part:IsA("BasePart") then

            if not originalPhysics[part] then
                originalPhysics[part] = {
                    CanCollide = part.CanCollide,
                    CanTouch = part.CanTouch,
                    CanQuery = part.CanQuery
                }
            end

            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
        end
    end
end

-- RESTORE LOCAL PHYSICS
local function StopNoClip()

    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end

    for part, properties in pairs(originalPhysics) do

        if part and part.Parent then
            pcall(function()
                part.CanCollide = properties.CanCollide
                part.CanTouch = properties.CanTouch
                part.CanQuery = properties.CanQuery
            end)
        end
    end

    table.clear(originalPhysics)
end

-- START NOCLIP
local function StartNoClip(character)

    StopNoClip()
    ApplyNoClip(character)

    noclipConnection = RunService.Stepped:Connect(function()

        if not character or not character.Parent then
            StopNoClip()
            return
        end

        ApplyNoClip(character)
    end)
end

-- STOP FLY
local function StopFly()

    flyEnabled = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end

    if flyGyro then
        flyGyro:Destroy()
        flyGyro = nil
    end

    StopNoClip()

    if flyHumanoid and flyHumanoid.Parent then

        flyHumanoid.AutoRotate = oldAutoRotate

        flyHumanoid:ChangeState(
            Enum.HumanoidStateType.GettingUp
        )
    end

    flyHumanoid = nil
    oldAutoRotate = nil

    FlyButton.Text = "FLY: OFF"
end

-- START FLY
local function StartFly()

    local character = player.Character

    if not character then
        return false
    end

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    local root =
        character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root then
        return false
    end

    if humanoid.RigType ~= Enum.HumanoidRigType.R6 then
        return false
    end

    flyHumanoid = humanoid
    oldAutoRotate = humanoid.AutoRotate

    humanoid.AutoRotate = false

    StartNoClip(character)

    -- BODY VELOCITY
    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    flyVelocity.Velocity = Vector3.zero
    flyVelocity.Parent = root

    -- BODY GYRO
    flyGyro = Instance.new("BodyGyro")
    flyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    flyGyro.P = 90000
    flyGyro.D = 1000
    flyGyro.CFrame = workspace.CurrentCamera.CFrame
    flyGyro.Parent = root

    flyEnabled = true
    FlyButton.Text = "FLY: ON"

    -- MOVEMENT LOOP
    flyConnection = RunService.RenderStepped:Connect(function()

        if not flyEnabled then
            return
        end

        if not root.Parent then
            StopFly()
            return
        end

        local camera = workspace.CurrentCamera

        if not camera then
            return
        end

        local forward = 0
        local right = 0
        local vertical = 0

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            forward = forward + 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.S) then
            forward = forward - 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.D) then
            right = right + 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.A) then
            right = right - 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            vertical = vertical + 1
        end

        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            vertical = vertical - 1
        end

        local direction =
            camera.CFrame.LookVector * forward
            + camera.CFrame.RightVector * right
            + Vector3.new(0, vertical, 0)

        if direction.Magnitude > 0 then
            direction = direction.Unit
        end

        -- LIVE SPEED CONTROL
        flyVelocity.Velocity = direction * flySpeed

        flyGyro.CFrame = camera.CFrame
    end)

    return true
end

-- ==================================
-- SPEED BUTTONS
-- ==================================

local function UpdateSpeed()

    SpeedLabel.Text = "SPEED: " .. flySpeed

end

SpeedDown.MouseButton1Click:Connect(function()

    flySpeed = math.max(10, flySpeed - 5)

    UpdateSpeed()

end)

SpeedUp.MouseButton1Click:Connect(function()

    flySpeed = math.min(150, flySpeed + 5)

    UpdateSpeed()

end)

-- FLY TOGGLE
FlyButton.MouseButton1Click:Connect(function()

    if flyEnabled then

        StopFly()

    else

        local success = StartFly()

        if not success then

            FlyButton.Text = "R6 REQUIRED"

            task.delay(1.5, function()

                if FlyButton.Parent and not flyEnabled then
                    FlyButton.Text = "FLY: OFF"
                end

            end)
        end
    end
end)

-- ==================================
-- NAVIGATION
-- ==================================

local function OpenSection(name)

    SectionTitle.Text = name

    Home.Visible = false
    Section.Visible = true

    local november = (name == "NOVEMBER")

    FlyButton.Visible = november
    SpeedDown.Visible = november
    SpeedLabel.Visible = november
    SpeedUp.Visible = november

    if november then
        Info.Text = "NOVEMBER FUNCTIONS"
    else
        Info.Text = "FARM FUNCTIONS"
    end
end

NovemberButton.MouseButton1Click:Connect(function()
    OpenSection("NOVEMBER")
end)

FarmButton.MouseButton1Click:Connect(function()
    OpenSection("FARM")
end)

Back.MouseButton1Click:Connect(function()

    Section.Visible = false
    Home.Visible = true

end)

-- ==================================
-- WINDOW CONTROLS
-- ==================================

-- CLOSE
Close.MouseButton1Click:Connect(function()

    StopFly()
    ScreenGui:Destroy()

end)

-- MINIMIZE
local minimized = false

Minimize.MouseButton1Click:Connect(function()

    minimized = not minimized

    Body.Visible = not minimized

    if minimized then

        Main.Size = UDim2.new(0, 430, 0, 44)

    else

        Main.Size = UDim2.new(0, 430, 0, 300)

    end

end)

-- ==================================
-- DRAG WINDOW
-- ==================================

local dragging = false
local dragStart = nil
local startPosition = nil

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end

        end)
    end

end)

UIS.InputChanged:Connect(function(input)

    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )

    end

end)

-- RESPAWN CLEANUP
player.CharacterAdded:Connect(function()

    StopFly()

end)

-- PARENT GUI
local parentSuccess = pcall(function()

    ScreenGui.Parent = guiParent

end)

if not parentSuccess then

    ScreenGui.Parent = player:WaitForChild("PlayerGui")

end

print("MIX0MUSI v1.2 LOADED")
