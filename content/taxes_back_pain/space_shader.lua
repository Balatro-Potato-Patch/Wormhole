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
        atlas.image:setWrap("repeat", "repeat")
        local pos = {x = 0, y = 0}
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
SMODS.Edition {
    key = 'torn', 
    sound = {
        sound = 'mult',
        per = 1,
        vol = 1
    },
    order = 3,
    config = { },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    on_apply = function(card)
        
    end,
    on_remove = function(card)
        
    end,
    in_shop = true,
    weight = 3,
    extra_cost = 4,
    get_weight = function(self)
        return self.weight
    end,

    shader = 'torn'
}