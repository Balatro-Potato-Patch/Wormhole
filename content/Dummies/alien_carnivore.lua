SMODS.Atlas {
  key = "dum_carnivore",
  path = "Dummies/carnivore.png",
  px = 71,
  py = 95
}

SMODS.Sound{
    key = "dum_sfx_carnivore_chomp",
    path = "Dummies/sfx_carnivore_chomp.ogg",
    pitch = 1.0,
    volume = 1.0
}

--- comment
--- @param card balatro.Card
--- @return boolean
local function can_carnivore_eat(card)
    return card:has_attribute("alien") or card:has_attribute("cat") or card:has_attribute("fish") or false
end

-- should be implmeneted in SMODS 1603a Card:has_attribute(attribute)
if not Card.has_attribute then 
    function Card:has_attribute(attribute)
    if not SMODS.Attributes[attribute] then return end
    for i, v in pairs(SMODS.get_attribute_pool(attribute)) do
        if v == self.config.center.key then return true end
    end
    end
end

-- Ceremonial Dagger
SMODS.Joker {
    key = "dum_carnivore",
    attributes = {"mult","chips","xmult", "alien"},
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "dum_carnivore",

    wormhole_pos_extra = { x = 0, y = 1 },
    wormhole_anim = {
        { x = 0, y = 0, t = 3 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { x = 3, y = 0, t = 0.2 },
        { xrange = { first = 1, last = 2 }, y = 0, t = 0.2 },
        { x = 0, y = 0, t = 2 },
        { x = 3, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { x = 0, y = 0, t = 2 },
        { x = 3, y = 0, t = 0.1 },
        { x = 0, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
        { xrange = { first = 0, last = 2 }, y = 0, t = 0.2 },
    },
    wormhole_anim_extra = {
        { x = 0, y = 1, t = 2.1 }, { x = 3, y = 1, t = 0.1 },
        { x = 0, y = 1, t = 0.1 }, { x = 3, y = 1, t = 0.1 },
        { x = 0, y = 1, t = 0.1 }, { x = 3, y = 1, t = 0.1 },
        { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
        { x = 0, y = 1, t = 0.1 }, { x = 3, y = 1, t = 0.1 },
        { x = 0, y = 1, t = 8 },
        { x = 0, y = 1, t = 0.1 }, { x = 3, y = 1, t = 0.1 },
        { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
        { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
        { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
        { x = 0, y = 1, t = 2.1 }, { x = 3, y = 1, t = 0.1 },
        { x = 0, y = 1, t = 8 },
        { x = 0, y = 1, t = 2.1 }, { x = 3, y = 1, t = 0.1 },
        { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
        { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
    },

    pos = { x = 0, y = 0 },
    config = { extra = { mult_gain = 7, chips_gain = 17, xmult_gain = 0.3, mult = 0, chips = 0, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.mult_gain, card.ability.extra.chips_gain, card.ability.extra.xmult_gain,
            card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.xmult
        } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and can_carnivore_eat(G.jokers.cards[my_pos + 1]) and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        -- See note about SMODS Scaling Manipulation on the wiki -- TODO should I use SMODS.scale_card?
                        if sliced_card:has_attribute("alien") then
                            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                        end
                        if sliced_card:has_attribute("cat") then
                            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                        end
                        if sliced_card:has_attribute("fish") then
                            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                        end
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('worm_dum_sfx_carnivore_chomp', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = localize('k_worm_dum_carnivore_eat'),
                    colour = G.C.RED,
                    no_juice = true
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                xmult = card.ability.extra.xmult
            }
        end
    end,

    ppu_team = {"dummies"},
    ppu_coder = {"vissa"},
    ppu_artist = {"vissa"},
    pronouns = "it_its"
}
