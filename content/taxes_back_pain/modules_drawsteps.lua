
-- Bg
SMODS.DrawStep{
    key = 'module_background',
    order = 5,
    func = function(card, layer)
        if card.config.center.discovered and (card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module') then
            return
        end
        if card and (card.config.center.set == 'tbp_module' or card.config.center.atlas == 'worm_tbp_ship') then
            local _shader = "worm_torn"
            if card.edition and card.edition.negative then
                _shader = "worm_torn_neg"
            end
            card.children.center:draw_shader(_shader, nil, card.ARGS.send_to_shader)
            if card.children.front and not card:should_hide_front() then
                card.children.front:draw_shader(_shader, card, self.ARGS.send_to_shader)
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
        if card.config.center.discovered and card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module' then
            return
        end
        if card and card.config.center.set == 'tbp_module' then
            if G.tbp and G.tbp.module_frames then
                local state = card.config.center.discovered and "base" or 'undiscovered'
                if card.edition and card.edition.negative then
                    state = "negative"
                end
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
        if not card.config.center.discovered or (card.config.center.discovered and (card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module')) then
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
                -- local pos = card.config.center.module_pos or {x=9, y=1}
                -- G.tbp.module_sprites[card.config.center.key] = G.tbp.module_sprites[card.config.center.key] or Sprite(0, 0, G.CARD_W, G.CARD_W, 
                --     G.ASSET_ATLAS["worm_tbp_module_sprite_only"], pos)
                
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
        if card.config.center.discovered and card.config.center.atlas == 'centers' or card.config.center.atlas == 'worm_tbp_module' then
            return
        end
        if card and card.config.center.set == 'tbp_module' then
            if G.tbp and G.tbp.module_icons then
                local slot = card.config.center.discovered and card.config.center.slot or 'undiscovered'
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

-- Undiscovered Versions
SMODS.UndiscoveredSprite {
    key = "tbp_module",
    atlas = "worm_tbp_module_frame",
    pos = {x = 3, y = 1} 
}

-- Spaceship Drawsteps
SMODS.DrawStep{
    key = 'tbp_spaceship',
    order = 30,
    func = function(card, layer)
        if card and card.config.center.atlas == 'worm_tbp_ship' then
            if G.tbp and G.tbp.spaceship then
                G.tbp.spaceship.role.draw_major = card 
                G.tbp.spaceship:draw_shader('dissolve',0, nil, nil, card.children.center, nil, nil, nil, nil, nil, 0.6)
                G.tbp.spaceship:draw_shader('dissolve', nil, nil, nil, card.children.center)
                -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
            end 
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}