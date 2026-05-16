local rocket_text = {
	"所有打出的牌型均视为",
	"{C:attention}#1#{},同时",
	"获得原牌型的",
	"{C:chips}筹码{}和{C:mult}倍率{}, 持续{C:attention}#2#{} #4#",
	"{B:1,C:white}#3#",
}

return {
	descriptions = {
		Back = {
			b_worm_polarskull_space_station = {
				name = "空间站卡组",
				text = {
					"开局时拥有{C:attention,T:v_worm_polarskull_gravitational_slingshot}引力弹弓{}",
					"和{C:polarskull_rocket,T:c_worm_polarskull_atlascentaur}宇宙神-半人马{}",
				},
			},
		},
		Joker = {
			j_worm_polarskull_martian = {
				name = {
					"F.N.M.",
					"{s:0.8}友好邻家火星人"
				},
				text = {
					"若仅打出{C:attention}#1#{}就击败了当前{C:attention}底注{}",
					"则创建{C:attention}#2#{}张{C:spectral}幻灵{}牌，",
					"所需牌型每{C:attention}底注{}变化一次",
					"{C:inactive}(必须有空位)",
					"{C:inactive}(当前为: {B:1,C:white}#3#{C:inactive})",
				},
			},
			j_worm_polarskull_launchpad = {
				name = "发射台",
				text = {
					"击败{C:attention}Boss盲注{}时，",
					"根据该回合最后打出的{C:attention}牌型{}",
					"创建对应的{C:polarskull_rocket}火箭{}牌",
					"{C:inactive}(必须有空位)"
				},
			},
			j_worm_polarskull_rocket_science = {
				name = "火箭科学",
				text = {
					"每次使用{C:polarskull_rocket}火箭{}牌时，",
					"若该火箭与当前{C:attention}激活{}的火箭",
					"对应不同牌型，则获得{X:mult,C:white}X#2#{}倍率",
					"{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)",
				}
			},
			j_worm_polarskull_olimar = {
				name = "欧力马队长",
				text = {
					{
						"使用{C:polarskull_rocket}火箭{}牌时",
						"将其变为{C:dark_edition}#1#{}",
					},
					{
						"可同时{C:attention}激活{}多张{C:polarskull_rocket}火箭{}牌，",
						"且同一火箭可多次出现",
						"{C:inactive}(最右侧的{C:polarskull_rocket}火箭{}牌",
						"{C:inactive}决定牌型名称)"
					},
				}
			}
		},
		polarskull_rocket = {
			c_worm_polarskull_atlasv = {
				name = "宇宙神5号",
				text = rocket_text,
			},
			c_worm_polarskull_vostok1 = {
				name = "东方一号",
				text = rocket_text,
			},
			c_worm_polarskull_longmarch5 = {
				name = "长征五号",
				text = rocket_text,
			},
			c_worm_polarskull_soyuz1 = {
				name = "联盟1号",
				text = rocket_text,
			},
			c_worm_polarskull_titaniv = {
				name = "大力神4号",
				text = rocket_text,
			},
			c_worm_polarskull_atlascentaur = {
				name = "宇宙神-半人马",
				text = rocket_text,
			},
			c_worm_polarskull_spaceshuttle = {
				name = "航天飞机",
				text = rocket_text,
			},
			c_worm_polarskull_sls = {
				name = "太空发射系统",
				text = rocket_text,
			},
			c_worm_polarskull_titanieee = {
				name = "大力神三E",
				text = rocket_text,
			},
			c_worm_polarskull_saturnv = {
				name = "土星5号",
				text = rocket_text,
			},
			c_worm_polarskull_deltaii = {
				name = "德尔塔2号",
				text = rocket_text,
			},
			c_worm_polarskull_ariane5 = {
				name = "阿丽亚娜5号",
				text = rocket_text,
			},
		},
		Spectral = {
			c_worm_polarskull_ssdolphin = {
				name = "SS Dolphin",
				text = {
					"所有打出的牌型视作包含所有",
					"{C:legendary,E:1}牌型{}, 持续{C:attention}#2#{} #4#",
					"叠加所有基础{C:chips}筹码{}和{C:mult}倍率{}",
					"{B:1,C:white}#3#",
				},
			},
			c_worm_polarskull_ssdolphin_ppm = {
				name = "SS Dolphin",
				text = {
					"所有打出的牌型视作包含所有",
					"{C:legendary,E:1}牌型{}, 持续{C:attention}#2#{} #4#",
					"叠加所有基础{C:chips}筹码{}和{C:mult}倍率{}",
					"{C:inactive}(不受{C:attention}永动机{C:inactive}影响)",
					"{B:1,C:white}#3#",
				},
			},
		},
		Other = {
			undiscovered_polarskull_rocket = {
				name = "未发现",
				text = {
					"在一场没有种子的流程中",
					"购买这张牌来查看它的作用",
				},
			},

			p_worm_rocket_normal_1 = {
				name = "基础火箭包",
				text = {
					"从{C:attention}#2#{}张",
					"{C:polarskull_rocket}火箭{}牌中选择 {C:attention}#1#{}张",
				},
			},
			p_worm_rocket_normal_2 = {
				name = "基础火箭包",
				text = {
					"从{C:attention}#2#{}张",
					"{C:polarskull_rocket}火箭{}牌中选择 {C:attention}#1#{}张",
				},
			},
			p_worm_rocket_jumbo = {
				name = "巨型火箭包",
				text = {
					"从{C:attention}#2#{}张",
					"{C:polarskull_rocket}火箭{}牌中选择 {C:attention}#1#{}张",
				},
			},
			p_worm_rocket_mega = {
				name = "超级火箭包",
				text = {
					"从{C:attention}#2#{}张",
					"{C:polarskull_rocket}火箭{}牌中选择 {C:attention}#1#{}张",
				},
			},
		},
		Voucher = {
			v_worm_polarskull_gravitational_slingshot = {
				name = "引力弹弓",
				text = {
					"{C:attention}激活的{C:polarskull_rocket}火箭{}牌",
					"每次使用与其对应牌型相关的{C:planet}星球{}牌时，",
					"持续时间{C:attention}+1{}回合",
				},
			},
			v_worm_polarskull_prepetual_motion_machine = {
				name = "永动机",
				text = {
					"{C:attention}激活的{C:polarskull_rocket}火箭{}效果",
					"会{C:attention}无限{}持续，直到使用另一张{C:polarskull_rocket}火箭{}牌",
				},
			},
		},

		PotatoPatch = {
			PotatoPatchTeam_polar_skull = {
				name = "Polar Skull",
			},
			PotatoPatchDev_cloudzxiii = {
				name = "cloudzXIII",
				text = {
					"{C:gold,E:1}May your heart be your guiding key",
					"Helped with brainstorming and",
					"coding the Jokers for our team!",
				},
			},
			PotatoPatchDev_noodlemire = {
				name = "Noodlemire",
				text = {
					"{C:money}Bowl of Noodles",
					"Lead programmer and idea producer",
					"behind the {C:polarskull_rocket}Rocket{} Cards!",
					"Also made some art and bugfixes."
				},
			},
			PotatoPatchDev_mariofan = {
				name = "MarioFan597",
				text = {
					"{C:red,s:1.5,E:1}Letsa go!",
					"Helped with various things like",
					"text formating, brainstorming,",
					"coding, and art"
				},
			},
			PotatoPatchDev_rainstar = {
				name = "Rainstar",
				text = {
					"{C:money}The sun.",
					"Formulated the team.",
					"Coded 2 vouchers and a deck."
				},
			},
			PotatoPatchDev_comykel = {
				name = "Comykel",
				text = {
					"{C:attention,s:0.9,E:1}Throughout Heaven and Earth, I alone am the jobless one.{}",
					"The one who did almost all of the art!",
					"if you're interested in his works, see CMYKL (the mod!)",
				},
			},
			PotatoPatchDev_jade = {
				name = "Jade Penguin",
				text = {
					"{C:green}Pupil of Chartreuse Chamber{}",
					"Made some of the art, and helped made the ideas of",
					"some of the stuff you see here from our team!",
					"{C:dark_edition}+1{} Joker Slot :)",
				},
			},
		},
	},
	misc = {
		dictionary = {
			b_polarskull_rocket_cards = "火箭牌",
			k_polarskull_rocket = "火箭",
			k_polarskull_inactive = "未激活",
			k_polarskull_round_singular = "回合",
			k_polarskull_round_plural = "回合",
			k_polarskull_rocket_pack = "火箭包",
			k_polarskull_plus_rocket = "+1火箭",
			k_polarskull_plus_round = "+1回合！",
			k_polarskull_unlimited = "无限",
		},
		v_dictionary = {
			k_polarskull_left = "剩余#1#",
			k_polarskull_martian_inactive = "未激活",
			k_polarskull_martian_active = "激活",
		},
		v_text = {
			ch_c_rocket_paper_scissors = { "所有{C:attention}Boss盲注{}都变为{C:attention,T:bl_mouth}巨口{}或{C:attention,T:bl_eye}巨眼{}"},
			ch_c_polarskull_credits_1 = {"          {C:inactive,s:0.9}制作者: Team {C:polarskull_rocket,s:0.9}Polar Skull{}"},
			ch_c_polarskull_credits_2 = {"           {C:inactive,s:0.9}创意: {C:red,s:0.9}MarioFan597{}"},
			ch_c_polarskull_credits_3 = {"           {C:inactive,s:0.9}代码: {C:gold,s:0.9}cloudzXIII{}"}
		},
		challenge_names = {
			c_worm_rocket_paper_scissors = "火箭石头剪子布",
		},
		quips = {
			worm_polarskull_martian_party = {"{f:worm_polarskull_noto}🥳🎉🎊"},
			worm_polarskull_martian_music = {"{f:worm_polarskull_noto}🤙👽🎸🎶"},
			worm_polarskull_martian_world = {"{f:worm_polarskull_noto}🧑🌍👍👏"},
			worm_polarskull_martian_workout = {"{f:worm_polarskull_noto}💪🃏🏋️🏙️"},
			worm_polarskull_martian_plsrocket = {"{f:worm_polarskull_noto}👎👉🚀🙏"},
			worm_polarskull_martian_dumbass = {"{f:worm_polarskull_noto}🤦🤷"},
			worm_polarskull_martian_broke = {"{f:worm_polarskull_noto}💀🪦💔😢"},
			worm_polarskull_martian_retry = {"{f:worm_polarskull_noto}🚮🔁🚶"},
		},
		achievement_names = {
			ach_worm_polarskull_dandori = "丹多里",
			ach_worm_polarskull_sschamp = "空间站冠军",
			ach_worm_polarskull_completion = "Polar Skull 全收集",
		},
		achievement_descriptions = {
			ach_worm_polarskull_dandori = "在一局游戏中发现欧利玛队长",
			ach_worm_polarskull_sschamp = {
				"使用空间站卡组",
				"在金注或更高难度下获胜。"
			},
			ach_worm_polarskull_completion = {
				"发现Team",
				"Polar Skull 的 100% 内容。"
			},
		},
	},
}
