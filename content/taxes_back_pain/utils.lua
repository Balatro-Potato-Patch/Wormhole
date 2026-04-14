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

-- Function to get equipped module on a spaceship
-- card: spaceship
function Wormhole.tbp.get_equipped_modules(card)
    local modules = {}
    if card.ability and card.ability.extra and card.ability.extra.modules then
        for k, v in pairs(card.ability.extra.modules) do
            if next(v) then
                modules[k] = v
            end
        end
    end
    if next(modules) then
        return modules
    end
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

    self.tbp.module_icons = {
        core = Sprite(0, 0, self.CARD_W, self.CARD_W, 
            G.ASSET_ATLAS["worm_tbp_icons_cards"], {
                x=2, 
                y=0
            }),
        weapons = Sprite(0, 0, self.CARD_W, self.CARD_H,
            G.ASSET_ATLAS["worm_tbp_icons_cards"], {
                x = 0,
                y = 0
            }),
        thrusters = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_icons_cards"], {
                x = 1,
                y = 0
            }),
        utility = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_icons_cards"], {
                x = 3,
                y = 1
            }),
        undiscovered = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_icons_cards"], {
                x = 5,
                y = 1
            }),
    }

    self.tbp.module_banners = {
        core = Sprite(0, 0, self.CARD_W, self.CARD_W, 
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x=1, 
                y=0
            }),
        weapons = Sprite(0, 0, self.CARD_W, self.CARD_H,
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x = 0,
                y = 0
            }),
        thrusters = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x = 2,
                y = 0
            }),
        utility = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x = 4,
                y = 0
            }),
        undiscovered = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x = 5,
                y = 0
            }),
    }

    self.tbp.module_frames = {
        base = Sprite(0, 0, self.CARD_W, self.CARD_W, 
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x=1, 
                y=1
            }),
        undiscovered = Sprite(0, 0, self.CARD_W, self.CARD_H,
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x = 1,
                y = 2
            }),
        negative = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["worm_tbp_module_frame"], {
                x = 0,
                y = 1
            }),
    }

    self.tbp.spaceship = Sprite(0, 0, self.CARD_W, self.CARD_W, 
            G.ASSET_ATLAS["worm_tbp_ship_soul"], {
                x=4, 
                y=0
            })

    -- self.tbp.module_sprites = {}

    return ret
end