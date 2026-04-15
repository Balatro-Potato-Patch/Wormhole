SMODS.Joker {
    key = "sttgl",
    atlas = 'VVjokers',
    rarity = 'worm_otherworldly',
    cost = 30,
    pos = {x = 3, y = 0},
    soul_pos = {x = 4, y = 0},
    config = {
        extra = {
            sttgl = 1,
            denom = 2,
            copies = 2
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_artist = { "FirstTry" },
    ppu_coder = { "FirstTry" },
    loc_vars = function(self,info_queue,card)
        local oddwin, oddnope = SMODS.get_probability_vars(card, 1, card.ability.extra.denom, self.key)
        local copycard = card.ability.extra.copies
        return {
            vars = {
                oddwin, oddnope, copycard
            }
        }
    end,
    calculate = function(self,card,context)
               local function planetdupe(card, new_card, area)
    if not card then return nil end
    local area = area or (new_card and new_card.area) or card.area or G.consumeables
    local cardwasindeck = new_card and new_card.added_to_deck or nil
    local copy = copy_card(card, new_card)
    if new_card and cardwasindeck then copy:remove_from_deck() end
    if card.playing_card then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        copy.playing_card = G.playing_card
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, copy)
    end
    if (new_card and cardwasindeck) or not new_card then copy:add_to_deck() end
    if not new_card then area:emplace(copy) end
    return copy
    end
    if context.using_consumeable and context.consumeable.ability.set == "Planet" and not context.blueprint and not (context.consumeable.edition or {}).negative then
        for i = 1, card.ability.extra.copies do
    local copy = planetdupe(context.consumeable)
    if SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.denom) then
        copy:set_edition('e_negative')
    end
    end
    end
    end
}