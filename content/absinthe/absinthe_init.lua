--#region Atlases

SMODS.Atlas {
    key = "abs_credits",
    path = 'absinthe/abs_credits.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "abs_modifier",
    path = 'absinthe/abs_modifier.png',
    px = 71,
    py = 95
}

--#endregion

--#region Team and Dev Objects
loc_colour()
G.ARGS.LOC_COLOURS.absinthe = HEX('5fd47e')

PotatoPatchUtils.Team {
    name = 'absinthe',
    colour = HEX('5fd47e')
}

PotatoPatchUtils.Developer {
    name = 'pangaea47',
    team = 'absinthe',
    colour = HEX('e6fab8'),
    atlas = 'worm_abs_credits',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    loc = true
}

PotatoPatchUtils.Developer {
    name = 'theAstra',
    team = 'absinthe',
    colour = HEX('8710c7'),
    atlas = 'worm_abs_credits',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    loc = true
}

PotatoPatchUtils.Developer {
    name = 'AstraLuna',
    team = 'absinthe',
    colour = HEX('8de16b'),
    atlas = 'worm_abs_credits',
    pos = { x = 2, y = 1 },
    soul_pos = { x = 3, y = 1 },
    loc = true
}

PotatoPatchUtils.Developer {
    name = 'pi_cubed',
    team = 'absinthe',
    colour = HEX('e14159'),
    atlas = 'worm_abs_credits',
    pos = { x = 0, y = 2 },
    soul_pos = { x = 1, y = 2 },
    loc = true
}

PotatoPatchUtils.Developer {
    name = 'AnneBean',
    team = 'absinthe',
    colour = HEX('ae65ff'),
    atlas = 'worm_abs_credits',
    pos = { x = 2, y = 2 },
    soul_pos = { x = 3, y = 2 },
    loc = true
}

PotatoPatchUtils.Developer {
    name = 'nixthatoneartist',
    team = 'absinthe',
    colour = HEX("0db829"),
    atlas = 'worm_abs_credits',
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 },
    loc = true
}

PotatoPatchUtils.Developer {
    name = 'base4',
    team = 'absinthe',
    colour = HEX("6a8a6b"),
    atlas = 'worm_abs_credits',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    loc = true
}

--#endregion

--#region Utils

Wormhole.Absinthe = {}

---Returns the name of the most played poker hand
function Wormhole.Absinthe.get_most_played_hand()
    local _handname, _played, _order = 'High Card', -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end

    return _handname
end

function Wormhole.Absinthe.get_random_team()
    local valid_teams = {}
    for k, v in pairs(PotatoPatchUtils.Teams) do
        if v.mod_id == 'Wormhole' then
            table.insert(valid_teams, v)
        end
    end

    return pseudorandom_element(valid_teams, 'abs_rand_team')
end

Wormhole.Absinthe.type_blacklist = {
    ['Back'] = true
}

function Wormhole.Absinthe.get_team_card_key(team, seed)
    local cards = {}
    for i, v in pairs(G.P_CENTERS) do
        if not v.hidden and not G.GAME.banned_keys[v.key] and v.set and not Wormhole.Absinthe.type_blacklist[v.set] and v.ppu_team and v.rarity ~= 4 then
            for k, t in pairs(v.ppu_team) do
                if t == team then
                    cards[#cards+1] = v.key
                    break
                end
            end
        end
    end
    return pseudorandom_element(cards, pseudoseed(seed))
end

function Wormhole.Absinthe.get_card_area_to_emplace(key)
    local area
    local center = G.P_CENTERS[key]
    if center.select_card and not center.set == 'Booster' then
        if type(center.select_card) == "function" then -- Card's value takes first priority
            area = center.config.center:select_card(center)
        else
            area = center.select_card
        end
    elseif SMODS.ConsumableTypes[center.set] and SMODS.ConsumableTypes[center.set].select_card then -- ConsumableType is second priority
        if type(SMODS.ConsumableTypes[center.set].select_card) == "function" then
            area = SMODS.ConsumableTypes[center.set]:select_card(center)
        else
            area = SMODS.ConsumableTypes[center.set].select_card
        end
    end

    if not area then
        if center.set == 'Joker' then
            area = 'jokers'
        elseif center.consumeable or center.set == 'Voucher' or center.set == 'Booster' then
            area = 'consumeables'
        end
    end

    return area
end

-- "No Space!" alert but with support for custom 'cover' colours
function Wormhole.Absinthe.alert_no_space(card, area, colour)
  colour = colour or adjust_alpha(G.C.BLACK, 0.7)
    G.CONTROLLER.locks.no_space = true
  attention_text({
      scale = 0.9, text = localize('k_no_space_ex'), hold = 0.9, align = 'cm',
      cover = area, cover_padding = 0.1, cover_colour = colour
  })
  card:juice_up(0.3, 0.2)
  for i = 1, #area.cards do
    area.cards[i]:juice_up(0.15)
  end
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
    play_sound('tarot2', 0.76, 0.4);return true end}))
    play_sound('tarot2', 1, 0.4)

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5*G.SETTINGS.GAMESPEED, blockable = false, blocking = false,
    func = function()
      G.CONTROLLER.locks.no_space = nil
    return true end}))
end

SMODS.DrawStep {
    key = 'absinthe_modified',
    order = 25,
    func = function(self, layer)
        if self.absinthe_modified then
            if not Wormhole.Absinthe.modifier_sprite then
                Wormhole.Absinthe.modifier_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS['worm_abs_modifier'], { x = 0, y = 0 })
            end
            Wormhole.Absinthe.modifier_sprite.role.draw_major = self
            if self.edition and not self.delay_edition then
                for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                    if self.edition[v.key:sub(3)] and v.shader then
                    if type(v.draw) == 'function' then
                        v:draw(self, layer)
                    else
                        Wormhole.Absinthe.modifier_sprite:draw_shader(v.shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
                    end
                    end
                end
                if self.edition.negative then
                    Wormhole.Absinthe.modifier_sprite:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
                end
            elseif not self:should_draw_base_shader() then
            -- Don't render base dissolve shader.
            elseif not self.greyed then
            Wormhole.Absinthe.modifier_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
--#endregion
