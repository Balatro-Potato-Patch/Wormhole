SMODS.Atlas({key = "asm_ubs", path = "ubs.png", px = 89, py = 109, atlas_table = "ASSET_ATLAS"}):register()

SMODS.Consumable {
    key = 'pheromosa',
    set = 'worm_ultrabeast',
    loc_txt = {
        name = 'Pheromosa',
        text = {
            "Activate to gain {C:chips}+#1#{} chips", "on your next hand,",
            "consumes self on activation."
        }
    },
    atlas = 'worm_asm_ubs', 
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 }, 
    config = {extra_slots_used = 1, extra = {chips = 251}},

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,

    keep_on_use = function(self, card) return true end,

    can_use = function(self, card) return (not card.ability.active) end,

    use = function(self, card, area, copier)
        play_sound('timpani')
        card.ability.active = true
        local eval = function() return card.ability.active end
        juice_card_until(card, eval, true)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card:juice_up()
            if card.ability.active then
                return {chips = card.ability.extra.chips}
            end
        end

        if context.after then
            if card.ability.active then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Sound({key = "asm_buzz", path = 'buzz.ogg'})
SMODS.Consumable {
    key = 'buzzwole',
    set = 'worm_ultrabeast',
    loc_txt = {
        name = 'Buzzwole',
        text = {
            "Activate to gain {C:mult}+#1#{} mult", "on your next hand,",
            "consumes self on activation."
        }
    },
    -- atlas = '', pos = { x = 1, y = 0 }, -- update this

    config = {extra_slots_used = 1, extra = {mult = 53}},

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    keep_on_use = function(self, card) return true end,

    can_use = function(self, card) return (not card.ability.active) end,

    use = function(self, card, area, copier)
        play_sound('timpani')
        card.ability.active = true
        local eval = function() return card.ability.active end
        juice_card_until(card, eval, true)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.active then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        play_sound('worm_asm_buzz')
                        return true
                    end
                }))
                return {mult = card.ability.extra.mult}
            end
        end

        if context.after then
            if card.ability.active then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end
    end
}

