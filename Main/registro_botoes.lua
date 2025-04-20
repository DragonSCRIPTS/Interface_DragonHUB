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
        nome = "Speed Hack",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/speed_hack.lua",
        descricao = "Aumenta a velocidade do seu personagem",
        menu = "movimento"
    },
    
    -- Botão de Teleporte
    {
        nome = "Teleporte",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/teleport.lua",
        descricao = "Teleporta para locais específicos do mapa",
        menu = "utilidades"
    },
    
    -- Botão de Auto Click
    {
        nome = "Auto Click",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/auto_click.lua",
        descricao = "Clica automaticamente para você",
        menu = "utilidades"
    },
    
    -- Botão de Infinite Jump
    {
        nome = "Pulo Infinito",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/infinite_jump.lua",
        descricao = "Permite pular sem limite",
        menu = "movimento"
    },
    
    -- Botão de Aimbot
    {
        nome = "Aimbot",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/aimbot.lua",
        descricao = "Sistema de mira automática",
        menu = "combate"
    },
    
    -- Botão de NoClip
    {
        nome = "NoClip",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/noclip.lua",
        descricao = "Atravessa paredes e objetos",
        menu = "movimento"
    },
    
    -- Botão de Fly
    {
        nome = "Fly",
        tamanho = {X = 200, Y = 50},
        linkCarregamento = "https://raw.githubusercontent.com/usuario/repositorio/branch/scripts/fly.lua",
        descricao = "Permite que seu personagem voe",
        menu = "movimento"
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
