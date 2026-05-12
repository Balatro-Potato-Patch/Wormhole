SMODS.Stake{
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Shinku'},
    ppu_coder = {'Shinku'},
    key = 'mrrp_cosmic',
    atlas = 'mrrp_stake',
    pos = {x = 0, y = 0},
    applied_stakes = { "stake_gold" },
    sticker_atlas = "mrrp",
    sticker_pos = {x = 2, y = 0},
    shiny = true,
    colour = HEX('5F718B'),
    prefix_config = {
        applied_stakes = false
    },
	modifiers = function()
		G.GAME.modifiers.enable_worm_mrrp_meteoric = true
	end,

}