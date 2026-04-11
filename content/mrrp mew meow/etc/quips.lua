local menthol = not not next(SMODS.find_mod("Menthol"))

SMODS.JimboQuip{
    key = "mrrp_menthol",
    extra = {
        text_key = "menthol",
        materialize_colours = {
            HEX("CA7CA7")
        },
        sound = "worm_mrrp_meow"
    },
    filter = function (self, quip_type)
        local key = "menthol"
        local center = "j_minty_minty"
        if not menthol then
            key = "no_"..key
            center = "j_lucky_cat"
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

        print(key)
        self.extra.text_key = key
        self.extra.center = center
        return not not G.localization.misc.quips[key], G.testdebuglol and {weight=10000} or nil
    end
}