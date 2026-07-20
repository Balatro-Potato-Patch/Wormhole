local upgrade_hook = SMODS.upgrade_poker_hands
function SMODS.upgrade_poker_hands(args)
    if next(SMODS.find_card("j_worm_thorn_binary")) and args.from and args.from.config and args.from.config.center and args.from.config.center.set == "Planet" then
        local level_down = false
        local upgraded_hands = type(args.hands) == 'string' and {args.hands} or args.hands
        for k, v in pairs(SMODS.find_card("j_worm_thorn_binary")) do
            if v.area.config.type == "joker" and not level_down then
                for _, hand in pairs(upgraded_hands) do
                    if SMODS.pseudorandom_probability(v, 'thorn_binary', 1, v.ability.extra.odds) then
                        args.level_up = args.level_up + 1
                    elseif G.GAME.hands[hand].level > 1 then
                        args.level_up = -1
                        level_down = true
                    else
                        args.level_up = 0
                        level_down = true
                    end
                end
            end
        end
    end
    upgrade_hook(args)
end