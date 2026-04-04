SMODS.Edition {
    key = "hedonia_tipsy",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Tipsy', text = { 'This is example text' }, label = 'Tipsy' },
    in_shop = false, -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function (card)
        card.edition.drunk_wobble_strength = 0.6
    end,

    calculate = function (self, card, context)
        -- if held in hand
            -- rng check for chance to sober up
                -- actually sober up
        -- when scored
            -- TODO integrations for bartender manipulation of drunk effect
            -- rng (ignoring global) to pick rank change direction
            -- actually change rank
    end
}

SMODS.Edition {
    key = "hedonia_drunk",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Drunk', text = { 'This is example text' }, label = 'Drunk' },
    in_shop = false, -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function (card)
        card.edition.drunk_wobble_strength = 1.0
    end,
}

SMODS.Edition {
    key = "hedonia_very_drunk",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Very Drunk', text = { 'This is example text' }, label = 'Very Drunk' },
    in_shop = false, -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function (card)
        card.edition.drunk_wobble_strength = 1.5
    end,
}


SMODS.Shader {
    key = "hedonia_shader_drunk",
    path = "Hedonia/drunk.fs", -- TODO write the shader
    send_vars = function (sprite, card)
        return {
            wobble_strength = card.edition.drunk_wobble_strength,
            time = love.timer.getTime(),
        }
    end,
}