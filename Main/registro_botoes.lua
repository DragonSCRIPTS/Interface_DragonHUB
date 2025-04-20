-- Registro de Botões (registro_botoes.lua)
-- Este arquivo contém o registro de todos os botões disponíveis, com suas propriedades e links de carregamento

-- Tabela que retorna a lista de botões
return {
    -- Estrutura de cada botão:
    -- {
    --     nome = "Nome do Botão",
    --     tamanho = {X = largura, Y = altura},
    --     linkCarregamento = "URL para carregar a lógica do botão",
    --     icone = "rbxassetid://ID_DO_ICONE", -- Opcional
    --     descricao = "Descrição do botão", -- Opcional
    --     menu = "nome_do_menu" -- Opcional, para organizar botões em diferentes menus
    -- }
    
    -- Botão de Auto Farm
    {
        nome = "Auto Farm",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/auto_farm.lua",
        descricao = "Ativa o modo de coleta automática de recursos",
        menu = "farming"
    },
    
    -- Botão de ESP (Ver jogadores através das paredes)
    {
        nome = "ESP Players",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/esp_players.lua",
        descricao = "Ativa a visualização de jogadores através das paredes",
        menu = "visual"
    },
    
    -- Botão de Velocidade
    {
        nome = "porta trial",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/speed_hack.lua",
        descricao = "ir automaticamente para porta da raça do usuário",
        menu = "V4"
    },
    
    -- Botão de Teleporte
    {
        nome = "Teleporte",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/teleport.lua",
        descricao = "Teleporta para locais específicos do mapa",
        menu = "teleport"
    },
    
    -- Botão de Auto Click
    {
        nome = "Auto Click",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/auto_click.lua",
        descricao = "Clica automaticamente para você",
        menu = "configurações"
    },
    
    -- Botão de Infinite Jump
    {
        nome = "Pulo Infinito",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/infinite_jump.lua",
        descricao = "Permite pular sem limite",
        menu = "configurações"
    },
    
    -- Botão de Aimbot
    {
        nome = "Aimbot",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/aimbot.lua",
        descricao = "Sistema de mira automática",
        menu = "configurações"
    },
    
    -- Botão de NoClip
    {
        nome = "NoClip",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/noclip.lua",
        descricao = "Atravessa paredes e objetos",
        menu = "configurações"
    },
    
    -- Botão de Fly
    {
        nome = "Fly",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/fly.lua",
        descricao = "Permite que seu personagem voe",
        menu = "configurações"
    },
    
    -- Botão de Item Farm
    {
        nome = "Item Farm",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/item_farm.lua",
        descricao = "Coleta automaticamente itens próximos",
        menu = "farming"
    }
}
