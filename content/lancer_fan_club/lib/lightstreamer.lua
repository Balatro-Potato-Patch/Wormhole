-- AWFUL HACK
local curl = Wormhole.LancerFanClub.libcurl()

-- takes from the following github projects, both MIT licensed:
-- love2d-lua-websocket by flaribbit - https://github.com/flaribbit/love2d-lua-websocket
-- PISSStreamGodot by Stovoy - https://github.com/Stovoy/pISSStreamGodot/

--- @enum Wormhole.LancerFanClub.LightstreamerStatus
local STATUS = {
    CONNECTING = 0,
    OPEN       = 1,
    CLOSING    = 2,
    CLOSED     = 3,
    TCPOPENING = 4,
}

--- @class Wormhole.LancerFanClub.LightstreamerClient
local LSC = Object:extend()

function LSC:init(args)
    self.connection_status = STATUS.CLOSED
end











Wormhole.LancerFanClub.LightstreamerClient = LSC
Wormhole.LancerFanClub.LightstreamerStatus = STATUS