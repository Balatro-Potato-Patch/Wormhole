SMODS.ConsumableType({
    key = "worm_meow_Spacetart",
    primary_colour = HEX("2e4bff"),
    secondary_colour = HEX("5b4bf0"),
    select_card = "consumeables",
    default = "c_worm_stellar_strawberry",
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
SMODS.Atlas({
    key = "meow_sparkle",
    px = 71,
    py = 95,
    path = "TeamMeow/sparkle.png",
    frames = 7,
    atlas_table = "ANIMATION_ATLAS"
})
SMODS.Atlas({
    key = "meow_sparkleBg",
    px = 71,
    py = 95,
    path = "TeamMeow/sparkleBg.png",
    frames = 7,
    atlas_table = "ANIMATION_ATLAS"
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

Wormhole.TEAM_MEOW.tartInfo = {}
local function create_tart(tart, tartPos, foilPos, regFunc, boostFunc, boostKey)
    SMODS.Consumable({
        key = tart,
        set = "worm_meow_Spacetart",
        atlas = "meow_spacetart",
        soul_pos = foilPos,
        pos = tartPos,
        config = {
            extra = {
                tart = tart,
            },
        },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = {
                set = "Other",
                key = "spacetart_" .. tart .. "_regular",
                specific_vars = { "","","" }
            }
        end,
        can_use = function(self, card)
            return false
        end,
    })
    Wormhole.TEAM_MEOW.tartInfo[tart] = {
        regular_func = regFunc,
        boosted_func = boostFunc,
        boost_key = boostKey,
        pos = foilPos
    }
end
create_tart("stellar_strawberry", { x = 0, y = 2 }, { x = 1, y = 0 }, function (card, context) return { message = "test" } end, function (card, context)
    if context.joker_main then
        return {
            message = "betterTest",
        }
    end
end, "j_joker")
local g = Wormhole.TEAM_MEOW.tartInfo
local gcu = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card, ...)
    local ret = gcu(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card, ...)
    if card and card.tarts then
        local Table = {}
        for k, v in ipairs(card.tarts) do
            Table[v] = Table[v] and Table[v] + 1 or 1
        end
        for k, v in pairs(Table) do
            generate_card_ui({
                set = "Other",
                key = "spacetart_"..k.."_"..(card.config.center.key == Wormhole.TEAM_MEOW.tartInfo[k].boost_key and "boosted" or "regular")
            }, ret, { localize("k_stack1"), v, localize("k_stack2") })
        end
    end
    return ret
end
meow_add_dev_calc_functionality("silverautumn", function (old, _, context)
    for k, card in pairs(G.jokers.cards) do
        if card.tarts then
            for kk, tart in ipairs(card.tarts) do
                local key = card.config.center.key
                if key == g[tart].boost_key then
                    SMODS.calculate_effect(g[tart].boosted_func(card, context) or {}, card)
                else
                    SMODS.calculate_effect(g[tart].regular_func(card, context) or {}, card)
                end
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
        if card.tarts then
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
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
SMODS.DrawStep {
    key = 'sparkle',
    order = 150,
    func = function(card)
        local bool = false
        if G.jokers and G.jokers.cards then
            for k, v in pairs(G.jokers.cards) do
                if meow_cards_are_colliding(card, v) then
                    bool = true
                end
            end
        end
        local playerHas = false
        if G.consumeables and G.consumeables.cards then
            for k, v in pairs(G.consumeables.cards) do
                if v == card then
                    playerHas = true
                end
            end
        end
        if card.ability.set == "worm_meow_Spacetart" and bool and playerHas then
            Wormhole.TEAM_MEOW.sharedSparkleBg = Wormhole.TEAM_MEOW.sharedSparkleBg or
                AnimatedSprite(0, 0, G.CARD_W, G.CARD_H, G.ANIMATION_ATLAS["worm_meow_sparkleBg"], {x=0,y=0})
            Wormhole.TEAM_MEOW.sharedSparkleBg.role.draw_major = card
            Wormhole.TEAM_MEOW.sharedSparkleBg:draw_shader('dissolve', nil, nil, nil, card.children.center, 0.025, 0, 0, 0)
            Wormhole.TEAM_MEOW.sharedSparkle = Wormhole.TEAM_MEOW.sharedSparkle or
                AnimatedSprite(0, 0, G.CARD_W, G.CARD_H, G.ANIMATION_ATLAS["worm_meow_sparkle"], {x=0,y=0})
            Wormhole.TEAM_MEOW.sharedSparkle.role.draw_major = card
            Wormhole.TEAM_MEOW.sharedSparkle:draw_shader('dissolve', nil, nil, nil, card.children.center, 0, 0, 0, 0)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
local old = Card.draw
function Card:draw(...)
    local ret = old(self, ...)
    local bool = false
    if G.jokers and G.jokers.cards then
        for k, v in ipairs(G.jokers.cards) do
            if meow_cards_are_colliding(self, v) and self ~= v then
                bool = true
            end
        end
    end
    local color = bool and HEX("63c74d") or HEX("ff0044")
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(color[1],color[2],color[3],0.25)
    if Wormhole.TEAM_MEOW.DEBUG then
    love.graphics.rectangle("fill", self.T.x * G.TILESIZE * G.TILESCALE, self.T.y * G.TILESIZE * G.TILESCALE,
    self.T.w * G.TILESIZE * G.TILESCALE, self.T.h * G.TILESIZE * G.TILESCALE)
    end
    love.graphics.setColor(r,g,b,a)
end
local old = Card.stop_drag
function Card:stop_drag(...)
    local ret = old(self, ...)
    local bool = false
    local colliders = {}
    if G.jokers and G.jokers.cards then
        for k, v in pairs(G.jokers.cards) do
            if meow_cards_are_colliding(self, v) then
                bool = true
                table.insert(colliders, { card = v, dist = meow_get_distance_between_two_cards(v, self)})
            end
        end
    end
    local playerHas = false
    if G.consumeables and G.consumeables.cards then
        for k, v in pairs(G.consumeables.cards) do
            if v == self then
                playerHas = true
            end
        end
    end
    if self.ability and self.ability.set == "worm_meow_Spacetart" and bool and playerHas then
        local tart = self.ability.extra.tart
        table.sort(colliders, function (a, b)
            return a.dist < b.dist
        end)
        table.insert(colliders[1].card.tarts, tart)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0,
            func = function()
                self:start_dissolve(nil, nil, 0.9)
                play_sound("worm_meowChomp", 1 + 0.5 * (math.random() - 0.5), 0.6)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.6,
            func = function()
                play_sound("tarot1")
                colliders[1].card:juice_up(0.5, 0.5)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot2", nil, 0.8)
                colliders[1].card:juice_up(0.2, 0.5)
                love.mouse.setCursor()
                return true
            end,
        }))
    end
    return ret
end
local old = Game.update
function Game:update(dt, ...)
    local ret = old(self, dt, ...)
    if G.consumeables and G.consumeables.cards then
        for k, v in pairs(G.consumeables.cards) do
            if v.ability and v.ability.set == "worm_meow_Spacetart" then
                local bool = false
                if G.jokers and G.jokers.cards then
                    for k, vv in pairs(G.jokers.cards) do
                        if meow_cards_are_colliding(v, vv) then
                            bool = true
                        end
                    end
                end
                if bool then
                    love.mouse.setCursor(Wormhole.TEAM_MEOW.cursor)
                else
                    love.mouse.setCursor()
                end
            end
        end
    end
end