--- Adds a functionality to a developer calculate.\
--- basically just hooks but fuck you regardless
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
function meow_cards_are_colliding(c1,c2)
    local xiscolliding = (c1.T.x <= c2.T.x + c2.T.w) and (c1.T.x + c1.T.w >= c2.T.x)
    local yiscolliding = (c1.T.y <= c2.T.y + c2.T.h) and (c1.T.y + c1.T.h >= c2.T.y)
    return xiscolliding and yiscolliding
end

function meow_get_distance_between_two_cards(c1,c2)
    return ((c1.T.x + c1.T.w / 2 - (c2.T.x + c2.T.w / 2)) ^ 2 + (c1.T.y + c1.T.h / 2 - (c2.T.y + c2.T.h / 2)) ^ 2)^(1/2)
    
end