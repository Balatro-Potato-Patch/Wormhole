SMODS.Joker {
    key = "cking",
    atlas = 'VVjokers',
    rarity = 'worm_otherworldly',
    cost = 30,
    pos = {x = 2, y = 1},
    soul_pos = {x = 3, y = 1},
    config = {
        extra = {
        },
        immutable = {
            rounds = 3,
            roundup = 0,
            roundadd = 1
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_artist = { "FirstTry" },
    ppu_coder = { "FirstTry" },
    loc_vars = function(self,info_queue,card)
        local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
        return {
            vars = {
                card.ability.immutable.rounds,
                card.ability.immutable.roundup,
                most_played
            }
        }
    end,
    calculate = function(self,card,context)
    local round_tally = 0
    local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
            if context.end_of_round and context.main_eval then
--            SMODS.calculate_effect({ message = card.ability.immutable.roll_rounds .."/".. card.ability.immutable.total_rounds , colour = G.C.FILTER}, card)
            SMODS.scale_card(card, {
                ref_table = card.ability.immutable,
                ref_value = "roundup",
                scalar_value = "roundadd",
--                message = card.ability.immutable.roll_rounds .."/".. card.ability.immutable.total_rounds,
--                colour = G.C.RED
            })
        if (to_big(card.ability.immutable.roundup) >= to_big(card.ability.immutable.rounds)) then
            SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = 1,
                        hands = most_played
                    }
                    card.ability.immutable.roundup = 0
                end
            end
    end
}