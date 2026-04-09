-- Magical Girl
SMODS.Joker {
    key = "lfc_magical_girl",
    blueprint_compat = true,
    demicoloncompat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    ppu_artist = {"J8-Bit"},
    ppu_team = { "Lancer Fan Club" },
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
        if context.joker_main or context.forcetrigger then
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
local function lfc_custom_image(filename)
    local full_path = (SMODS.current_mod.path .. "assets/lancer_fan_club/" .. filename)
    print("Loading image at " .. full_path)
    local file_data = assert(NFS.newFileData(full_path), ("Failed to create file_data"))
    local tempimagedata = assert(love.image.newImageData(file_data), ("Failed to create tempimagedata"))
    return (assert(love.graphics.newImage(tempimagedata), ("Failed to create return image")))
end

local image_ref = {}
for i = 1, 5 do
    local name = "lfc_sm_bg" .. tostring(i)
    --print(name)
    image_ref[i] = lfc_custom_image(name .. ".png")
end

-- Shader
SMODS.Shader {
    key = 'lfc_magical_girl',
    path = 'lfc_magical_girl.fs',

    send_vars = function(self, sprite, card)
        return {
            img_bg = image_ref[1],
            img_bg_details = { image_ref[1]:getWidth(), image_ref[1]:getHeight() },
            img_bigcircles = image_ref[2],
            img_bigcircles_details = { image_ref[2]:getWidth(), image_ref[2]:getHeight() },
            img_smallcircles = image_ref[3],
            img_smallcircles_details = { image_ref[3]:getWidth(), image_ref[3]:getHeight() },
            img_bigsparkles = image_ref[4],
            img_bigsparkles_details = { image_ref[4]:getWidth(), image_ref[4]:getHeight() },
            img_smallsparkles = image_ref[5],
            img_smallsparkles_details = { image_ref[5]:getWidth(), image_ref[5]:getHeight() },
        }
    end
}

-- DrawStep
SMODS.DrawStep {
    key = "lfc_magical_girl",
    order = 30,
    func = function(self, layer)
        if self.config.center_key == "j_worm_lfc_magical_girl" then
            --self.children.center:draw_shader('worm_lfc_magical_girl', nil, self.ARGS.send_to_shader)
            --print(self.config.center)
            self.config.lfc_decoration = self.config.lfc_decoration or
                SMODS.create_sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[self.config.center.atlas],
                    self.config.center.pos)
            self.config.lfc_decoration.role.draw_major = self
            self.config.lfc_decoration:draw_shader('worm_lfc_magical_girl', nil, self.ARGS.send_to_shader, nil,
                self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}
