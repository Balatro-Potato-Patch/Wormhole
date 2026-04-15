local colours = {
    mrrp_pink = HEX("CA7CA7"),
    mrrp_orange = HEX('C47C47'),
    mrrp_orange2 = HEX('FCC603'),
    mrrp_blue = HEX('7994C1'),
    mrrp_green = HEX('82A356'),
    mrrp_cyan = HEX('7AC7AC'),
}
loc_colour()
for k,v in pairs(colours) do
    G.ARGS.LOC_COLOURS[k] = v
    G.C[k] = v
end

-- for negative hand level compat
local to_number = to_number or tonumber
setmetatable(G.C.HAND_LEVELS, {
    __index = function(t,k)
        k = to_number(k) or k
        if (to_number(k) or 1) <= 0 then
            k = math.min(-to_number(k),7)
        end
        return rawget(t,k)
    end
})