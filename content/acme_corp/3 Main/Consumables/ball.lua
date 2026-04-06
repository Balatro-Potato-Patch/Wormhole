Wormhole.ACME = Wormhole.ACME or {}

Wormhole.ACME.ball_function = function(self, scale_mod)
    local last_T = (self.worm_ACME_last_T or 0)
    if (G.TIMERS.REAL - last_T) < 0 then self.worm_ACME_last_T = 0; last_T = 0 end
    Wormhole.ACME.last_ball_h = Wormhole.ACME.last_ball_h or self.children.floating_sprite.VT.h

    self.children.center.is_acme_ball = true
    self.children.floating_sprite.VT.h = (G.TIMERS.REAL - last_T) > 0.1 and Wormhole.ACME.last_ball_h*(-2^(-(0.2*(G.TIMERS.REAL - last_T) + 1))+1) + (Wormhole.ACME.last_ball_h*(2^(-(0.2*(G.TIMERS.REAL - last_T) + 1))))*math.abs(math.sin(6*(G.TIMERS.REAL - last_T))) or Wormhole.ACME.last_ball_h

    local func = function(x)
        return (math.abs(math.sin(x))*(1/((x^1.3)+1)) - 0.18*(Wormhole.ACME.last_ball_h - self.children.floating_sprite.VT.h))
    end
    
    self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod, 0, 0, 0.25 - 4*func(6*(G.TIMERS.REAL - last_T)))
    self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, 0, 0, 0.25 - 4*func(6*(G.TIMERS.REAL - last_T)))
end

local card_click_ref = Card.click
function Card:click()
    if self.config.center.key == 'c_worm_acme_ball' and not self.highlighted then
        self.worm_ACME_last_T = G.TIMERS.REAL
    end
    card_click_ref(self)
end

SMODS.Consumable{
    key = 'acme_ball',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = {x=0, y=0},
    soul_pos = {x=0, y=1, draw = function(self, scale_mod) Wormhole.ACME.ball_function(self, scale_mod) end},
	use = function(self, card, area, copier)
        local used = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.cards do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('card1', percent)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                    _card:set_ability(SMODS.poll_enhancement {key = 'ACME_ball', guaranteed = true})
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0  
    end,
}
