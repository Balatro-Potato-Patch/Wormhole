
-- Bg
SMODS.DrawStep{
    key = 'module_background',
    order = 5,
    func = function(card, layer)
        if card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module' then
            return
        end
        if card and card.config.center.set == 'tbp_module' then
            card.children.center:draw_shader("worm_torn", nil, card.ARGS.send_to_shader)
            if card.children.front and not card:should_hide_front() then
                card.children.front:draw_shader("worm_torn", card, self.ARGS.send_to_shader)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Frame
SMODS.DrawStep{
    key = 'tbp_frame',
    order = 21,
    func = function(card, layer)
        if card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module' then
            return
        end
        if card and card.config.center.set == 'tbp_module' then
            if G.tbp and G.tbp.module_frames then
                local state = "base"
                G.tbp.module_frames[state].role.draw_major = card 
                G.tbp.module_frames[state]:draw_shader('dissolve', nil, nil, nil, card.children.center)
                -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
            end 
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Module
SMODS.DrawStep{
    key = 'tbp_module',
    order = 22,
    func = function(card, layer)
        if card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module' then
            return
        end
        if card and card.config.center.set == 'tbp_module' then
            if G.tbp and G.tbp.module_sprites then

                -- Haven't implemented actual sprites for it yet. oops
                -- G.tbp.module_sprites[card.config.center.key] = G.tbp.module_sprites[card.config.center.key] or Sprite(0, 0, G.CARD_W, G.CARD_W, 
                --     G.ASSET_ATLAS["worm_tbp_module_sprite_only"], {
                --         x=card.config.center.module_pos.x, 
                --         y=card.config.center.module_pos.y
                --     })

                G.tbp.module_sprites[card.config.center.key] = G.tbp.module_sprites[card.config.center.key] or Sprite(0, 0, G.CARD_W, G.CARD_W, 
                    G.ASSET_ATLAS["worm_tbp_module_sprite_only"], {
                        x=0, 
                        y=1
                    })
                G.tbp.module_sprites[card.config.center.key].role.draw_major = card 
                G.tbp.module_sprites[card.config.center.key]:draw_shader('dissolve',0, nil, nil, card.children.center, nil, nil, nil, nil, nil, 0.6)
                G.tbp.module_sprites[card.config.center.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
                -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
            end 
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}


-- Icon & Banner
SMODS.DrawStep{
    key = 'tbp_module_icon',
    order = 25,
    func = function(card, layer)
        if card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module' then
            return
        end
        if card and card.config.center.set == 'tbp_module' then
            if G.tbp and G.tbp.module_icons then
                local slot = card.config.center.slot
                G.tbp.module_banners[slot].role.draw_major = card 
                G.tbp.module_banners[slot]:draw_shader('dissolve', nil, nil, nil, card.children.center)

                G.tbp.module_icons[slot].role.draw_major = card 
                G.tbp.module_icons[slot]:draw_shader('dissolve', nil, nil, nil, card.children.center)
                -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
            end 
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
