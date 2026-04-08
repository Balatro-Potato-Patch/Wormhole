SMODS.Consumable{
    key = 'acme_wineglass',
    set = 'ACME_Gadget',
    atlas = Atlas_AcmeGadgets.key,
    pos = {x = 10, y = 0},
    soul_pos = {x = 10, y = 1 },
    ppu_coder = {'RadiationV2'},
    ppu_artist = {'RadiationV2'},
	config = {
        active = false,
        extra = {numBreaks = 0, glassBreak = false, mod_conv = 'm_glass'}
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        local glass_num_text = card.ability.extra.numBreaks
        local plural = "copies"
        if card.ability.extra.numBreaks == 1 then
            plural = "copy"
        end
        if not card.ability.active then
            return{key = self.key, vars = {glass_num_text, plural}}
        else
            return{key = self.key .. '_alt', vars = {glass_num_text, plural}}
        end
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, card.ability.extra.numBreaks do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local curCopy = copy_card(G.hand.highlighted[1],  nil, nil, G.playing_card)
                    curCopy.states.visible = nil
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.1,
                        func = function()
                            curCopy:start_materialize()
                            return true
                        end
                    }))
                    curCopy:juice_up(0.2, 0.2)
                    curCopy:set_ability(card.ability.extra.mod_conv)
                    curCopy:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.hand:emplace(curCopy)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local glass_cards = card.ability.extra.numBreaks

            local changedGlassAmount = false
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered then
                    card.ability.extra.glassBreak = true
                    changedGlassAmount = true
                    glass_cards = glass_cards + 1
                end
            end
            card.ability.extra.numBreaks = glass_cards
            if changedGlassAmount then
                if not card.ability.active then
                    card.ability.active = true
                    return {
                        message = localize('k_active_ex'),
                        colour = G.C.RED
                    }
                else
                    return {
                        message = card.ability.extra.numBreaks .. " " .. localize('k_stocked'),
                        colour = G.C.ORANGE
                    }
                end
            end
        end
    end,
    can_use = function(self, card)
        return
            card.ability.extra.glassBreak and
            G.hand and #G.hand.highlighted == 1
    end,
}
