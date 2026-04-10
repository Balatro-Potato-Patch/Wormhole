SMODS.Back {
    key = "tlr_astrologist",
	set = "Back",
    atlas = "tlr_deck",
	pos = { x = 0, y = 0 },
    config = { vouchers = { 'v_worm_tlr_skywatching', 'v_worm_tlr_stargazing' } },

    loc_vars = function(self, info_queue, card)
		return {
            vars = {
                localize{type = 'name_text', key = 'v_worm_tlr_skywatching', set = 'Voucher'},
                localize{type = 'name_text', key = 'v_worm_tlr_stargazing', set = 'Voucher'}
            }
        }
	end,
}