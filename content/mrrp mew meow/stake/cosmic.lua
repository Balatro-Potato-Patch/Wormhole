SMODS.Stake{
    key = 'cosmic',
    atlas = 'mrrp_stake',
    pos = {x = 0, y = 0},
    applied_stakes = { "stake_gold" },
    sticker_atlas = "mrrp",
    shiny = true,
    sticker_pos = {x = 2, y = 0},
    colour = HEX('5F718B'),
    prefix_config = {
        applied_stakes = false
    },
	modifiers = function()
		G.GAME.modifiers.enable_worm_celestial = true
	end,

}