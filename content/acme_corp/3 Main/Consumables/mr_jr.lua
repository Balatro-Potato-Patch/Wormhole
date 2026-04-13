SMODS.Consumable{
    key = 'acme_mr_jr',
    set = 'ACME_Gadget',
    atlas = Atlas_AcmeGadgets.key,
    pos = {x = 8, y = 0},
    soul_pos = {x = 8, y = 1 },
    ppu_coder = {'RadiationV2'},
    ppu_artist = {'RadiationV2'},
	config = {
        active = false,
        extra = {boosters_opened = 0, boosters = 4, rarity = 'rare'}
    },
    loc_vars = function(self, info_queue, card)
        local turns_left = (card.ability.extra.boosters - card.ability.extra.boosters_opened)
        local curKey = self.key
        if (card.ability.extra.rarity == 'legendary') then
            curKey = curKey .. '_legendary'
        end
        if turns_left > 1 then
            return{key = curKey, vars = {turns_left, localize('k_boosters')}}
        elseif turns_left == 1 then
            return{key = curKey, vars = {turns_left, localize('k_boosters')}}
        else
            return{key = curKey .. '_alt'}
        end
    end,
    use = function(self, card, area, copier)
        if card.ability.extra.rarity == 'rare' then
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            SMODS.add_card({ set = 'Joker', rarity = 'Rare' })
        end
        if card.ability.extra.rarity == 'legendary' then
            play_sound('timpani')
            SMODS.add_card({ set = 'Joker', legendary = true })
            check_for_unlock { type = 'spawn_legendary' }
            card:juice_up(0.3, 0.5)
        end
    end,
    calculate = function(self, card, context)
        if context.open_booster then
            if card.ability.active then
                return
            end

            card.ability.extra.boosters_opened = card.ability.extra.boosters_opened + 1
            local remaining = card.ability.extra.boosters - card.ability.extra.boosters_opened
            if remaining > 0 then
                return {
                    message = remaining .. " " .. localize('k_remaining'),
                    colour = G.C.ORANGE
                }
            else
                card.ability.active = true
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.RED
                }
            end

        end
        if context.ending_shop then
            if math.random(1, 25) == 1 and
            card.ability.extra.rarity == 'rare' then
                card.ability.extra.rarity = 'legendary'
                card:juice_up(0.5, 0.5)
                card.children.floating_sprite:set_sprite_pos({ x = 9, y = 1 })
                play_sound('gong', 0.9, 0.8)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
    end,
    can_use = function(self, card)
        return
            (#G.jokers.cards < G.jokers.config.card_limit or
            card.area == G.jokers) and
            card.ability.extra.boosters_opened >= card.ability.extra.boosters
    end,
}
