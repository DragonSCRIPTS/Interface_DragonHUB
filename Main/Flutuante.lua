-- Flutuante.lua
-- Este é o botão flutuante que aparece quando o menu principal é fechado

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Função para carregar o menu principal quando clicar no flutuante
local function carregarMenuPrincipal()
    loadstring(game:HttpGet("https://exemplo.com/menu_principal.lua"))()
    -- Remover o flutuante quando o menu principal for carregado
    if CoreGui:FindFirstChild("FloatingButton") then
        CoreGui.FloatingButton:Destroy()
    end
end

-- Criar o botão flutuante
local function criarBotaoFlutuante()
    -- Verifica se já existe um botão flutuante
    if CoreGui:FindFirstChild("FloatingButton") then
        CoreGui.FloatingButton:Destroy()
    end
    
    local floatingButton = Instance.new("ScreenGui")
    floatingButton.Name = "FloatingButton"
    floatingButton.Parent = CoreGui
    floatingButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local button = Instance.new("Frame")
    button.Name = "Button"
    button.Size = UDim2.new(0, 50, 0, 50)
    button.Position = UDim2.new(0.9, 0, 0.5, 0) -- Posição padrão no lado direito da tela
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BorderSizePixel = 0
    button.Parent = floatingButton
    
    -- Tornar o botão redondo
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0) -- Faz o botão ser perfeitamente redondo
    uiCorner.Parent = button
    
    -- Adicionar um ícone ou texto
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.Text = "+"
    icon.TextSize = 30
    icon.Font = Enum.Font.SourceSansBold
    icon.Parent = button
    
    -- Efeito de hover
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    
    -- Tornar o botão arrastável
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Ao clicar no botão (e soltar), carrega o menu principal
    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Se o mouse não moveu muito (não foi um arrasto), considere como um clique
            if (input.Position - dragStart).Magnitude < 5 then
                carregarMenuPrincipal()
            end
        end
    end)
end

-- Inicializar o botão flutuante
criarBotaoFlutuante()
