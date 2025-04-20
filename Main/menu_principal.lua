-- Menu Principal (menu_principal.lua)
-- Este é o menu principal, que é quadrado e arrastável, com botões de minimizar, maximizar e fechar

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Carregar a barra de menus junto com o menu principal
local function carregarBarraDeMenus()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/barra_menus.lua"))()
end

-- Função para carregar o botão flutuante quando fechar o menu
local function carregarFlutuante()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/Flutuante.lua"))()
end

-- Função para carregar o criador de botões com filtro por menu
local function carregarCriadorBotoesComFiltro(nomeMenu)
    -- Carrega o script de criação de botões
    local criadorBotoes = loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/criador_botoes.lua"))()
    
    -- Modifica a função criarBotoes antes de usar
    local criarBotoesOriginal = criadorBotoes.criarBotoes
    
    -- Substitui a função original para incluir filtro por menu
    criadorBotoes.criarBotoes = function()
        -- Carrega o registro de botões
        local registroBotoes = loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/registro_botoes.lua"))()
        
        -- Verifica se o menu principal existe
        if not CoreGui:FindFirstChild("MenuPrincipal") then
            print("Menu Principal não encontrado!")
            return
        end
        
        -- Encontra o contêiner para os botões
        local mainContent = CoreGui.MenuPrincipal.MainFrame.ContentFrame.MainContent
        
        -- Cria um contêiner para organizar os botões
        local botoesContainer = Instance.new("ScrollingFrame")
        botoesContainer.Name = "BotoesContainer"
        botoesContainer.Size = UDim2.new(1, -20, 1, -60) -- Ajustado para deixar espaço para o título
        botoesContainer.Position = UDim2.new(0, 10, 0, 50) -- Posicionado abaixo do título
        botoesContainer.BackgroundTransparency = 1
        botoesContainer.BorderSizePixel = 0
        botoesContainer.ScrollBarThickness = 6
        botoesContainer.ScrollingDirection = Enum.ScrollingDirection.Y
        botoesContainer.Parent = mainContent
        
        -- Filtra os botões pelo menu selecionado
        local botoesFiltrados = {}
        for _, botao in ipairs(registroBotoes) do
            if botao.menu and botao.menu:lower() == nomeMenu:lower() then
                table.insert(botoesFiltrados, botao)
            end
        end
        
        -- Ajusta o tamanho do canvas com base no número de botões filtrados
        botoesContainer.CanvasSize = UDim2.new(0, 0, 0, #botoesFiltrados * 60 + 20)
        
        -- Mensagem para quando não há botões para o menu selecionado
        if #botoesFiltrados == 0 then
            local semBotoesMsg = Instance.new("TextLabel")
            semBotoesMsg.Name = "SemBotoesMsg"
            semBotoesMsg.Size = UDim2.new(1, -20, 0, 40)
            semBotoesMsg.Position = UDim2.new(0, 10, 0, 10)
            semBotoesMsg.BackgroundTransparency = 1
            semBotoesMsg.TextColor3 = Color3.fromRGB(255, 255, 255)
            semBotoesMsg.Text = "Não há botões disponíveis para este menu."
            semBotoesMsg.TextSize = 18
            semBotoesMsg.Font = Enum.Font.SourceSans
            semBotoesMsg.Parent = botoesContainer
            return
        end
        
        -- Cria os botões filtrados
        for i, botaoInfo in ipairs(botoesFiltrados) do
            -- Cria o frame do botão
            local botaoFrame = Instance.new("Frame")
            botaoFrame.Name = "Botao_" .. botaoInfo.nome
            botaoFrame.Size = UDim2.new(0, botaoInfo.tamanho.X, 0, botaoInfo.tamanho.Y)
            botaoFrame.Position = UDim2.new(0.5, -botaoInfo.tamanho.X/2, 0, (i-1) * 60 + 10)
            botaoFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            botaoFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
            botaoFrame.BorderSizePixel = 2
            botaoFrame.Parent = botoesContainer
            
            -- Cria o botão clicável
            local botao = Instance.new("TextButton")
            botao.Name = "Botao"
            botao.Size = UDim2.new(1, 0, 1, 0)
            botao.BackgroundTransparency = 0.2
            botao.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            botao.BorderSizePixel = 0
            botao.Text = botaoInfo.nome
            botao.TextColor3 = Color3.fromRGB(255, 255, 255)
            botao.Font = Enum.Font.SourceSansBold
            botao.TextSize = 16
            botao.Parent = botaoFrame
            
            -- Adiciona efeito de hover
            local originalColor = botao.BackgroundColor3
            local hoverColor = Color3.fromRGB(90, 90, 90)
            
            botao.MouseEnter:Connect(function()
                botao.BackgroundColor3 = hoverColor
            end)
            
            botao.MouseLeave:Connect(function()
                botao.BackgroundColor3 = originalColor
            end)
            
            -- Adiciona a função de clique para carregar a lógica
            botao.MouseButton1Click:Connect(function()
                -- Executa o script do link fornecido
                pcall(function()
                    loadstring(game:HttpGet(botaoInfo.linkCarregamento))()
                    print("Carregado: " .. botaoInfo.nome)
                end)
            end)
            
            -- Adiciona um ícone se especificado
            if botaoInfo.icone then
                local icone = Instance.new("ImageLabel")
                icone.Name = "Icone"
                icone.Size = UDim2.new(0, 20, 0, 20)
                icone.Position = UDim2.new(0, 5, 0.5, -10)
                icone.BackgroundTransparency = 1
                icone.Image = botaoInfo.icone
                icone.Parent = botaoFrame
                
                -- Ajusta a posição do texto para acomodar o ícone
                botao.TextXAlignment = Enum.TextXAlignment.Center
            end
            
            -- Adiciona uma descrição (tooltip) se especificada
            if botaoInfo.descricao then
                -- Cria um tooltip que aparece ao passar o mouse
                local tooltip = Instance.new("Frame")
                tooltip.Name = "Tooltip"
                tooltip.Size = UDim2.new(0, 200, 0, 40)
                tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                tooltip.BorderColor3 = Color3.fromRGB(60, 60, 60)
                tooltip.BorderSizePixel = 1
                tooltip.Visible = false
                tooltip.ZIndex = 10
                tooltip.Parent = botaoFrame
                
                local tooltipText = Instance.new("TextLabel")
                tooltipText.Name = "TooltipText"
                tooltipText.Size = UDim2.new(1, -10, 1, -10)
                tooltipText.Position = UDim2.new(0, 5, 0, 5)
                tooltipText.BackgroundTransparency = 1
                tooltipText.TextColor3 = Color3.fromRGB(255, 255, 255)
                tooltipText.TextWrapped = true
                tooltipText.Text = botaoInfo.descricao
                tooltipText.Font = Enum.Font.SourceSans
                tooltipText.TextSize = 14
                tooltipText.ZIndex = 11
                tooltipText.Parent = tooltip
                
                botao.MouseEnter:Connect(function()
                    tooltip.Position = UDim2.new(1, 10, 0, 0)
                    tooltip.Visible = true
                end)
                
                botao.MouseLeave:Connect(function()
                    tooltip.Visible = false
                end)
            end
        end
    end
    
    -- Chama a função modificada
    criadorBotoes.criarBotoes()
    
    return criadorBotoes
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
    title.Text = "Dragon HUB"
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
    
    -- Mensagem de boas-vindas inicial no MainContent
    local welcomeMessage = Instance.new("TextLabel")
    welcomeMessage.Name = "WelcomeMessage"
    welcomeMessage.Size = UDim2.new(1, -40, 0, 40)
    welcomeMessage.Position = UDim2.new(0, 20, 0, 20)
    welcomeMessage.BackgroundTransparency = 1
    welcomeMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeMessage.Text = "Bem-vindo ao Dragon HUB! Selecione um menu acima para ver as opções disponíveis."
    welcomeMessage.TextSize = 18
    welcomeMessage.Font = Enum.Font.SourceSans
    welcomeMessage.Parent = mainContent
    
    return menuPrincipal
end

-- Inicializar o menu principal
local menuPrincipal = criarMenuPrincipal()

-- Carregar a barra de menus
carregarBarraDeMenus()

-- Modifica a barra de menus para chamar o criador de botões ao clicar nos menus
local function modificarBarraMenus()
    -- Aguarda a criação completa da barra de menus
    wait(0.5)
    
    -- Encontra a barra de menus
    local menuBarContainer = menuPrincipal.MainFrame.ContentFrame.MenuBarContainer
    
    -- Verifica se a barra existe
    if menuBarContainer then
        -- Procura todos os botões de menu na barra
        for _, botaoMenu in pairs(menuBarContainer:GetChildren()) do
            if botaoMenu:IsA("TextButton") then
                -- Substitui o evento de clique para chamar o criador de botões com o nome do menu
                botaoMenu.MouseButton1Click:Connect(function()
                    -- Nome do menu para filtrar os botões
                    local nomeMenu = botaoMenu.Text:lower()
                    
                    -- Limpa o conteúdo principal
                    local mainContent = menuPrincipal.MainFrame.ContentFrame.MainContent
                    for _, child in pairs(mainContent:GetChildren()) do
                        child:Destroy()
                    end
                    
                    -- Título do menu selecionado
                    local menuTitle = Instance.new("TextLabel")
                    menuTitle.Name = "MenuTitle"
                    menuTitle.Size = UDim2.new(1, -40, 0, 40)
                    menuTitle.Position = UDim2.new(0, 20, 0, 10)
                    menuTitle.BackgroundTransparency = 1
                    menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    menuTitle.Text = "Menu: " .. botaoMenu.Text
                    menuTitle.TextSize = 22
                    menuTitle.Font = Enum.Font.SourceSansBold
                    menuTitle.TextXAlignment = Enum.TextXAlignment.Left
                    menuTitle.Parent = mainContent
                    
                    -- Carrega o criador de botões e cria os botões filtrados pelo menu
                    local criadorBotoes = carregarCriadorBotoesComFiltro(nomeMenu)
                    
                    -- Mensagem de carregamento
                    print("Carregando botões para o menu: " .. botaoMenu.Text)
                end)
            end
        end
    else
        warn("Barra de menus não encontrada!")
    end
end

-- Chama a função para modificar a barra de menus após um breve atraso
spawn(modificarBarraMenus)
