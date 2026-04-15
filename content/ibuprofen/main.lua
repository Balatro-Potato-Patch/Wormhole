
-- /// team ///
SMODS.current_mod.extra_tabs = PotatoPatchUtils.CREDITS.register_page(SMODS.current_mod)

PotatoPatchUtils.Team {
  name = 'Team Ibuprofen',
  colour = HEX"e34244",
  loc = 'k_team_ibuprofen',
}

PotatoPatchUtils.Developer {
  name = 'Twigi',
  colour = G.C.MONEY,
  loc = 'd_twigi', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Team Ibuprofen', -- Must match an already existing Team name
  atlas = 'worm_Devs',
  soul_pos = {x = 1, y = 0},
  pos = {x = 0, y = 0}
}

PotatoPatchUtils.Developer {
  name = 'Oasis-J',
  colour = G.C.PURPLE,
  loc = 'd_joos', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Team Ibuprofen', -- Must match an already existing Team name
  atlas = 'worm_Devs',
  pos = {x = 2, y = 0}
}

PotatoPatchUtils.Developer {
  name = 'AveryIGuess',
  colour = G.C.SECONDARY_SET.Tarot,
  loc = 'd_avery', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Team Ibuprofen', -- Must match an already existing Team name
  atlas = 'worm_Devs',
  pos = {x = 3, y = 0}
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

SMODS.Sound{
  key = 'boom',
  path = "ibuprofen/boom.ogg",
}

SMODS.Sound{
  key = 'woof',
  path = "ibuprofen/Bark.ogg",
}

SMODS.Shader{
    key = "cosmic",
    path = "ibuprofen/cosmic.fs",
}

-- /// consumables ///

-- The Mountain
SMODS.Consumable {
    key = 'mountain',
    set = 'Tarot',
    ppu_coder = {'Twigi'},
    ppu_artist = {'Oasis-J'},
    loc_txt = {
    name = 'The Mountain',
    text = {
      "Enhances {C:attention}2{}","selected cards to","{C:attention}Frozen Cards{}"
    }
  },
    atlas = "Consumables",
    pos = { x = 4, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_worm_frozen' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

-- Eclipse
SMODS.Consumable {
  key = 'eclipse',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Twigi'},
  unlocked = true,
  discovered = true,
  set = 'Spectral',
  pos = { x = 2, y = 0 },
  atlas = 'Consumables',
  loc_txt = {
    name = 'Eclipse',
    text = {
      "Add {C:dark_edition}Negative{} to up to",
      "{C:attention} 1 {}selected playing card"
    }
  },
  config = { extra = {}, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
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
  key = 'nebula',
  ppu_artist = {'Twigi'},
  unlocked = true,
  discovered = true,
  set = 'Spectral',
  pos = { x = 3, y = 0 },
  atlas = 'Consumables',
  loc_txt = {
    name = 'Nebula',
    text = {
      "Add {C:dark_edition}Cosmic{} to up to",
      "{C:attention} 1 {}selected playing card"
    }
  },
  ppu_coder = {'Twigi'},
  config = { extra = {}, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'e_worm_cosmicedition', set = 'Edition', config = { extra = 1 } }
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
          highlighted:set_edition('e_worm_cosmicedition', true)
          return true
        end
      }))
      card:juice_up(0.3, 0.5)
    end
  end
}

-- Supergiant
SMODS.Consumable {
  key = 'supergiant',
  ppu_artist = {'Twigi'},
  ppu_coder = {'Twigi'},
  unlocked = true,
  discovered = true,
  set = 'Spectral',
  pos = { x = 0, y = 0 },
  atlas = 'Consumables',
  loc_txt = {
    name = 'Supergiant',
    text = {
      "{C:attention}Triple{} a cards base chips"
    }
  },
  config = { extra = {}, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    local conv_card = G.hand.highlighted[1]
    if conv_card.ability.name == 'Stone Card' then
      conv_card.ability.perma_bonus = conv_card.ability.perma_bonus + (50 + conv_card.ability.perma_bonus) * 2
    else
      conv_card.ability.perma_bonus = conv_card.ability.perma_bonus +
          (conv_card.base.nominal + conv_card.ability.perma_bonus) * 2
    end
  end,

}

-- /// editions ///

-- Cosmic
SMODS.Edition{
    key = "cosmicedition",
    ppu_coder = {'Oasis-J'},
    ppu_artist = {'Oasis-J'},
    shader = "cosmic",
    loc_txt = {
        label = "Cosmic",
        name = "Cosmic",
        text = {"Gives {C:mult}+1{} Mult for each ","{C:attention}level of played hand{} when scored"},
    },
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true,
    config = {extra = {mult = 1}},

    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            local cosmult = G.GAME.hands[context.scoring_name].level
            return {mult = cosmult}
        end
    end
}

-- /// enhancements ///

-- Frozen
SMODS.Enhancement {
    key = 'frozen',
    ppu_artist = {'AveryIGuess'},
    ppu_coder = {'AveryIGuess'},
    loc_txt = {
    name = 'Frozen Card',
    text = {
      "{C:attention}Returns to hand{}","if played or discarded","{C:attention}once{} per round"
    }
  },
    atlas = "Consumables",
    pos = { x = 1, y = 0 },
    config = { extra = { saves = 1 } },
    shatters = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.saves} }
    end,
    calculate = function(self, card, context)
      if next(SMODS.find_card('j_worm_permafrost')) then card.ability.extra.saves = 1 end

      if context.stay_flipped and context.other_card == card and context.to_area == G.discard and card.ability.extra.saves > 0 and G.GAME.blind.in_blind then
        if card.ability.extra.saves == 1 then card.ability.extra.saves = 0 end
        return {message = "Frozen!",colour =  G.C.SECONDARY_SET.Planet , modify = {to_area = G.hand}}
      elseif context.stay_flipped and context.other_card == card and context.to_area == G.discard and card.ability.extra.saves == 0 then card.ability.extra.saves = 1 end
 
    end,
}


-- /// jokers ///

--SJJ Engine Failure
SMODS.Joker {
  key = 'enginefailure',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {
    name = 'Engine Failure',
    text = { "{X:mult,C:white} X#1# {} Mult", "{C:mult} Self destructs{} if score {C:attention}catches fire{}" }
  },
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

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then return { xmult = card.ability.extra.xmult} end
    if context.after then
      if SMODS.last_hand_oneshot then 
        G.E_MANAGER:add_event(Event({
            func = function()
              play_sound('worm_boom')
              SMODS.destroy_cards(card, nil, true)
              return true
            end
          }))
        end
    end
  end

}

--Dysonsphere
SMODS.Joker{

    key = "dyson",
    ppu_coder = {'Oasis-J'},
    ppu_artist = {'Oasis-J'},
    loc_txt = { -- local text
      name = 'Dyson Sphere',
      text = {"{X:mult,C:white}X2{} Mult for each {C:hearts}Sun{} or {C:diamonds}Stars{}", 
      "Tarot in your consumable area",
    },},
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0},
    config = {extra = {xmult = 2}},

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
SMODS.Joker{
    key = "horizon",
    ppu_coder = {'Oasis-J'},
    ppu_artist = {'Oasis-J'},
    loc_txt = {
        name ="Event Horizon",
        text = {"{X:mult,C:white}X3{} Mult for lowest level above one", "shared by all hand types.",
                    "{C:inactive}Currently: #1#{}"},
    },
    atlas = "Jokers",
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 0},
    config = {extra = {xmult = 3, current = 0}},
    loc_vars = function(self, info_queue, center)
      return {vars = {center.ability.extra.current}}
                end,

    calculate = function(self, card, context)
        local level = math.huge
        for k, v in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(k) and v.level <= level then
                level = v.level
            end
        end
        card.ability.extra.current = (level-1)
        if context.joker_main and level > 1 then
            local endmult = card.ability.extra.xmult*(level-1)
            return{
                x_mult = endmult
            }
        end
    end
}

--Red Shift
SMODS.Joker {
  key = 'redshift',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {
    name = 'Red Shift',
    text = { "{C:attention}Enhanced Cards{} are {C:attention}Mult Cards{}" }
  },
  atlas = "Jokers",
  rarity = 1,
  cost = 4,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 3, y = 1 },
  config = { extra = { } },

  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS['m_mult']
    return { vars = {} }
  end,

  calculate = function(self, card, context)
    if context.check_enhancement and context.other_card.config.center.key == "c_base" then return else return {m_mult = true } end
  end
}

--Permafrost
SMODS.Joker {
  key = 'permafrost',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {
    name = 'Permafrost',
    text = { "{C:attention}Frozen Cards{}","always return to hand" }
  },
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 4, y = 0 },
  config = { extra = { xmult = 3 } },

  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS['m_worm_frozen']
    return {  vars = { center.ability.extra.xmult } }
  end,

  calculate = function(self, card, context)
    
  end,
  in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_steel'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_worm_frozen') then
                return true
            end
        end
        return false
    end

}

--Laika
SMODS.Joker {
  key = 'laika',
  ppu_artist = {'Oasis-J'},
  ppu_coder = {'Twigi'},
  loc_txt = {
    name = 'Laika',
    text = { "Earn {C:money}$1{} at the end of round","for each time {C:attention}most played hand{} was played"}
  },
  atlas = "Jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 5, y = 0 },
  config = { extra = { money = 0 } },

  loc_vars = function(self, info_queue, center)
    return {  vars = { center.ability.extra.money } }
  end,

  calculate = function(self, card, context)
  local _handname, _played = 'High Card', -1
  for hand_key, hand in pairs(G.GAME.hands) do
    if hand.played > _played then
      _played = hand.played
      _handname = hand_key
    end
  end
  local most = _handname
  if context.first_hand_drawn then card.ability.extra.money = 0 end

  if context.joker_main and context.scoring_name == most  then
    card.ability.extra.money = card.ability.extra.money + 1
    play_sound('worm_woof')
    return{ message = "Woof!"}
  end

  end,
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.money
  end
}

--Hyperdrive
SMODS.Joker {
  key = 'hyperdrive',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {
    name = 'Hyper Space',
    text = { "Earn {C:money}double ${}","{C:attention}Ante{} increases twice as fast" }
  },
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

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.money, center.ability.extra.active } }
  end,

  calculate = function(self, card, context)
    if context.money_altered and card.ability.extra.active and context.amount > 0 then
      card.ability.extra.active = false
      ease_dollars(context.amount)
      card.ability.extra.active = true
      return{message = "Doubled!"}
    end
    if context.modify_ante and context.ante_end then
      return{message = "Hyperspeed!", colour = G.C.EDITION , modify = 2}
    end
  end
}

--terraforming
SMODS.Joker {
  key = 'terraforming',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {
    name = 'Terraforming',
    text = { "Create a {C:attention}Earth{} whenever","a {C:attention}#1#{} is used", "{C:inactive}Used planet changes each round" }
  },
  atlas = "Jokers",
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 6, y = 1 },
  config = { extra = {  planetchoice = 'Mars' } },

  loc_vars = function(self, info_queue, center)
    return { vars = {center.ability.extra.planetchoice } }
  end,

  calculate = function(self, card, context)
  Terra = {}
    Terra[1] = "Pluto"
    Terra[2] = "Mercury"
    Terra[3] = "Saturn"
    Terra[4] = "Jupiter"
    Terra[5] = "Mars"
    Terra[6] = "Venus"
    Terra[7] = "Uranus"
    Terra[8] = "Neptune"
    Terra[9] = "Planet X"
    Terra[10] = "Eris"
    Terra[11] = "Ceres"

    if context.using_consumeable and context.consumeable.ability.name == card.ability.extra.planetchoice  then
      SMODS.add_card{ key = "c_earth"}
    end

    if context.end_of_round and context.main_eval then
      local randnum = pseudorandom("seeddddy", 1, 11)
      card.ability.extra.planetchoice = Terra[randnum]
    end
  end

}

--Jettison
SMODS.Joker{
  key = 'jettison',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {        -- local text
    name = 'Jettison',
    text = {
      '{C:attention}First discarded{} hand become {C:attention}Frozen Cards{}',
    },

  },
  atlas = 'Jokers',         --atlas' key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 6,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = false,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 0, y = 2 },   --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { extra = { rank = 0, suit = 0 } },


  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_frozen
    return {
      vars = {
        
      }
    }
  end,

  calculate = function(self, card, context)
    if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
    end
    if context.discard and G.GAME.current_round.discards_used <= 0 then
      for k, v in ipairs(context.full_hand) do
         v:set_ability(G.P_CENTERS.m_worm_frozen, nil, true) 
      end
    end
  end
}

--Brood Mother
SMODS.Joker {
  key = 'brood',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  loc_txt = {
    name = 'Brood Mother',
    text = { "Destroy a random card in hand","and create a {C:attention}Jack{} whenever"," a {C:attention}Queen{} is played" }
  },
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

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.money, center.ability.extra.death_card } }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then 
      local rndcard = pseudorandom_element(G.hand.cards)
      rndcard.slayqueen = true
      if rndcard then
        G.E_MANAGER:add_event(Event({
            func = function()
              SMODS.add_card{ set = "Base", rank = "Jack"}
              return true
            end
          }))
      end
    end
    if context.destroy_card and context.destroy_card.slayqueen then return { remove = true } end
  end

}

--WarpGate
SMODS.Joker{
ppu_coder = {'Twigi'},
ppu_artist = {'Oasis-J'},
key = 'warpgate',
  loc_txt = {
    name = 'Warp Gate',
    text = { "Sell this card after {C:attention}1 round{}"," to give {C:Legendary}Eternal{} to a random joker","{C:inactive}Currently {C:attention}#1#{}" }
  },
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

  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.currounds, center.ability.extra.maxrounds,} }
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
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  key = 'heater', --joker key
  loc_txt = {    -- local text
    name = 'Space Heater',
    text = {
      'Melts played {C:attention}Frozen Cards{}','and gains {X:mult,C:white} X#2# {} Mult','{C:inactive}Currently {X:mult,C:white} X#1# {}'
    },

  },
  atlas = 'Jokers',         --atlas' key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 7,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 0, y = 1 },
  soul_pos = { x = 6, y = 0 },   --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { extra = { xmult = 1, multmod = .33 } },

  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_frozen
    return { vars = { center.ability.extra.xmult, center.ability.extra.multmod } }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.config.center.key == "m_worm_frozen" then
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
      return {x_mult = card.ability.extra.xmult}
    end
    
  end,
  in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_worm_frozen') then
                return true
            end
        end
        return false
    end
  
}

--Space Heater
SMODS.Joker {
  ppu_coder = {'Twigi'},
  ppu_artist = {'Oasis-J'},
  key = 'asteroidmining', --joker key
  loc_txt = {    -- local text
    name = 'Asteroid Mining',
    text = {
      'Earn {C:money}$2{} when a','{C:attention}Frozen Card{} is scored'
    },

  },
  atlas = 'Jokers',         --atlas' key
  rarity = 2,               --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
  cost = 7,                 --cost
  unlocked = true,          --where it is unlocked or not: if true,
  discovered = true,        --whether or not it starts discovered
  blueprint_compat = true,  --can it be blueprinted/brainstormed/other
  eternal_compat = true,    --can it be eternal
  perishable_compat = true, --can it be perishable
  pos = { x = 0, y = 1 },
  soul_pos = { x = 1, y = 2 },   --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
  config = { extra = { } },

  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_frozen
    return { vars = { } }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.config.center.key == "m_worm_frozen" then
        return {
          ease_dollars(2),
          card = card
        }
      end
    end
  end,
  in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_worm_frozen') then
                return true
            end
        end
        return false
    end
  
}

--Shining Star
SMODS.Joker {
  key = 'shiningstar',
  ppu_coder = {'Twigi'},
  ppu_artist = {'Twigi'},
  loc_txt = {
    name = 'Shining Star',
    text = { "If played hand is a","{C:attention}Single {C:diamonds}Diamond{}","Retrigger it 5 times" }
  },
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

  loc_vars = function(self, info_queue, center)
    return {  vars = { center.ability.extra.retriggers } }
  end,

  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and #context.full_hand == 1 and context.other_card:is_suit("Diamonds") then
      return { repetitions = card.ability.extra.retriggers }
    end
  end

}
