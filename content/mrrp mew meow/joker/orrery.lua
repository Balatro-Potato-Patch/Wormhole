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
ppu_team = {'Mrrp Mew Meow :3'},
ppu_artist = {"SarcPot"},
ppu_coder = {'Shinku','Cyan'},
key = "mrrp_orrery",
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
                    --  this card's functionality needs to be carried out as an Event.
                    --  this is so that it can properly detect which of the cards it can make are already owned.
                    --  this imposes complications, but I was able to perfect its functionality in spite of this.
            G.E_MANAGER:add_event(Event({
                func = function()
                    --  this identifies if there is enough space to make any cards.
                    --  G.GAME.consumeable_buffer is not needed here since it is calculated at the moment of creation.
                    if #G.consumeables.cards < G.consumeables.config.card_limit then

                    --  this compiles which sets (and therefore pools) the cards belong to, by indices for convenience.
                    --  under normal circumstances, there should only be one set, being Tarot cards.
                    --  however, this supports modularity for anything that could change these cards.
                        local pollsets = {}
                        for k,v in ipairs(orrery_cards) do
                            if G.P_CENTERS[v] and G.P_CENTERS[v].set then
                                pollsets[G.P_CENTERS[v].set] = true
                            end
                        end

                    --  this gathers all of the cards' respective pools and sorts them under one table.
                    --  getting raw pools rather than SMODS' clean pools is actually preferred here for efficiency.
                    --  this is performed as a function to ensure the card ability succeeds with any number of sets.
                        local poolsets = function(input_table)
                            local ret = {}
                            for k,v in pairs(input_table) do
                                ret[k] = get_current_pool(k)
                            end
                            return ret
                        end
                        local sets = poolsets(pollsets)

                    --  this remakes the original table of keys with the keys as the indices rather than values.
                    --  this is for efficiency in matching keys, preventing duplicate writes, and deciding to stop early.
                        local lookfor = {}
                        for k,v in ipairs(orrery_cards) do
                            lookfor[v] = true
                        end

                    --  this goes through every key in every pool and tries to match it to a key this joker can make.
                    --  if the card isn't already owned or duplicates can exist, then its key is written to avail_cards.
                    --  the key is also removed from lookfor once it's been found, to prevent writing duplicates.
                    --  if there's nothing left in lookfor (i.e. all of this cards keys were found), then it stops early.
                        local avail_cards = {}
                        for _,pool in pairs(sets) do
                            for k,v in pairs(pool) do
                                if lookfor[v] then
                                    lookfor[v] = nil
                                    avail_cards[#avail_cards+1] = v
                                end
                                if not next(lookfor) then break end
                            end
                        end

                    --  if no keys are valid (i.e. by an error) or can't be created, avail_cards should be empty.
                    --  the card-creation part of the process will stop here if either of these are the case.
                        if not next(avail_cards) then return true end


                    --  this decides which cards will get made by choosing at random between the cards that can be made.
                    --  it limits itself to however many cards can be made (whether by availability or area capacity).
                    --  once a key is chosen, it's removed from the list to prevent duplicates and allow up to all 4.
                        local cardstocreate = {}
                        for i = 1, math.min(#avail_cards, G.consumeables.config.card_limit-#G.consumeables.cards) do
                            local key, indx = pseudorandom_element(avail_cards, pseudoseed("orrery"))
                            cardstocreate[#cardstocreate+1] = key
                            avail_cards[indx] = nil
                        end

                    --  this spawns all of the cards that were chosen in the end.
                    --  they all spawn in the same instant, rather than with small pauses like The Emperor does.
                    --  I just thought it would flow better and feel more polished if it behaved in this way.
                        --  to replicate The Emperor, put play_sound and SMODS.add_card in the Event,
                        --  then put the Event in the for loop, and put SMODS.calculate_effect before the for loop.
                        --  the Event delay should only be 0.6 on the last card (i==#cardstocreate) and 0.4 otherwise.  
                        play_sound('timpani')
                        for i = 1, #cardstocreate do
                            SMODS.add_card{ key = cardstocreate[i], area = G.consumeables }
                        end

                    --  because this all happens in an Event, the card must be manually called to do its animations.
                    --  this is handled by SMODS.calculate_effect, by passing the usual return values as a table.
                    --  we must pass "instant = true" to counteract the timing of the event and emulate normal timing.
                    --  however, passing this normally means that there is no pause after the card's animation.
                    --  to give the pause back, we have to put it in another, nested Event with a "before" trigger.
                    --  however, this would once again normally put the animation after all other Events are processed.
                    --  thankfully, by passing "true" as our third argument, we can place our Event at the very front.
                    --  this means that this nested Event is processed instantly after being added in the parent Event.
                        G.E_MANAGER:add_event(Event{
                            trigger = "before",
                            delay = 0.6,
                            func = function()
                                SMODS.calculate_effect({
                                    message = localize{type='variable',key='a_plus_tarot',vars={#cardstocreate}},
                                    colour = G.C.SECONDARY_SET.Tarot,
                                    instant = true,
                                }, card)
                                return true
                            end
                        }, nil, true)

                    end
                    return true
                end
            }))
            -- this isn't perfect since it allows a post-trigger when nothing actually happened
            return nil, true
        end
    end
end,
}