Wormhole.ACME = Wormhole.ACME or {}


-- colors n stuff

local UI = {
    bg          = { 0.05, 0.03, 0.03, 0.85 },
    panel       = { 0.12, 0.08, 0.08, 1 },
    panel_hi    = { 0.16, 0.10, 0.10, 1 },
    border      = { 0.45, 0.20, 0.12, 1 },
    maze_wall   = { 0.38, 0.15, 0.10, 1 },
    maze_floor  = { 0.08, 0.06, 0.05, 1 },
    maze_fuse   = { 1.00, 0.60, 0.10, 1 },
    maze_glow   = { 1.00, 0.40, 0.05, 0.35 },
    maze_start  = { 0.25, 0.90, 0.35, 1 },
    maze_end    = { 0.95, 0.22, 0.22, 1 },
    lo_on       = { 1.00, 0.85, 0.10, 1 },
    lo_off      = { 0.12, 0.10, 0.08, 1 },
    lo_grid     = { 0.55, 0.42, 0.15, 1 },
    cord_handle = { 0.65, 0.28, 0.12, 1 },
    cord_rope   = { 0.50, 0.38, 0.28, 1 },
    timer_bg    = { 0.18, 0.10, 0.08, 1 },
    timer_ok    = { 0.20, 0.80, 0.35, 1 },
    timer_warn  = { 1.00, 0.75, 0.10, 1 },
    timer_crit  = { 1.00, 0.18, 0.10, 1 },
    title       = { 1.00, 0.78, 0.12, 1 },
    sub         = { 0.65, 0.52, 0.40, 1 },
    white       = { 1, 1, 1, 1 },
    btn         = { 0.50, 0.15, 0.10, 1 },
    btn_hov     = { 0.72, 0.22, 0.15, 1 },
    btn_brd     = { 0.68, 0.30, 0.20, 1 },
}


-- lil helpers

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

local function hit_rect(mx, my, r)
    return mx >= r.x and mx <= r.x + r.w and my >= r.y and my <= r.y + r.h
end

local function lerp(a, b, t) return a + (b - a) * t end
local function ease_out(t) return 1 - (1 - t) ^ 3 end


-- making the maze (dfs backtracker)

local function generate_maze(cols, rows)
    local grid = {}
    for r = 1, rows do
        grid[r] = {}
        for c = 1, cols do
            grid[r][c] = { n = true, s = true, e = true, w = true }
        end
    end
    local vis = {}
    for r = 1, rows do
        vis[r] = {}; for c = 1, cols do vis[r][c] = false end
    end

    local stack = {}
    local cr, cc = 1, 1
    vis[1][1] = true
    local count = 1
    local total = cols * rows
    while count < total do
        local nb = {}
        if cr > 1 and not vis[cr - 1][cc] then nb[#nb + 1] = { r = cr - 1, c = cc, d = 'n', o = 's' } end
        if cr < rows and not vis[cr + 1][cc] then nb[#nb + 1] = { r = cr + 1, c = cc, d = 's', o = 'n' } end
        if cc > 1 and not vis[cr][cc - 1] then nb[#nb + 1] = { r = cr, c = cc - 1, d = 'w', o = 'e' } end
        if cc < cols and not vis[cr][cc + 1] then nb[#nb + 1] = { r = cr, c = cc + 1, d = 'e', o = 'w' } end
        if #nb > 0 then
            local ch = nb[math.random(#nb)]
            stack[#stack + 1] = { r = cr, c = cc }
            grid[cr][cc][ch.d] = false
            grid[ch.r][ch.c][ch.o] = false
            cr, cc = ch.r, ch.c
            vis[cr][cc] = true
            count = count + 1
        else
            local top = table.remove(stack)
            cr, cc = top.r, top.c
        end
    end
    return grid
end


-- making lights out (always solvable)

local function generate_lights_out(size, num_toggles)
    local grid = {}
    for r = 1, size do
        grid[r] = {}; for c = 1, size do grid[r][c] = false end
    end

    local function toggle(r, c)
        grid[r][c] = not grid[r][c]
        if r > 1 then grid[r - 1][c] = not grid[r - 1][c] end
        if r < size then grid[r + 1][c] = not grid[r + 1][c] end
        if c > 1 then grid[r][c - 1] = not grid[r][c - 1] end
        if c < size then grid[r][c + 1] = not grid[r][c + 1] end
    end

    for _ = 1, num_toggles do toggle(math.random(size), math.random(size)) end

    local any = false
    for r = 1, size do for c = 1, size do if grid[r][c] then any = true end end end
    if not any then toggle(math.random(size), math.random(size)) end

    return grid, toggle
end


-- path helpers

local function can_move(grid, r1, c1, r2, c2)
    if math.abs(r1 - r2) + math.abs(c1 - c2) ~= 1 then return false end
    if r2 < r1 then return not grid[r1][c1].n end
    if r2 > r1 then return not grid[r1][c1].s end
    if c2 < c1 then return not grid[r1][c1].w end
    if c2 > c1 then return not grid[r1][c1].e end
    return false
end

local function mouse_to_cell(mx, my, mr)
    if not mr then return nil, nil end
    local c = math.floor((mx - mr.x) / mr.cell) + 1
    local r = math.floor((my - mr.y) / mr.cell) + 1
    if c >= 1 and c <= mr.cols and r >= 1 and r <= mr.rows then return r, c end
    return nil, nil
end

local start_transition -- forward declaration

local function try_extend_path(g, r, c)
    if not r or not c then return end
    local path = g.maze_path
    local last = path[#path]
    if last.r == r and last.c == c then return end

    -- undo path
    for i = #path - 1, 1, -1 do
        if path[i].r == r and path[i].c == c then
            for j = #path, i + 1, -1 do table.remove(path, j) end
            return
        end
    end

    -- make line bigger
    if can_move(g.maze_grid, last.r, last.c, r, c) then
        path[#path + 1] = { r = r, c = c }
        play_sound('cardSlide1', 0.7 + #path * 0.015)
        if r == g.maze_rows and c == g.maze_cols then
            start_transition(g, 2)
        end
    end
end


-- trans. and timing
-- :transgender_flag:

local PHASE_TITLES = { 'Thread the Fuse!', 'Cut the Power!', 'Pull to Ignite!' }
local PHASE_SUBS   = { 'Drag through the maze', 'Turn all lights off', 'Drag the cord!' }

local function get_time_limit(g, phase)
    local t = g.times_completed or 0
    if phase == 1 then return math.max(15, 25 - t * 2) end
    if phase == 2 then return math.max(12, 20 - t * 1.5) end
    if phase == 3 then return math.max(5, 8 - t * 0.5) end
    return 20
end

start_transition = function(g, to_phase)
    if g.transitioning then return end
    g.transitioning = {
        from = g.phase,
        to = to_phase,
        start = love.timer.getTime(),
        dur = 0.5,
    }

    if to_phase == 2 then
        local size = math.min(3 + (g.times_completed or 0), 5)
        local toggles = size == 3 and 5 or (size == 4 and 8 or 12)
        g.lo_size = size
        g.lo_grid = generate_lights_out(size, toggles)
    elseif to_phase == 3 then
        g.cord_pull = 0
        g.cord_dragging = false
    end

    play_sound('card1', 1.0 + to_phase * 0.1)
end

local function finish_transition(g)
    local tr = g.transitioning
    g.phase = tr.to
    g.phase_start = love.timer.getTime()
    g.transitioning = nil
end


-- handling the closing of the game

local function close_bomb_game(success)
    local g = Wormhole.ACME.bomb_game
    if not g then return end
    local card = g.card

    Wormhole.ACME.bomb_game = nil

    if success then
        card.ability.extra.last_ante_used = G.GAME.round_resets.ante
        card.ability.extra.completed = true
        card.ability.extra.times_completed = (card.ability.extra.times_completed or 0) + 1
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                play_sound('timpani')
                card:juice_up(0.8, 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_acme_bombs_complete'),
                    colour = G.C.RED,
                })
                return true
            end,
        }))
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('cancel')
                card:start_dissolve()
                return true
            end,
        }))
    end
end


-- drawing UI

local function calc_panel(offset)
    local sw, sh = love.graphics.getDimensions()
    local S      = sh / 1080
    local pw     = math.floor(420 * S)
    local ph     = math.floor(520 * S)
    local px     = math.floor((sw - pw) / 2) + (offset or 0)
    local py     = math.floor((sh - ph) / 2)
    return {
        S = S,
        sw = sw,
        sh = sh,
        panel = { x = px, y = py, w = pw, h = ph },
        btn = {
            x = px + (pw - math.floor(100 * S)) / 2,
            y = py + ph - math.floor(38 * S),
            w = math.floor(100 * S),
            h = math.floor(26 * S),
        },
    }
end

local function draw_chrome(lo, title, sub)
    local p, S = lo.panel, lo.S
    love.graphics.setColor(0, 0, 0, 0.35)
    love.graphics.rectangle('fill', p.x + 4 * S, p.y + 4 * S, p.w, p.h, 8 * S, 8 * S)
    love.graphics.setColor(UI.panel)
    love.graphics.rectangle('fill', p.x, p.y, p.w, p.h, 8 * S, 8 * S)
    love.graphics.setColor(UI.panel_hi)
    love.graphics.rectangle('fill', p.x + 3 * S, p.y + 3 * S, p.w - 6 * S, p.h - 6 * S, 6 * S, 6 * S)
    love.graphics.setColor(UI.border)
    love.graphics.setLineWidth(math.max(1, 2 * S))
    love.graphics.rectangle('line', p.x, p.y, p.w, p.h, 8 * S, 8 * S)
    if title then center_text(title, p.x + p.w / 2, p.y + 22 * S, 1.4 * S, UI.title) end
    if sub then center_text(sub, p.x + p.w / 2, p.y + 44 * S, 0.85 * S, UI.sub) end
end

local function draw_timer_bar(lo, frac)
    local p, S = lo.panel, lo.S
    local bw = p.w - 40 * S
    local bh = 10 * S
    local bx = p.x + 20 * S
    local by = p.y + p.h - 55 * S
    love.graphics.setColor(UI.timer_bg)
    love.graphics.rectangle('fill', bx, by, bw, bh, 3 * S, 3 * S)
    local col = frac > 0.5 and UI.timer_ok or (frac > 0.2 and UI.timer_warn or UI.timer_crit)
    love.graphics.setColor(col)
    love.graphics.rectangle('fill', bx, by, bw * frac, bh, 3 * S, 3 * S)
    love.graphics.setColor(UI.border)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('line', bx, by, bw, bh, 3 * S, 3 * S)
end

local function draw_give_up(lo)
    local b = lo.btn
    local mx, my = love.mouse.getPosition()
    local hov = hit_rect(mx, my, b)
    love.graphics.setColor(hov and UI.btn_hov or UI.btn)
    love.graphics.rectangle('fill', b.x, b.y, b.w, b.h, 5 * lo.S, 5 * lo.S)
    love.graphics.setColor(UI.btn_brd)
    love.graphics.setLineWidth(math.max(1, 1.5 * lo.S))
    love.graphics.rectangle('line', b.x, b.y, b.w, b.h, 5 * lo.S, 5 * lo.S)
    center_text('Give Up', b.x + b.w / 2, b.y + b.h / 2, 0.85 * lo.S, UI.white)
end


-- maze

local function draw_maze_phase(g, offset)
    local lo = calc_panel(offset)
    local p, S = lo.panel, lo.S
    draw_chrome(lo, PHASE_TITLES[1], PHASE_SUBS[1])

    local margin = 20 * S
    local hdr = 60 * S
    local ftr = 65 * S
    local aw = p.w - margin * 2
    local ah = p.h - hdr - ftr
    local cs = math.floor(math.min(aw / g.maze_cols, ah / g.maze_rows))
    local mw = cs * g.maze_cols
    local mh = cs * g.maze_rows
    local mx = p.x + (p.w - mw) / 2
    local my = p.y + hdr + (ah - mh) / 2

    g.maze_render = { x = mx, y = my, cell = cs, cols = g.maze_cols, rows = g.maze_rows, lo = lo }

    -- floor
    love.graphics.setColor(UI.maze_floor)
    love.graphics.rectangle('fill', mx, my, mw, mh)

    -- start n end
    love.graphics.setColor(UI.maze_start[1], UI.maze_start[2], UI.maze_start[3], 0.3)
    love.graphics.rectangle('fill', mx, my, cs, cs)
    love.graphics.setColor(UI.maze_end[1], UI.maze_end[2], UI.maze_end[3], 0.3)
    love.graphics.rectangle('fill', mx + (g.maze_cols - 1) * cs, my + (g.maze_rows - 1) * cs, cs, cs)

    -- the fuse
    if #g.maze_path > 1 then
        for pass = 1, 2 do
            for i = 1, #g.maze_path - 1 do
                local a, b = g.maze_path[i], g.maze_path[i + 1]
                local ax = mx + (a.c - 0.5) * cs
                local ay = my + (a.r - 0.5) * cs
                local bx = mx + (b.c - 0.5) * cs
                local by = my + (b.r - 0.5) * cs
                if pass == 1 then
                    love.graphics.setColor(UI.maze_glow)
                    love.graphics.setLineWidth(cs * 0.5)
                else
                    love.graphics.setColor(UI.maze_fuse)
                    love.graphics.setLineWidth(cs * 0.22)
                end
                love.graphics.line(ax, ay, bx, by)
            end
        end
    end
    -- end of fuse
    local last = g.maze_path[#g.maze_path]
    love.graphics.setColor(UI.maze_fuse)
    love.graphics.circle('fill', mx + (last.c - 0.5) * cs, my + (last.r - 0.5) * cs, cs * 0.18)

    -- walls
    love.graphics.setColor(UI.maze_wall)
    love.graphics.setLineWidth(math.max(2, 3 * S))
    local grid = g.maze_grid
    for r = 1, g.maze_rows do
        for c = 1, g.maze_cols do
            local cx = mx + (c - 1) * cs
            local cy = my + (r - 1) * cs
            if grid[r][c].n then love.graphics.line(cx, cy, cx + cs, cy) end
            if grid[r][c].w then love.graphics.line(cx, cy, cx, cy + cs) end
            if c == g.maze_cols and grid[r][c].e then love.graphics.line(cx + cs, cy, cx + cs, cy + cs) end
            if r == g.maze_rows and grid[r][c].s then love.graphics.line(cx, cy + cs, cx + cs, cy + cs) end
        end
    end

    -- tick tock
    local elapsed = love.timer.getTime() - g.phase_start
    local limit = get_time_limit(g, 1)
    draw_timer_bar(lo, math.max(0, 1 - elapsed / limit))
    draw_give_up(lo)
end


-- lights out

local function draw_lights_phase(g, offset)
    local lo = calc_panel(offset)
    local p, S = lo.panel, lo.S
    draw_chrome(lo, PHASE_TITLES[2], PHASE_SUBS[2])

    local size = g.lo_size
    local margin = 40 * S
    local hdr = 60 * S
    local ftr = 65 * S
    local aw = p.w - margin * 2
    local ah = p.h - hdr - ftr
    local cs = math.floor(math.min(aw / size, ah / size))
    local gw = cs * size
    local gh = cs * size
    local gx = p.x + (p.w - gw) / 2
    local gy = p.y + hdr + (ah - gh) / 2

    g.lo_render = { x = gx, y = gy, cell = cs, size = size, lo = lo }

    for r = 1, size do
        for c = 1, size do
            local cx = gx + (c - 1) * cs
            local cy = gy + (r - 1) * cs
            local on = g.lo_grid[r][c]
            love.graphics.setColor(on and UI.lo_on or UI.lo_off)
            love.graphics.rectangle('fill', cx + 2 * S, cy + 2 * S, cs - 4 * S, cs - 4 * S, 4 * S, 4 * S)
            love.graphics.setColor(UI.lo_grid)
            love.graphics.setLineWidth(math.max(1, 1.5 * S))
            love.graphics.rectangle('line', cx + 2 * S, cy + 2 * S, cs - 4 * S, cs - 4 * S, 4 * S, 4 * S)
        end
    end

    local elapsed = love.timer.getTime() - g.phase_start
    local limit = get_time_limit(g, 2)
    draw_timer_bar(lo, math.max(0, 1 - elapsed / limit))
    draw_give_up(lo)
end


-- ripcord. beyblade ahh

local function draw_pullcord_phase(g, offset)
    local lo = calc_panel(offset)
    local p, S = lo.panel, lo.S
    draw_chrome(lo, PHASE_TITLES[3], PHASE_SUBS[3])

    local hdr = 60 * S
    local ftr = 65 * S
    local cy = p.y + hdr + (p.h - hdr - ftr) / 2

    -- rope
    local cord_x1 = p.x + 60 * S
    local cord_x2 = p.x + p.w - 80 * S + (g.cord_pull or 0)
    love.graphics.setColor(UI.cord_rope)
    love.graphics.setLineWidth(math.max(3, 5 * S))
    love.graphics.line(cord_x1, cy, cord_x2, cy)

    -- box
    love.graphics.setColor(UI.maze_wall)
    love.graphics.rectangle('fill', cord_x1 - 30 * S, cy - 25 * S, 40 * S, 50 * S, 4 * S, 4 * S)
    love.graphics.setColor(UI.border)
    love.graphics.setLineWidth(math.max(1, 2 * S))
    love.graphics.rectangle('line', cord_x1 - 30 * S, cy - 25 * S, 40 * S, 50 * S, 4 * S, 4 * S)

    -- handle
    local hx = cord_x2
    local hw = 18 * S
    local hh = 40 * S
    love.graphics.setColor(UI.cord_handle)
    love.graphics.rectangle('fill', hx - hw / 2, cy - hh / 2, hw, hh, 4 * S, 4 * S)
    love.graphics.setColor(UI.border)
    love.graphics.rectangle('line', hx - hw / 2, cy - hh / 2, hw, hh, 4 * S, 4 * S)

    g.cord_render = {
        handle = { x = hx - hw / 2, y = cy - hh / 2, w = hw, h = hh },
        base_x2 = p.x + p.w - 80 * S,
        threshold = 180 * S,
        lo = lo,
    }

    -- pull bar
    local pull_frac = math.min(1, math.abs(g.cord_pull or 0) / (g.cord_render.threshold))
    if pull_frac > 0 then
        local bar_w = 120 * S
        local bar_h = 8 * S
        local bar_x = p.x + (p.w - bar_w) / 2
        local bar_y = cy + 60 * S
        love.graphics.setColor(UI.timer_bg)
        love.graphics.rectangle('fill', bar_x, bar_y, bar_w, bar_h, 3 * S, 3 * S)
        local col = pull_frac < 0.8 and UI.timer_warn or UI.timer_ok
        love.graphics.setColor(col)
        love.graphics.rectangle('fill', bar_x, bar_y, bar_w * pull_frac, bar_h, 3 * S, 3 * S)
        love.graphics.setColor(UI.border)
        love.graphics.rectangle('line', bar_x, bar_y, bar_w, bar_h, 3 * S, 3 * S)
    end

    local elapsed = love.timer.getTime() - g.phase_start
    local limit = get_time_limit(g, 3)
    draw_timer_bar(lo, math.max(0, 1 - elapsed / limit))
    draw_give_up(lo)
end


-- the big cheese

local function draw_game()
    local g = Wormhole.ACME.bomb_game
    if not g then return end

    local sw, sh = love.graphics.getDimensions()
    local S = sh / 1080
    local pw = math.floor(420 * S)

    love.graphics.setColor(UI.bg)
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    -- time out
    if not g.transitioning then
        local elapsed = love.timer.getTime() - g.phase_start
        local limit = get_time_limit(g, g.phase)
        if elapsed >= limit then
            close_bomb_game(false)
            return
        end
    end

    -- animations
    if g.transitioning then
        local tr      = g.transitioning
        local t       = math.min(1, (love.timer.getTime() - tr.start) / tr.dur)
        local e       = ease_out(t)
        local off_out = -pw * 1.2 * e
        local off_in  = pw * 1.2 * (1 - e)

        if tr.from == 1 then draw_maze_phase(g, off_out) end
        if tr.from == 2 then draw_lights_phase(g, off_out) end
        if tr.to == 2 then draw_lights_phase(g, off_in) end
        if tr.to == 3 then draw_pullcord_phase(g, off_in) end

        if t >= 1 then finish_transition(g) end
        return
    end

    if g.phase == 1 then draw_maze_phase(g, 0) end
    if g.phase == 2 then draw_lights_phase(g, 0) end
    if g.phase == 3 then draw_pullcord_phase(g, 0) end
end


-- inputs

local function on_pressed(x, y, btn)
    local g = Wormhole.ACME.bomb_game
    if not g or btn ~= 1 or g.transitioning then return false end

    -- debounce double clicks from opening the game
    if love.timer.getTime() - g.phase_start < 0.25 then return true end

    -- give up logic
    local lo
    if g.phase == 1 and g.maze_render then
        lo = g.maze_render.lo
    elseif g.phase == 2 and g.lo_render then
        lo = g.lo_render.lo
    elseif g.phase == 3 and g.cord_render then
        lo = g.cord_render.lo
    end
    if lo and hit_rect(x, y, lo.btn) then
        close_bomb_game(false)
        return true
    end

    if g.phase == 1 then
        local r, c = mouse_to_cell(x, y, g.maze_render)
        if r then
            g.maze_dragging = true
            try_extend_path(g, r, c)
        end
        return true
    end

    if g.phase == 2 and g.lo_render then
        local lr = g.lo_render
        local gc = math.floor((x - lr.x) / lr.cell) + 1
        local gr = math.floor((y - lr.y) / lr.cell) + 1
        if gc >= 1 and gc <= lr.size and gr >= 1 and gr <= lr.size then
            -- toggle lights
            local grid = g.lo_grid
            local sz = g.lo_size
            grid[gr][gc] = not grid[gr][gc]
            if gr > 1 then grid[gr - 1][gc] = not grid[gr - 1][gc] end
            if gr < sz then grid[gr + 1][gc] = not grid[gr + 1][gc] end
            if gc > 1 then grid[gr][gc - 1] = not grid[gr][gc - 1] end
            if gc < sz then grid[gr][gc + 1] = not grid[gr][gc + 1] end
            play_sound('button', 0.9 + math.random() * 0.2)

            -- check if done
            local solved = true
            for rr = 1, sz do
                for cc = 1, sz do
                    if grid[rr][cc] then solved = false end
                end
            end
            if solved then start_transition(g, 3) end
        end
        return true
    end

    if g.phase == 3 and g.cord_render then
        local h = g.cord_render.handle
        if x >= h.x - 20 and x <= h.x + h.w + 20 and y >= h.y - 20 and y <= h.y + h.h + 20 then
            g.cord_dragging = true
            g.cord_drag_start_x = x
        end
        return true
    end

    return true
end

local function on_moved(x, y)
    local g = Wormhole.ACME.bomb_game
    if not g or g.transitioning then return end

    if g.phase == 1 and g.maze_dragging then
        local r, c = mouse_to_cell(x, y, g.maze_render)
        try_extend_path(g, r, c)
    end

    if g.phase == 3 and g.cord_dragging then
        local pull = math.max(0, x - g.cord_drag_start_x)
        g.cord_pull = pull
        if pull >= g.cord_render.threshold then
            g.cord_dragging = false
            play_sound('timpani')
            close_bomb_game(true)
        end
    end
end

local function on_released(x, y, btn)
    local g = Wormhole.ACME.bomb_game
    if not g or btn ~= 1 then return end

    if g.phase == 1 then g.maze_dragging = false end

    if g.phase == 3 and g.cord_dragging then
        g.cord_dragging = false
        -- snap back to reality
        g.cord_pull = 0
        play_sound('cancel')
    end
end


-- hooks

local function install_hooks()
    if Wormhole.ACME._bomb_hooks then return end

    local _draw = love.draw
    love.draw = function()
        _draw()
        if Wormhole.ACME.bomb_game then
            love.graphics.push('all')
            love.graphics.origin()
            draw_game()
            love.graphics.pop()
        end
    end

    local _mp = love.mousepressed
    love.mousepressed = function(x, y, btn, ...)
        if Wormhole.ACME.bomb_game then
            on_pressed(x, y, btn)
            return
        end
        if _mp then _mp(x, y, btn, ...) end
    end

    local _mr = love.mousereleased
    love.mousereleased = function(x, y, btn, ...)
        if Wormhole.ACME.bomb_game then
            on_released(x, y, btn)
            return
        end
        if _mr then _mr(x, y, btn, ...) end
    end

    local _mm = love.mousemoved
    love.mousemoved = function(x, y, dx, dy, ...)
        if Wormhole.ACME.bomb_game then
            on_moved(x, y)
            return
        end
        if _mm then _mm(x, y, dx, dy, ...) end
    end

    Wormhole.ACME._bomb_hooks = true
end


-- minigame opening

local function open_bomb_game(card)
    install_hooks()
    local times = card.ability.extra.times_completed or 0
    local cols = math.min(5 + times, 9)
    local rows = cols

    Wormhole.ACME.bomb_game = {
        card            = card,
        phase           = 1,
        phase_start     = love.timer.getTime(),
        transitioning   = nil,
        times_completed = times,
        -- maze
        maze_cols       = cols,
        maze_rows       = rows,
        maze_grid       = generate_maze(cols, rows),
        maze_path       = { { r = 1, c = 1 } },
        maze_dragging   = false,
        maze_render     = nil,
        -- Phase 2: Lights Out (initialized on transition)
        lo_size         = nil,
        lo_grid         = nil,
        lo_render       = nil,
        -- Phase 3: Pullcord (initialized on transition)
        cord_pull       = 0,
        cord_dragging   = false,
        cord_render     = nil,
    }
end


-- the card itself

SMODS.Consumable {
    key = 'acme_bombs',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = { x = 7, y = 0 },
    soul_pos = { x = 7, y = 1 },
    ppu_coder = { 'Basil_Squared' },
    ppu_artist = { 'RadiationV2' },
    keep_on_use = function(self, card)
        return true
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if initial then
            card.ability.extra = {
                last_ante_used = 0,
                completed = false,
                effect_used = false,
                times_completed = 0,
            }
        end
    end,
    config = {
        extra = {
            last_ante_used = 0,
            completed = false,
            effect_used = false,
            times_completed = 0,
        }
    },
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        local ante = G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante or 0
        if e.completed and e.last_ante_used == ante and not e.effect_used then
            return { key = self.key .. '_alt' }
        else
            return { vars = {} }
        end
    end,
    can_use = function(self, card)
        if not G.GAME or not G.GAME.round_resets then return false end
        local e = card.ability.extra
        local ante = G.GAME.round_resets.ante

        if e.completed and e.last_ante_used == ante and not e.effect_used then
            return G.hand and #G.hand.highlighted == 5
        else
            return e.last_ante_used ~= ante
        end
    end,
    use = function(self, card, area, copier)
        local e = card.ability.extra
        local ante = G.GAME.round_resets.ante

        if e.completed and e.last_ante_used == ante and not e.effect_used then
            -- kaboom
            e.effect_used = true
            local destroyed = {}
            for i = 1, #G.hand.highlighted do
                destroyed[#destroyed + 1] = G.hand.highlighted[i]
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end,
            }))

            for i = 1, #destroyed do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.12,
                    func = function()
                        play_sound('card1', 0.75 + i * 0.05)
                        destroyed[i]:start_dissolve(nil, true)
                        return true
                    end,
                }))
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_acme_bombs_complete'),
                        colour = G.C.RED,
                    })
                    return true
                end,
            }))
        else
            -- open minigame
            e.completed = false
            e.effect_used = false
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    open_bomb_game(card)
                    return true
                end,
            }))
        end
    end,
    calculate = function(self, card, context)
        -- no scoring here
    end,
}
