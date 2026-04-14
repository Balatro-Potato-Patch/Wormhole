-- Ulala
SMODS.Joker({
    key = 'riverboat_ulala',
    atlas = 'worm_jokers',
    pos = { x = 2, y = 0 },
    soul_pos = {
        x = 9,
        y = 1,
        draw = function(card, scale_mod, rotate_mod) -- Thank you, Vanilla Remade
            card.hover_tilt = card.hover_tilt * 1.5
            card.children.floating_sprite:draw_shader('hologram', nil, card.ARGS.send_to_shader, nil,
                card.children.center, 2 * scale_mod, 2 * rotate_mod)
            card.hover_tilt = card.hover_tilt / 1.5
        end
    },
    rarity = 2, -- Uncommon
    cost = 6,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { mult = 0, gain = 5 } },
    ppu_coder = { "fooping" },
    ppu_artist = { "camo" },
    ppu_team = { "riverboat" },
    attributes = { "mult", "scaling", "reset", "rank", "five" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local has_five = false
            if context.scoring_hand then
                for _, scoring_card in ipairs(context.scoring_hand) do
                    if scoring_card:get_id() == 5 then
                        has_five = true
                        break
                    end
                end
            end

            if has_five then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                return {
                    message = 'Upgrade!',
                    colour = G.C.MULT,
                    card = card
                }
            else
                if card.ability.extra.mult > 0 then
                    card.ability.extra.mult = 0
                    return {
                        message = 'Reset',
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
        end

        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize({ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } })
            }
        end
    end
})
