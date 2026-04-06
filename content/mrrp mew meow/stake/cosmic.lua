SMODS.Stake{
    key = 'cosmic',
    atlas = 'mrrp_stake',
    pos = {x = 0, y = 0},
    applied_stakes = { "stake_gold" },
    sticker_atlas = "mrrp_sticker",
    shiny = true,
    sticker_pos = {x = 1, y = 0},
    colour = HEX('5F718B'),
    prefix_config = {
        applied_stakes = false
    },
    loc_txt = {
        name = 'Cosmic Stake',
        text = {
            "Shop can have {C:attention}Gravity{} Jokers",
            "{C:inactive,s:0.8}(Halves all hand levels){}"
        }
    },
	modifiers = function()
		G.GAME.modifiers.enable_worm_celestial = true
	end,

}