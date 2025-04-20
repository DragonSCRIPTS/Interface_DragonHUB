-- Configuração dos Menus (config_menus.lua)
-- Este arquivo contém a configuração dos menus disponíveis

return {
    {
        nome = "Principal",
        ativo = true,
        imagemURL = nil,  -- [off] já que não tem imagem
    },
    {
        nome = "Jogador",
        ativo = true,
        imagemURL = "rbxassetid://123456789",  -- [on] com link para imagem
    },
    {
        nome = "Mundo",
        ativo = true,
        imagemURL = nil,  -- [off] já que não tem imagem
    },
    {
        nome = "Visual",
        ativo = true,
        imagemURL = "rbxassetid://126417791294855",  -- [on] com link para imagem
    },
    {
        nome = "Combate",
        ativo = false,  -- Este menu não estará disponível
        imagemURL = nil,
    },
    {
        nome = "Sobre",
        ativo = true,
        imagemURL = nil,  -- [off] já que não tem imagem
    }
}
