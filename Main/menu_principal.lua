-- Menu Principal (menu_principal.lua)
-- Este é o menu principal, que é quadrado e arrastável, com botões de minimizar, maximizar e fechar

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Carregar a barra de menus junto com o menu principal
local function carregarBarraDeMenus()
    loadstring(game:HttpGet("https://exemplo.com/barra_menus.lua"))()
end

-- Função para carregar o botão flutuante quando fechar o menu
local function carregarFlutuante()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/Flutuante.lua"))()
end

-- Criar a interface do menu principal
local function criarMenuPrincipal()
    -- Verificar se já existe um menu principal
    if CoreGui:FindFirstChild("MenuPrincipal") then
        CoreGui.MenuPrincipal:Destroy()
    end
    
    local menuPrincipal = Instance.new("ScreenGui")
    menuPrincipal.Name = "MenuPrincipal"
    menuPrincipal.Parent = CoreGui
    menuPrincipal.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200) -- Centralizado na tela
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = menuPrincipal
    
    -- Barra superior (título e botões de controle)
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame
    
    -- Título do menu
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -90, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "Menu Principal"
    title.TextSize = 16
    title.Font = Enum.Font.SourceSansBold
    title.Parent = topBar
    
    -- Botão de minimizar (-)
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -90, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "-"
    minimizeButton.TextSize = 20
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.Parent = topBar
    
    -- Botão de maximizar (+)
    local maximizeButton = Instance.new("TextButton")
    maximizeButton.Name = "MaximizeButton"
    maximizeButton.Size = UDim2.new(0, 30, 0, 30)
    maximizeButton.Position = UDim2.new(1, -60, 0, 0)
    maximizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    maximizeButton.BorderSizePixel = 0
    maximizeButton.Text = "+"
    maximizeButton.TextSize = 20
    maximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeButton.Font = Enum.Font.SourceSansBold
    maximizeButton.Parent = topBar
    
    -- Botão de fechar (x)
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "X"
    closeButton.TextSize = 16
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = topBar
    
    -- Container para o conteúdo
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame
    
    -- Espaço para a barra de menus
    local menuBarContainer = Instance.new("Frame")
    menuBarContainer.Name = "MenuBarContainer"
    menuBarContainer.Size = UDim2.new(1, 0, 0, 30)
    menuBarContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    menuBarContainer.BorderSizePixel = 0
    menuBarContainer.Parent = contentFrame
    
    -- Espaço principal para o conteúdo dos menus
    local mainContent = Instance.new("Frame")
    mainContent.Name = "MainContent"
    mainContent.Size = UDim2.new(1, 0, 1, -30)
    mainContent.Position = UDim2.new(0, 0, 0, 30)
    mainContent.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    mainContent.BorderSizePixel = 0
    mainContent.Parent = contentFrame
    
    -- Variáveis para controlar o estado
    local minimized = false
    local originalSize = UDim2.new(0, 600, 0, 400)
    local minimizedSize = UDim2.new(0, 600, 0, 30)
    
    -- Funcionalidade do botão de minimizar
    minimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            -- Minimizar
            mainFrame:TweenSize(minimizedSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
            minimized = true
            minimizeButton.Text = "+"
            maximizeButton.Visible = false
        else
            -- Restaurar
            mainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
            minimized = false
            minimizeButton.Text = "-"
            maximizeButton.Visible = true
        end
    end)
    
    -- Funcionalidade do botão de maximizar (restaurar tamanho padrão)
    maximizeButton.MouseButton1Click:Connect(function()
        mainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    end)
    
    -- Funcionalidade do botão de fechar
    closeButton.MouseButton1Click:Connect(function()
        menuPrincipal:Destroy()
        carregarFlutuante()
    end)
    
    -- Tornar o menu arrastável pela barra superior
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Inicializar o menu principal
criarMenuPrincipal()

-- Carregar a barra de menus
carregarBarraDeMenus()
