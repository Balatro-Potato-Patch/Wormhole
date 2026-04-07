local upgrade_hook = SMODS.upgrade_poker_hands
function SMODS.upgrade_poker_hands(args)
    if next(SMODS.find_card("j_worm_thorn_binary")) and args.from.config.center.set == "Planet" then
        if SMODS.pseudorandom_probability(SMODS.find_card("j_worm_thorn_binary")[1], 'thorn_binary', 1, SMODS.find_card("j_worm_thorn_binary")[1].ability.extra.odds) then
            args.level_up = 2
        elseif G.GAME.hands[args.from.ability.hand_type].level > 1 then
            args.level_up = -1
        else
            args.level_up = 0
        end
    end
    upgrade_hook(args)
end