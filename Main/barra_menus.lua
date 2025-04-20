-- Barra de Menus (barra_menus.lua)
-- Este arquivo implementa a barra de menus e carrega a configuração dos menus

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Carregar a configuração dos menus
local function carregarConfiguracao()
    local success, menuConfig = pcall(function()
        return loadstring(game:HttpGet("https://exemplo.com/config_menus.lua"))()
    end)
    
    if success then
        return menuConfig
    else
        warn("Erro ao carregar configuração dos menus: " .. menuConfig)
        return {}
    end
end

-- Função para criar um botão de menu
local function criarBotaoMenu(nome, index, ativo, imagemURL)
    local menu = Instance.new("TextButton")
    menu.Name = nome
    menu.Size = UDim2.new(0, 100, 1, 0)
    menu.Position = UDim2.new(0, (index - 1) * 100, 0, 0)
    menu.BackgroundColor3 = ativo and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
    menu.BorderSizePixel = 0
    menu.TextColor3 = Color3.fromRGB(255, 255, 255)
    menu.Text = nome
    menu.TextSize = 14
    menu.Font = Enum.Font.SourceSans
    menu.AutoButtonColor = false
    
    -- Se tiver uma imagem e estiver ativo
    if imagemURL and ativo then
        menu.Text = ""
        
        local imagem = Instance.new("ImageLabel")
        imagem.Name = "Imagem"
        imagem.Size = UDim2.new(0, 20, 0, 20)
        imagem.Position = UDim2.new(0.5, -10, 0.5, -10)
        imagem.BackgroundTransparency = 1
        imagem.Image = imagemURL
        imagem.Parent = menu
        
        local texto = Instance.new("TextLabel")
        texto.Name = "Texto"
        texto.Size = UDim2.new(1, 0, 0, 20)
        texto.Position = UDim2.new(0, 0, 0.5, 10)
        texto.BackgroundTransparency = 1
        texto.TextColor3 = Color3.fromRGB(255, 255, 255)
        texto.Text = nome
        texto.TextSize = 12
        texto.Font = Enum.Font.SourceSans
        texto.Parent = menu
    end
    
    -- Efeitos hover
    menu.MouseEnter:Connect(function()
        menu.BackgroundColor3 = ativo and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
    end)
    
    menu.MouseLeave:Connect(function()
        menu.BackgroundColor3 = ativo and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
    end)
    
    return menu
end

-- Função para mostrar conteúdo de um menu
local function mostrarConteudoMenu(menuNome)
    local menuPrincipal = CoreGui:FindFirstChild("MenuPrincipal")
    if not menuPrincipal then return end
    
    local mainContent = menuPrincipal.MainFrame.ContentFrame.MainContent
    
    -- Limpar conteúdo atual
    for _, child in pairs(mainContent:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Criar novo conteúdo baseado no menu selecionado
    local content = Instance.new("Frame")
    content.Name = menuNome .. "Content"
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.Parent = mainContent
    
    -- Carregar os botões específicos para este menu
    -- Aqui seria onde você carregaria os botões específicos para cada menu
    -- usando o mesmo método loadstring
    pcall(function()
        loadstring(game:HttpGet("https://exemplo.com/botoes_" .. string.lower(menuNome) .. ".lua"))()
    end)
    
    -- Exemplo de conteúdo padrão caso o arquivo de botões não exista
    local titulo = Instance.new("TextLabel")
    titulo.Name = "Titulo"
    titulo.Size = UDim2.new(1, 0, 0, 40)
    titulo.Position = UDim2.new(0, 0, 0, 20)
    titulo.BackgroundTransparency = 1
    titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
    titulo.Text = "Menu " .. menuNome
    titulo.TextSize = 24
    titulo.Font = Enum.Font.SourceSansBold
    titulo.Parent = content
    
    local descricao = Instance.new("TextLabel")
    descricao.Name = "Descricao"
    descricao.Size = UDim2.new(1, -40, 0, 30)
    descricao.Position = UDim2.new(0, 20, 0, 70)
    descricao.BackgroundTransparency = 1
    descricao.TextColor3 = Color3.fromRGB(200, 200, 200)
    descricao.Text = "Conteúdo do menu " .. menuNome .. " será carregado aqui."
    descricao.TextSize = 16
    descricao.Font = Enum.Font.SourceSans
    descricao.TextWrapped = true
    descricao.Parent = content
end

-- Função para atualizar qual menu está ativo
local function atualizarMenuAtivo(menuButtons, menuAtivo)
    for nome, button in pairs(menuButtons) do
        button.BackgroundColor3 = (nome == menuAtivo) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
    end
end

-- Função principal para criar a barra de menus
local function criarBarraMenus()
    local menuConfig = carregarConfiguracao()
    if not menuConfig or #menuConfig == 0 then
        warn("Não foi possível carregar a configuração dos menus ou ela está vazia")
        return
    end
    
    local menuPrincipal = CoreGui:FindFirstChild("MenuPrincipal")
    if not menuPrincipal then return end
    
    local menuBarContainer = menuPrincipal.MainFrame.ContentFrame.MenuBarContainer
    
    -- Limpar menus existentes
    for _, child in pairs(menuBarContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Criar botões de menu baseados na configuração
    local menuButtons = {}
    local menuAtivo = nil
    
    for i, menuInfo in ipairs(menuConfig) do
        local nome = menuInfo.nome
        local ativo = menuInfo.ativo
        local imagemURL = menuInfo.imagemURL
        
        local button = criarBotaoMenu(nome, i, ativo, imagemURL)
        button.Parent = menuBarContainer
        menuButtons[nome] = button
        
        if ativo and not menuAtivo then
            menuAtivo = nome
        end
        
        -- Adicionar funcionalidade ao botão
        button.MouseButton1Click:Connect(function()
            menuAtivo = nome
            atualizarMenuAtivo(menuButtons, menuAtivo)
            mostrarConteudoMenu(nome)
        end)
    end
    
    -- Mostrar o conteúdo do menu ativo inicial
    if menuAtivo then
        mostrarConteudoMenu(menuAtivo)
    end
end

-- Iniciar a barra de menus
criarBarraMenus()
