--[[ Shinku's original version ] ]
SMODS.Joker{
key = "orrery",
atlas = "mrrp",
pos = {x = 3, y = 1},
    config = { extra = { tarots = 1 } },
unlocked = true, 
discovered = false, 
rarity = 2,
cost = 6,
calculate = function(self, card, context)
    if context.poker_hand_changed and context.old_level and context.new_level then
        if context.new_level > context.old_level then
            local orrery_cards = {"c_star", "c_moon", "c_sun", "c_world"}
            for i = 1, math.min(card.ability.extra.tarots, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            SMODS.add_card({ key = pseudorandom_element(orrery_cards, "orrery") })
                            card:juice_up(0.3, 0.5)
                        end
                        return true
                    end
                }))
            end
            delay(0.6)
        end
    end
end,
}
--[[ Cyan's edit ]]

SMODS.Joker{
key = "orrery",
atlas = "mrrp",
pos = {x = 3, y = 1},
    config = { extra = { tarot = {"c_star", "c_moon", "c_sun", "c_world"} } },
unlocked = true, 
discovered = false, 
rarity = 2,
cost = 6,
loc_vars = function(self, info_queue, card)
    for k,v in ipairs(card.ability.extra.tarot) do
        info_queue[#info_queue+1] = G.P_CENTERS[v]
    end

    local loc = function(table_of_keys)
        local ret = {}
        for k,v in ipairs(table_of_keys) do
            ret[k] = localize{type="name_text", set=G.P_CENTERS[v].set, key=v}
        end
        return ret
    end
    local ret = loc(card.ability.extra.tarot)

    return {
        vars = ret
    }
end,
calculate = function(self, card, context)
    if context.poker_hand_changed and context.old_level and context.new_level then
        if context.new_level > context.old_level then
            local orrery_cards = card.ability.extra.tarot
            local card = context.blueprint and context.blueprint_card or card
            for i = 1, #orrery_cards do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            local pollsets = {}
                            for k,v in ipairs(orrery_cards) do
                                pollsets[G.P_CENTERS[v].set] = true
                            end
                            local poolsets = function(input_table)
                                local ret = {}
                                for k,v in pairs(input_table) do
                                    ret[k] = SMODS.get_clean_pool(k)
                                end
                                return ret
                            end
                            local sets = poolsets(pollsets)
                            local avail_cards = {}
                            local lookfor = {}
                            local lefttofind = {}
                            for k,v in ipairs(orrery_cards) do
                                lookfor[v] = true
                                lefttofind[v] = true
                            end
                            for _,pool in pairs(sets) do
                                for k,v in pairs(pool) do
                                    if lookfor[v] then
                                        avail_cards[#avail_cards+1] = v
                                        lefttofind[v] = nil
                                    end
                                    if not next(lefttofind) then break end
                                end
                            end
                            if not next(avail_cards) then return true end
                            play_sound('timpani')
                            SMODS.add_card({ key = pseudorandom_element(avail_cards, pseudoseed("orrery")), area = G.consumeables })
                            if i == 1 then
                                local amt = math.min(#avail_cards, 1+G.consumeables.config.card_limit-#G.consumeables.cards)
                                SMODS.calculate_effect({
                                    message = localize{type='variable',key='a_plus_tarot',vars={amt}},
                                    colour = G.C.SECONDARY_SET.Tarot,
                                    instant = true,
                                    func = function()
                                        delay(0.6)
                                    end
                                }, card)
                            end
                        end
                        return true
                    end
                }))
            end
        end
    end
end,
}