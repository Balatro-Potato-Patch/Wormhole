SMODS.Atlas {
    key = 'jokecolonyatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/wowsignal.png', --Update with actual art
}
SMODS.Joker {
    key = "jokecolony",
    atlas = 'jokecolonyatlas',
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    config = {extra={mult = 2}},
    ppu_coder = {'m0x3s'},
    ppu_artist = {'LasagnaFelidae'},
    loc_vars = function(self, info_queue, card)
        local pop = 0
        for _, joker in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
            if joker.ability.worm_colonycitizen == card.ability.colonyid then
                pop = pop + 1
            end
        end
        return { vars = {card.ability.extra.mult, pop, pop*card.ability.extra.mult} }
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.colonyid then
          for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card and joker.config.center.key == "j_worm_jokecolony"
            and joker.ability.extra.colonyid == card.ability.colonyid then
              G.GAME.worm_COLONYID = G.GAME.worm_COLONYID or 0
              card.ability.colonyid = G.GAME.worm_COLONYID
              G.GAME.worm_COLONYID = G.GAME.worm_COLONYID + 1
              for _, stored_joker in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
                if stored_joker.ability.worm_colonycitizen == joker.ability.extra.colonyid then
                  local stored_joker_copy = copy_card(stored_joker, nil, nil, nil, nil)
                  stored_joker_copy.ability.worm_colonycitizen = card.ability.colonyid
                  G.worm_colony:emplace(stored_joker_copy)
                end
              end
              break
            end
          end
          return
        end
        G.GAME.worm_COLONYID = G.GAME.worm_COLONYID or 0
        card.ability.colonyid = G.GAME.worm_COLONYID
        G.GAME.worm_COLONYID = G.GAME.worm_COLONYID + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
      if from_debuff then
        return
      end
      for _, joker in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
          if joker.ability.worm_colonycitizen == card.ability.colonyid then
              SMODS.destroy_cards(joker)
          end
      end
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        local pop = 0
        for _, joker in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
            if joker.ability.worm_colonycitizen == card.ability.colonyid then
                pop = pop + 1
            end
        end
        return {
          mult = pop*card.ability.extra.mult,
        }
      end
    end
}

local function create_leave_colony_view(card)
    G.specificcolony = CardArea(
        4.75,
        0,
        G.CARD_W * 4.95,
        G.CARD_H * 0.95,
        {
            type = 'joker',
            align_buttons = true,
            no_card_count = true,
        }
    )
    for _, joker in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
        if joker.ability.worm_colonycitizen == card.ability.colonyid then
            local copied_joker = copy_card(joker, nil, nil, nil, nil)
            copied_joker.ability.source_joker = joker
            copied_joker.ability.worm_colonycitizen = card.ability.colonyid
            G.specificcolony:emplace(copied_joker)
        end
    end
    return create_UIBox_generic_options({
        contents = {
            {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config = {text = localize("k_worm_specificcolony_receive_title") .. card.ability.colonyid, scale = 0.8, colour = G.C.WHITE, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={object = G.specificcolony}},
                }},
                {n=G.UIT.R,config={func = "worm_can_release_colony", button = 'worm_release_colony', align = "cm", minw = 1.3, minh = 1, r=0.15,colour = G.C.MULT,shadow = true}, nodes = {
                    {n=G.UIT.R, config={align = "cm", padding = 0.07}, nodes={
                        {n=G.UIT.R, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config = {text = localize("k_worm_specificcolony_receive_button"), scale = 0.6, colour = G.C.WHITE, shadow = true}}
                        }},
                    }},              
                }},
              }
            }
        }
    })
end

local function create_join_colony_view(card)
    G.specificcolony = CardArea(
        4.75,
        0,
        G.CARD_W * 4.95,
        G.CARD_H * 0.95,
        {
            type = 'joker',
            align_buttons = true,
            no_card_count = true,
        }
    )
    for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
        if joker.config.center.key ~= "j_worm_jokecolony" then
            local copied_joker = copy_card(joker, nil, nil, nil, nil)
            copied_joker.ability.source_joker = joker
            copied_joker.ability.worm_colonycitizen = card.ability.colonyid
            G.specificcolony:emplace(copied_joker)
        end
    end
    return create_UIBox_generic_options({
        contents = {
            {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config = {text = localize("k_worm_specificcolony_ship_title") .. card.ability.colonyid, scale = 0.8, colour = G.C.WHITE, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={object = G.specificcolony}},
                }},
                {n=G.UIT.R,config={func = "worm_can_join_colony", button = 'worm_join_colony', align = "cm", minw = 1.3, minh = 1, r=0.15,colour = G.C.CHIPS,shadow = true}, nodes = {
                    {n=G.UIT.R, config={align = "cm", padding = 0.07}, nodes={
                        {n=G.UIT.R, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config = {text = localize("k_worm_specificcolony_ship_button"), scale = 0.6, colour = G.C.WHITE, shadow = true}}
                        }},
                    }},              
                }},
              }
            }
        }
    })
end

local function jokecolony_button_ui(card)
  return UIBox {
    definition = {
      n = G.UIT.ROOT,
      config = {colour = G.C.CLEAR},
      nodes = {
        {
          n = G.UIT.R,
          config = {
            align = 'cm',
            padding = 0.15,
            r = 0.08,
            hover = true,
            shadow = true,
            colour = G.C.CHIPS,
            button = 'worm_join_jokecolony',
            func = 'worm_can_join_jokecolony',
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = localize("k_worm_jokecolony_ship_button"),
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.5,
                  }
                },
                {
                  n = G.UIT.B,
                  config = {
                    w = 1.25,
                    h = 0.6
                  }
                }
              }
            }
          }
        },
        {
          n = G.UIT.R,
          config = {align = 'cm',
            padding = 0.15,
            r = 0.08,
            hover = true,
            shadow = true,
            colour = G.C.MULT,
            button = 'worm_leave_jokecolony',
            func = 'worm_can_leave_jokecolony',
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = localize("k_worm_jokecolony_receive_button"), --Update later
                    colour = G.C.UI.TEXT_LIGHT, -- color of the button text
                    scale = 0.4,
                  }
                },
                {
                  n = G.UIT.B,
                  config = {
                    w = 1.25,
                    h = 0.6
                  }
                }
              }
            }
          }
        },
      }
    },
    config = {
      align = 'cl',
      major = card,
      parent = card,
      offset = { x = 1.2, y = 0 }
    }
  }
end

G.FUNCS.worm_release_colony = function(e)
  for  _, joker in ipairs(G.specificcolony.highlighted) do
    for _, og in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
        if joker.ability.source_joker == og then
          og.area:remove_card(og)
          og:add_to_deck()
          G.jokers:emplace(og)
          SMODS.destroy_cards(joker)
          break
        end
    end
  end
end

G.FUNCS.worm_can_release_colony = function(e)
  local tot_slots_used = 0
  for  _, joker in ipairs(G.specificcolony and G.specificcolony.highlighted or {}) do
    tot_slots_used = tot_slots_used + 1-joker.ability.card_limit
  end
  local can_use = (G.jokers.config.card_limit >= tot_slots_used + #G.jokers.cards) and (G.specificcolony and #G.specificcolony.highlighted > 0)
  e.config.button = can_use and 'worm_release_colony' or nil
  e.config.colour = can_use and G.C.MULT or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_join_colony = function(e)
  for  _, joker in ipairs(G.specificcolony.highlighted) do
    for _, og in ipairs(G.jokers and G.jokers.cards or {}) do
        if joker.ability.source_joker == og then
          og.ability.worm_colonycitizen = joker.ability.worm_colonycitizen
          og.area:remove_card(og)
          og:add_to_deck()
          G.worm_colony:emplace(og)
          SMODS.destroy_cards(joker)
          break
        end
    end
  end
end

G.FUNCS.worm_can_join_colony = function(e)
  local can_use = G.specificcolony and #G.specificcolony.highlighted > 0
  e.config.button = can_use and 'worm_join_colony' or nil
  e.config.colour = can_use and G.C.CHIPS or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_can_leave_jokecolony = function(e)
  local card = e.config.ref_table
  local pop = 0
  for _, joker in ipairs(G.worm_colony and G.worm_colony.cards or {}) do
      if joker.ability.worm_colonycitizen == card.ability.colonyid then
          pop = pop + 1
      end
  end
  local can_use = not card.debuff and pop > 0

  e.config.button = can_use and 'worm_leave_jokecolony' or nil
  e.config.colour = can_use and G.C.MULT or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_leave_jokecolony = function(e)
    local card = e.config.ref_table
    G.FUNCS.overlay_menu {
        definition = create_leave_colony_view(card)
    }
end

G.FUNCS.worm_can_join_jokecolony = function(e)
  local card = e.config.ref_table
  local options = 0
  for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
      if joker.config.center.key ~= "j_worm_jokecolony" then
          options = options + 1
      end
  end
  local can_use = not card.debuff and options > 0
  e.config.button = can_use and 'worm_join_jokecolony' or nil
  e.config.colour = can_use and G.C.CHIPS or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_join_jokecolony = function(e)
    local card = e.config.ref_table
    G.FUNCS.overlay_menu {
        definition = create_join_colony_view(card)
    }
end

SMODS.DrawStep {
  key = 'worm_jokecolony_button',
  order = -30,
  func = function(card, layer)
    if card.children.worm_jokecolony_button then
      card.children.worm_jokecolony_button:draw()
    end
  end
}
SMODS.draw_ignore_keys.worm_jokecolony_button = true

SMODS.current_mod.custom_card_areas = function(game) -- game is the same as G
    game.worm_colony = CardArea(
        4.75,
        2,
        G.CARD_W * 4.95,
        G.CARD_H * 0.95,
        {
            type = 'joker',
            highlight_limit = 0,
            align_buttons = true,
        }
    )
    game.worm_colony.states.visible = false
end

local card_sell_ref = Card.can_sell_card
function Card:can_sell_card(context)
  if G.specificcolony and self.area == G.specificcolony then
    return false
  end
  return card_sell_ref(self, context)
end

local highlight_ref = Card.highlight
function Card.highlight(self, is_highlighted)
    if is_highlighted and self.config.center.key == "j_worm_jokecolony" and self.area == G.jokers then
        self.children.worm_jokecolony_button = jokecolony_button_ui(self)
    elseif self.children.worm_jokecolony_button then
        self.children.worm_jokecolony_button:remove()
        self.children.worm_jokecolony_button = nil
    end
    return highlight_ref(self, is_highlighted)
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local m = G_UIDEF_use_and_sell_buttons_ref(card)
    if card.area and G.specificcolony and card.area == G.specificcolony then
        table.remove(m.nodes[1].nodes, 1)
    end
    return m
end