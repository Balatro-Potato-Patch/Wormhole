Wormhole.EUDA = {}
Wormhole.EUDA.anomaly_mult = 0
Wormhole.EUDA.anomaly_mult_mod = 0.2

--code by tby 

local eval_hook = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    local ret = eval_hook(e)
    if not Wormhole.EUDA then
      Wormhole.EUDA = {}
    end
    Wormhole.EUDA.anomaly_mult = Wormhole.EUDA.anomaly_mult + Wormhole.EUDA.anomaly_mult_mod
    return ret
end

local startRunHook = Game.start_run
function Game:start_run(args)
    local ret = startRunHook(self, args)
    if not Wormhole.EUDA then
      Wormhole.EUDA = {}
    end
    Wormhole.EUDA.anomaly_mult = 0

    return ret
end