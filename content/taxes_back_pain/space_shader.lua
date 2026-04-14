SMODS.Atlas {
  key = "tbp_big_space_atlas",
  path = "taxes_back_pain/space_bg.png",
  px = 800,
  py = 500
}
SMODS.Shader {
    key = 'torn', 
    path = 'torn.fs',
    send_vars = function(sprite)
        local atlas = G.ASSET_ATLAS[Wormhole.prefix .."_tbp_big_space_atlas"]
        atlas.image:setWrap("mirroredrepeat", "mirroredrepeat")
        
        local function generate_direction()
            local shader_speed = 15
            local a, b = 0, 0
            a = math.random() * shader_speed
            b = shader_speed - a
            local flip_a = math.random() > 0.5 and 1 or -1
            local flip_b = math.random() > 0.5 and 1 or -1

            return {h = flip_a * math.sqrt(a), v = flip_b * math.sqrt(b)}
        end

        -- Allows for a random starting point
        sprite.tbp_space_shader_random_pos = sprite.tbp_space_shader_random_pos or {x = math.random(0, 20) + (math.random()), y = math.random(0, 20) + (math.random())}
        sprite.tbp_space_shader_random_dir = sprite.tbp_space_shader_random_dir or generate_direction()
        local pos = sprite.tbp_space_shader_random_pos
        local dir = sprite.tbp_space_shader_random_dir
        local w, h = 50, 80
        local texW, texH = atlas.image:getDimensions()
    
        return {
            maskTex = atlas.image,
            maskAtlas = {atlas.px, atlas.py},
            maskPos = {pos.x, pos.y, texW, texH},
            maskDir = {dir.h, dir.v},
            maskUV = {w, h},
            -- { pos.x * atlas.px / texW, pos.y * atlas.py / texH, w / texW, h / texH },
        }
    end
}
SMODS.Atlas {
  key = "tbp_big_space_atlas_neg",
  path = "taxes_back_pain/space_bg_neg.png",
  px = 800,
  py = 500
}
SMODS.Shader {
    key = 'torn_neg', 
    path = 'torn_neg.fs',
    send_vars = function(sprite)
        local atlas = G.ASSET_ATLAS[Wormhole.prefix .."_tbp_big_space_atlas_neg"]
        atlas.image:setWrap("mirroredrepeat", "mirroredrepeat")
        -- Allows for a random starting point
        sprite.tbp_space_shader_random_pos = sprite.tbp_space_shader_random_pos or {x = math.random(0, 20) + (math.random()), y = math.random(0, 20) + (math.random())}
        local pos = sprite.tbp_space_shader_random_pos
        local w, h = 50, 80
        local texW, texH = atlas.image:getDimensions()
    
        return {
            maskTex = atlas.image,
            maskAtlas = {atlas.px, atlas.py},
            maskPos = {pos.x, pos.y, texW, texH},
            maskUV = {w, h},
            -- { pos.x * atlas.px / texW, pos.y * atlas.py / texH, w / texW, h / texH },
        }
    end
}