--contains boosters and SMODS.ConsumableType

SMODS.Atlas({key = "asm_ultrawormhole_sm", path = "awesomeswagmoney/ultrawormholesmall.png", px = 95, py = 99, fps = 7, frames = 3, atlas_table = "ANIMATION_ATLAS"}):register()
SMODS.Atlas({key = "asm_ultrawormhole_bg", path = "awesomeswagmoney/ultrawormholebig.png", px = 95, py = 99, fps = 7, frames = 3, atlas_table = "ANIMATION_ATLAS"}):register()
SMODS.Atlas({key = "asm_ultrawormhole_bgr", path = "awesomeswagmoney/ultrawormholebigger.png", px = 95, py = 99, fps = 7, frames = 3, atlas_table = "ANIMATION_ATLAS"}):register()
SMODS.Atlas({
    key = "asm_ubtag",
    path = "awesomeswagmoney/tag.png",
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.ConsumableType{
    key = "worm_ultrabeast",
    primary_colour = HEX("345678"),
    secondary_colour = HEX("3e36c9"),
    default = "c_worm_pheromosa" --CHANGE LATER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

local wormhole_create_card = function (self, card, i)
    return {
        set = "worm_ultrabeast",
        soulable = true,
        skip_materialize = true,
        area = G.pack_cards,
        key_append = "worm_wormholepack",
    }
end

local wormhole_particles = function (self)
    G.booster_pack_sparkles = Particles(1, 1, 0, 0, { --someone who knows more about particles can mess with this
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.BLUE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.RED, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
end

local wormhole_colour = function (self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.worm_ultrabeast)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.worm_ultrabeast, special_colour = G.C.BLACK, contrast = 2 })
end

local wormholes = { --im so fucking smart
    { type = "normal_1", atlas = "worm_asm_ultrawormhole_sm", display_size = { w = 83, h = 99 },  extra = 2, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 4 },
    -- { type = "normal_2", extra = 2, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 4 },
    { type = "jumbo_1", atlas = "worm_asm_ultrawormhole_bg", display_size = { w = 99, h = 99 }, extra = 4, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 6 },
    { type = "mega_1", atlas = "worm_asm_ultrawormhole_bgr", display_size = { w = 102, h = 99 }, extra = 4, choose = 2, pos = { x = 0, y = 0 }, weight = 0.2, cost = 8 },
}

for _, t in ipairs(wormholes) do
    SMODS.Booster {
        key = "wormhole_"..t.type,
        weight = t.weight,
        kind = "worm_Ultrawormhole",
        cost = t.cost,
        atlas = t.atlas,
        display_size = t.display_size,
        select_card = 'consumeables',
        disable_shine = true,
        config = { extra = t.extra, choose = t.choose },
        group_key = "k_worm_ultrawormhole",
        --draw_hand = true,
        loc_vars = function (self, info_queue, card)
            local cfg = (card and card.ability) or self.config or {}
            return {
                vars = { cfg.choose, cfg.extra },
                key = self.key:sub(1, -3),
            }
        end,
        ease_background_colour = wormhole_colour,
        particles = wormhole_particles,
        create_card = wormhole_create_card,
        ppu_team = {"awesomeswagmoney"}
    }
end

return {
    SMODS.Tag {
        key = 'ub',
        atlas = 'asm_ubtag', 
        pos = { x = 0, y = 0 },
        in_pool = function()
		    return (G.GAME.round_resets.ante > 1)
	    end,
        apply = function(self, tag, context)
              if context.type == "new_blind_choice" then
                  tag:yep("+", G.C.ATTENTION, function()
                      local key = "p_worm_wormhole_mega_1"
                      local card = Card(
                          G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                          G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                          G.CARD_W * 1.27,
                          G.CARD_H * 1.27,
                          G.P_CARDS.empty,
                          G.P_CENTERS[key],
                          { bypass_discovery_center = true, bypass_discovery_ui = true }
                      )
                      card.cost = 0
                      card.from_tag = true
                      G.FUNCS.use_card({ config = { ref_table = card } })
                      card:start_materialize()
                      return true
                  end)
                  tag.triggered = true
                  return true
              end
          end,
        ppu_artist = {"worm_garb"},
        ppu_coder = {"worm_garb"},
        ppu_team = {"awesomeswagmoney"},
      },
    }