-- Atlas
SMODS.Atlas {
    key = "shrug_vouchers",
    px = 71,
    py = 95,
    path = "TeamShrug/vouchers.png"
}



---FIRST CONTACT---
-------------------
---FIRST CONTACT---

SMODS.Voucher {
    key = "shrug_first_contact",
    atlas = "shrug_vouchers",
    pos = { x = 0, y = 0 },
    cost = 10,

    -- Replace 1/5 booster cards (same odds as Omen Globe)
    calculate = function(self, card, context)
        if context.create_booster_card and context.booster.config.center.kind == "Celestial" and pseudorandom("v_worm_shrug_first_contact") > 0.8 then
            return {
                booster_create_flags = {
                    set = "shrug_alien",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    'ar4'
                }
            }
        end
    end,

    -- Credits
    ppu_coder = {
        "microwave",
    },
    ppu_artist = {
        "atiredguy",
    },
    ppu_team = { "shrug" }
}



---TRADE NETWORK---
-------------------
---TRADE NETWORK---

SMODS.Voucher {
    key = "shrug_trade_network",
    atlas = "shrug_vouchers",
    pos = { x = 1, y = 0 },
    cost = 10,
    requires = { "v_worm_shrug_first_contact" },
    config = { extra = { alien_rate = 3 } },

    -- Redeeming
    redeem = function(self, card)
        G.GAME.shrug_alien_rate = card.ability.extra.alien_rate
    end,

    -- Credits
    ppu_coder = {
        "microwave",
    },
    ppu_artist = {
        "atiredguy",
    },
    ppu_team = { "shrug" }
}
