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
            if card.ability.consumeable.hand_type then
                level_up_hand(from, card.ability.consumeable.hand_type, nil, back.effect.config.level_up)
            end
            local _hand, _tally = nil, -1
            for _, v in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end
            if _hand then
                level_up_hand(from, _hand, nil, back.effect.config.level_down)
            end
        end
    end
}