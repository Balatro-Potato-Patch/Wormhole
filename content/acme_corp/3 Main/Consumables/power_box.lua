Wormhole.ACME = Wormhole.ACME or {}

local WIRE_DATA = {
    { color = { 0.95, 0.22, 0.22 }, label = 'A' },
    { color = { 0.30, 0.55, 1.00 }, label = 'B' },
    { color = { 0.20, 0.88, 0.35 }, label = 'C' },
    { color = { 1.00, 0.82, 0.05 }, label = 'D' },
    { color = { 0.72, 0.32, 0.92 }, label = 'E' },
    { color = { 1.00, 0.55, 0.08 }, label = 'F' },
    { color = { 0.05, 0.85, 0.85 }, label = 'G' },
    { color = { 1.00, 0.42, 0.72 }, label = 'H' },
}

local UI = {
    bg       = { 0.07, 0.07, 0.10, 0.82 },
    panel    = { 0.10, 0.10, 0.15, 1 },
    panel_hi = { 0.14, 0.14, 0.20, 1 },
    border   = { 0.28, 0.28, 0.36, 1 },
    wall     = { 0.08, 0.08, 0.12, 1 },
    wall_brd = { 0.22, 0.22, 0.30, 1 },
    title    = { 1, 0.85, 0.05, 1 },
    sub      = { 0.55, 0.55, 0.65, 1 },
    btn      = { 0.55, 0.13, 0.13, 1 },
    btn_hov  = { 0.80, 0.22, 0.22, 1 },
    btn_brd  = { 0.75, 0.30, 0.30, 1 },
    white    = { 1, 1, 1, 1 },
}

local function calc_layout(n)
    local sw, sh  = love.graphics.getDimensions()
    local S       = sh / 1080
    local pw      = math.floor(420 * S)
    local ph      = math.floor(math.max(320 * S, 100 * S + n * 72 * S))
    local px      = math.floor((sw - pw) / 2)
    local py      = math.floor((sh - ph) / 2)

    local tr      = math.floor(22 * S)
    local mt      = math.floor(70 * S)
    local mb      = math.floor(52 * S)
    local ms      = math.floor(56 * S)
    local use     = ph - mt - mb
    local sp      = use / n

    local lo      = {
        S = S,
        tr = tr,
        panel = { x = px, y = py, w = pw, h = ph },
        left = {},
        right = {},
        btn = {
            x = px + (pw - math.floor(110 * S)) / 2,
            y = py + ph - math.floor(42 * S),
            w = math.floor(110 * S),
            h = math.floor(28 * S),
        },
    }

    local ww      = math.floor(tr * 2.6)
    lo.wall_left  = { x = px + ms - ww / 2, y = py + mt - tr, w = ww, h = use + tr * 2, r = math.floor(6 * S) }
    lo.wall_right = { x = px + pw - ms - ww / 2, y = py + mt - tr, w = ww, h = use + tr * 2, r = math.floor(6 * S) }

    for i = 1, n do
        local cy    = py + mt + sp * (i - 0.5)
        lo.left[i]  = { x = px + ms, y = cy }
        lo.right[i] = { x = px + pw - ms, y = cy }
    end
    return lo
end

local function center_text(text, cx, cy, scale, col)
    local f = love.graphics.getFont()
    if not f then return end
    love.graphics.setColor(col)
    love.graphics.push()
    love.graphics.translate(cx, cy)
    love.graphics.scale(scale, scale)
    love.graphics.print(text, -f:getWidth(text) / 2, -f:getHeight() / 2)
    love.graphics.pop()
end

local function draw_wire(x1, y1, x2, y2, col, w)
    love.graphics.setColor(col[1], col[2], col[3], col[4] or 1)
    love.graphics.setLineWidth(w or 4)
    love.graphics.setLineJoin('bevel')
    love.graphics.setLineStyle('smooth')
    local N     = 20
    local pts   = {}
    local d     = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
    local droop = math.min(d * 0.22, 60)
    for i = 0, N do
        local t = i / N
        pts[#pts + 1] = x1 + (x2 - x1) * t
        pts[#pts + 1] = y1 + (y2 - y1) * t + droop * math.sin(t * math.pi)
    end
    if #pts >= 4 then love.graphics.line(pts) end
end

local function draw_game()
    local g = Wormhole.ACME.wire_game
    if not g then return end

    g.layout     = calc_layout(g.wire_count)
    local lo     = g.layout
    local p      = lo.panel
    local S      = lo.S
    local tr     = lo.tr

    local sw, sh = love.graphics.getDimensions()

    love.graphics.setColor(UI.bg)
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    love.graphics.setColor(0, 0, 0, 0.35)
    love.graphics.rectangle('fill', p.x + 4 * S, p.y + 4 * S, p.w, p.h, 8 * S, 8 * S)
    love.graphics.setColor(UI.panel)
    love.graphics.rectangle('fill', p.x, p.y, p.w, p.h, 8 * S, 8 * S)
    love.graphics.setColor(UI.panel_hi)
    love.graphics.rectangle('fill', p.x + 3 * S, p.y + 3 * S, p.w - 6 * S, p.h - 6 * S, 6 * S, 6 * S)
    love.graphics.setColor(UI.border)
    love.graphics.setLineWidth(math.max(1, 2 * S))
    love.graphics.rectangle('line', p.x, p.y, p.w, p.h, 8 * S, 8 * S)

    for _, wl in ipairs({ lo.wall_left, lo.wall_right }) do
        love.graphics.setColor(UI.wall)
        love.graphics.rectangle('fill', wl.x, wl.y, wl.w, wl.h, wl.r, wl.r)
        love.graphics.setColor(UI.wall_brd)
        love.graphics.setLineWidth(math.max(1, 1.5 * S))
        love.graphics.rectangle('line', wl.x, wl.y, wl.w, wl.h, wl.r, wl.r)
    end

    center_text('Fix the Wires!', p.x + p.w / 2, p.y + 22 * S, 1.5 * S, UI.title)
    local done = 0
    for _ in pairs(g.connections) do done = done + 1 end
    center_text(done .. '/' .. g.wire_count, p.x + p.w / 2, p.y + 46 * S, 1.0 * S, UI.sub)

    for li, ri in pairs(g.connections) do
        local lp = lo.left[li]; local rp = lo.right[ri]
        local wid = g.left_order[li]; local c = WIRE_DATA[wid].color
        draw_wire(lp.x + tr, lp.y, rp.x - tr, rp.y, { 0, 0, 0, 0.35 }, 8 * S)
        draw_wire(lp.x + tr, lp.y, rp.x - tr, rp.y, c, 5 * S)
    end

    if g.dragging then
        local lp = lo.left[g.dragging]
        local mx, my = love.mouse.getPosition()
        local wid = g.left_order[g.dragging]; local c = WIRE_DATA[wid].color
        draw_wire(lp.x + tr, lp.y, mx, my, { 0, 0, 0, 0.30 }, 8 * S)
        draw_wire(lp.x + tr, lp.y, mx, my, c, 5 * S)
    end

    for i = 1, g.wire_count do
        local wid = g.left_order[i]
        local d   = WIRE_DATA[wid]
        local lp  = lo.left[i]
        local cl  = g.connections[i] ~= nil
        local la  = cl and 0.30 or 1

        love.graphics.setColor(d.color[1] * 0.55, d.color[2] * 0.55, d.color[3] * 0.55, la)
        love.graphics.rectangle('fill', lp.x + tr * 0.6, lp.y - 4 * S, tr * 0.7, 8 * S, 2 * S, 2 * S)
        if not cl then
            love.graphics.setColor(d.color[1], d.color[2], d.color[3], 0.12)
            love.graphics.circle('fill', lp.x, lp.y, tr + 6 * S)
        end
        love.graphics.setColor(d.color[1], d.color[2], d.color[3], la)
        love.graphics.circle('fill', lp.x, lp.y, tr)
        love.graphics.setColor(1, 1, 1, 0.6 * la)
        love.graphics.setLineWidth(math.max(1, 2 * S))
        love.graphics.circle('line', lp.x, lp.y, tr)
        center_text(d.label, lp.x, lp.y, 1.1 * S, { 1, 1, 1, la })

        local rd = WIRE_DATA[i]
        local rp = lo.right[i]
        local cr = false
        for _, ri in pairs(g.connections) do if ri == i then
                cr = true; break
            end end
        local ra = cr and 0.30 or 1

        love.graphics.setColor(rd.color[1] * 0.55, rd.color[2] * 0.55, rd.color[3] * 0.55, ra)
        love.graphics.rectangle('fill', rp.x - tr * 1.3, rp.y - 4 * S, tr * 0.7, 8 * S, 2 * S, 2 * S)
        if not cr then
            love.graphics.setColor(rd.color[1], rd.color[2], rd.color[3], 0.12)
            love.graphics.circle('fill', rp.x, rp.y, tr + 6 * S)
        end
        love.graphics.setColor(rd.color[1], rd.color[2], rd.color[3], ra)
        love.graphics.circle('fill', rp.x, rp.y, tr)
        love.graphics.setColor(1, 1, 1, 0.6 * ra)
        love.graphics.setLineWidth(math.max(1, 2 * S))
        love.graphics.circle('line', rp.x, rp.y, tr)
        center_text(rd.label, rp.x, rp.y, 1.1 * S, { 1, 1, 1, ra })
    end

    local b      = lo.btn
    local mx, my = love.mouse.getPosition()
    local hov    = mx >= b.x and mx <= b.x + b.w and my >= b.y and my <= b.y + b.h

    love.graphics.setColor(hov and UI.btn_hov or UI.btn)
    love.graphics.rectangle('fill', b.x, b.y, b.w, b.h, 5 * S, 5 * S)
    love.graphics.setColor(UI.btn_brd)
    love.graphics.setLineWidth(math.max(1, 1.5 * S))
    love.graphics.rectangle('line', b.x, b.y, b.w, b.h, 5 * S, 5 * S)
    center_text('Give Up', b.x + b.w / 2, b.y + b.h / 2, 0.9 * S, UI.white)
end

local function hit_circle(mx, my, cx, cy, r)
    return (mx - cx) ^ 2 + (my - cy) ^ 2 <= (r + 8) ^ 2
end

local function hit_rect(mx, my, r)
    return mx >= r.x and mx <= r.x + r.w and my >= r.y and my <= r.y + r.h
end

local function close_wire_game()
    Wormhole.ACME.wire_game = nil
end

local function check_completion()
    local g = Wormhole.ACME.wire_game
    if not g then return end
    local n = 0
    for _ in pairs(g.connections) do n = n + 1 end
    if n < g.wire_count then return end

    g.completed = true
    local card = g.card
    if card then
        card.ability.extra.last_ante_used = G.GAME.round_resets.ante
        card.ability.extra.completed = true
        card.ability.extra.times_completed = (card.ability.extra.times_completed or 0) + 1
        card.ability.extra.x_mult = math.min(1.2 + (card.ability.extra.times_completed - 1) * 0.1, 1.6)
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.55,
        func = function()
            play_sound('timpani')
            if card then card:juice_up(0.8, 0.5) end
            close_wire_game()
            if card then
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_acme_wires_complete'),
                    colour = G.C.MULT,
                })
            end
            return true
        end,
    }))
end

local function install_hooks()
    if Wormhole.ACME._pb_hooks then return end

    local _draw = love.draw
    love.draw = function()
        _draw()
        if Wormhole.ACME.wire_game then
            love.graphics.push('all')
            love.graphics.origin()
            draw_game()
            love.graphics.pop()
        end
    end

    local _mp = love.mousepressed
    love.mousepressed = function(x, y, btn, ...)
        local g = Wormhole.ACME.wire_game
        if g and btn == 1 then
            local lo = g.layout
            if not lo then
                if _mp then _mp(x, y, btn, ...) end; return
            end
            for i = 1, g.wire_count do
                if not g.connections[i] and hit_circle(x, y, lo.left[i].x, lo.left[i].y, lo.tr) then
                    g.dragging = i
                    play_sound('cardSlide1')
                    return
                end
            end
            if hit_rect(x, y, lo.btn) then
                close_wire_game()
                return
            end
            return
        end
        if _mp then _mp(x, y, btn, ...) end
    end

    local _mr = love.mousereleased
    love.mousereleased = function(x, y, btn, ...)
        local g = Wormhole.ACME.wire_game
        if g and btn == 1 and g.dragging then
            local lo = g.layout
            if lo then
                for i = 1, g.wire_count do
                    if hit_circle(x, y, lo.right[i].x, lo.right[i].y, lo.tr) then
                        if g.left_order[g.dragging] == i then
                            g.connections[g.dragging] = i
                            play_sound('card1', 1.0 + i * 0.08)
                            check_completion()
                        else
                            play_sound('cancel')
                        end
                        break
                    end
                end
            end
            g.dragging = nil
            return
        end
        if _mr then _mr(x, y, btn, ...) end
    end

    Wormhole.ACME._pb_hooks = true
end

local function open_wire_game(card)
    install_hooks()
    local times = card.ability.extra.times_completed or 0
    local wc = math.min(4 + times, 8)

    local order = {}
    for i = 1, wc do order[i] = i end
    for i = wc, 2, -1 do
        local j = math.random(i)
        order[i], order[j] = order[j], order[i]
    end

    Wormhole.ACME.wire_game = {
        card        = card,
        wire_count  = wc,
        left_order  = order,
        connections = {},
        dragging    = nil,
        completed   = false,
        layout      = calc_layout(wc),
    }
end

SMODS.Consumable {
    key = 'acme_power_box',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    ppu_coder = { 'basil_squared' },
    ppu_artist = { 'RadiationV2' },
    keep_on_use = function(self, card)
        return true
    end,
    config = {
        extra = {
            x_mult = 1.2,
            last_ante_used = 0,
            completed = false,
            times_completed = 0,
        }
    },
    loc_vars = function(self, info_queue, card)
        local wires = math.min(4 + (card.ability.extra.times_completed or 0), 8)
        return { vars = { card.ability.extra.x_mult, wires } }
    end,
    can_use = function(self, card)
        return G.GAME and G.GAME.round_resets
            and card.ability.extra.last_ante_used ~= G.GAME.round_resets.ante
    end,
    use = function(self, card, area, copier)
        local used = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used:juice_up(0.3, 0.5)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                open_wire_game(card)
                return true
            end,
        }))
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.completed then
            return {
                Xmult_mod = card.ability.extra.x_mult,
                message = 'X' .. card.ability.extra.x_mult,
                colour = G.C.MULT,
            }
        end
        if context.end_of_round and not context.repetition then
            if G.GAME.round_resets.ante ~= card.ability.extra.last_ante_used then
                card.ability.extra.completed = false
            end
        end
    end,
}
