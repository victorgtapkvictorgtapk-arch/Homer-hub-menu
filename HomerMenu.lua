--[[
    🟣 HOMER MENU v2.0
    Tema: Neon Roxo
    Compatível com Executor Delta
    Script para "You vs Homer"
    GitHub: https://github.com/seuusuario/homermenu
]]

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Jogador Local
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configurações
local Settings = {
    Noclip = false,
    InfiniteJump = false,
    SpeedEnabled = false,
    WalkSpeed = 16,
    JumpForce = 50,
    MaxHeight = 500,
    MaxSpeed = 80,
    SpeedIncrement = 4
}

-- Cores Neon Roxo
local Colors = {
    Background = Color3.fromRGB(15, 15, 15),
    Header = Color3.fromRGB(25, 25, 25),
    NeonPurple = Color3.fromRGB(170, 0, 255),
    NeonLight = Color3.fromRGB(200, 50, 255),
    Text = Color3.fromRGB(255, 255, 255),
    ButtonOn = Color3.fromRGB(100, 0, 150),
    ButtonOff = Color3.fromRGB(40, 40, 40),
    Danger = Color3.fromRGB(255, 50, 50)
}

-- Criar Interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HomerMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 450)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -225)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0

-- Borda Neon
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Colors.NeonPurple
FrameStroke.Thickness = 2
FrameStroke.Transparency = 0.3
FrameStroke.Parent = MainFrame

-- Cantos arredondados
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Parent = MainFrame

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Colors.Header
Header.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🟣 Homer Menu"
Title.TextColor3 = Colors.NeonLight
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextStrokeColor3 = Colors.NeonPurple
Title.TextStrokeTransparency = 0.7

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Colors.NeonPurple
CloseButton.Text = "X"
CloseButton.TextColor3 = Colors.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16

-- Área de Conteúdo
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -65)
ContentFrame.Position = UDim2.new(0, 10, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4
ContentFrame.ScrollBarImageColor3 = Colors.NeonPurple
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = ContentFrame

-- Função para criar botão
local function CreateButton(text, yPosition, isDanger, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, 0, yPosition)
    Button.BackgroundColor3 = isDanger and Colors.Danger or Colors.NeonPurple
    Button.Text = text
    Button.TextColor3 = Colors.Text
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.AutoButtonColor = true
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Colors.NeonLight
    ButtonStroke.Thickness = 1
    ButtonStroke.Transparency = 0.5
    ButtonStroke.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    Button.Parent = ContentFrame
    
    return Button
end

-- Função para criar toggle
local function CreateToggle(text, yPosition, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "ToggleFrame"
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
    ToggleFrame.Position = UDim2.new(0.05, 0, 0, yPosition)
    ToggleFrame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Colors.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 60, 0, 25)
    ToggleButton.Position = UDim2.new(1, -65, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = Colors.ButtonOff
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Colors.Text
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 12
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = ToggleButton
    
    Label.Parent = ToggleFrame
    ToggleButton.Parent = ToggleFrame
    ToggleFrame.Parent = ContentFrame
    
    return ToggleButton
end

-- Montar interface
Header.Parent = MainFrame
Title.Parent = Header
CloseButton.Parent = Header
ContentFrame.Parent = MainFrame
MainFrame.Parent = ScreenGui
ScreenGui.Parent = game:GetService("CoreGui")

-- Criar botões e toggles
local buttonY = 0
local buttons = {}

-- 1. Noclip
local noclipToggle = CreateToggle("🔄 Noclip", buttonY, function() end)
buttonY = buttonY + 40

-- 2. Pulos Infinitos
local jumpToggle = CreateToggle("🏃‍♂️ Pulos Infinitos", buttonY, function() end)
buttonY = buttonY + 40

-- 3. Velocidade
local speedButton = CreateButton("⚡ Velocidade: " .. Settings.WalkSpeed, buttonY, false, function() end)
buttonY = buttonY + 45

-- 4. Matar Todos
local killButton = CreateButton("💀 Matar Todos", buttonY, true, function() end)
buttonY = buttonY + 45

-- 5. Matar como Homer
local homerButton = CreateButton("👊 Matar como Homer", buttonY, true, function() end)
buttonY = buttonY + 45

-- Ajustar tamanho do canvas
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Funcionalidade Noclip
noclipToggle.MouseButton1Click:Connect(function()
    Settings.Noclip = not Settings.Noclip
    noclipToggle.BackgroundColor3 = Settings.Noclip and Colors.ButtonOn or Colors.ButtonOff
    noclipToggle.Text = Settings.Noclip and "ON" or "OFF"
    
    if Settings.Noclip then
        local noclipConnection
        noclipConnection = RunService.Stepped:Connect(function()
            if Settings.Noclip and Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                if noclipConnection then
                    noclipConnection:Disconnect()
                end
            end
        end)
    else
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Funcionalidade Pulos Infinitos
jumpToggle.MouseButton1Click:Connect(function()
    Settings.InfiniteJump = not Settings.InfiniteJump
    jumpToggle.BackgroundColor3 = Settings.InfiniteJump and Colors.ButtonOn or Colors.ButtonOff
    jumpToggle.Text = Settings.InfiniteJump and "ON" or "OFF"
    
    if Settings.InfiniteJump then
        UserInputService.JumpRequest:Connect(function()
            if Settings.InfiniteJump and Character then
                local root = Character:FindFirstChild("HumanoidRootPart")
                if root and root.Position.Y < Settings.MaxHeight then
                    root.Velocity = Vector3.new(root.Velocity.X, Settings.JumpForce, root.Velocity.Z)
                end
            end
        end)
    end
end)

-- Funcionalidade Velocidade
speedButton.MouseButton1Click:Connect(function()
    Settings.SpeedEnabled = not Settings.SpeedEnabled
    
    if Settings.SpeedEnabled then
        Settings.WalkSpeed = math.min(Settings.WalkSpeed + Settings.SpeedIncrement, Settings.MaxSpeed)
    else
        Settings.WalkSpeed = 16
    end
    
    Humanoid.WalkSpeed = Settings.WalkSpeed
    speedButton.Text = "⚡ Velocidade: " .. Settings.WalkSpeed
end)

-- Funcionalidade Matar Todos
killButton.MouseButton1Click:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum.Health = 0
                end
            end
        end
    end
end)

-- Funcionalidade Matar como Homer
homerButton.MouseButton1Click:Connect(function()
    local isHomer = false
    if Character:FindFirstChild("Humanoid") then
        local name = Character.Humanoid.DisplayName or Character.Name
        isHomer = string.find(string.lower(name), "homer") or 
                  string.find(string.lower(name), "simpson")
    end
    
    if isHomer then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then
                        hum.Health = 0
                        -- Efeito especial
                        local explosion = Instance.new("Explosion")
                        explosion.Position = char:FindFirstChild("HumanoidRootPart").Position
                        explosion.BlastRadius = 15
                        explosion.Parent = Workspace
                    end
                end
            end
        end
    else
        warn("⚠️ Você precisa ser o Homer para usar esta função!")
    end
end)

-- Fechar menu
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sistema de arrastar
local dragging = false
local dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Atualizar quando o personagem mudar
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    
    -- Reaplicar velocidade se ativa
    if Settings.SpeedEnabled then
        Humanoid.WalkSpeed = Settings.WalkSpeed
    end
end)

print("✅ Homer Menu v2.0 carregado com sucesso!")
print("🎮 Compatível com You vs Homer")
print("🟣 Tema Neon Roxo ativado")
