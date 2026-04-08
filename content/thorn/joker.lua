SMODS.Atlas {
    key = 'thorn_cards',
    path = 'thorn/thorn_cards.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	key = 'thorn_jimbo',
	rarity = 1,
    atlas = "thorn_cards",
	pos = { x = 0, y = 0 },
	cost = 4,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false, -- Me making our Jokers compatible with my shit... Hehehehe :Þ
    loc_vars = function(self, info_queue, card)
        return { vars = {G.PROFILES[G.SETTINGS.profile].name}}
    end,
	calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            SMODS.add_card{set = "Planet"}
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card:add_sticker("perishable", true)
    end,
    ppu_artist = {"None, currently"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

SMODS.Joker {
	key = 'thorn_binary',
	rarity = 1,
    atlas = "thorn_cards",
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false,
    config = { extra = { odds = 2, times = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'thorn_binary')
		return { vars = { numerator, denominator} }
    end,
    ppu_artist = {"willow"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

--Not sure if I should like make a file for this stuff but
Wormhole.suits_dark = {Spades = true, Clubs = true}
Wormhole.suits_light = {Hearts = true, Diamonds = true}

function suit_count(suit)
    local count = 0
    for k, v in pairs(G.playing_cards) do
        if v.base and v.base.suit == suit then
            count = count + 1
        end
        if suit == "dark" then
            if v.base and Wormhole.suits_dark[v.base.suit] then
                count = count + 1
            end
        elseif suit == "light" then
            if v.base and Wormhole.suits_light[v.base.suit] then
                count = count + 1
            end
        end
    end
    return count
end

SMODS.Joker {
	key = 'thorn_derse',
	rarity = 2,
    atlas = "thorn_cards",
	pos = { x = 2, y = 0 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = true,
    config = { extra = { xmult_base = 1, xmult_gain = 0.1, xmult = 1, percentage_floor = 45 } },
    loc_vars = function(self, info_queue, card)
        if card.area.config.type == "Joker" then
            local percentage = ((suit_count("dark")/#G.playing_cards)*100)
            if percentage >= card.ability.extra.percentage_floor then
                card.ability.extra.xmult = card.ability.extra.xmult_base + ((percentage - card.ability.extra.percentage_floor) * card.ability.extra.xmult_gain)
            else
                card.ability.extra.xmult = card.ability.extra.xmult_base
            end
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.percentage_floor, percentage }, key = self.key }
        else
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.percentage_floor }, key = self.key .. "_collection" }
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local percentage = ((suit_count("dark")/#G.playing_cards)*100)
            if percentage >= card.ability.extra.percentage_floor then
                card.ability.extra.xmult = card.ability.extra.xmult_base + ((percentage - card.ability.extra.percentage_floor) * card.ability.extra.xmult_gain)
            else
                card.ability.extra.xmult = card.ability.extra.xmult_base
            end
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    ppu_artist = {"This will get replaced by ERROR"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}