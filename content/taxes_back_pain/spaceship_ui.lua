local tbp_hook_info_tip_from_rows = info_tip_from_rows
function info_tip_from_rows(desc_nodes, name)
    if desc_nodes.tbp_module then
        local col = Wormhole.tbp.module_colours[desc_nodes.tbp_module]
        local durability_col = mix_colours(G.C.BLACK, col, 0.8)
        local t = {}
        for k, v in ipairs(desc_nodes) do
            t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
        end
        return {n=G.UIT.C, nodes = {
            {n=G.UIT.R, config = {align = 'cm', colour = col}, nodes = {
                {n=G.UIT.C, config = {align = 'cm', colour = darken(col, 0.4), padding = 0.1}, nodes = {
                    {n=G.UIT.T, config={text = localize('tbp_module_'..desc_nodes.tbp_module), scale = 0.32, colour = G.C.UI.TEXT_LIGHT, vert = true}}
                }},
                {n=G.UIT.C, config = {align = 'cm', padding = 0.05, colour = lighten(col, 0.4)}, nodes = {
                    {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = lighten(col, 0.4)}, nodes={
                        {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}
                    }},
                    desc_nodes.module_info and {n=G.UIT.R, config = {align = 'cm', r = 0.1, minw = 0.5, minh = 0.2, colour = durability_col, outline = 1, outline_colour = darken(col, 0.15),
                        progress_bar = {
                            max = desc_nodes.module_info.total_durability, ref_table = desc_nodes.module_info, ref_value = 'durability', empty_col = durability_col, filled_col = adjust_alpha(col, 0.8)
                        }
                    }, nodes = {
                        {n=G.UIT.T, config = {text = desc_nodes.module_info.durability .. ' turns', colour = lighten(col, 0.3), scale = 0.2}}
                    }} or nil
                }}
            }},
            
        }}
    else
        return tbp_hook_info_tip_from_rows(desc_nodes, name)
    end
end

G.FUNCS.show_spaceship_tooltips = function(e)
    if e.config.ref_table then 
        e.children.info = UIBox{
            definition = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.02}, nodes=e.config.ref_table},
            config = {offset = {x=0.03,y=0}, align = 'cr', parent = e}}
        e.children.info:align_to_major()
        e.config.ref_table = nil
    end
end
  