local reset_ref = Wormhole.reset_game_globals
function Wormhole.reset_game_globals(run_start)
    reset_ref(run_start)
    if run_start then
        G.GAME.asm_xurkitree = 7
    end
end