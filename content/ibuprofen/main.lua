-- /// team ///
SMODS.current_mod.extra_tabs = PotatoPatchUtils.CREDITS.register_page(SMODS.current_mod)

PotatoPatchUtils.Team {
  name = 'Team Ibuprofen',
  colour = HEX "e34244",
  loc = 'k_team_ibuprofen',
  short_credit = true,
    credit_rows = {3}
}

PotatoPatchUtils.Developer {
  name = 'Twigi',
  colour = G.C.MONEY,
  loc = 'd_twigi',         -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Team Ibuprofen', -- Must match an already existing Team name
  atlas = 'worm_Devs',
  soul_pos = { x = 1, y = 0 },
  pos = { x = 0, y = 0 }
}

PotatoPatchUtils.Developer {
  name = 'Oasis-J',
  colour = G.C.PURPLE,
  loc = 'd_joos',          -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Team Ibuprofen', -- Must match an already existing Team name
  atlas = 'worm_Devs',
  pos = { x = 2, y = 0 }
}

PotatoPatchUtils.Developer {
  name = 'AveryIGuess',
  colour = G.C.SECONDARY_SET.Tarot,
  loc = 'd_avery',         -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Team Ibuprofen', -- Must match an already existing Team name
  atlas = 'worm_Devs',
  pos = { x = 3, y = 0 }
}




-- /// resources ///

SMODS.Atlas {
  key = 'Jokers',
  path = 'ibuprofen/IbuJokers.png',
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = 'Devs',
  path = 'ibuprofen/IbuDevs.png',
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = 'Consumables',
  path = 'ibuprofen/IbuConsumables.png',
  px = 71,
  py = 95
}

SMODS.Sound {
  key = 'ibu_boom',
  path = "ibuprofen/boom.ogg",
}

SMODS.Sound {
  key = 'ibu_woof',
  path = "ibuprofen/Bark.ogg",
}

SMODS.Shader {
  key = "ibu_cosmic",
  path = "ibuprofen/cosmic.fs",
}

-- /// consumables ///

-- The Mountain
SMODS.Consumable {
  key = 'ibu_mountain',
  set = 'Tarot',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Consumables",
  pos = { x = 4, y = 0 },
  config = { max_highlighted = 2, mod_conv = 'm_worm_ibu_frozen' },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
    return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
  end,
}

-- Eclipse
SMODS.Consumable {
  key = 'ibu_eclipse',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Twigi' },
  ppu_team = { 'Team Ibuprofen' },
  unlocked = true,
  discovered = true,
  set = 'Spectral',
  pos = { x = 2, y = 0 },
  atlas = 'Consumables',
  config = { extra = {}, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } }
    return { vars = { card.ability.max_highlighted } }
  end,
  can_use = function(self, card)
    if G.hand and (#G.hand.highlighted <= self.config.max_highlighted) and G.hand.highlighted[1] then
      local condition = true
      for i = 1, #G.hand.highlighted do
        if G.hand.highlighted[i].edition then
          condition = false
        end
      end
      if condition then return true end
    end
    return false
  end,

  use = function(self, card)
    local edition = { negative = true }
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        func = function()
          local highlighted = G.hand.highlighted[i]
          highlighted:set_edition(edition, true)
          return true
        end
      }))
      card:juice_up(0.3, 0.5)
    end
  end
}

SMODS.Consumable {
  key = 'ibu_nebula',
  ppu_artist = { 'Twigi' },
  ppu_team = { 'Team Ibuprofen' },
  unlocked = true,
  discovered = true,
  set = 'Spectral',
  pos = { x = 3, y = 0 },
  atlas = 'Consumables',
  ppu_coder = { 'Twigi' },
  config = { extra = {}, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'e_worm_ibu_cosmicedition', set = 'Edition', config = { extra = 1 } }
    return { vars = { card.ability.max_highlighted } }
  end,
  can_use = function(self, card)
    if G.hand and (#G.hand.highlighted <= self.config.max_highlighted) and G.hand.highlighted[1] then
      local condition = true
      for i = 1, #G.hand.highlighted do
        if G.hand.highlighted[i].edition then
          condition = false
        end
      end
      if condition then return true end
    end
    return false
  end,
  use = function(self, card)
    local edition = { negative = true }
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        func = function()
          local highlighted = G.hand.highlighted[i]
          highlighted:set_edition('e_worm_ibu_cosmicedition', true)
          return true
        end
      }))
      card:juice_up(0.3, 0.5)
    end
  end
}

-- Supergiant
SMODS.Consumable {
  key = 'ibu_supergiant',
  ppu_artist = { 'Twigi' },
  ppu_coder = { 'Twigi' },
  ppu_team = { 'Team Ibuprofen' },
  unlocked = true,
  discovered = true,
  set = 'Spectral',
  pos = { x = 0, y = 0 },
  atlas = 'Consumables',
  config = { extra = {}, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    local conv_card = G.hand.highlighted[1]
    if conv_card.ability.name == 'Stone Card' then
      conv_card.ability.perma_bonus = conv_card.ability.perma_bonus + (50 + conv_card.ability.perma_bonus) * 2
    elseif SMODS.has_enhancement(conv_card, "m_worm_ct_junk_card") then
      conv_card.ability.extra.supergiant_chips_mult = conv_card.ability.extra.supergiant_chips_mult * 3
    else
      conv_card.ability.perma_bonus = conv_card.ability.perma_bonus +
          (conv_card.base.nominal + conv_card.ability.perma_bonus) * 2
    end
  end,
}

-- /// editions ///

-- Cosmic
SMODS.Edition {
  key = "ibu_cosmicedition",
  ppu_coder = { 'Oasis-J' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  shader = "ibu_cosmic",
  unlocked = true, --where it is unlocked or not: if true,
  discovered = true,
  config = { extra = { mult = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
      local cosmult = G.GAME.hands[context.scoring_name].level
      return { mult = cosmult }
    end
  end
}

-- /// enhancements ///

-- Frozen
SMODS.Enhancement {
  key = 'ibu_frozen',
  ppu_artist = { 'AveryIGuess' },
  ppu_coder = { 'AveryIGuess' },
  ppu_team = { "Team Ibuprofen" },
  atlas = "Consumables",
  pos = { x = 1, y = 0 },
  config = { extra = { saves = 1 } },
  shatters = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.saves } }
  end,
  calculate = function(self, card, context)
    if next(SMODS.find_card('j_worm_ibu_permafrost')) then card.ability.extra.saves = 1 end

    if context.stay_flipped and context.other_card == card and context.to_area == G.discard and card.ability.extra.saves > 0 and G.GAME.blind.in_blind then
      if card.ability.extra.saves == 1 then card.ability.extra.saves = 0 end
      return { message = "Frozen!", colour = G.C.SECONDARY_SET.Planet, modify = { to_area = G.hand } }
    elseif context.stay_flipped and context.other_card == card and context.to_area == G.discard and card.ability.extra.saves == 0 then
      card.ability.extra.saves = 1
    end
  end,
}


-- /// jokers ///

--SJJ Engine Failure
SMODS.Joker {
  key = 'ibu_enginefailure',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 1,
  cost = 4,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pos = { x = 1, y = 1 },
  config = { extra = { xmult = 3 } },
  attributes = { "xmult", "space" },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then return { xmult = card.ability.extra.xmult } end
    if context.after then
      if SMODS.last_hand_oneshot then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('worm_ibu_boom')
            SMODS.destroy_cards(card, {immediate = true})
            return true
          end
        }))
      end
    end
  end

}

--Dysonsphere
SMODS.Joker {
  key = "ibu_dyson",
  ppu_coder = { 'Oasis-J' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = 'Jokers',         --atlas' key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 6,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 1, y = 0 },
  config = { extra = { xmult = 2 } },
  attributes = { "xmult", "tarot", "space" },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_sun
    info_queue[#info_queue + 1] = G.P_CENTERS.c_star
    return { vars = { card.ability.extra.xmult } }
  end,
  calculate = function(self, card, context) -- scores chips
    if context.other_consumeable and (context.other_consumeable.ability.name == 'The Sun' or context.other_consumeable.ability.name == 'The Star') then
      return {
        x_mult = card.ability.extra.xmult,
        message_card = context.other_consumeable
      }
    end
  end
}

--Event Horizon
SMODS.Joker {
  key = "ibu_horizon",
  ppu_coder = { 'Oasis-J' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 2, y = 0 },
  config = { extra = { xmult = 3, current = 0 } },
  attributes = { "xmult", "space" },
  loc_vars = function(self, info_queue, card)

    local level = math.huge
    for k, v in pairs(G.GAME.hands) do
      if SMODS.is_poker_hand_visible(k) and v.level <= level then
        level = v.level
      end
    end
    card.ability.extra.current = math.max(card.ability.extra.xmult * (level - 1), 1)

    return { vars = { card.ability.extra.xmult, card.ability.extra.current } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then

      local level = math.huge
      for k, v in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(k) and v.level <= level then
          level = v.level
        end
      end
      card.ability.extra.current = math.max(card.ability.extra.xmult * (level - 1), 1)

      if card.ability.extra.current > 1 then
        return {
          x_mult = card.ability.extra.current
        }
      end
    end
  end
}

--Red Shift
SMODS.Joker {
  key = 'ibu_redshift',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 1,
  cost = 4,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 3, y = 1 },
  config = { extra = { mult = 4 } },

  attributes = { "enhancements", "mult", "space" },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,

  calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and context.other_card and next(SMODS.get_enhancements(context.other_card)) then
      return { mult = card.ability.extra.mult }
    end
  end
}

--Permafrost
SMODS.Joker {
  key = 'ibu_permafrost',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 4, y = 0 },

  attributes = { "enhancements", "passive", "space" },

  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS['m_worm_ibu_frozen']
  end,

  calculate = function(self, card, context)

  end,
  in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_steel'`
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(playing_card, 'm_worm_ibu_frozen') then
        return true
      end
    end
    return false
  end

}

--Laika
SMODS.Joker {
  key = 'ibu_laika',
  ppu_artist = { 'Oasis-J' },
  ppu_coder = { 'Twigi' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 5, y = 0 },
  config = { extra = { money = 0, money_gain = 1 } },

  attributes = { "economy", "hand_type", "space" },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.money_gain } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local _handname, _played = 'High Card', -1
      for hand_key, hand in pairs(G.GAME.hands) do
        if hand.played > _played then
          _played = hand.played
          _handname = hand_key
        end
      end
      local most = _handname
      if context.scoring_name == most then
        card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_gain
        return { message = "Woof!", sound = 'worm_ibu_woof', pitch = 1 }
      end
    end
  end,
  calc_dollar_bonus = function(self, card)
    local money = card.ability.extra.money
    card.ability.extra.money = 0
    return money
  end
}

--Hyperdrive
SMODS.Joker {
  key = 'ibu_hyperdrive',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 4, y = 1 },
  config = { extra = { money = 0, active = true } },

  attributes = { "economy", "passive", "space" },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.active } }
  end,

  calculate = function(self, card, context)
    if context.money_altered and card.ability.extra.active and context.amount > 0 then
      card.ability.extra.active = false
      ease_dollars(context.amount)
      card.ability.extra.active = true
      return { message = "Doubled!" }
    end
    if context.modify_ante and context.ante_end then
      return { message = "Hyperspeed!", colour = G.C.EDITION, modify = 2 }
    end
  end
}

--terraforming
SMODS.Joker {
  key = 'ibu_terraforming',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 6, y = 1 },
  config = { extra = { planetchoice = 'Mars' } },

  attributes = { "generation", "planet", "space" },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS['c_earth']
    return { vars = { card.ability.extra.planetchoice } }
  end,

  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.name == card.ability.extra.planetchoice then
      SMODS.add_card { key = "c_earth" }
    end

    if context.end_of_round and context.main_eval then
      local Terra = {
        "Pluto",
        "Mercury",
        "Saturn",
        "Jupiter",
        "Mars",
        "Venus",
        "Uranus",
        "Neptune",
        "Planet X",
        "Eris",
        "Ceres"
      }
      local randnum = pseudorandom("seeddddy", 1, 11)
      card.ability.extra.planetchoice = Terra[randnum]
    end
  end

}

--Jettison
SMODS.Joker {
  key = 'ibu_jettison',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = 'Jokers',         --atlas' key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 6,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = false, --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 0, y = 2 },   --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { extra = { rank = 0, suit = 0 } },

  attributes = { "enhancements", "discard", "space" },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_ibu_frozen
  end,

  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
    if context.discard and G.GAME.current_round.discards_used <= 0 then
      for k, v in ipairs(context.full_hand) do
        v:set_ability(G.P_CENTERS.m_worm_ibu_frozen, nil, true)
      end
    end
  end
}

--Brood Mother
SMODS.Joker {
  key = 'ibu_brood',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 3, y = 0 },
  config = { extra = { money = 0, active = true } },

  attributes = { "destroy_card", "generation", "rank", "queen", "space", "alien"},

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.death_card } }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then
      local rndcard = pseudorandom_element(G.hand.cards)
      rndcard.slayqueen = true
      if rndcard then
        G.E_MANAGER:add_event(Event({
          func = function()
            SMODS.add_card { set = "Base", rank = "Jack" }
            return true
          end
        }))
      end
    end
    if context.destroy_card and context.destroy_card.slayqueen then return { remove = true } end
  end

}

--WarpGate
SMODS.Joker {
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  key = 'ibu_warpgate',
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
  pos = { x = 5, y = 1 },
  config = { extra = { currounds = 0, maxrounds = 1 } },

  attributes = { "joker", "on_sell", "space" },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.currounds, card.ability.extra.maxrounds, } }
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.main_eval then
      card.ability.extra.currounds = card.ability.extra.currounds + 1
      if card.ability.extra.currounds >= card.ability.extra.maxrounds then
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
        return {
          message = localize('k_active_ex'),
          colour = G.C.FILTER
        }
      end
    end
    if context.selling_self and card.ability.extra.currounds >= card.ability.extra.maxrounds then
      local eligible_jokers = {}
      for _, v in ipairs(G.jokers.cards) do
        if not SMODS.is_eternal(v, card) then table.insert(eligible_jokers, v) end
      end
      local chosen_joker = pseudorandom_element(eligible_jokers, 'randomseed13')
      if chosen_joker then chosen_joker:add_sticker('eternal', true) end
    end
  end

}

--Space Heater
SMODS.Joker {
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  key = 'ibu_heater',          --joker key
  atlas = 'Jokers',            --atlas' key
  rarity = 2,                  --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 7,                    --cost
  unlocked = true,             --where it is unlocked or not: if true,
  discovered = true,           --whether or not it starts discovered
  blueprint_compat = true,     --can it be blueprinted/brainstormed/other
  eternal_compat = true,       --can it be eternal
  perishable_compat = true,    --can it be perishable
  pos = { x = 0, y = 1 },
  soul_pos = { x = 6, y = 0 }, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { extra = { xmult = 1, multmod = .33 } },

  attributes = { "enhancements", "xmult", "scaling", "space" },

  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_ibu_frozen
    return { vars = { center.ability.extra.xmult, center.ability.extra.multmod } }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.config.center.key == "m_worm_ibu_frozen" then
        local rancard = context.other_card
        rancard:set_ability('c_base', nil, true)
        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.multmod
        return {
          message = "Melted!",
          card = card
        }
      end
    end
    if context.joker_main then
      return { x_mult = card.ability.extra.xmult }
    end
  end,
  in_pool = function(self, args)
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(playing_card, 'm_worm_ibu_frozen') then
        return true
      end
    end
    return false
  end

}

--Space Heater
SMODS.Joker {
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Oasis-J' },
  ppu_team = { 'Team Ibuprofen' },
  key = 'ibu_asteroidmining',  --joker key
  atlas = 'Jokers',            --atlas' key
  rarity = 2,                  --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 7,                    --cost
  unlocked = true,             --where it is unlocked or not: if true,
  discovered = true,           --whether or not it starts discovered
  blueprint_compat = true,     --can it be blueprinted/brainstormed/other
  eternal_compat = true,       --can it be eternal
  perishable_compat = true,    --can it be perishable
  pos = { x = 0, y = 1 },
  soul_pos = { x = 1, y = 2 }, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { extra = { money = 2 } },

  attributes = { "economy", "enhancements", "space" },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_ibu_frozen
    return { vars = { card.ability.extra.money } }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.config.center.key == "m_worm_ibu_frozen" then
        return {
          ease_dollars(card.ability.extra.money),
          card = card
        }
      end
    end
  end,
  in_pool = function(self, args)
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(playing_card, 'm_worm_ibu_frozen') then
        return true
      end
    end
    return false
  end

}

--Shining Star
SMODS.Joker {
  key = 'ibu_shiningstar',
  ppu_coder = { 'Twigi' },
  ppu_artist = { 'Twigi' },
  ppu_team = { 'Team Ibuprofen' },
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 2, y = 1 },
  config = { extra = { retriggers = 5 } },

  attributes = { "hand_type", "suit", "diamonds", "retrigger", "space" },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.retriggers } }
  end,

  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and #context.full_hand == 1 and context.other_card:is_suit("Diamonds") then
      return { repetitions = card.ability.extra.retriggers }
    end
  end

}
