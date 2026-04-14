SMODS.Consumable{
    key = 'acme_trash',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = {x=5, y=0},
    soul_pos = {x=5, y=1},
    ppu_artist = {'RadiationV2'},
    ppu_coder = {'Opal'},
    config = {extra = {required = 30, discarded = 0}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'perishable', set = 'Other', vars = {5, 5}}
        if card.ability.extra.discarded < card.ability.extra.required then
            local _vars = {card.ability.extra.required - card.ability.extra.discarded}
            if card.ability.extra.required - card.ability.extra.discarded == 1 then
                _vars[#_vars+1] = localize('k_card')
            else
                _vars[#_vars+1] = localize('k_cards')
            end
            return{vars = _vars}
        else
            return{key = self.key..'_alt'}
        end
    end,
    calculate = function(self, card, context)
        if context.pre_discard and card.ability.extra.required > card.ability.extra.discarded then
            card.ability.extra.discarded = card.ability.extra.discarded + #context.full_hand
            if card.ability.extra.discarded >= card.ability.extra.required then
                return{
                    message = localize('k_active_ex'),
                    colour = G.C.RED,
                }
            else
                return{
                    message = localize{type = 'variable', key = 'a_remaining', vars = {card.ability.extra.required - card.ability.extra.discarded}},
                    colour = G.C.ORANGE,
                }
            end
        end
    end,
    can_use = function(self, card)
        return card.ability.extra.discarded >= card.ability.extra.required
    end,
    use = function(self, card, area, copier)
        local used = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({set = 'Joker', attributes = {'food'}, edition = 'e_negative', stickers = {'perishable'}, force_stickers = true})
                used:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
}
