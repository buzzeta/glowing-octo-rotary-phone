-- FlowerHub Rivals | Syringa, Lavender & Black Theme
-- Вставь в исполнитель (Delta, Xeno, Wave и т.д.)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==================== ЦВЕТА ====================
local Theme = {
    Syringa     = Color3.fromRGB(200, 162, 200), -- Сирень
    Lavender    = Color3.fromRGB(230, 190, 255), -- Лаванда
    DarkPurple  = Color3.fromRGB(45, 30, 60),    -- Темно-фиолетовый (фон)
    Black       = Color3.fromRGB(10, 10, 12),    -- Черный
    White       = Color3.fromRGB(245, 245, 245),
    Red         = Color3.fromRGB(255, 80, 80),
    Green       = Color3.fromRGB(100, 255, 100)
}

-- ==================== СОЗДАНИЕ GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlowerHub_Rivals"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 380)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
MainFrame.BackgroundColor3 = Theme.DarkPurple
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Theme.Syringa
Stroke.Thickness = 2
Stroke.Transparency = 0.3
Stroke.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Theme.Black
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🌸 FlowerHub Rivals"
TitleLabel.TextColor3 = Theme.Lavender
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 5)
CloseBtn.BackgroundColor3 = Theme.Black
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Syringa
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Контейнер вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 30)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabContainer

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -95)
ContentFrame.Position = UDim2.new(0, 10, 0, 85)
ContentFrame.BackgroundColor3 = Theme.Black
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- ==================== ВКЛАДКИ ====================
local Tabs = {}
local CurrentTab = "Aim"

local function CreateTab(name)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 100, 1, 0)
    Btn.BackgroundColor3 = Theme.DarkPurple
    Btn.Text = name
    Btn.TextColor3 = Theme.Syringa
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamMedium
    Btn.Parent = TabContainer

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        CurrentTab = name
        for _, child in ipairs(ContentFrame:GetChildren()) do
            if child:IsA("Frame") then child.Visible = false end
        end
        local page = ContentFrame:FindFirstChild(name .. "Page")
        if page then page.Visible = true end

        for _, btn in ipairs(TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = (btn.Text == name) and Theme.Syringa or Theme.DarkPurple
                btn.TextColor3 = (btn.Text == name) and Theme.Black or Theme.Syringa
            end
        end
    end)

    return Btn
end

CreateTab("Aim")
CreateTab("Movement")
CreateTab("Noclip")

-- ==================== СОЗДАНИЕ СТРАНИЦ ====================
local function CreatePage(name)
    local Page = Instance.new("Frame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, -10, 1, -10)
    Page.Position = UDim2.new(0, 5, 0, 5)
    Page.BackgroundTransparency = 1
    Page.Visible = (name == "Aim")
    Page.Parent = ContentFrame

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    return Page
end

local AimPage = CreatePage("Aim")
local MovementPage = CreatePage("Movement")
local NoclipPage = CreatePage("Noclip")

-- ==================== ЭЛЕМЕНТЫ УПРАВЛЕНИЯ ====================
local function CreateToggle(parent, text, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 32)
    Frame.BackgroundColor3 = Theme.DarkPurple
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.Lavender
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 40, 0, 20)
    Toggle.Position = UDim2.new(1, -50, 0.5, -10)
    Toggle.BackgroundColor3 = default and Theme.Syringa or Theme.Black
    Toggle.Text = default and "ON" or "OFF"
    Toggle.TextColor3 = default and Theme.Black or Theme.Syringa
    Toggle.TextSize = 11
    Toggle.Font = Enum.Font.GothamBold
    Toggle.Parent = Frame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = Toggle

    local state = default
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.BackgroundColor3 = state and Theme.Syringa or Theme.Black
        Toggle.Text = state and "ON" or "OFF"
        Toggle.TextColor3 = state and Theme.Black or Theme.Syringa
        if callback then callback(state) end
    end)

    return Toggle, state
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 50)
    Frame.BackgroundColor3 = Theme.DarkPurple
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Theme.Lavender
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -20, 0, 8)
    Bar.Position = UDim2.new(0, 10, 0, 30)
    Bar.BackgroundColor3 = Theme.Black
    Bar.BorderSizePixel = 0
    Bar.Parent = Frame

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 4)
    BarCorner.Parent = Bar

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Syringa
    Fill.BorderSizePixel = 0
    Fill.Parent = Bar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 4)
    FillCorner.Parent = Fill

    local dragging = false

    local function update(input)
        local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Label.Text = text .. ": " .. value
        if callback then callback(value) end
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- ==================== AIM ФУНКЦИИ ====================
local aimbotEnabled = false
local autoFireEnabled = false
local aimSmoothness = 0.15
local currentTarget = nil

local function GetClosestPlayer()
    local closest = nil
    local shortestDist = math.huge
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myPos then return nil end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local dist = (player.Character.HumanoidRootPart.Position - myPos.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closest = player
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and LocalPlayer.Character then
        local target = GetClosestPlayer()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local aimPos = targetPart.Position
                local currentCF = Camera.CFrame
                local newCF = CFrame.new(currentCF.Position, aimPos)
                Camera.CFrame = currentCF:Lerp(newCF, aimSmoothness)
                currentTarget = target
            end
        end
    end

    -- Автострельба (упрощенно: при нажатии ЛКМ, если есть цель)
    if autoFireEnabled and currentTarget and currentTarget.Character then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
end)

-- ==================== MOVEMENT ФУНКЦИИ ====================
local speedEnabled = false
local speedValue = 50
local infiniteJumpEnabled = false
local flyEnabled = false
local flySpeed = 50

local originalSpeed = 16
local originalJumpPower = 50

local function applySpeed()
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedEnabled and speedValue or originalSpeed
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    originalSpeed = humanoid.WalkSpeed
    originalJumpPower = humanoid.UseJumpPower and humanoid.JumpPower or 50
    if speedEnabled then humanoid.WalkSpeed = speedValue end
end)

-- Бесконечные прыжки
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Полет
local flyConnection = nil
local bodyVelocity = nil
local bodyGyro = nil

local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end

    humanoid.PlatformStand = true
    bodyVelocity = Instance.new("BodyVelocity", hrp)
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyGyro = Instance.new("BodyGyro", hrp)
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.P = 1e4

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled or not bodyVelocity or not bodyGyro then return end
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0, 1, 0) end

        if moveDir.Magnitude > 0 then
            bodyVelocity.Velocity = moveDir.Unit * flySpeed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        bodyGyro.CFrame = Camera.CFrame
    end)
end

local function stopFly()
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.PlatformStand = false end
    end
end

-- ==================== NOCLIP ФУНКЦИЯ ====================
local noclipEnabled = false
local noclipConnection = nil

local function startNoclip()
    noclipConnection = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

local function stopNoclip()
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- ==================== ЗАПОЛНЕНИЕ ВКЛАДОК ====================
-- Aim
CreateToggle(AimPage, "Aimbot (автонаводка)", false, function(v) aimbotEnabled = v end)
CreateToggle(AimPage, "Auto Fire (автострельба)", false, function(v) autoFireEnabled = v end)
CreateSlider(AimPage, "Smoothness", 1, 100, 15, function(v) aimSmoothness = v / 100 end)

-- Movement
CreateToggle(MovementPage, "Speed Hack", false, function(v) speedEnabled = v applySpeed() end)
CreateSlider(MovementPage, "Speed Value", 16, 200, 50, function(v) speedValue = v applySpeed() end)
CreateToggle(MovementPage, "Infinite Jump", false, function(v) infiniteJumpEnabled = v end)
CreateToggle(MovementPage, "Fly", false, function(v)
    flyEnabled = v
    if v then startFly() else stopFly() end
end)
CreateSlider(MovementPage, "Fly Speed", 10, 200, 50, function(v) flySpeed = v end)

-- Noclip
CreateToggle(NoclipPage, "Noclip (сквозь стены)", false, function(v)
    noclipEnabled = v
    if v then startNoclip() else stopNoclip() end
end)

-- При респавне отключаем noclip и fly для снижения риска
LocalPlayer.CharacterAdded:Connect(function()
    if noclipEnabled then
        noclipEnabled = false
        stopNoclip()
    end
    if flyEnabled then
        flyEnabled = false
        stopFly()
    end
end)

-- Уведомление
local Notify = Instance.new("TextLabel")
Notify.Size = UDim2.new(0, 300, 0, 40)
Notify.Position = UDim2.new(0.5, -150, 0, 20)
Notify.BackgroundColor3 = Theme.Black
Notify.Text = "🌸 FlowerHub Rivals загружен!"
Notify.TextColor3 = Theme.Syringa
Notify.TextSize = 16
Notify.Font = Enum.Font.GothamBold
Notify.Parent = ScreenGui

local NotifyCorner = Instance.new("UICorner")
NotifyCorner.CornerRadius = UDim.new(0, 8)
NotifyCorner.Parent = Notify

task.delay(3, function()
    Notify:Destroy()
end)

print("FlowerHub Rivals успешно загружен")
