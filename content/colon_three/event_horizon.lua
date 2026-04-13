if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "ct_event_horizon",
    atlas = "ct_event_horizon",
    pos = { x = 2, y = 0 },
    config = { extra = { levels = 0, rotation = 0 } },
    attributes = { "space", "hand_type" },
    ppu_coder = { "meta" },
    ppu_artist = { "notmario", "lordruby" },
    ppu_team = { ":3" },
    rarity = 1,
    cost = 5,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels }, name_key = card.area ~= G.jokers and "j_worm_ct_event_horizon_fake" or nil }
    end,
    calculate = function(self, card, context)
        if context.before and card.ability.extra.levels ~= 0 then
            SMODS.upgrade_poker_hands({
                hands = context.scoring_name,
                level_up = card.ability.extra.levels,
                from = card
            })
            card.ability.extra.levels = 0
            return nil, true
        end
    end,
    update = function(self, card, dt)
        if card.ability and card.ability.extra and card.ability.extra.levels then
            local mix_fac = 0.3 ^ dt
            card.ability.extra.rotation = mix_fac * (card.ability.extra.rotation or 0) + (1 - mix_fac) * card.ability.extra.levels * math.pi * 5 / 4 * 9 / 10
        end
        if card.area == G.jokers then
            card.children.center.dont_animate = false
        else
            card.children.center.dont_animate = true
        end
    end,
}
-- rotate hook
local card_draw = Card.draw
function Card:draw(layer, ...)
	if self.config and self.config.center.key == "j_worm_ct_event_horizon" then
		self.VT.r = self.VT.r + self.ability.extra.rotation
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r + self.ability.extra.rotation
		end
	end

	card_draw(self, layer, ...)

	if self.config and self.config.center.key == "j_worm_ct_event_horizon" then
		self.VT.r = self.VT.r - self.ability.extra.rotation
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r - self.ability.extra.rotation
		end
	end
end

local upgrade_hands_ref = SMODS.upgrade_poker_hands
SMODS.upgrade_poker_hands = function(args)
    if (not args.from or not args.from.config or not args.from.config.center or args.from.config.center.key ~= "j_worm_ct_event_horizon") and next(SMODS.find_card("j_worm_event_horizon")) then
        for i, v in ipairs(SMODS.find_card("j_worm_ct_event_horizon")) do
            v.ability.extra.levels = v.ability.extra.levels + (args.level_up or 1)
        end
    else
        upgrade_hands_ref(args)
    end
end
