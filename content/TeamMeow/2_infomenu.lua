function G.FUNCS.worm_meow_custom_info_menu_switch_page(e)
	local config = e.config
	local args = config.args
	local max_page = config.max_page
	args.page = config.page
	args.menu_type = config.menu_type
	args.back_func = config.back_func
	args.no_first_time = config.no_first_time
	args.is_page_switch = true
	local change = config.page_change

	args.page = args.page + change
	if args.page < 1 then
		args.page = max_page
	elseif args.page > max_page then
		args.page = 1
	end

	Wormhole.TEAM_MEOW.create_spacetart_info_menu(args)
end

SMODS.Atlas({
	key = "meowPanelApply",
	px = 80,
	py = 60,
	path = "TeamMeow/panelApply.png",
	frames = 30,
	atlas_table = "ANIMATION_ATLAS",
})
SMODS.Atlas({
	key = "meowPanelSwitch",
	px = 80,
	py = 60,
	path = "TeamMeow/panelSwitch.png",
	frames = 24,
	atlas_table = "ANIMATION_ATLAS",
})
SMODS.Atlas({
	key = "meowPanelStack",
	px = 80,
	py = 60,
	path = "TeamMeow/panelStack.png",
})
SMODS.Atlas({
	key = "meowPanelBoosts",
	px = 80,
	py = 60,
	path = "TeamMeow/panelBoosts.png",
})

function Wormhole.TEAM_MEOW.create_spacetart_UIBox_definition(args)
	local sprites = {}
	local scale = 0.85
	for _, atlas in ipairs({
		"worm_meowPanelApply",
		"worm_meowPanelStack",
		"worm_meowPanelSwitch",
		"worm_meowPanelBoosts",
	}) do
		sprites[#sprites + 1] = SMODS.create_sprite(0, 0, 2 * scale, 1.5 * scale, atlas, { x = 0, y = 0 })
	end
	local args = args or {}
	local back_func = args.back_func or "exit_overlay_menu"
	local no_first_time = args.no_first_time
	local menu_type = args.menu_type
	local page = args.page or 1
	local loc = G.localization.PotatoPatch.Info_Menu["worm_meow_tarts"]
	local function create_info_sprite(sprite)
		return {
			n = G.UIT.C,
			config = { align = "cm", colour = G.C.BLACK, r = 0.2, minw = 2, minh = 1.5, padding = 0.05 },
			nodes = {
				{
					n = G.UIT.O,
					config = { align = "cm", object = sprite },
				},
			},
		}
	end
	local function create_text_box(args)
		local desc_node = {}
		local loc_target = args.loc_target and copy_table(args.loc_target)
		localize({
			type = "descriptions",
			loc_target = { text = loc_target, text_parsed = args.text_parsed },
			nodes = desc_node,
			scale = 1,
			text_colour = G.C.UI.TEXT_LIGHT,
			vars = args.vars or {},
			stylize = true,
			no_shadow = true,
		})
		desc_node = desc_from_rows(desc_node, true)
		desc_node.config.align = "cm"

		return {
			n = G.UIT.C,
			config = {},
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm", colour = G.C.BLACK, r = 0.2, minw = 8, minh = 1.5 },
					nodes = {
						{
							n = G.UIT.C,
							config = { align = "cm", padding = 0.05, r = 0.2 },
							nodes = {
								desc_node,
							},
						},
					},
				},
			},
		}
	end

	local name_nodes = {
		n = G.UIT.R,
		config = { align = "cm", colour = G.C.CLEAR },
		nodes = {
			{ n = G.UIT.C, config = { align = "cm" }, nodes = {} },
		},
	}
	local subname_nodes = {
		n = G.UIT.R,
		config = { align = "cm", colour = G.C.CLEAR, padding = -0.15 },
		nodes = {
			{ n = G.UIT.C, config = { align = "cm" }, nodes = {} },
		},
	}
	local info_nodes = {}
	if loc then
		local temp_name_node = {}
		if args.image then
			temp_name_node = { n = G.UIT.O, config = { object = args.image, align = "cm " } }
		else
			localize({
				type = "name",
				loc_target = loc,
				nodes = temp_name_node,
				scale = 1.5,
				text_colour = G.C.UI.TEXT_LIGHT,
				vars = args.vars or {},
				stylize = true,
			})
			temp_name_node = desc_from_rows(temp_name_node, true)
			temp_name_node.config.align = "cm"
		end
		name_nodes.nodes[1].nodes[#name_nodes.nodes[1].nodes + 1] = {
			n = G.UIT.R,
			config = { align = "cm", colour = G.C.CLEAR },
			nodes = {
				{ n = G.UIT.C, config = { align = "cm" }, nodes = {
					temp_name_node,
				} },
			},
		}

		local target = loc.text[page]
		if target then
			local temp_subname_node = {}
			localize({
				type = "name",
				loc_target = target,
				nodes = temp_subname_node,
				scale = 0.8,
				text_colour = G.C.UI.TEXT_LIGHT,
				vars = args.vars or {},
				stylize = true,
				no_pop_in = true,
				no_bump = true,
				no_silent = true,
				no_spacing = true,
			})
			temp_subname_node = desc_from_rows(temp_subname_node, true)
			temp_subname_node.config.align = "cm"
			subname_nodes.nodes[1].nodes[#subname_nodes.nodes[1].nodes + 1] = {
				n = G.UIT.R,
				config = { align = "cm", colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							temp_subname_node,
						},
					},
				},
			}
			info_nodes = {
				n = G.UIT.R,
				config = { align = "cm", padding = 0, colour = G.C.CLEAR },
				nodes = {
					{ n = G.UIT.C, config = { align = "cm", padding = 0.2 }, nodes = {} },
				},
			}
			for i, v in ipairs(target.text) do
				info_nodes.nodes[1].nodes[#info_nodes.nodes[1].nodes + 1] = {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						i % 2 == 0 and create_info_sprite(sprites[i]) or nil,
						i % 2 == 0 and { n = G.UIT.C, config = { minw = 0.2 } } or nil,
						create_text_box({ loc_target = v, text_parsed = target.text_parsed[i], vars = args.vars }),
						i % 2 == 1 and { n = G.UIT.C, config = { minw = 0.2 } } or nil,
						i % 2 == 1 and create_info_sprite(sprites[i]) or nil,
					},
				}
			end
		end
	end

	G.PROFILES[G.SETTINGS.profile].first_time_disable = G.PROFILES[G.SETTINGS.profile].first_time_disable or {}

	local ret = {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			minw = G.ROOM.T.w * 5,
			minh = G.ROOM.T.h * 5,
			padding = 0.1,
			r = 0.1,
			colour = args.bg_colour or { G.C.GREY[1], G.C.GREY[2], G.C.GREY[3], 0.7 },
		},
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					minh = 1,
					r = 0.3,
					padding = 0.07,
					minw = 1,
					colour = args.outline_colour or G.C.JOKER_GREY,
					emboss = 0.1,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
							minh = 1,
							r = 0.2,
							padding = 0.1,
							minw = 1,
							colour = args.colour or G.C.L_BLACK,
						},
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", r = 0.2, padding = 0.15, minw = 1, colour = G.C.BLACK },
								nodes = {
									{
										n = G.UIT.C,
										config = {
											align = "cm",
											r = 0.2,
											padding = 0.05,
											minw = 1,
											colour = G.C.L_BLACK,
										},
										nodes = {
											name_nodes,
											subname_nodes,
											info_nodes,
											{
												n = G.UIT.R,
												config = { align = "cm", padding = 0.2 },
												nodes = {
													{
														n = G.UIT.C,
														config = { align = "cr", colour = G.C.CLEAR },
														nodes = {
															not no_first_time
																	and create_toggle({
																		label = localize("ppu_first_time_disable"),
																		ref_table = G.PROFILES[G.SETTINGS.profile].first_time_disable,
																		ref_value = menu_type,
																		callback = function() end,
																	})
																or nil,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { align = "cm", padding = 0 },
												nodes = {
													not args.no_back
															and {
																n = G.UIT.C,
																config = {
																	id = args.back_id or "overlay_menu_back_button",
																	align = "cm",
																	minw = 4,
																	button_delay = args.back_delay,
																	padding = 0.1,
																	r = 0.1,
																	hover = true,
																	colour = args.back_colour or G.C.ORANGE,
																	button = back_func,
																	shadow = true,
																	focus_args = {
																		nav = "wide",
																		button = "b",
																		snap_to = args.snap_back,
																	},
																},
																nodes = {
																	{
																		n = G.UIT.R,
																		config = {
																			align = "cm",
																			padding = 0,
																			no_fill = true,
																		},
																		nodes = {
																			{
																				n = G.UIT.T,
																				config = {
																					id = args.back_id or nil,
																					text = args.back_label
																						or localize("b_back"),
																					scale = 0.5,
																					colour = G.C.UI.TEXT_LIGHT,
																					shadow = true,
																					func = not args.no_pip
																							and "set_button_pip"
																						or nil,
																					focus_args = not args.no_pip
																							and {
																								button = args.back_button
																									or "b",
																							}
																						or nil,
																				},
																			},
																		},
																	},
																},
															}
														or nil,
												},
											},
											{
												n = G.UIT.R,
												config = { align = "cm", minh = not no_first_time and 0.1 or 0.03 },
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}
	if loc and loc.text and #loc.text > 1 then
		local pages = {
			n = G.UIT.C,
			config = { padding = 0.2 },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						minw = 0.5,
						minh = 0.3,
						maxh = 0.5,
						padding = 0.1,
						r = 0.1,
						hover = true,
						colour = args.page_colour or G.C.BLACK,
						shadow = true,
						button = "worm_meow_custom_info_menu_switch_page",
						page_change = -1,
						menu_type = menu_type,
						page = page,
						max_page = (#(loc.text or {}) or 1),
						back_func = back_func,
						no_first_time = no_first_time,
						args = args,
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm", padding = 0.05 },
							nodes = {
								{ n = G.UIT.T, config = { text = "<", scale = 0.4, colour = G.C.UI.TEXT_LIGHT } },
							},
						},
					},
				},
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						minw = 0.5,
						minh = 0.3,
						maxh = 0.5,
						padding = 0.1,
						r = 0.1,
						hover = true,
						colour = args.page_colour or G.C.BLACK,
						shadow = true,
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm", padding = 0.05 },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("k_page") .. " " .. page .. "/" .. (#(loc.text or {}) or 1),
										scale = 0.4,
										colour = G.C.UI.TEXT_LIGHT,
									},
								},
							},
						},
					},
				},
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						minw = 0.5,
						minh = 0.3,
						maxh = 0.5,
						padding = 0.1,
						r = 0.1,
						hover = true,
						colour = args.page_colour or G.C.BLACK,
						shadow = true,
						button = "worm_meow_custom_info_menu_switch_page",
						page_change = 1,
						menu_type = menu_type,
						page = page,
						max_page = (#(loc.text or {}) or 1),
						back_func = back_func,
						no_first_time = no_first_time,
						args = args,
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm", padding = 0.05 },
							nodes = {
								{ n = G.UIT.T, config = { text = ">", scale = 0.4, colour = G.C.UI.TEXT_LIGHT } },
							},
						},
					},
				},
			},
		}
		table.insert(ret.nodes[1].nodes[1].nodes[1].nodes[1].nodes[4].nodes, 1, pages)
	end

	return ret
end

function Wormhole.TEAM_MEOW.create_spacetart_info_menu(args)
	if not args or not args.menu_type or not G.localization.PotatoPatch.Info_Menu[args.menu_type] then
		return
	end
	local config = {}
	if args.is_page_switch then
		config.offset = { x = 0, y = 0 }
	end
	G.FUNCS.overlay_menu({
		definition = Wormhole.TEAM_MEOW.create_spacetart_UIBox_definition(args or {}),
		config = config,
	})
end

function Wormhole.TEAM_MEOW.open_spacetart_info_menu()
	G.PROFILES[G.SETTINGS.profile].first_time_disable = G.PROFILES[G.SETTINGS.profile].first_time_disable or {}
	if not G.PROFILES[G.SETTINGS.profile].first_time_disable["worm_meow_tarts"] then
		Wormhole.TEAM_MEOW.create_spacetart_info_menu({
			menu_type = "worm_meow_tarts",
			vars = { G.GAME.max_foil_slots or 7 },
		})
	end
end
