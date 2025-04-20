-- Criador de Botões (criador_botoes.lua)
-- Este arquivo é responsável por criar botões no menu principal com base nas informações obtidas do registro de botões

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Função para criar botões no menu principal
local function criarBotoes()
    -- Verifica se o menu principal existe
    if not CoreGui:FindFirstChild("MenuPrincipal") then
        print("Menu Principal não encontrado!")
        return
    end
    
    -- Carrega o registro de botões
    local registroBotoes = loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/Interface_DragonHUB/refs/heads/main/Main/registro_botoes.lua"))()
    
    -- Encontra o contêiner para os botões (MainContent do menu principal)
    local mainContent = CoreGui.MenuPrincipal.MainFrame.ContentFrame.MainContent
    
    -- Cria um contêiner para organizar os botões
    local botoesContainer = Instance.new("ScrollingFrame")
    botoesContainer.Name = "BotoesContainer"
    botoesContainer.Size = UDim2.new(1, -20, 1, -20)
    botoesContainer.Position = UDim2.new(0, 10, 0, 10)
    botoesContainer.BackgroundTransparency = 1
    botoesContainer.BorderSizePixel = 0
    botoesContainer.ScrollBarThickness = 6
    botoesContainer.ScrollingDirection = Enum.ScrollingDirection.Y
    botoesContainer.CanvasSize = UDim2.new(0, 0, 0, #registroBotoes * 60 + 20) -- Ajusta o tamanho do canvas com base no número de botões
    botoesContainer.Parent = mainContent
    
    -- Cria os botões com base no registro
    for i, botaoInfo in ipairs(registroBotoes) do
        -- Cria o frame do botão
        local botaoFrame = Instance.new("Frame")
        botaoFrame.Name = "Botao_" .. botaoInfo.nome
        botaoFrame.Size = UDim2.new(0, botaoInfo.tamanho.X, 0, botaoInfo.tamanho.Y)
        botaoFrame.Position = UDim2.new(0.5, -botaoInfo.tamanho.X/2, 0, (i-1) * 60 +
         10) -- Posiciona cada botão em sequência
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

-- Função para atualizar os botões (para ser chamada quando necessário)
local function atualizarBotoes()
    -- Remove os botões existentes
    local mainContent = CoreGui.MenuPrincipal.MainFrame.ContentFrame.MainContent
    if mainContent:FindFirstChild("BotoesContainer") then
        mainContent.BotoesContainer:Destroy()
    end
    
    -- Cria os botões novamente
    criarBotoes()
end

-- Retorna as funções para serem usadas externamente
return {
    criarBotoes = criarBotoes,
    atualizarBotoes = atualizarBotoes
}
