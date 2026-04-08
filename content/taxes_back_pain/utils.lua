-- Function to automatically apply mod prefix and item prefix to items in loc table
function Wormhole.tbp.prefix_loc_table(input, output)
    local mod_prefix = Wormhole.prefix
    for type, data in pairs(input) do
        local pref = mod_prefix .. '_tbp_'
        if SMODS[type] and SMODS[type].class_prefix then
            pref = SMODS[type].class_prefix .. '_' .. pref
        end
        if type == 'tbp_module' then
            pref = 'c_' .. pref
        end
        output.descriptions[type] = output.descriptions[type] or {}
        for key, t in pairs(data) do
            output.descriptions[type][pref..key] = t
        end
    end
    return output
end

function Card:tbp_has_module(m)
    if self and self.config and self.config.center and self.config.center.key == "j_worm_tbp_spaceship" then
        for k, v in ipairs(self.ability.extra.modules) do
            if v[1] == m then return true end
        end
    end
    return false
end

-- Game Start
local tbp_hook_igo = Game.init_game_object
function Game.init_game_object(self)
    local ret = tbp_hook_igo(self)

    ret.tbp = {
        round_reset = {

        },
        run = {
            modules_installed = {
                total = 0,
                --[type] = 0
            },
            modules_failed = {
                total = 0,
                --[type] = 0
            },
            last_module_installed = nil,
            last_module_failed = nil,
            durability_lost = {
                total = 0,
                -- [type] = 0
            },
        }
    }

    return ret
end