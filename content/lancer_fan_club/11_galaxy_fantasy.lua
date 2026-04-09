-- Galaxy Fantasy
SMODS.Joker {
    key = "lfc_galaxy_fantasy",
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 3,
    cost = 10,
    ppu_coder = { "J8-Bit" },
    ppu_artist = {"J8-Bit"},
    ppu_team = { "Lancer Fan Club" },
    atlas = "lfc_jokers",
    pos = { x = 3, y = 1 },
    config = { extra = { rounds = 0, total_rounds = 3, card_type = G.P_CENTERS["c_black_hole"] } },
    attributes = {
        "on_sell",
        "spectral",
        "generation",
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = card.ability.extra.card_type
        return {
            vars = {
                card.ability.extra.total_rounds,
                card.ability.extra.rounds,
                card.ability.extra.card_type and
                localize({
                    type = 'name_text',
                    key = card.ability.extra.card_type.key,
                    set = card.ability.extra.card_type.set
                }) or localize("k_lfc_none"),
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ key = card.ability.extra.card_type.key })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.SECONDARY_SET[card.ability.extra.card_type.set] or G.C.FILTER
            }
        end
    end
}
