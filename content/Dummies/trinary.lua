SMODS.Atlas {
  key = "dummies_trinary",
  path = "Dummies/trinary.png",
  px = 34,
  py = 34
}

SMODS.Tag {
    key = "dum_trinary",
	atlas = "worm_dummies_trinary",
    pos = { x = 0, y = 0 },
    ppu_team = { "dummies" },
    ppu_artist = { "flowire" },
    ppu_coder = { "flowire" },
    unlocked = true,
    discovered = false,
    min_ante = 2,
	config = { extra = { uses = 3 } },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.ability.uses or tag.config.extra.uses } }
    end,
    apply = function(self, tag, context)
        -- Bugfix: Tag triggers on Discards for first Hand of round
        if context.type == 'eval' then
            tag.ability.used = false --> Can't use "tag.triggered"
        end
        -- Chopped up copy of "Tag:yep()"
        if context.type == 'round_start_bonus' and not tag.ability.used then
            tag.ability.used = true
            -- Select Type
            local rng = pseudorandom("trinary_system")
            local selected --> Only allows one "Spectral" per Trinary-Tag
            if rng < 0.2 and not tag.ability.DrSpectred then
                tag.ability.DrSpectred = true
                selected = 'Spectral'
            else selected = rng >= 0.6 and 'Tarot' or 'Planet' end
            -- Tag:Yap()
            stop_use()
            local yapping = tostring(tag.ability.uses or tag.config.extra.uses)
            G.E_MANAGER:add_event(Event({
                delay = 0.4,
                trigger = 'after',
                func = function()
                    attention_text({
                        text = yapping,
                        colour = G.C.WHITE,
                        scale = 1,
                        hold = 0.3/G.SETTINGS.GAMESPEED,
                        cover = tag.HUD_tag,
                        cover_colour = G.C.SECONDARY_SET[selected] or G.C.GREEN,
                        align = 'cm',
                    })
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end
            }))
            -- Give Consumable
			if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
						SMODS.add_card{ set = selected, key_append = 'trinary_system' }
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
			end
            -- Destroy (when out of uses)
            tag.ability.uses = (tag.ability.uses or tag.config.extra.uses) - 1
            tag.triggered = true --> Set "triggered" for other Events...
            if tag.ability.uses <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        tag.HUD_tag.states.visible = false
                        return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = (function()
                        tag:remove()
                        return true
                    end)
                }))
            else
                --delay(0.7)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function()
                        -- ...but remove "triggered" again.
                        tag.triggered = false
                        return true
                    end
                }))
            end
            return true
        end
    end
}
