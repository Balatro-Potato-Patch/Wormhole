SMODS.ConsumableType({
    key = "worm_meow_Spacetart",
    primary_colour = HEX("2e4bff"),
    secondary_colour = HEX("5b4bf0"),
    collection_rows = { 6 },
    shop_rate = 4,
    text_colour = G.C.UI.TEXT_LIGHT,
})

SMODS.Atlas({
    key = "meow_spacetart",
    px = 71,
    py = 95,
    path = "TeamMeow/spacetarts.png",
})

local ref = Card.init
function Card:init(...)
    local ret = ref(self, ...)
    self.tarts = {}
    return ret
end

local card_save = Card.save
function Card:save(...)
    local st = card_save(self, ...)
    st.tarts = self.tarts
    return st
end

local card_load = Card.load
function Card:load(cardTable, other_card, ...)
    local st = card_load(self, cardTable, other_card, ...)
    self.tarts = cardTable.tarts
    return st
end
SMODS.Consumable({
    key = "stellar_strawberry",
    set = "worm_meow_Spacetart",
    atlas = "meow_spacetart",
    soul_pos = { x = 1, y = 0 },
    pos = { x = 0, y = 2 },
    config = {
        extra = {
            perma_chips = 25,
        },
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_chips,
            },
        }
    end,
    use = function(self, card, area, copier)
        table.insert(G.jokers.cards[1].tarts, "stellar_strawberry")
    end,
    can_use = function(self, card)
        return #G.jokers.cards >= 1
    end,
})
-- todo: rename variable to be better
local g = {
    stellar_strawberry = {
        regular_func = function (card, context)
            return {
                message = "test",
            }
        end,
        
        boosted_func = function (card, context)
            if context.joker_main then
                return {
                    message = "betterTest",
                }
            end
        end,
        boost_key = "j_joker",
        pos = {x=1,y=0}
    }
}

local gcu = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card, ...)
    local ret = gcu(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card, ...)
    if card then
        local Table = {}
        for k, v in ipairs(card.tarts) do
            Table[v] = Table[v] and Table[v] + 1 or 1
        end
        for k, v in pairs(Table) do
            generate_card_ui({
                set = "Other",
                key = "spacetart_"..k.."_"..(card.config.center.key == g[k].boost_key and "boosted" or "regular")
            }, ret, {v})
        end
    end
    return ret
end
meow_add_dev_calc_functionality("silverautumn", function (old, _, context)
    for k, card in pairs(G.jokers.cards) do
        for kk, tart in ipairs(card.tarts) do
            local key = card.config.center.key
            if key == g[tart].boost_key then
                SMODS.calculate_effect(g[tart].boosted_func(card, context) or {}, card)
            else
                SMODS.calculate_effect(g[tart].regular_func(card, context) or {}, card)
            end
        end
    end
    return old
end)
SMODS.DrawStep {
    key = 'tarts',
    order = 100,
    func = function(card)
        local yshift = 0
        local yinc = 0.2/3
        for k, v in ipairs(card.tarts) do
            local tartObj = g[v]
            tartObj.sprite = tartObj.sprite or
            Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["worm_meow_spacetart"], tartObj.pos)
            local tartSprite = tartObj.sprite
            tartSprite.role.draw_major = card
            tartSprite:draw_shader('dissolve', 0, nil, nil, card.children.center, 0, 0, 0, yshift, nil, 0.6)
            tartSprite:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, 0, 0, yshift)
            yshift = yshift + yinc
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
