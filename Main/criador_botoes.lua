-- Criador de Botões (criador_botoes.lua)
-- Este arquivo é responsável por criar botões no menu principal com base nas informações obtidas do registro de botões

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

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
    botoesContainer.ScrollBarThickness = 4
    botoesContainer.ScrollingDirection = Enum.ScrollingDirection.Y
    botoesContainer.CanvasSize = UDim2.new(0, 0, 0, #registroBotoes * 45 + 20) -- Reduzido o espaçamento
    botoesContainer.Parent = mainContent
    
    -- Cria os botões com base no registro
    for i, botaoInfo in ipairs(registroBotoes) do
        -- Tamanho padrão menor para os botões
        local tamanhoBotao = Vector2.new(botaoInfo.tamanho and botaoInfo.tamanho.X or 180, botaoInfo.tamanho and botaoInfo.tamanho.Y or 40)
        
        -- Cria o frame do botão
        local botaoFrame = Instance.new("Frame")
        botaoFrame.Name = "Botao_" .. botaoInfo.nome
        botaoFrame.Size = UDim2.new(0, tamanhoBotao.X, 0, tamanhoBotao.Y)
        botaoFrame.Position = UDim2.new(0.5, -tamanhoBotao.X/2, 0, (i-1) * 45 + 10) -- Reduzido o espaçamento
        botaoFrame.BackgroundTransparency = 1
        botaoFrame.Parent = botoesContainer
        
        -- Cria o botão redondo com gradiente
        local botao = Instance.new("TextButton")
        botao.Name = "Botao"
        botao.Size = UDim2.new(1, 0, 1, 0)
        botao.BackgroundColor3 = Color3.fromRGB(60, 60, 80) -- Cor base mais bonita
        botao.BorderSizePixel = 0
        botao.Text = botaoInfo.nome
        botao.TextColor3 = Color3.fromRGB(255, 255, 255)
        botao.Font = Enum.Font.GothamSemibold -- Fonte mais moderna
        botao.TextSize = 14
        botao.Parent = botaoFrame
        
        -- Adiciona cantos arredondados
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.5, 0) -- Botão completamente redondo (arredonda metade da altura)
        UICorner.Parent = botao
        
        -- Adiciona um gradiente para melhorar a aparência
        local UIGradient = Instance.new("UIGradient")
        UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 110)), -- Cor superior mais clara
            ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 70))  -- Cor inferior mais escura
        })
        UIGradient.Rotation = 90
        UIGradient.Parent = botao
        
        -- Adiciona uma sombra sutil
        local sombra = Instance.new("Frame")
        sombra.Name = "Sombra"
        sombra.Size = UDim2.new(1, 4, 1, 4)
        sombra.Position = UDim2.new(0, -2, 0, -2)
        sombra.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        sombra.BorderSizePixel = 0
        sombra.ZIndex = botao.ZIndex - 1
        sombra.Parent = botaoFrame
        
        -- Arredonda a sombra também
        local sombraCorner = Instance.new("UICorner")
        sombraCorner.CornerRadius = UDim.new(0.5, 0)
        sombraCorner.Parent = sombra
        
        -- Adiciona transparência à sombra
        local sombraTransparencia = Instance.new("UIGradient")
        sombraTransparencia.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.6),
            NumberSequenceKeypoint.new(1, 0.8)
        })
        sombraTransparencia.Parent = sombra
        
        -- Adiciona efeito de hover com animação
        local originalColor = botao.BackgroundColor3
        local hoverColor = Color3.fromRGB(90, 90, 130)
        local clickColor = Color3.fromRGB(40, 40, 60)
        
        -- Configurações para animação
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        botao.MouseEnter:Connect(function()
            local tween = TweenService:Create(botao, tweenInfo, {BackgroundColor3 = hoverColor})
            tween:Play()
            
            -- Pequena animação de escala
            local scaleTween = TweenService:Create(botao, tweenInfo, {Size = UDim2.new(1.05, 0, 1.05, 0)})
            scaleTween:Play()
        end)
        
        botao.MouseLeave:Connect(function()
            local tween = TweenService:Create(botao, tweenInfo, {BackgroundColor3 = originalColor})
            tween:Play()
            
            -- Retorna ao tamanho original
            local scaleTween = TweenService:Create(botao, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
            scaleTween:Play()
        end)
        
        -- Adiciona efeito ao clicar
        botao.MouseButton1Down:Connect(function()
            local tween = TweenService:Create(botao, tweenInfo, {BackgroundColor3 = clickColor})
            tween:Play()
            
            -- Efeito de pressionar
            local scaleTween = TweenService:Create(botao, tweenInfo, {Size = UDim2.new(0.95, 0, 0.95, 0)})
            scaleTween:Play()
        end)
        
        botao.MouseButton1Up:Connect(function()
            local tween = TweenService:Create(botao, tweenInfo, {BackgroundColor3 = hoverColor})
            tween:Play()
            
            -- Retorna ao tamanho do hover
            local scaleTween = TweenService:Create(botao, tweenInfo, {Size = UDim2.new(1.05, 0, 1.05, 0)})
            scaleTween:Play()
        end)
        
        -- Adiciona a função de clique para carregar a lógica (mantida a original)
        botao.MouseButton1Click:Connect(function()
            -- Executa o script do link fornecido
            pcall(function()
                loadstring(game:HttpGet(botaoInfo.linkCarregamento))()
                print("Carregado: " .. botaoInfo.nome)
                
                -- Feedback visual de sucesso
                local sucessoTween = TweenService:Create(botao, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 120, 80)})
                sucessoTween:Play()
                
                delay(0.5, function()
                    local reverterTween = TweenService:Create(botao, TweenInfo.new(0.5), {BackgroundColor3 = originalColor})
                    reverterTween:Play()
                end)
            end)
        end)
        
        -- Adiciona um ícone se especificado
        if botaoInfo.icone then
            local icone = Instance.new("ImageLabel")
            icone.Name = "Icone"
            icone.Size = UDim2.new(0, tamanhoBotao.Y * 0.6, 0, tamanhoBotao.Y * 0.6) -- Proporcionado ao tamanho do botão
            icone.Position = UDim2.new(0, 10, 0.5, -icone.Size.Y.Offset/2)
            icone.BackgroundTransparency = 1
            icone.Image = botaoInfo.icone
            icone.ImageColor3 = Color3.fromRGB(240, 240, 255) -- Leve coloração para combinar
            icone.ZIndex = botao.ZIndex + 1
            icone.Parent = botao
            
            -- Ajusta a posição do texto para acomodar o ícone
            botao.TextXAlignment = Enum.TextXAlignment.Center
            botao.Position = botao.Position + UDim2.new(0, 15, 0, 0) -- Desloca o texto um pouco
        end
        
        -- Adiciona um brilho sutil
        local highlight = Instance.new("Frame")
        highlight.Name = "Highlight"
        highlight.Size = UDim2.new(1, -4, 0, 1)
        highlight.Position = UDim2.new(0, 2, 0, 2)
        highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        highlight.BackgroundTransparency = 0.8
        highlight.BorderSizePixel = 0
        highlight.ZIndex = botao.ZIndex + 1
        highlight.Parent = botao
        
        local highlightCorner = Instance.new("UICorner")
        highlightCorner.CornerRadius = UDim.new(1, 0)
        highlightCorner.Parent = highlight
        
        -- Adiciona uma descrição (tooltip) se especificada
        if botaoInfo.descricao then
            -- Cria um tooltip que aparece ao passar o mouse
            local tooltip = Instance.new("Frame")
            tooltip.Name = "Tooltip"
            tooltip.Size = UDim2.new(0, 200, 0, 40)
            tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            tooltip.BorderColor3 = Color3.fromRGB(60, 60, 80)
            tooltip.BorderSizePixel = 1
            tooltip.Visible = false
            tooltip.ZIndex = 10
            tooltip.Parent = botaoFrame
            
            -- Arredonda os cantos do tooltip
            local tooltipCorner = Instance.new("UICorner")
            tooltipCorner.CornerRadius = UDim.new(0, 8)
            tooltipCorner.Parent = tooltip
            
            local tooltipText = Instance.new("TextLabel")
            tooltipText.Name = "TooltipText"
            tooltipText.Size = UDim2.new(1, -16, 1, -16)
            tooltipText.Position = UDim2.new(0, 8, 0, 8)
            tooltipText.BackgroundTransparency = 1
            tooltipText.TextColor3 = Color3.fromRGB(240, 240, 255)
            tooltipText.TextWrapped = true
            tooltipText.Text = botaoInfo.descricao
            tooltipText.Font = Enum.Font.Gotham
            tooltipText.TextSize = 13
            tooltipText.ZIndex = 11
            tooltipText.Parent = tooltip
            
            botao.MouseEnter:Connect(function()
                tooltip.Position = UDim2.new(1, 10, 0, 0)
                tooltip.Visible = true
                
                -- Animação do tooltip
                tooltip.BackgroundTransparency = 1
                local tooltipTween = TweenService:Create(tooltip, TweenInfo.new(0.3), {BackgroundTransparency = 0.1})
                tooltipTween:Play()
            end)
            
            botao.MouseLeave:Connect(function()
                local tooltipTween = TweenService:Create(tooltip, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                tooltipTween:Play()
                
                delay(0.2, function()
                    tooltip.Visible = false
                end)
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
