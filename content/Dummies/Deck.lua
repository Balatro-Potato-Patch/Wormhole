SMODS.Sound({ key = "dum_starstudded", path = "Dummies/worm_dum_starstudded.ogg" })

SMODS.Back {
    key = "dum_starstudded",
    atlas = 'DummiesDecks',
    pos = { x = 13, y = 5 },
    wormhole_pos_extra = {
        background_a = { x = 0, y = 1 },
        background_b = { x = 4, y = 1 },
        comet = { x = 6, y = 3 },
        stars = { x = 0, y = 2 },
        gleebleglorp = { x = 7, y = 3 },
        frame = { x = 0, y = 0 }
    },
    wormhole_pos_extra_order = {
        "background_a",
        "background_b",
        "comet",
        "stars",
        "gleebleglorp",
        "frame"
    },
    wormhole_anim_extra = {
        background_a = {
            { x = 0,                            y = 1, t = 5.15 },
            { xrange = { first = 1, last = 2 }, y = 1, t = 0.3 },
            { x = 3,                            y = 1, t = 5.15 },
            { xrange = { first = 2, last = 1 }, y = 1, t = 0.3 },
        },
        background_b = {
            { x = 7,                            y = 1, t = 5 },
            { xrange = { first = 6, last = 5 }, y = 1, t = 0.3 },
            { x = 4,                            y = 1, t = 5.15 },
            { xrange = { first = 5, last = 6 }, y = 1, t = 0.3 },
            { x = 7,                            y = 1, t = 0.15 }
        },
        comet = {
            { x = 6,                            y = 3, t = 30.192837465 },
            { xrange = { first = 3, last = 5 }, y = 3, t = 0.1 },
        },
        stars = {
            { x = 0,                            y = 2, t = 6.987654321 },
            { xrange = { first = 1, last = 7 }, y = 2, t = 0.125 },
            { xrange = { first = 0, last = 2 }, y = 3, t = 0.125 }
        },
        gleebleglorp = {
            { x = 7,                             y = 3,                            t = 600 },
            { xrange = { first = 0, last = 7 },  yrange = { first = 4, last = 7 }, t = 0.1 },
            { xrange = { first = 8, last = 15 }, yrange = { first = 0, last = 4 }, t = 0.1 },
            { xrange = { first = 8, last = 12 }, y = 5,                            t = 0.1 },
        },
        frame = {
            { x = 0,                            y = 0, t = 1 },
            { xrange = { first = 1, last = 6 }, y = 0, t = 0.1 },
            { x = 0,                            y = 0, t = 4 }
        }
    },
    apply = function(self, back)
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 1
    end,
    calculate = function(self, back, context)
        if context.using_consumeable and context.consumeable.config.center.set == "Planet" and not G.GAME.worm_dum_starstudded_used then
            local planets_used = 0
            if G.GAME and G.GAME.consumeable_usage then
                for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end
            end

            if planets_used >= 9 then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 2
                G.GAME.worm_dum_starstudded_used = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("worm_dum_starstudded", 1, 0.6)
                        return true
                    end
                }))
                return { message = localize { type = "variable", key = "worm_dum_a_joker_slots", vars = { 2 } } }
            end
        end
    end,

    ppu_team = { "dummies" },
    ppu_artist = { "ghostsalt" },
    ppu_coder = { "ghostsalt" }
}