-- Magical Girl
SMODS.Joker {
    key = "lfc_magical_girl",
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    pos = { x = 0, y = 2 },
    discovered = false,
    config = { extra = { chips = 0, chips_inc = 15 } },
    attributes = {
        "chips",
        "scaling",
        "enhancements"
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_inc,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_ability and not context.blueprint then
            if (context.other_card.ability.set == "Default" or context.other_card.ability.set == "Enhanced") and context.new ~= "c_base" and (context.old ~= context.new) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "chips",            -- the key to the value in the ref_table
                    scalar_value = "chips_inc",     -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.CHIPS
                    }
                })
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    in_pool = function(self, args)
        for _, card in ipairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(card)) then
                return true
            end
        end
    end,
}

-- Images
SMODS.current_mod.lfc_custom_image = function(filename)
    local full_path = (SMODS.current_mod.path .. "assets/lancer_fan_club/" .. filename)
    print("Loading image at " .. full_path)
    local file_data = assert(NFS.newFileData(full_path), ("Failed to create file_data"))
    local tempimagedata = assert(love.image.newImageData(file_data), ("Failed to create tempimagedata"))
    return (assert(love.graphics.newImage(tempimagedata), ("Failed to create return image")))
end

for i = 1, 5 do
    local name = "lfc_sm_bg" .. tostring(i)
    --print(name)
    SMODS.current_mod[name] = SMODS.current_mod.lfc_custom_image(name .. ".png")
end

-- Shader
SMODS.Shader {
    key = 'lfc_magical_girl',
    path = 'lfc_magical_girl.fs',

    send_vars = function(self, sprite, card)
        local img_array = {}
        for i = 1, 5 do
            table.insert(img_array, SMODS.current_mod["lfc_sm_bg" .. tostring(i)])
        end
        return {
            imgs = img_array
        }
    end
}

-- DrawStep
SMODS.DrawStep {
    key = "lfc_magical_girl",
    order = 1,
    func = function(self, layer)
        if self.config.center_key == "j_wormhole_lfc_magical_girl" then
            print("DO THE DRAW THING")
            self.children.center:draw_shader('lfc_magical_girl', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}
