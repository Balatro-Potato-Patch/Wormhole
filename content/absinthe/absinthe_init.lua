--#region Atlases

SMODS.Atlas {
    key = "abs_credits",
    path = 'absinthe/abs_credits.png',
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
    atlas = 'worm_abs_credits',
    pos = { x = 2, y = 1 },
    soul_pos = { x = 3, y = 1 }
}

PotatoPatchUtils.Developer {
    name = 'pi_cubed',
    team = 'absinthe',
    colour = HEX('e14159'),
    atlas = 'worm_abs_credits',
    pos = { x = 0, y = 2 },
    soul_pos = { x = 1, y = 2 }
}

PotatoPatchUtils.Developer {
    name = 'AnneBean',
    team = 'absinthe',
    atlas = 'worm_abs_credits',
    pos = { x = 2, y = 2 },
    soul_pos = { x = 3, y = 2 }
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
    atlas = 'worm_abs_credits',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 }
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

--#endregion