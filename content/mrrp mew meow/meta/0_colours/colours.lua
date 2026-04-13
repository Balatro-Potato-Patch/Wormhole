local colours = {
    mrrp_pink = HEX("CA7CA7"),
    mrrp_orange = HEX('C47C47'),
    mrrp_blue = HEX('7994C1'),
    mrrp_green = HEX('82A356'),
    mrrp_cyan = HEX('64A29C'),
}
loc_colour()
for k,v in pairs(colours) do
    G.ARGS.LOC_COLOURS[k] = v
    G.C[k] = v
end