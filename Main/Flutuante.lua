-- Flutuante.lua
-- Este é o botão flutuante que aparece quando o menu principal é fechado

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

-- Determinar onde colocar a GUI (CoreGui pode dar problemas em alguns casos)
local parent = game:GetService("CoreGui")

-- ID da imagem para o botão flutuante
local imageId = "rbxassetid://126417791294855"

-- Função para carregar o menu principal quando clicar no flutuante
local function carregarMenuPrincipal()
    -- Usar pcall para capturar erros
    local success, errorMsg = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/menu_principal.lua"))()
    end)
    
    if not success then
        warn("Erro ao carregar menu principal: " .. errorMsg)
    end
    
    -- Remover o flutuante quando o menu principal for carregado
    if parent:FindFirstChild("DragonHUB_FloatingButton") then
        parent.DragonHUB_FloatingButton:Destroy()
    end
end

-- Criar o botão flutuante
local function criarBotaoFlutuante()
    -- Verifica se já existe um botão flutuante
    if parent:FindFirstChild("DragonHUB_FloatingButton") then
        parent.DragonHUB_FloatingButton:Destroy()
    end
    
    local floatingButton = Instance.new("ScreenGui")
    floatingButton.Name = "DragonHUB_FloatingButton"
    floatingButton.Parent = parent
    floatingButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    floatingButton.ResetOnSpawn = false
    
    local button = Instance.new("Frame")
    button.Name = "Button"
    button.Size = UDim2.new(0, 60, 0, 60)
    button.Position = UDim2.new(0.95, -30, 0.5, 0) -- Posição no lado direito da tela
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Preto
    button.BorderSizePixel = 0
    button.Active = true
    button.Parent = floatingButton
    
    -- Adicionar um efeito de sombra
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1.2, 0, 1.2, 0)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084" -- Imagem de sombra circular
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ZIndex = -1
    shadow.Parent = button
    
    -- Tornar o botão redondo
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0) -- Faz o botão ser perfeitamente redondo
    uiCorner.Parent = button
    
    -- Adicionar a imagem DragonHUB no lugar do texto
    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(0.8, 0, 0.8, 0)
    logo.Position = UDim2.new(0.5, 0, 0.5, 0)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundTransparency = 1
    logo.Image = imageId
    logo.ScaleType = Enum.ScaleType.Fit
    logo.Parent = button
    
    -- Adicionar um efeito de brilho sutil
    local highlight = Instance.new("UIStroke")
    highlight.Name = "Highlight"
    highlight.Color = Color3.fromRGB(80, 80, 80)
    highlight.Thickness = 1.5
    highlight.Transparency = 0.5
    highlight.Parent = button
    
    -- Efeito de hover
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Cinza escuro ao passar o mouse
        highlight.Color = Color3.fromRGB(120, 120, 120)
        -- Não precisamos mais mudar a cor do texto já que estamos usando imagem
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Volta para preto
        highlight.Color = Color3.fromRGB(80, 80, 80)
    end)
    
    -- Tornar o botão clicável
    local clickDetector = Instance.new("TextButton")
    clickDetector.Name = "ClickDetector"
    clickDetector.Size = UDim2.new(1, 0, 1, 0)
    clickDetector.BackgroundTransparency = 1
    clickDetector.Text = ""
    clickDetector.Parent = button
    
    -- Tornar o botão arrastável
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    clickDetector.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
    
    clickDetector.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Adicionar efeito de clique visual
    clickDetector.MouseButton1Down:Connect(function()
        button:TweenSize(UDim2.new(0, 55, 0, 55), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
        logo:TweenSize(UDim2.new(0.75, 0, 0.75, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
    end)
    
    clickDetector.MouseButton1Up:Connect(function()
        button:TweenSize(UDim2.new(0, 60, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
        logo:TweenSize(UDim2.new(0.8, 0, 0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
        
        -- Verificar se foi realmente um clique ou um arrasto
        if not dragging or (dragInput and (dragInput.Position - dragStart).Magnitude < 5) then
            carregarMenuPrincipal()
        end
    end)
    
    -- Adicionar função de clique direta
    clickDetector.MouseButton1Click:Connect(function()
        carregarMenuPrincipal()
    end)
    
    -- Adicionar efeito de pulsação para chamar atenção
    spawn(function()
        while button.Parent do
            for i = 0, 1, 0.1 do
                if not button or not button.Parent then break end
                highlight.Transparency = 0.7 - (0.3 * i)
                wait(0.05)
            end
            
            for i = 0, 1, 0.1 do
                if not button or not button.Parent then break end
                highlight.Transparency = 0.4 + (0.3 * i)
                wait(0.05)
            end
            
            wait(1)
        end
    end)
    
    -- Adicionar efeito de rotação suave para a logo
    spawn(function()
        while button.Parent do
            for i = 0, 360, 1 do
                if not button or not button.Parent or not logo or not logo.Parent then break end
                logo.Rotation = i / 180
                wait(0.1)
            end
        end
    end)
    
    -- Adicionar tratamento para erro de imagem
    logo.ImageRectSize = Vector2.new(0, 0)
    logo:GetPropertyChangedSignal("IsLoaded"):Connect(function()
        if not logo.IsLoaded then
            -- Falha ao carregar a imagem, usar texto como backup
            logo.Visible = false
            
            local textBackup = Instance.new("TextLabel")
            textBackup.Name = "TextBackup"
            textBackup.Size = UDim2.new(1, -10, 1, -10)
            textBackup.Position = UDim2.new(0, 5, 0, 5)
            textBackup.BackgroundTransparency = 1
            textBackup.TextColor3 = Color3.fromRGB(255, 255, 255)
            textBackup.Text = "Dragon\nHUB"
            textBackup.TextSize = 14
            textBackup.Font = Enum.Font.GothamBold
            textBackup.Parent = button
            
            button.MouseEnter:Connect(function()
                textBackup.TextColor3 = Color3.fromRGB(255, 100, 100)
            end)
            
            button.MouseLeave:Connect(function()
                textBackup.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
        end
    end)
end

-- Inicializar o botão flutuante com um pequeno atraso para garantir que tudo está carregado
spawn(function()
    wait(0.5)
    criarBotaoFlutuante()
end)
