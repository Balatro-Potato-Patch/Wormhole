

SMODS.Shader {
    key = "stew_chromakey",
    path = "BalatroStewniversity/chromakey.fs"
}

SMODS.Shader {
    key = "stew_stellar",
    path = "BalatroStewniversity/stellar.fs",
    send_vars = function (sprite, card)
        return {
            stellar_seed = card and card.edition.stellar_seed or 0
        }
    end,
}

