Wormhole.LancerFanClub.piss_info = {
    current = {
        urine = {
            value = 50
        },
        wasteWater = {
            value = 50
        },
        cleanWater = {
            value = 50
        },
    }
}
local currentvalues = Wormhole.LancerFanClub.piss_info.current

local json = require("json")
local https = require("SMODS.https")
local last_piss_ping

local function process_piss_info(...)
    print(...)
    local ret = ({ ... })
    if ret[1] == 200 then
        Wormhole.LancerFanClub.piss_info = json.decode(ret[2])
    end
end

function Wormhole.LancerFanClub.get_piss()
    if last_piss_ping and ((G.TIMERS.REAL - last_piss_ping) > 10) then
        last_piss_ping = G.TIMERS.REAL
        https.asyncRequest("https://api.peeonauts.com/live", process_piss_info)
    end
end

G.E_MANAGER:add_event(Event({
    func = function()
        Wormhole.LancerFanClub.get_piss()
        return true
    end
}))

SMODS.Joker {
    key = "lfc_pissstream",
    atlas = "lfc_jokers",
    pos = { x = 0, y = 0 },

    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    demicoloncompat = true,

    config = {
        extra = {
            water = 1,
            shit = 0.25,
            piss = 0.1,
        }
    },
    attributes = {
        "economy",
        "mult",
        "chips",
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.water,
                card.ability.extra.shit,
                card.ability.extra.piss,
                math.ceil(card.ability.extra.water * currentvalues.cleanWater.value),
                math.ceil(card.ability.extra.shit * currentvalues.wasteWater.value),
                math.ceil(card.ability.extra.piss * currentvalues.urine.value)
            },
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = math.ceil(card.ability.extra.shit * currentvalues.wasteWater.value),
                chips = math.ceil(card.ability.extra.water * currentvalues.cleanWater.value)
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return math.ceil(card.ability.extra.piss * currentvalues.urine.value)
    end,

    set_ability = function(self, card, initial, delay_sprites)
        Wormhole.LancerFanClub.get_piss()
    end,

    ppu_coder = { "InvalidOS", "ellestuff." }
}

-- Elle moment
local shader = love.graphics.newShader([[
uniform vec2 dims;
uniform float fac;
uniform vec3 palette[4];
uniform sampler2D bubbles;
uniform float time;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
	float progress = clamp(fac,0.,1.);
	bool flowEdge = !(floor(progress+.5)!=progress);
	
	vec4 c = vec4(1.);
	
	float waveA = sin(texture_coords.x*2.+time*progress*5.)/40.; // Flowing at edge of bar
	
	float waveB = sin(texture_coords.y*4.+time*progress*-4.)/10.+.5; // Health bar flowing
	
	float waveC = sin(texture_coords.x*.5+time*progress)/60.; // Bubble texture X offset
	
	
	waveA = flowEdge ? 0. : waveA; // Only flow if HP isn't full/empty
	waveB = waveB+texture_coords.y*2.;
	
	waveB = waveB>2. ? 2.-(waveB-2.)*1.5 : waveB;
	
	waveB += float(texture_coords.y<(1-progress+waveA+1./dims.y) && !flowEdge)*.75;
	
	vec2 bubbleTexCoord = texture_coords*dims/128.;
	bubbleTexCoord += vec2(waveC+.2,time*progress/11.-floor(time*progress/11.));
	bubbleTexCoord -= floor(bubbleTexCoord); // Like modulo, but better :3
	
	float bubbleTex = texture2D( bubbles, bubbleTexCoord ).x*.5;
	waveB = clamp(waveB-bubbleTex, 0.,3.);
	
	vec3 fac = mix(palette[int(floor(waveB))],palette[int(ceil(waveB))],waveB-floor(waveB));
	
	if ( texture_coords.y>(1-progress+waveA) ) { return vec4(fac,c.a); } else { discard; }
}]]) --SMODS.current_mod.path .. "assets/shaders/shader.fs" ) -- Gives me more control than SMODS.Shader

local barsprite = love.graphics.newImage(love.image.newImageData(1,1)) -- Turns out rectangles don't work for uv stuff so i'm doing this
local bubblesprite = love.graphics.newImage(love.image.newImageData(SMODS.NFS.newFileData(SMODS.current_mod.path .. "assets/lancer_fan_club/bubbles.png")))
shader:send("bubbles", bubblesprite)

local function draw_piss_bar(fac, x, y, w, h, colours, back)
    local back = back or false
    local old_shader = love.graphics.getShader()


    shader:sendColor("palette", colours[1], colours[2], colours[3], colours[4])

    shader:send("fac", fac)
    shader:send("dims", { w, h })
    shader:send("time", G.TIMERS.REAL)

    if back then
        local c = HEX("4f6367")
        love.graphics.setColor(c[1],c[2],c[3])
        love.graphics.rectangle("fill", x, y, w, h)
    end

    love.graphics.setShader(shader)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(barsprite, x, y, 0, w, h)

    love.graphics.setShader(old_shader)
end

local bar_palettes = {
    piss = { HEX("fff39a"), HEX("f5d15a"), HEX("eca94e"), HEX("dc8c40") }
}

local function piss_draw(card)
    love.graphics.clear()

    draw_piss_bar(currentvalues.urine.value/100, 10, 10, 40, 40, bar_palettes.piss)
end

SMODS.DrawStep {
    key = 'pisscanvas',
    order = 100,
    func = function(self, layer)
        -- Copied this from my Wordle Joker lol
        if self.config.center.key == "j_worm_lfc_pissstream" and not Wormhole.LFC_Util.card_obscured(self) then
            if not self.pisscanvas then
                self.pisscanvas = SMODS.CanvasSprite({
                    canvasScale = 1
                })
            end

            local c = love.graphics.getCanvas()

            love.graphics.push()
            love.graphics.origin()
            self.pisscanvas.canvas:renderTo(function() piss_draw(self) end)
            love.graphics.pop()

            self.pisscanvas.role.draw_major = self
            self.pisscanvas:draw_shader("dissolve", nil, nil, nil, self.children.center)
        end
    end
}
