local menthol = not not next(SMODS.find_mod("Menthol"))
local sarcpot = not not next(SMODS.find_mod("sarcpot"))
local wtmjq = not not next(SMODS.find_mod("Too Many Jimbo Quips"))
local index = not not next(SMODS.find_mod("Index"))
local steady = not not next(SMODS.find_mod("steady"))
local biblio = not not next(SMODS.find_mod("bibliography"))

SMODS.JimboQuip{
    key = "mrrp_menthol",
    extra = {
        text_key = "menthol",
        ppu_dev = "worm_Minty",
        materialize_colours = {
            HEX("CA7CA7")
        },
        sound = "worm_mrrp_meow"
    },
    filter = function (self, quip_type)
        local key = "menthol"
        if not menthol then
            key = "no_"..key
        end

        if quip_type == "win" then
            key = key.."_win"
            if menthol then
                local areas = {
                    "jokers",
                    "consumables",
                }
                for _,area in ipairs(areas) do
                    for i,card in ipairs(G[area].cards) do
                        if card.config.center.original_mod and card.config.center.original_mod.id == "Menthol" then
                            return true
                        end
                    end
                end
            end
        elseif quip_type == "loss" then
            key = key.."_loss"
        end

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        return not not G.localization.misc.quips[key]-- , G.quipdebugtime and {weight=10000} or nil
    end
}

SMODS.JimboQuip{
    key = "mrrp_biblio",
    extra = {
        text_key = "biblio",
        ppu_dev = "worm_Minty",
        materialize_colours = {
            HEX("CA7CA7")
        },
        sound = "worm_mrrp_meow"
    },
    filter = function (self, quip_type)
        local key = "biblio"
        if not biblio then
            key = "no_"..key
        end

        if quip_type == "win" then
            key = key.."_win"
        elseif quip_type == "loss" then
            key = key.."_loss"
        end

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        return not not G.localization.misc.quips[key]
    end
}

--HEY COPY THIS ONE FOR SUPER BASIC FUNCTIONALITY THANKS
SMODS.JimboQuip{ 
    key = "mrrp_sarcpot",
    extra = {
        text_key = "sarcpot",
        ppu_dev = "worm_SarcPot"
    },
    filter = function (self, quip_type)
        local key = "sarcpot"
        if not sarcpot then
            key = "no_"..key
        end

        --[[
        if quip_type == "win" then
            key = key.."_win"
        elseif quip_type == "loss" then
            key = key.."_loss"
        end
        ]]

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        return not not G.localization.misc.quips[key]
    end
}

SMODS.JimboQuip{
    key = "mrrp_wtmjq",
    extra = {
        text_key = "wtmjq",
        ppu_dev = "worm_MP"
    },
    filter = function (self, quip_type)
        local key = "wtmjq"
        if not wtmjq then
            key = "no_"..key
        end

        --[[
        if quip_type == "win" then
            key = key.."_win"
        elseif quip_type == "loss" then
            key = key.."_loss"
        end
        ]]

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        return not not G.localization.misc.quips[key]
    end
}

SMODS.JimboQuip{
    key = "mrrp_index",
    extra = {
        text_key = "index",
        ppu_dev = "worm_MP"
    },
    filter = function (self, quip_type)
        local key = "index"
        if not index then
            key = "no_"..key
        end

        --[[
        if quip_type == "win" then
            key = key.."_win"
        elseif quip_type == "loss" then
            key = key.."_loss"
        end
        ]]

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        return not not G.localization.misc.quips[key]
    end
}

SMODS.JimboQuip{
    key = "mrrp_cyan",
    extra = {
        text_key = "mmm",
        ppu_dev = "worm_Cyan"
    },
    filter = function (self, quip_type)
        local key = "mmm"

        if quip_type == "win" then
            key = key.."_win"
        elseif quip_type == "loss" then
            key = key.."_loss"
        end

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
            for k, v in ipairs(G.jokers.cards) do
                if v and v.config and v.config.center and v.config.center.ppu_team and v.config.center.ppu_team[1] == 'Mrrp Mew Meow :3' then
                    return not not G.localization.misc.quips[key]
                end
            end
        end
        return false
    end
}

SMODS.JimboQuip{
    key = "mrrp_steady",
    extra = {
        text_key = "steady",
        ppu_dev = "worm_Cyan"
    },
    filter = function (self, quip_type)
        local key = "steady"
        if not steady then
            key = "no_"..key
        end

        if quip_type == "win" then
            key = key.."_win"
        elseif quip_type == "loss" then
            key = key.."_loss"
        end

        key = "worm_mrrp_"..key

        --print(key)
        self.extra.text_key = key
        return not not G.localization.misc.quips[key]
    end
}