local reset_ref = Wormhole.reset_game_globals
function Wormhole.reset_game_globals(run_start) --this doesnt work yet bcs someone was stupid
    print"hello"
    reset_ref(run_start)
    if run_start then
        print"yes"
        G.GAME.asm_xurkitree = 1
    else
        print"no"
    end
end