SMODS.Atlas {
    key = 'euda_jokecolonyatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/JokeColony.png', --Update with actual art
}
SMODS.Joker {
    key = "euda_jokecolony",
    atlas = 'euda_jokecolonyatlas',
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = true,
    cost = 10,
    discovered = true,
    config = {extra= { mult = 4 }},
    ppu_coder = {'M0xes'},
    ppu_artist = {'Jewel'},
    ppu_team = {"TeamEudaimonia"},
    attributes = {"joker", "mult", "space",},
    loc_vars = function(self, info_queue, card)
        local pop = 0
        for _, joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
            if joker.ability.worm_euda_colonycitizen == card.ability.extra.colonyid then
                pop = pop + 1
            end
        end
        return { vars = {card.ability.extra.mult, pop, pop*card.ability.extra.mult} }
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.colonyid then
          for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card and joker.config.center.key == "j_worm_euda_jokecolony"
            and joker.ability.extra.colonyid == card.ability.extra.colonyid then
              G.GAME.worm_euda_COLONYID = G.GAME.worm_euda_COLONYID or 0
              card.ability.extra.colonyid = G.GAME.worm_euda_COLONYID
              G.GAME.worm_euda_COLONYID = G.GAME.worm_euda_COLONYID + 1
              for _, stored_joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
                if stored_joker.ability.worm_euda_colonycitizen == joker.ability.extra.colonyid then
                  local stored_joker_copy = copy_card(stored_joker, nil, nil, nil, nil)
                  stored_joker_copy.ability.worm_euda_colonycitizen = card.ability.extra.colonyid
                  stored_joker_copy.ability.worm_euda_already_shipped = nil
                  G.worm_euda_colony:emplace(stored_joker_copy)
                end
              end
              break
            end
          end
          return
        end
        G.GAME.worm_euda_COLONYID = G.GAME.worm_euda_COLONYID or 0
        card.ability.extra.colonyid = G.GAME.worm_euda_COLONYID
        G.GAME.worm_euda_COLONYID = G.GAME.worm_euda_COLONYID + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
      if from_debuff then
        return
      end
      for _, joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
          if joker.ability.worm_euda_colonycitizen == card.ability.extra.colonyid then
              if SMODS.is_eternal(joker, card) then
                joker.area:remove_card(joker)
                joker:add_to_deck()
                G.jokers:emplace(joker)
              else
                SMODS.destroy_cards(joker)
              end
          end
      end
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        local pop = 0
        for _, joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
            if joker.ability.worm_euda_colonycitizen == card.ability.extra.colonyid then
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
    G.worm_euda_specificcolony = CardArea(
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
    for _, joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
        if joker.ability.worm_euda_colonycitizen == card.ability.extra.colonyid then
            local copied_joker = copy_card(joker, nil, nil, nil, nil)
            copied_joker.ability.source_joker = joker
            copied_joker.ability.worm_euda_colonycitizen = card.ability.extra.colonyid
            G.worm_euda_specificcolony:emplace(copied_joker)
        end
    end
    return create_UIBox_generic_options({
        contents = {
            {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config = {text = localize("k_worm_euda_specificcolony_receive_title") .. card.ability.extra.colonyid, scale = 0.8, colour = G.C.WHITE, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={object = G.worm_euda_specificcolony}},
                }},
                {n=G.UIT.R,config={func = "worm_euda_can_release_colony", button = 'worm_euda_release_colony', align = "cm", minw = 1.3, minh = 1, r=0.15,colour = G.C.MULT,shadow = true}, nodes = {
                    {n=G.UIT.R, config={align = "cm", padding = 0.07}, nodes={
                        {n=G.UIT.R, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config = {text = localize("k_worm_euda_specificcolony_receive_button"), scale = 0.6, colour = G.C.WHITE, shadow = true}}
                        }},
                    }},              
                }},
              }
            }
        }
    })
end

local function create_join_colony_view(card)
    G.worm_euda_specificcolony = CardArea(
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
        if joker.config.center.key ~= "j_worm_euda_jokecolony" and not joker.ability.worm_euda_already_shipped then
            local copied_joker = copy_card(joker, nil, nil, nil, nil)
            copied_joker.ability.source_joker = joker
            copied_joker.ability.worm_euda_colonycitizen = card.ability.extra.colonyid
            G.worm_euda_specificcolony:emplace(copied_joker)
        end
    end
    return create_UIBox_generic_options({
        contents = {
            {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config = {text = localize("k_worm_euda_specificcolony_ship_title") .. card.ability.extra.colonyid, scale = 0.8, colour = G.C.WHITE, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={object = G.worm_euda_specificcolony}},
                }},
                {n=G.UIT.R,config={func = "worm_euda_can_join_colony", button = 'worm_euda_join_colony', align = "cm", minw = 1.3, minh = 1, r=0.15,colour = G.C.CHIPS,shadow = true}, nodes = {
                    {n=G.UIT.R, config={align = "cm", padding = 0.07}, nodes={
                        {n=G.UIT.R, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config = {text = localize("k_worm_euda_specificcolony_ship_button"), scale = 0.6, colour = G.C.WHITE, shadow = true}}
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
            button = 'worm_euda_join_jokecolony',
            func = 'worm_euda_can_join_jokecolony',
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = localize("k_worm_euda_jokecolony_ship_button"),
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
            button = 'worm_euda_leave_jokecolony',
            func = 'worm_euda_can_leave_jokecolony',
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = localize("k_worm_euda_jokecolony_receive_button"), --Update later
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

G.FUNCS.worm_euda_release_colony = function(e)
  for  _, joker in ipairs(G.worm_euda_specificcolony.highlighted) do
    for _, og in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
        if joker.ability.source_joker == og then
          og.area:remove_card(og)
          og:add_to_deck()
          G.jokers:emplace(og)
          if joker.ability.eternal then joker.ability.eternal = nil end
          SMODS.destroy_cards(joker)
          break
        end
    end
  end
end

G.FUNCS.worm_euda_can_release_colony = function(e)
  local tot_slots_used = 0
  for  _, joker in ipairs(G.worm_euda_specificcolony and G.worm_euda_specificcolony.highlighted or {}) do
    tot_slots_used = tot_slots_used + 1-joker.ability.card_limit
  end
  local can_use = (G.jokers.config.card_limit >= tot_slots_used + #G.jokers.cards) and (G.worm_euda_specificcolony and #G.worm_euda_specificcolony.highlighted > 0)
  e.config.button = can_use and 'worm_euda_release_colony' or nil
  e.config.colour = can_use and G.C.MULT or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_euda_join_colony = function(e)
  for  _, joker in ipairs(G.worm_euda_specificcolony.highlighted) do
    for _, og in ipairs(G.jokers and G.jokers.cards or {}) do
        if joker.ability.source_joker == og then
          og.ability.worm_euda_colonycitizen = joker.ability.worm_euda_colonycitizen
          og.area:remove_card(og)
          og:remove_from_deck()
          G.worm_euda_colony:emplace(og)
          og.ability.worm_euda_already_shipped = true
          if joker.ability.eternal then joker.ability.eternal = nil end
          SMODS.destroy_cards(joker)
          break
        end
    end
  end
end

G.FUNCS.worm_euda_can_join_colony = function(e)
  local can_use = G.worm_euda_specificcolony and #G.worm_euda_specificcolony.highlighted > 0
  e.config.button = can_use and 'worm_euda_join_colony' or nil
  e.config.colour = can_use and G.C.CHIPS or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_euda_can_leave_jokecolony = function(e)
  local card = e.config.ref_table
  local pop = 0
  for _, joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
      if joker.ability.worm_euda_colonycitizen == card.ability.extra.colonyid then
          pop = pop + 1
      end
  end
  local can_use = not card.debuff and pop > 0

  e.config.button = can_use and 'worm_euda_leave_jokecolony' or nil
  e.config.colour = can_use and G.C.MULT or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_euda_leave_jokecolony = function(e)
    local card = e.config.ref_table
    G.FUNCS.overlay_menu {
        definition = create_leave_colony_view(card)
    }
end

G.FUNCS.worm_euda_can_join_jokecolony = function(e)
  local card = e.config.ref_table
  local options = 0
  for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
      if joker.config.center.key ~= "j_worm_euda_jokecolony" and not joker.ability.worm_euda_already_shipped then
          options = options + 1
      end
  end
  local can_use = not card.debuff and options > 0
  e.config.button = can_use and 'worm_euda_join_jokecolony' or nil
  e.config.colour = can_use and G.C.CHIPS or G.C.UI.BACKGROUND_INACTIVE
end

G.FUNCS.worm_euda_join_jokecolony = function(e)
    local card = e.config.ref_table
    G.FUNCS.overlay_menu {
        definition = create_join_colony_view(card)
    }
end

SMODS.DrawStep {
  key = 'worm_euda_jokecolony_button',
  order = -30,
  func = function(card, layer)
    if card.children.worm_euda_jokecolony_button then
      card.children.worm_euda_jokecolony_button:draw()
    end
  end
}
SMODS.draw_ignore_keys.worm_euda_jokecolony_button = true

local custom_card_areas_ref = SMODS.current_mod.custom_card_areas or function(game) end
SMODS.current_mod.custom_card_areas = function(game) -- game is the same as G 
  game.worm_euda_colony = CardArea(
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
    game.worm_euda_colony.states.visible = false
    custom_card_areas_ref(game)
end

local card_sell_ref = Card.can_sell_card
function Card:can_sell_card(context)
  if G.worm_euda_specificcolony and self.area == G.worm_euda_specificcolony then
    return false
  end
  return card_sell_ref(self, context)
end

local highlight_ref = Card.highlight
function Card.highlight(self, is_highlighted)
    if is_highlighted and self.config.center.key == "j_worm_euda_jokecolony" and self.area == G.jokers then
        self.children.worm_euda_jokecolony_button = jokecolony_button_ui(self)
    elseif self.children.worm_euda_jokecolony_button then
        self.children.worm_euda_jokecolony_button:remove()
        self.children.worm_euda_jokecolony_button = nil
    end
    return highlight_ref(self, is_highlighted)
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local m = G_UIDEF_use_and_sell_buttons_ref(card)
    if card.area and G.worm_euda_specificcolony and card.area == G.worm_euda_specificcolony then
        table.remove(m.nodes[1].nodes, 1)
    end
    return m
end

local calc_ref = SMODS.current_mod.calculate or function(self, context) return end
SMODS.current_mod.calculate = function(self, context)
    if context.end_of_round and not context.game_over and context.main_eval then
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            joker.ability.worm_euda_already_shipped = nil
        end
        for _, joker in ipairs(G.worm_euda_colony and G.worm_euda_colony.cards or {}) do
            joker.ability.worm_euda_already_shipped = nil
        end
    end
    return calc_ref(self, context)
end