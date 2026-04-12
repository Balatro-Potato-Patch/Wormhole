local reset_ref = Wormhole.reset_game_globals
function Wormhole.reset_game_globals(run_start)
    reset_ref(run_start)
    if run_start then
        G.GAME.asm_xurkitree = 7
        G.GAME.asm_celesteela = 1
    end
end

local click_ref = Card.click
function Card:click()
    if self and self.config and self.config.center and self.config.center.key == "c_worm_blacephalon" then
        play_sound('worm_asm_clownhonk',1 + math.random()*0.02)
    end
    click_ref(self)
end