Wormhole.LFC_Util = {}

Wormhole.LFC_Util.debug_print = function(str)
    if print and G.GAME.lfc_debug then print(str) end
end
Wormhole.LFC_Util.total_keys = function(table)
    local length = 0
    for _, __ in pairs(table) do
        length = length + 1
    end
    return length
end

-- Copied from slimeutils :)
Wormhole.LFC_Util.card_obscured = function(card)
    return not card.config.center.discovered and (card.ability.consumeable or card.config.center.unlocked) and
        not card.bypass_discovery_center
end

-- Copied from one of J8's mods
Wormhole.LFC_Util.create_random_tag = function(rng_key)
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            --- Credits to Eremel
            local tag_pool = get_current_pool('Tag')
            local selected_tag = pseudorandom_element(tag_pool, rng_key)
            local it = 1
            while selected_tag == 'UNAVAILABLE' do
                it = it + 1
                selected_tag = pseudorandom_element(tag_pool, rng_key .. it)
            end
            local tag = Tag(selected_tag)
            if tag.name == "Orbital Tag" then
                local _poker_hands = {}
                for k, v in pairs(G.GAME.hands) do
                    if v.visible then
                        _poker_hands[#_poker_hands + 1] = k
                    end
                end
                tag.ability.orbital_hand = pseudorandom_element(_poker_hands,
                    rng_key .. "_orbital_tag")
            end
            tag:set_ability()
            add_tag(tag)
            return true
        end
    }))
end

-- modified from Entropy's Entropy.generate_void_invert_uibox, which i also wrote most of -alexi
Wormhole.LFC_Util.generate_pokedex_entry_ui = function(center, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    SMODS.Center.generate_ui(center, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if center.generate_extra_ui then
        center:generate_extra_ui(info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end
    if not center.discovered or center.locked then return end

    local version = pseudorandom_element({ 'us', 'um' }, center.key .. "_dex_entry")
    local lines = (G.GAME.worm_log or {})[center.key]
        and G.localization.misc.v_dictionary_parsed[center.dex_entry_key .. "_" .. version]
        or G.localization.misc.v_dictionary_parsed["lfc_obtain_pokemon_warning"]

    local vars = {
        colours = {
            G.ARGS.LOC_COLOURS["lfc_pkmn_" .. version]
        }
    }

    local localize_args = {
        AUT = full_UI_table,
        nodes = desc_nodes,
        vars = vars,
    }
    -- taken from localize; adds the multibox text
    localize_args.AUT.multi_box = localize_args.AUT.multi_box or {}
    local i = #full_UI_table.multi_box + 1 -- fucking janky ass method
    for _, line in ipairs(lines) do
        local final_line = SMODS.localize_box(line, localize_args)
        if i == 1 or next(localize_args.AUT.info) then
            localize_args.nodes[#localize_args.nodes+1] = final_line -- Sends main box to AUT.main
            if not next(localize_args.AUT.info) then localize_args.nodes.main_box_flag = true end
        elseif not next(localize_args.AUT.info) then
            localize_args.AUT.multi_box[i-1] = localize_args.AUT.multi_box[i-1] or {}
            localize_args.AUT.multi_box[i-1][#localize_args.AUT.multi_box[i-1]+1] = final_line
        end
        if not next(localize_args.AUT.info) and localize_args.AUT.box_colours then
            localize_args.AUT.box_colours[i] = localize_args.vars.box_colours and localize_args.vars.box_colours[i] or G.C.UI.BACKGROUND_WHITE
        end
    end
end

function Wormhole.LFC_Util.ease_eigengrau_bg_alpha(target)
    G.E_MANAGER:add_event(Event({
        trigger = "ease",
        ref_table = G.ARGS,
        ref_value = "eigengrau_alpha",
        ease_to = target,
        delay = 2,
    }))
end

function Wormhole.LFC_Util.is_card_modified(card)
    if card.seal or card.edition or next(SMODS.get_enhancements(card)) then
        return true
    end
    for k, _ in pairs(SMODS.Stickers) do
        if card.ability[k] then return true end
    end
    return false
end