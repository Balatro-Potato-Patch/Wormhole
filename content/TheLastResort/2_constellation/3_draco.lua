SMODS.Consumable{
	key = "tlr_const_draco",
	set = 'worm_tlr_constellation',
	atlas = "tlr_const",
	pos = {x=0, y=9},
    ppu_team = {"TheLastResort"},
	ppu_coder = {"Jogla"},
    ppu_artist = {"Aura2247"},
	config = {
		amounts = {0, 0, 1, 3},
        choices = {0, 0, 3, 5}
	},
    loc_vars = function (self, info_queue, card)
        return {vars = {
            card.ability.amounts[card.ability.tier],
            card.ability.choices[card.ability.tier],
        }}
    end,
    can_use = function (self, card)
        local current_blind = ""
        for k,v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Select" or v == "Current" then current_blind = k end
        end
        return current_blind ~= "Boss" or card.ability.tier >= 4
    end,
    use = function (self, card, area, copier)
        if card.ability.tier == 1 then
            local current_blind = ""
            for k,v in pairs(G.GAME.round_resets.blind_states) do
                if v == "Select" or v == "Current" then current_blind = k end
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = (function()
                    add_tag(Tag(G.GAME.round_resets.blind_tags[current_blind]))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    card:juice_up()
                    return true
                end)
            }))
        elseif card.ability.tier == 2 or card.ability.tier == 3 then
            for _,v in pairs(G.GAME.round_resets.blind_tags) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = (function()
                        add_tag(Tag(v))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        card:juice_up()
                        return true
                    end)
                }))
            end
            if card.ability.tier == 3 then
                G.FUNCS.Wormhole_TLR_draco{max_selected = card.ability.amounts[card.ability.tier], max_choices = card.ability.choices[card.ability.tier],}
            end
        elseif card.ability.tier == 4 then
            G.FUNCS.Wormhole_TLR_draco{max_selected = card.ability.amounts[card.ability.tier], max_choices = card.ability.choices[card.ability.tier],}
        end
    end
}