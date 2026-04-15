SMODS.Atlas {
    key = 'thorn_voucher',
    path = 'thorn/voucher.png',
    px = 71,
    py = 95
}

function thorn_most_played()
    local played = 0
    local hand_key = nil
    local order = #G.handlist + 1
    for k, v in pairs(G.GAME.hands) do
        if (v.played ~= 0) and (v.played >= played) and (v.order < order) then
            order = v.order
            played = v.played
            hand_key = k
        end
    end
    return hand_key
end

SMODS.Voucher {
	key = 'thorn_ip_travel',
    atlas = "thorn_voucher",
	pos = { x = 0, y = 0 },
    attributes = {'space', 'planet'},
	calculate = function(self, card, context)
        if (thorn_most_played() and context.using_consumeable and context.consumeable.config.center.set == "Planet") and not G.GAME.used_vouchers["v_worm_thorn_is_travel"] then
            SMODS.upgrade_poker_hands{
                hands = thorn_most_played(),
                func = function(current, base, parameter, level_up)
                    local add = 0
                    for k, v in pairs(G.GAME.hands) do
                        if v == G.GAME.hands["High Card"] then
                            if v["l_" .. parameter] then
                                add = v["l_" .. parameter]
                            end
                        end
                    end
                    return current + add
                end
            }
        end
    end,
    ppu_artist = {"mtw"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

SMODS.Voucher {
	key = 'thorn_is_travel',
    atlas = "thorn_voucher",
	pos = { x = 1, y = 0 },
    requires = {"v_worm_thorn_p-travel"},
    attributes = {'space', 'planet'},
	calculate = function(self, card, context)
        if thorn_most_played() and context.using_consumeable and context.consumeable.config.center.set == "Planet" then
            local hand_steal = context.consumeable.ability.hand_type
            SMODS.upgrade_poker_hands{
                hands = thorn_most_played(),
                func = function(current, base, parameter, level_up)
                    local add = 0
                    for k, v in pairs(G.GAME.hands) do
                        if v == G.GAME.hands[hand_steal] then
                            if v["l_" .. parameter] then
                                add = v["l_" .. parameter]
                            end
                        end
                    end
                    return current + add
                end
            }
        end
    end,
    ppu_artist = {"willow"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}
