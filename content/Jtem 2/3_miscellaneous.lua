-- https://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion
local function hsl2rgb(h,s,l,al) 
    local a=s*math.min(l,1-l);
    local f = function(n, k) k = math.fmod((n+h/30),12); return l - a*math.max(math.min(k-3,9-k,1),-1) end
    return {f(0),f(8),f(4),al};
end

-- stole ts from my own mod i cba to write the event thing
WORM_JTEM.simple_event_add = function (func, delay, queue, config)
    config = config or {}
    G.E_MANAGER:add_event(Event{
        trigger = config.trigger or 'after',
        delay = delay or 0.1,
        func = func,
        blocking = config.blocking,
        blockable = config.blockable,
    }, queue, config.front)
end

function WORM_JTEM.filter_table(tbl, predicate, ordered_in, ordered_out) 
    if not tbl or not predicate then return {} end
    if #tbl == 0 and ordered_in then return {} end
    local table_out = {}
    if ordered_in then
        for k,v in ipairs(tbl) do
            if predicate(v, k) then
                if ordered_out then
                    table.insert(table_out,v)
                else
                    table_out[k] = v
                end
            end
        end
    else
        for k,v in pairs(tbl)  do
            if predicate(v, k) then
                if ordered_out then
                    table.insert(table_out,v)
                else
                    table_out[k] = v
                end
            end
        end 
    end
    return table_out
end

---@param cards Card[] list of cards
---@param func fun(card: Card, index: number): nil callback for each card
---@param config? table config for the function
---@param queue? string event queue
function WORM_JTEM.do_things_to_card(cards, func, config, queue) -- func(card)
    queue = queue or "base"
    config = config or {stay_flipped_delay = 1,stagger = 0.5,finish_flipped_delay = 0.5, fifo = true}
    if not cards then return end
    for i, card in ipairs(cards) do
        WORM_JTEM.simple_event_add(
            function ()
                
                if not config.no_sound and card then
                    play_sound('card1')
                end
                if not config.no_juice then
                    card:juice_up(0.3, 0.3)
                end
                if not config.no_flip then
                    card:flip()
                end
                if not config.fifo then
                    if(config.stay_flipped_delay) then
                        delay(config.stay_flipped_delay, queue)
                    end
                    WORM_JTEM.simple_event_add(
                        function ()
                            func(card, i)
                            if not config.no_sound and card then
                                play_sound("card1",math.abs(1.15 - (i-0.999)/(#cards-0.998)*0.3))
                            end
                            if not config.no_juice then
                                card:juice_up(0.3, 0.3)
                            end
                            if not config.no_flip then
                                card:flip()
                            end
                            if not config.dont_unhighlight and card.highlighted and card.area then
                                card.area:remove_from_highlighted(card)
                            end
                            return true
                        end,config.finish_flipped_delay or 0.5, queue
                    )
                end

                return true
            end,config.stagger or 0, queue
        )
        if config.fifo and config.fifo_wait_for_finish then
            WORM_JTEM.simple_event_add(
                function ()
                    func(card, i)
                    if not config.no_sound and card then
                        play_sound("card1",math.abs(1.15 - (i-0.999)/(#cards-0.998)*0.3))
                    end
                    if not config.no_juice then
                        card:juice_up(0.3, 0.3)
                    end

                    if not config.no_flip then
                        card:flip()
                    end
                    if not config.dont_unhighlight and card.highlighted and card.area then
                        card.area:remove_from_highlighted(card)
                    end
                    return true
                end,config.finish_flipped_delay or 0.5, queue
            )
        end
    end
    if(config.fifo and config.stay_flipped_delay) then
        delay(config.stay_flipped_delay or 0, queue)
        for i, card in ipairs(cards) do
            if config.fifo and not config.fifo_wait_for_finish then
                WORM_JTEM.simple_event_add(
                    function ()
                        if not config.once then
                        end

                        func(card, i)
                        if not config.no_sound and card then
                            play_sound("card1",math.abs(1.15 - (i-0.999)/(#cards-0.998)*0.3))
                        end
                        if not config.no_juice then
                            card:juice_up(0.3, 0.3)
                        end

                        if not config.no_flip then
                            card:flip()
                        end
                        if not config.dont_unhighlight and card.highlighted and card.area then
                            card.area:remove_from_highlighted(card)
                        end
                        return true
                    end,config.finish_flipped_delay or 0.5, queue
                )
            end
        end
    end

end

SMODS.DynaTextEffect {
    key = "jtem2_obfuscate",
    func = function (dynatext, index, letter)
        letter.letter = love.graphics.newText(dynatext.font.FONT, string.char(math.fmod((string.byte(letter.char) + math.fmod(math.floor(G.TIMERS.REAL * 142.1 + index), 192)), 94)+ 33))
    end
}

SMODS.DynaTextEffect {
    key = "jtem2_rainbow_wiggle",
    func = function (dynatext, index, letter)
        letter.colour = hsl2rgb(math.fmod((G.TIMERS.REAL + index) * 50, 360), 1, 0.75)
        letter.offset.y = math.cos(G.TIMERS.REAL * 2.95 + index) * 9
        letter.scale = (((math.sin((G.TIMERS.REAL + index)*2.9443) + 1)/2) + 6 )/6
    end
}
SMODS.DynaTextEffect {
    key = "jtem2_snaking",
    func = function (dynatext, index, letter)
        letter.offset.x = math.sin((G.TIMERS.REAL + index) * 7.95) * 7
        letter.offset.y = math.cos((G.TIMERS.REAL + index) * 7.95) * 7
    end
}
SMODS.DynaTextEffect {
    key = "jtem2_shrivel",
    func = function (dynatext, index, letter)
        letter.offset.x = math.sin((G.TIMERS.REAL * 14511.15 + index * 534.415) * 7.95) * 5
        letter.offset.y = math.cos((G.TIMERS.REAL * 534.15 + index * 14511.415) * 7.95) * 5
    end
}
SMODS.DynaTextEffect {
    key = "jtem2_exponent",
    func = function (dynatext, index, letter)
        letter.offset.y = 20
        letter.offset.x = 20
    end
}