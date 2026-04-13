if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "ct_busted_3d_printer",
    atlas = "ct_derelict",
    pos = { x = 2, y = 1 },
    config = {
        extra = {
            junk_num = 1,
            cleanup_num = 2
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_ct_junk_card
        info_queue[#info_queue+1] = { key = "worm_clean_up_keyword", set="Other", specific_vars = { card.ability.extra.cleanup_num } }
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use {
        clean_func = function(self, card, cards)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _first_dissolve = nil
                    local new_cards = {}
                    for i = 1, #cards do
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(cards[i], nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card:start_materialize(nil, _first_dissolve)
                        _first_dissolve = true
                        new_cards[#new_cards + 1] = _card
                    end
                    SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                    return true
                end
            }))
        end,
    },
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"notmario"},
    ppu_artist = {"notmario"},
    ppu_team = {":3"},
}
