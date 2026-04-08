--- Adds a functionality to a developer calculate.\
--- basically just hooks but fuck you regardless\
--- update: this has gone literally unused because global calc is dumb and stupid
--- @param dev string
--- @param func function
function meow_add_dev_calc_functionality(dev, func)
    local devObject = PotatoPatchUtils.Developers['worm_' .. dev]
    local oldCalc = devObject.calculate
    devObject.calculate = function (self, context)
        local ret = oldCalc and oldCalc(self, context) or nil
        ret = func(ret, self, context)
        return ret
    end
end
--- Returns whether 2 cards are colliding visually.
--- @param c1 Card
--- @param c2 Card
--- @return boolean
function meow_cards_are_colliding(c1,c2)
    local c1CenterX, c1CenterY = c1.T.x + c1.T.w / 2, c1.T.y + c1.T.h / 2
    local xiscolliding = c1CenterX > c2.T.x and c1CenterX < c2.T.x + c2.T.w
    local yiscolliding = c1CenterY > c2.T.y and c1CenterY < c2.T.y + c2.T.h
    return xiscolliding and yiscolliding
end
--- Gets the distance between 2 cards.
--- @param c1 Card
--- @param c2 Card
--- @return number
function meow_get_distance_between_two_cards(c1,c2)
    return ((c1.T.x + c1.T.w / 2 - (c2.T.x + c2.T.w / 2)) ^ 2 + (c1.T.y + c1.T.h / 2 - (c2.T.y + c2.T.h / 2)) ^ 2)^(1/2)
end

--- Shorthand for checking if the card has less than 7 tarts or not
--- @param card Card
--- @return boolean
function meow_can_apply_foil(card)
    if not card.tarts or not G.GAME or type(G.GAME.max_foil_slots) ~= "number" then
        return false
    else
        return #card.tarts < G.GAME.max_foil_slots
    end
end
