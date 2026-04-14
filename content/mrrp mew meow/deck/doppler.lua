SMODS.Back {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Shinku'},
    ppu_coder = {'Aure'},
    key = 'mrrp_doppler',
    atlas='mrrp', pos = {x=3, y=0},
    config = { level_up = 1, level_down = -1},
    loc_vars = function(self)
        return {
            vars = {
                SMODS.signed(self.config.level_up),
                SMODS.signed(self.config.level_down),
            }
        }
    end,
    calculate = function(self, back, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            local card = context.consumeable
            local from = G.deck and G.deck.cards[1] or G.deck or card
            local from_hand = card.ability.consumeable.hand_type
            local most_played, _tally = nil, -1
            for _, v in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                    most_played = v
                    _tally = G.GAME.hands[v].played
                end
            end
            if most_played == from_hand then return end
            if from_hand then
                level_up_hand(from, from_hand, nil, back.effect.config.level_up)
            end
            if most_played then
                level_up_hand(from, most_played, nil, back.effect.config.level_down)
            end
            return nil, true
        end
    end
}