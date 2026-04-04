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