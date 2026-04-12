-- Adapted from wormhole version 1.3.0~ALPHA.
-- You have permission to remove any unused functions in this script, if there are any after the mod jam is over.


function Sprite:wormhole_set_atlas(atlas)
  if not atlas then return end
  local new_atlas = G.ASSET_ATLAS[atlas]
  if not new_atlas then return end

  self.atlas = new_atlas

  self.sprite = love.graphics.newQuad(
    self.sprite_pos.x * self.atlas.px,
    self.sprite_pos.y * self.atlas.py,
    self.scale.x,
    self.scale.y, self.atlas.image:getDimensions())

  self.image_dims = {}
  self.image_dims[1], self.image_dims[2] = self.atlas.image:getDimensions()
end

SMODS.DrawStep {
  key = 'back_extra',
  order = 1,
  func = function(self)
    local deck_thing = G.P_CENTERS[self.wormhole_origin_deck_key or ((G.GAME.viewed_back or G.GAME.selected_back) and (G.GAME.viewed_back or G.GAME.selected_back).name) or "b_red"]
    if not deck_thing then return end
    if not self.wormhole_back_extra and deck_thing.wormhole_pos_extra then
      self.wormhole_back_extra = {}
      local wpe = deck_thing.wormhole_pos_extra
      if wpe.x and wpe.y then
        local atlas = G.ASSET_ATLAS[wpe.atlas or deck_thing.atlas]
        self.wormhole_back_extra.extra = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = wpe.x, y = wpe.y })
      else
        for k, v in pairs(wpe) do
          local atlas = G.ASSET_ATLAS[v and v.atlas or deck_thing.atlas]
          self.wormhole_back_extra[k] = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = v.x or 0, y = v.y or 0 })
        end
      end
    end

    if self.wormhole_back_extra then
      local wpe = deck_thing.wormhole_pos_extra
      if not wpe then return end
      if wpe.x and wpe.y then
        wpe = { extra = deck_thing.wormhole_pos_extra }
      end

      local order = deck_thing.wormhole_pos_extra_order
      if not order then
        order = {}
        for k, v in pairs(wpe) do
          order[#order + 1] = k
        end
      end
      for _, vv in ipairs(order) do
        local k = vv
        local v = wpe[vv]

        local overlay = G.C.WHITE
        if self.area and self.area.config.type == 'deck' and self.rank > 3 then
          self.back_overlay = self.back_overlay or {}
          self.back_overlay[1] = 0.5 + ((#self.area.cards - self.rank) % 7) / 50
          self.back_overlay[2] = 0.5 + ((#self.area.cards - self.rank) % 7) / 50
          self.back_overlay[3] = 0.5 + ((#self.area.cards - self.rank) % 7) / 50
          self.back_overlay[4] = 1
          overlay = self.back_overlay
        end

        self.wormhole_back_extra[k]:set_sprite_pos(v)
        self.wormhole_back_extra[k].role.draw_major = self

        if self.area and self.area.config.type == 'deck' then
          local self_two = self.wormhole_back_extra[k]
          if not self_two.states.visible then return end
          if self_two.draw_steps then
            for k, v in ipairs(self_two.draw_steps) do
              self_two:draw_shader(v.shader, v.shadow_height, v.send, v.no_tilt, v.other_obj, v.ms, v.mr, v.mx, v.my, not not v.send)
            end
          else
            if not self_two.states.visible then return end
            if self_two.sprite_pos.x ~= self_two.sprite_pos_copy.x or self_two.sprite_pos.y ~= self_two.sprite_pos_copy.y then
              self_two:set_sprite_pos(self_two.sprite_pos)
            end
            prep_draw(self.children.back, 1, 0, { x = 0, y = 0 }, true)
            love.graphics.scale(1 / (self.children.back.scale_mag or self.children.back.VT.scale))
            love.graphics.setColor(overlay or G.BRUTE_OVERLAY or G.C.WHITE)
            love.graphics.draw(
              self_two.atlas.image,
              self_two.sprite,
              -(self.children.back.T.w / 2 - self.children.back.VT.w / 2) * 10,
              0,
              0,
              self.children.back.VT.w / (self.children.back.T.w),
              self.children.back.VT.h / (self.children.back.T.h)
            )
            love.graphics.pop()
            add_to_drawhash(self_two)
            self_two:draw_boundingrect()
            if self_two.shader_tab then love.graphics.setShader() end
          end

          add_to_drawhash(self_two)
          self_two:draw_boundingrect()
        else
          self.wormhole_back_extra[k]:draw_shader('dissolve', nil, nil, nil, self.children.back)
        end
      end
    end
  end,
  conditions = { vortex = false, facing = 'back' },
}

SMODS.DrawStep {
  key = 'extra',
  order = 21,
  func = function(self, layer)
    if not self.wormhole_pos_extra and self.config and self.config.center and self.config.center.wormhole_pos_extra then
      local function copy(t)
        if type(t) ~= "table" then return t end
        local n = {}
        for k, v in pairs(t) do
          n[k] = copy(v)
        end
        return n
      end

      local ccwpe = self.config.center.wormhole_pos_extra
      if ccwpe.x and ccwpe.y then
        self.wormhole_pos_extra = { extra = copy(ccwpe) }
      else
        self.wormhole_pos_extra = copy(ccwpe)
      end
    end
    if not self.wormhole_extra and self.wormhole_pos_extra then
      self.wormhole_extra = {}
      local wpe = self.wormhole_pos_extra
      if wpe.x and wpe.y then
        local atlas = G.ASSET_ATLAS[wpe.atlas or self.config.center.atlas]
        self.wormhole_extra.extra = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = wpe.x, y = wpe.y })
      else
        for k, v in pairs(wpe) do
          local atlas = G.ASSET_ATLAS[v and v.atlas or self.config.center.atlas]
          self.wormhole_extra[k] = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = v.x or 0, y = v.y or 0 })
        end
      end
    end

    if self.wormhole_extra then
      if self.config.center.discovered or (self.params and self.params.bypass_discovery_center) then
        local wpe = self.wormhole_pos_extra
        if wpe.x and wpe.y then
          wpe = { extra = self.wormhole_pos_extra }
        end

        local wiggle_offset_x = self.wormhole_wiggle_offset_x or 0
        local wiggle_offset_y = self.wormhole_wiggle_offset_y or 0

        local order = self.config.center.wormhole_pos_extra_order
        if not order then
          order = {}
          for k, v in pairs(wpe) do
            order[#order + 1] = k
          end
        end
        for _, vv in ipairs(order) do
          local k = vv
          local v = wpe[vv]

          self.wormhole_extra[k]:set_sprite_pos(v)
          self.wormhole_extra[k].role.draw_major = self

          if (self.edition and self.edition.negative and (not self.delay_edition or self.delay_edition.negative)) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
            self.wormhole_extra[k]:draw_shader('negative', nil, self.ARGS.send_to_shader, nil, self.children.center, 0, 0, wiggle_offset_x, wiggle_offset_y)
          elseif not self:should_draw_base_shader() then
          elseif not self.greyed then
            self.wormhole_extra[k]:draw_shader('dissolve', nil, nil, nil, self.children.center, 0, 0, wiggle_offset_x, wiggle_offset_y)
          end

          if self.ability.name == 'Invisible Joker' and (self.config.center.discovered or self.bypass_discovery_center) then
            if self:should_draw_base_shader() then
              self.wormhole_extra[k]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, 0, 0, wiggle_offset_x, wiggle_offset_y)
            end
          end

          local center = self.config.center
          if center.wormhole_draw_extra and type(center.wormhole_draw_extra) == "function" then
            center:wormhole_draw_extra(self, layer)
          end
          if center.wormhole_draw_extra and type(center.wormhole_draw_extra) == "table"
              and center.wormhole_draw_extra[k] and type(center.wormhole_draw_extra[k]) == "function" then
            (center.wormhole_draw_extra[k])(self, layer)
          end

          local edition = self.delay_edition or self.edition
          if edition then
            for kk, vv in pairs(G.P_CENTER_POOLS.Edition) do
              if edition[vv.key:sub(3)] and vv.shader then
                if type(vv.draw) == 'function' then
                  vv:draw(self, layer)
                else
                  self.wormhole_extra[k]:draw_shader(vv.shader, nil, self.ARGS.send_to_shader, nil, self.children.center, 0, 0, wiggle_offset_x, wiggle_offset_y)
                end
              end
            end
          end

          if (edition and edition.negative) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
            self.wormhole_extra[k]:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center, 0, 0, wiggle_offset_x, wiggle_offset_y)
          end
        end
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' }
}





local update_ref = Game.update
function Game:update(dt)
  for k, v in pairs(G.MOVEABLES or {}) do
    local ccc = v and v.config and v.config.center
    if ccc and (ccc.wormhole_anim or ccc.wormhole_anim_extra or ccc.wormhole_anim_states or ccc.wormhole_anim_extra_states) and (ccc.discovered or v.bypass_discovery_center) then
      handle_wormhole_anim(v, dt)
      handle_wormhole_anim_extra(v, dt)
    end
  end

  for k, v in pairs(G.P_CENTER_POOLS.Back) do
    if v and (v.wormhole_anim or v.wormhole_anim_extra) and v.unlocked then
      handle_wormhole_anim_back(v, dt)
      handle_wormhole_anim_back_extra(v, dt)
    end
  end

  return update_ref(self, dt)
end

function format_wormhole_anim(anim)
  if not anim then return end
  local new_anim = {}
  for _, frame in ipairs(anim) do
    if frame and (frame.x or (frame.xrange and frame.xrange.first and frame.xrange.last)) and (frame.y or (frame.yrange and frame.yrange.first and frame.yrange.last)) then
      local firsty = frame.y or frame.yrange.first
      local lasty = frame.y or frame.yrange.last
      for y = firsty, lasty, firsty <= lasty and 1 or -1 do
        local firstx = frame.x or frame.xrange.first
        local lastx = frame.x or frame.xrange.last
        for x = firstx, lastx, firstx <= lastx and 1 or -1 do
          new_anim[#new_anim + 1] = { x = x, y = y, t = frame.t or 0, trandomrange = frame.trandomrange, trandomelement = frame.trandomelement, atlas = frame.atlas }
        end
      end
    end
  end
  new_anim = wormhole_generate_randomness(new_anim)
  return new_anim
end

function wormhole_generate_randomness(anim)
  if not anim then return end

  local length = 0
  for _, frame in ipairs(anim) do
    if frame.trandomrange then
      frame.t = (frame.trandomrange.first or 0) + (math.random() * ((frame.trandomrange.last or 0) - (frame.trandomrange.first or 0)))
    elseif frame.trandomelement then
      frame.t = frame.trandomelement[math.random(1, #frame.trandomelement)]
    end
    length = length + (frame.t or 0)
  end

  anim.length = length
  return anim
end

function handle_wormhole_anim(v, dt)
  if v.config.center.wormhole_anim_states or v.config.center.wormhole_anim then
    if not v.wormhole_anim_current_state then v.wormhole_anim_current_state = v.config.center.wormhole_anim_initial_state end
    if not v.wormhole_anim or v.wormhole_anim_state_cached ~= v.wormhole_anim_current_state then
      local anim = v.config.center.wormhole_anim_states
          and v.wormhole_anim_current_state
          and v.config.center.wormhole_anim_states[v.wormhole_anim_current_state]
          and v.config.center.wormhole_anim_states[v.wormhole_anim_current_state].anim

          or v.wormhole_anim
          or v.config.center.wormhole_anim

      v.wormhole_anim = format_wormhole_anim(anim)
      v.wormhole_anim_state_cached = v.wormhole_anim_current_state
    end

    if v.wormhole_anim then
      local loop = v.config.center.wormhole_anim_states and v.wormhole_anim_current_state and
          v.config.center.wormhole_anim_states[v.wormhole_anim_current_state] and v.config.center.wormhole_anim_states[v.wormhole_anim_current_state].loop
      if loop == nil then loop = true end
      if not v.wormhole_anim_t then v.wormhole_anim_t = 0 end
      v.wormhole_anim_t = v.wormhole_anim_t + dt
      if not loop and v.wormhole_anim_t >= v.wormhole_anim.length then
        local continuation = v.config.center.wormhole_anim_states[v.wormhole_anim_current_state].continuation
        if continuation then
          v.wormhole_anim_current_state = continuation
          v.wormhole_anim_t = 0
          handle_wormhole_anim(v, 0)
          return
        else
          v.wormhole_anim_t = v.wormhole_anim.length
        end
      elseif loop then
        if v.wormhole_anim_t >= v.wormhole_anim.length then v.wormhole_anim = wormhole_generate_randomness(v.wormhole_anim) end
        v.wormhole_anim_t = v.wormhole_anim_t % v.wormhole_anim.length
      end
      local ix = 0
      local t_tally = 0
      for _, frame in ipairs(v.wormhole_anim) do
        ix = ix + 1
        t_tally = t_tally + frame.t
        if t_tally > v.wormhole_anim_t then break end
      end
      v.children.center:set_sprite_pos({ x = v.wormhole_anim[ix].x, y = v.wormhole_anim[ix].y })
      if v.wormhole_anim[ix].atlas then v.children.center:wormhole_set_atlas(v.wormhole_anim[ix].atlas) end
    end
  end
end

function handle_wormhole_anim_extra(v, dt)
  if v.config.center.wormhole_anim_extra_states or v.config.center.wormhole_anim_extra then
    v.wormhole_anim_extra_cache = v.wormhole_anim_extra_cache or {}

    if v.config.center.wormhole_anim_extra_states then
      if not next(v.config.center.wormhole_anim_extra_states) then
        return
      end

      if not v.wormhole_anim_extra_current_states or type(v.wormhole_anim_extra_current_states) ~= "table" then
        if v.wormhole_anim_extra_current_states then
          v.wormhole_anim_extra_current_states = { extra = v.wormhole_anim_extra_current_states }
        elseif v.config.center.wormhole_anim_extra_initial_states then
          v.wormhole_anim_extra_current_states = v.config.center.wormhole_anim_extra_initial_states
        elseif v.config.center.wormhole_anim_extra_initial_state then
          v.wormhole_anim_extra_current_states = { extra = v.config.center.wormhole_anim_extra_initial_state }
        else
          v.wormhole_anim_extra_current_states = { extra = "default" }
        end
      end

      local first = next(v.config.center.wormhole_anim_extra_states)
      if v.config.center.wormhole_anim_extra_states[first].anim then
        v.config.center.wormhole_anim_extra_states = { extra = v.config.center.wormhole_anim_extra_states }
      end

      v.wormhole_anim_extra = {}

      for layer, state in pairs(v.wormhole_anim_extra_current_states) do
        local cache_key = layer .. ":" .. state

        if not v.wormhole_anim_extra_cache[cache_key] then
          local anim = v.config.center.wormhole_anim_extra_states[layer][state].anim
          v.wormhole_anim_extra_cache[cache_key] = format_wormhole_anim(anim)
        end

        v.wormhole_anim_extra[layer] = v.wormhole_anim_extra_cache[cache_key]
      end
    else
      if not next(v.config.center.wormhole_anim_extra) then
        return
      elseif v.config.center.wormhole_anim_extra[1] and not v.config.center.wormhole_anim_extra[1][1] then
        v.wormhole_anim_extra = { extra = v.config.center.wormhole_anim_extra }
      else
        v.wormhole_anim_extra = v.config.center.wormhole_anim_extra
      end

      for k, layer in pairs(v.wormhole_anim_extra) do
        if not v.wormhole_anim_extra_cache[k] then
          v.wormhole_anim_extra_cache[k] = format_wormhole_anim(layer)
        end
        v.wormhole_anim_extra[k] = v.wormhole_anim_extra_cache[k]
      end
    end

    if v.wormhole_anim_extra then
      for k, layer in pairs(v.wormhole_anim_extra) do
        local loop = v.config.center.wormhole_anim_extra_states and v.config.center.wormhole_anim_extra_states[k]
            and v.wormhole_anim_extra_current_states and v.wormhole_anim_extra_current_states[k]
            and v.config.center.wormhole_anim_extra_states[k][v.wormhole_anim_extra_current_states[k]]
            and v.config.center.wormhole_anim_extra_states[k][v.wormhole_anim_extra_current_states[k]].loop
        if loop == nil then loop = true end

        if not v.wormhole_anim_extra_t then v.wormhole_anim_extra_t = {} end
        if not v.wormhole_anim_extra_t[k] then
          v.wormhole_anim_extra_t[k] = 0
        end
        v.wormhole_anim_extra_t[k] = v.wormhole_anim_extra_t[k] + dt

        if not loop and v.wormhole_anim_extra_t[k] >= layer.length then
          local continuation = v.config.center.wormhole_anim_extra_states[k][v.wormhole_anim_extra_current_states[k]].continuation
          if continuation then
            v.wormhole_anim_extra_current_states[k] = continuation
            v.wormhole_anim_extra_t[k] = 0
            handle_wormhole_anim_extra(v, 0)
          else
            v.wormhole_anim_extra_t[k] = layer.length
          end
        elseif loop then
          if v.wormhole_anim_extra_t[k] >= layer.length then v.wormhole_anim_extra[k] = wormhole_generate_randomness(v.wormhole_anim_extra[k]) end
          v.wormhole_anim_extra_t[k] = v.wormhole_anim_extra_t[k] % layer.length
        end

        if not v.wormhole_prev_extra_ix then v.wormhole_prev_extra_ix = {} end
        if not v.wormhole_prev_extra_ix[k] then v.wormhole_prev_extra_ix[k] = -1 end
        local ix = 0
        local t_tally = 0
        for _, frame in ipairs(layer) do
          ix = ix + 1
          t_tally = t_tally + frame.t
          if t_tally > v.wormhole_anim_extra_t[k] then break end
        end
        if not v.wormhole_pos_extra then v.wormhole_pos_extra = {} end
        if not v.wormhole_pos_extra[k] then v.wormhole_pos_extra[k] = {} end

        if v.config.center.wormhole_extra_wiggle and v.wormhole_prev_extra_ix[k] ~= ix then
          math.randomseed(os.time() + math.floor(os.clock() * 1000000)) -- Lua is one of the languages of all time
          local rand_x = (math.random() * 0.015) - (0.015 / 2)
          local rand_y = (math.random() * 0.015) - (0.015 / 2)
          v.wormhole_wiggle_offset_x = rand_x
          v.wormhole_wiggle_offset_y = rand_y
        end
        v.wormhole_prev_extra_ix[k] = ix

        v.wormhole_pos_extra[k].x = layer[ix].x
        v.wormhole_pos_extra[k].y = layer[ix].y
        if layer[ix].atlas then
          v.wormhole_pos_extra[k].atlas = layer[ix].atlas
        end
      end
    end
  end
end

function handle_wormhole_anim_back(v, dt)
  if v.wormhole_anim then
    v.wormhole_anim = format_wormhole_anim(v.wormhole_anim)
    if not v.wormhole_anim_t then v.wormhole_anim_t = 0 end
    v.wormhole_anim_t = v.wormhole_anim_t + dt
    if v.wormhole_anim_t >= v.wormhole_anim.length then v.wormhole_anim = wormhole_generate_randomness(v.wormhole_anim) end
    v.wormhole_anim_t = v.wormhole_anim_t % v.wormhole_anim.length
    local ix = 0
    local t_tally = 0
    for _, frame in ipairs(v.wormhole_anim) do
      ix = ix + 1
      t_tally = t_tally + frame.t
      if t_tally > v.wormhole_anim_t then break end
    end
    v.pos = { x = v.wormhole_anim[ix].x, y = v.wormhole_anim[ix].y }
    if v.wormhole_anim[ix].atlas then v.atlas = v.wormhole_anim[ix].atlas end
  end
end

function handle_wormhole_anim_back_extra(v, dt)
  if v.wormhole_anim_extra then
    if not next(v.wormhole_anim_extra) then
      return
    elseif v.wormhole_anim_extra[1] and not v.wormhole_anim_extra[1][1] then
      v.wormhole_anim_extra = { extra = v.wormhole_anim_extra }
    end

    for k, layer in pairs(v.wormhole_anim_extra) do
      v.wormhole_anim_extra[k] = format_wormhole_anim(layer)
      layer = v.wormhole_anim_extra[k]

      if not v.wormhole_anim_extra_t then v.wormhole_anim_extra_t = {} end
      if not v.wormhole_anim_extra_t[k] then
        v.wormhole_anim_extra_t[k] = 0
      end
      v.wormhole_anim_extra_t[k] = v.wormhole_anim_extra_t[k] + dt

      if v.wormhole_anim_extra_t[k] >= layer.length then v.wormhole_anim_extra[k] = wormhole_generate_randomness(v.wormhole_anim_extra[k]) end
      v.wormhole_anim_extra_t[k] = v.wormhole_anim_extra_t[k] % layer.length

      local ix = 0
      local t_tally = 0
      for _, frame in ipairs(layer) do
        ix = ix + 1
        t_tally = t_tally + frame.t
        if t_tally > v.wormhole_anim_extra_t[k] then break end
      end
      if not v.wormhole_pos_extra then v.wormhole_pos_extra = {} end
      if not v.wormhole_pos_extra[k] then v.wormhole_pos_extra[k] = {} end

      v.wormhole_pos_extra[k].x = layer[ix].x
      v.wormhole_pos_extra[k].y = layer[ix].y
      if layer[ix].atlas then
        v.wormhole_pos_extra[k].atlas = layer[ix].atlas
      end
    end
  end
end

function Card:wormhole_set_anim_state(state, dont_reset_t)
  local center = self.config.center
  local states = center.wormhole_anim_states
  if not states then return end

  if state == nil then state = "default" end
  self.wormhole_anim_current_state = state

  if not self.wormhole_anim_t or not dont_reset_t then self.wormhole_anim_t = 0 end

  if not states[state] or not states[state].anim then return end
  local frame = format_wormhole_anim(states[state].anim)[wormhole_index_into_anim(states[state].anim, self.wormhole_anim_t)]
  if not frame then return end

  self.children.center:set_sprite_pos { x = frame.x or 0, y = frame.y or 0 }
  self.children.center:wormhole_set_atlas(frame.atlas or states[state].atlas or center.atlas)
end

function Card:wormhole_set_anim_extra_state(state, layer, dont_reset_t)
  local center = self.config.center
  local states = center.wormhole_anim_extra_states

  local first = next(states)
  if first and states[first].anim then
    states = { extra = states }
  end

  if layer == nil then layer = "extra" end
  if state == nil then state = "default" end

  if not self.wormhole_anim_extra_current_states then
    self.wormhole_anim_extra_current_states = {}
  end
  self.wormhole_anim_extra_current_states[layer] = state

  if not self.wormhole_anim_extra_t then
    self.wormhole_anim_extra_t = {}
    self.wormhole_anim_extra_t[layer] = self.wormhole_anim_extra_t[layer] or 0
  end

  if not dont_reset_t then
    self.wormhole_anim_extra_t[layer] = 0
  end

  local state_thing = states[layer] and states[layer][state]
  if not state_thing or not state_thing.anim then return end

  local frame = format_wormhole_anim(state_thing.anim)[wormhole_index_into_anim(state_thing.anim, self.wormhole_anim_extra_t[layer])]
  if not frame then return end

  if not self.wormhole_pos_extra then
    self.wormhole_pos_extra = {}
  end
  if not self.wormhole_pos_extra[layer] then
    self.wormhole_pos_extra[layer] = {}
  end

  self.wormhole_pos_extra[layer].x = frame.x or 0
  self.wormhole_pos_extra[layer].y = frame.y or 0
  self.wormhole_pos_extra[layer].atlas = frame.atlas or state_thing.atlas or center.atlas
end

function SMODS.Center:wormhole_set_anim_state(state, dont_reset_t)
  local center = self
  local states = center.wormhole_anim_states
  if not states then return end

  if state == nil then state = "default" end

  for _, v in pairs(G.MOVEABLES or {}) do
    if v and v.config and v.config.center and v.config.center.key == center.key then
      v.wormhole_anim_current_state = state

      if not v.wormhole_anim_t then
        v.wormhole_anim_t = 0
      end

      if not dont_reset_t then
        v.wormhole_anim_t = 0
      end

      if not states[state] or not states[state].anim then return end
      local frame = format_wormhole_anim(states[state].anim)[wormhole_index_into_anim(states[state].anim, v.wormhole_anim_t)]
      if frame then
        v.children.center:set_sprite_pos { x = frame.x or 0, y = frame.y or 0 }
        v.children.center:wormhole_set_atlas(frame.atlas or states[state].atlas or center.atlas)
      end
    end
  end
end

function SMODS.Center:wormhole_set_anim_extra_state(state, layer, dont_reset_t, change_center)
  local states = self.wormhole_anim_extra_states
  if not states then return end

  local first = next(states)
  if first and states[first].anim then
    states = { extra = states }
  end

  if layer == nil then layer = "extra" end
  if state == nil then state = "default" end

  if change_center then
    self.wormhole_anim_extra_initial_states = self.wormhole_anim_extra_initial_states or {}
    self.wormhole_anim_extra_initial_states[layer] = state
  end

  for _, v in pairs(G.MOVEABLES or {}) do
    if v and v.config and v.config.center and v.config.center.key == self.key then
      if not v.wormhole_anim_extra_current_states then
        v.wormhole_anim_extra_current_states = {}
      end
      v.wormhole_anim_extra_current_states[layer] = state

      if not v.wormhole_anim_extra_t then
        v.wormhole_anim_extra_t = {}
        v.wormhole_anim_extra_t[layer] = v.wormhole_anim_extra_t[layer] or 0
      end

      if not dont_reset_t then
        v.wormhole_anim_extra_t[layer] = 0
      end

      local state_thing = states[layer] and states[layer][state]
      if state_thing and state_thing.anim then
        local frame = format_wormhole_anim(state_thing.anim)[wormhole_index_into_anim(state_thing.anim, v.wormhole_anim_extra_t[layer])]

        if frame then
          v.wormhole_pos_extra = v.wormhole_pos_extra or {}
          v.wormhole_pos_extra[layer] = v.wormhole_pos_extra[layer] or {}

          v.wormhole_pos_extra[layer].x = frame.x or 0
          v.wormhole_pos_extra[layer].y = frame.y or 0
          v.wormhole_pos_extra[layer].atlas =
              frame.atlas or state_thing.atlas or self.atlas
        end
      end
    end
  end
end

wormhole_index_into_anim = function(anim, t)
  local length = 0
  for _, frame in ipairs(anim) do
    length = length + (frame.t or 0)
  end

  local ix = 1
  local tally = 0
  for i, frame in ipairs(anim) do
    tally = tally + (frame.t or 0)
    if tally > t then
      ix = i
      break
    end
  end

  return ix
end
