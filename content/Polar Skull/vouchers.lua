SMODS.Atlas {
    key = "polarskull_vouchers",
    path = "Polar Skull/vouchers.png",
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = "polarskull_gravitational_slingshot",
    atlas = "polarskull_vouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { } },
	requires = { },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
	--ppu_artist = {"jade", "noodlemire"},
	ppu_artist = {"comykel"},
	ppu_coder = {"rainstar"},
    ppu_team = { "polar_skull" },
    -- the code for it is in rockets.lua
}

SMODS.Voucher {
    key = "polarskull_prepetual_motion_machine",
    atlas = "polarskull_vouchers",
    pos = { x = 1, y = 0 },
    config = { extra = { } },
	requires = { "v_worm_polarskull_gravitational_slingshot" },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
	--ppu_artist = {"jade", "noodlemire"},
	ppu_artist = {"comykel"},
	ppu_coder = {"rainstar"},
    ppu_team = { "polar_skull" },
    -- the code for it is in rockets.lua
}
