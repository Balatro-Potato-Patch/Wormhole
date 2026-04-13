SMODS.Sound({
    key = "lfc_berry_wow",
    path = "lfc_berry_wow.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx1",
    path = "lfc_berry_sfx1.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx2",
    path = "lfc_berry_sfx2.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx3",
    path = "lfc_berry_sfx3.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx4",
    path = "lfc_berry_sfx4.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx5",
    path = "lfc_berry_sfx5.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_ante",
    path = "lfc_berry_ante.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_secret",
    path = "lfc_berry_secret.ogg",
    pitch = 1
})


SMODS.Joker({
    key = "lfc_fw",
    pos = { x = 4, y = 1 },
    soul_pos = {
        x = 5,
        y = 1,
        draw = function(card, scale_mod, rotate_mod)
            --print(card.edition and card.edition.shader)
            -- TODO: make this better for shader compatibility; this might break with custom editions
            card.children.floating_sprite:draw_shader(
                card.edition and (card.edition.shader or string.sub(card.edition.key, 3)) or 'dissolve',
                nil,
                card.edition and card.ARGS.send_to_shader or nil, nil,
                card.children.center, scale_mod, rotate_mod)
        end
    },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    demicoloncompat = true,
    atlas = "lfc_jokers",
    ppu_coder = { "ProdByProto" },
    ppu_artist = { "ProdByProto", "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
    config = {
        extra = {
            enhancement = "m_bonus",
            xmult = 2.5,
            secret = 0,
        }
    },
    attributes = {
        "xmult",
        "enhancements",
        --"on_sell",
        --"generation"
    },
    loc_vars = function(self, info_queue, card)
        local hint1, hint2 = "...", " "
        if card.ability.extra.secret == 1 then
            hint1, hint2 = localize("k_lfc_secret1"), localize("k_lfc_secret2")
        elseif card.ability.extra.secret == 2 then
            hint1, hint2 = localize("k_lfc_secret3"), localize("k_lfc_secret4")
        end
        return {
            vars = { card.ability.extra.enhancement and
            localize({ type = 'name_text', set = "Enhanced", key = card.ability.extra.enhancement }) or "Bonus Card",
                card.ability.extra.xmult, hint1, hint2 }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            if not G.GAME.lfc_berry_secret then G.GAME.lfc_berry_secret = 0 end
            card.ability.extra.secret = G.GAME.lfc_berry_secret
            if not card.ability.extra.secret == 1 then
                play_sound("worm_lfc_berry_wow", 1, 0.6)
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            if G.GAME.round_resets.ante >= 9 and card.ability.extra.secret == 1 then
                G.GAME.lfc_berry_secret = 2
                play_sound("worm_lfc_berry_secret", 1, 0.6)
                SMODS.add_card({ key = "j_worm_lfc_fw" })
            end
        end
    end,

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if (context.individual and context.cardarea == G.play and not context.end_of_round) or context.forcetrigger then
            if SMODS.has_enhancement(context.other_card, "m_bonus") then
                return {
                    xmult = cae.xmult,
                    remove_default_message = true,
                    message = localize { type = "variable", key = "a_xmult", vars = { cae.xmult } },
                    sound = "worm_lfc_berry_sfx" .. pseudorandom("moonberry_xmult_sfx", 1, 5),
                    colour = G.C.MULT
                }
            end
        end

        if context.ante_change and context.ante_end then
            if G.GAME.round_resets.ante >= 9 then
                if cae.secret == 0 then cae.secret = 1 end
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                func = function()
                    play_sound("worm_lfc_berry_ante", 1, 0.6)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.01585,
                        blockable = false,
                        blocking = false,
                        pause_force = true,
                        func = function()
                            card:juice_up(0.2)
                            for i=1, 10 do
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.0635 * i,
                                    blockable = false,
                                    blocking = false,
                                    pause_force = true,
                                    func = function()
                                        card:juice_up(0.3)
                                        return true
                                    end
                                }))
                            end
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.635,
                                blockable = false,
                                blocking = false,
                                pause_force = true,
                                func = function()
                                    card:juice_up(0.6)
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                end
            }
        end
    end

})

-- Images
local function lfc_custom_image(filename)
    local full_path = (SMODS.current_mod.path .. "assets/lancer_fan_club/" .. filename)
    print("Loading image at " .. full_path)
    local file_data = assert(NFS.newFileData(full_path), ("Failed to create file_data"))
    local tempimagedata = assert(love.image.newImageData(file_data), ("Failed to create tempimagedata"))
    return (assert(love.graphics.newImage(tempimagedata), ("Failed to create return image")))
end

local moon_berry_wormhole_image = lfc_custom_image("lfc_wormhole_spiral.png")

-- Shader
SMODS.Shader {
    key = 'lfc_moon_berry',
    path = 'lfc_moon_berry.fs',

    send_vars = function(self, sprite, card)
        return {
            wormhole_img = moon_berry_wormhole_image,
            wormhole_img_details = { moon_berry_wormhole_image:getWidth(), moon_berry_wormhole_image:getHeight() },
        }
    end
}

-- DrawStep
SMODS.DrawStep {
    key = "lfc_moon_berry",
    order = 30,
    func = function(self, layer)
        if self.config.center_key == "j_worm_lfc_fw" then
            --self.children.center:draw_shader('worm_lfc_magical_girl', nil, self.ARGS.send_to_shader)
            --print(self.config.center)
            self.config.lfc_decoration = self.config.lfc_decoration or
                SMODS.create_sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[self.config.center.atlas],
                    self.config.center.pos)
            self.config.lfc_decoration.role.draw_major = self
            self.config.lfc_decoration:draw_shader('worm_lfc_moon_berry', nil, self.ARGS.send_to_shader, nil,
                self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}
