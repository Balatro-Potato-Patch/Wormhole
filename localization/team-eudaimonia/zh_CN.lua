return {
    descriptions = {
        PotatoPatch = {
            PotatoPatchTeam_TeamEudaimonia = {
                name = "Eudaimonia",
            },

            PotatoPatchDev_LasagnaFelidae = {
                name = "LasagnaFelidae",
                text = {"big fat hairy deal"}
            },
            PotatoPatchDev_cosmeggo = {
                name = "cosmeggo",
                text = {"Formerly Plasma!"}
            },
            PotatoPatchDev_soulware = {
                name = "soulware",
                text = {"wunkuss."}
            },
            PotatoPatchDev_TigerTHawk = {
                name = "TigerTHawk",
                text = {"."}
            },
            PotatoPatchDev_iamarta = {
                name = "iamarta",
                text = {"bonjour"}
            },
            PotatoPatchDev_M0xes = {
                name = "M0xes",
                text = {"Me."}
            },
            PotatoPatchDev_Hunter = {
                name = "ARandomHunter",
                text = {"."}
            },
            PotatoPatchDev_Sillyz = {
                name = "Sillyz",
                text = {"."}
            },
            PotatoPatchDev_Typ0 = {
                name = "Typ0",
                text = {"Hit Game Dev Right Here","{s:0.75}Sprite By Inky{}"}
            },
            PotatoPatchDev_Jewel = {
                name = "Jewel",
                text = {"."}
            },


        },
        Blind = {
            bl_worm_euda_anomaly = {
                name = {
                    "异常"
                },
                text = {
                    "本局已打出的出牌数",
                    "使盲注增加{C:blind}20%{}"
                }
            }
        },
        Joker = {
            j_worm_euda_message = {
                name = {
                    "信息   ",
                },
                text = {
                    {
                    "{X:red,C:white}X#1#{}倍率",
                    "{C:green}#2# / #3#{}概率",
                    "获得一个{C:inactive}答案{}"
                    },
                    {
                    "{C:red}请谨慎使用{}"
                    }
                }
            },
            j_worm_euda_answer = {
                name = {
                    "答案",
                },
                text = {
                    {
                    "所有{C:attention}Boss盲注{}",
                    "都被替换为",
                    "{C:inactive}异常{}"
                    },
                    {
                    "{C:inactive}你本该听劝的……{}",
                    }
                }
            },
            j_worm_euda_wowsignal = {
                name = "Wow!信号",
                text = {{
                    "{C:green}#1# / #2#{}概率提供",
                    "{X:chips,C:white}X#3#{}到{X:chips,C:white}X#4#{}筹码"
                },{
                    "否则提供",
                    "{C:chips}+#5#{}到{C:chips}+#6#{}筹码"
                }},
                
            },
            j_worm_euda_jokecolony = {
                name = "Joke Colony",
                text = {
                    {
                    "将小丑牌存入{C:attention}群落",
                    "群落中每张存贮的小丑提供{C:mult}+#1#{}倍率",
                    "{C:inactive}(当前为{C:red}+#3#{C:inactive}倍率)",
                    },
                    {
                    "{C:inactive}每张小丑每回合只能进入一次群落"
                    }
                },
            },
            j_worm_euda_darkside = {
                name = "月之暗面",
                text = {
                    "{C:spades}#1#{}和{C:clubs}#2#{}",
                    "总是最先抽到",
                },
            },
            j_worm_euda_lunarcheese = {
                name = "月相奶酪",
                text = {
                    "出售时，使其右侧的{C:attention}小丑{}削弱#1#回合",
                    "它{C:attention}永久{}获得一次重复触发"
                },
            },
            j_worm_euda_extraevidence = {
                name = "地外证据",
                text = {
                    "{C:red}削弱{}所有计分牌",
                    "除了{C:attention}第一张{}",
                    "每有一种{C:attention}不同点数{}的{C:red}削弱牌{}",
                    "便{C:attention}重复触发{}第一张牌一次"
                }
            },
            j_worm_euda_ton618 = {
                name = "Ton 618",
                text = {
                    "如果至少有两张{C:attention}强化{}牌被计分",
                    "获得{X:mult,C:white}X#1#{}倍率并销毁",
                    "那些被计分的{C:attention}强化{}牌"
                },
            },
            j_worm_euda_cometwild = {
                name = "野性彗星",
                text = {
                    "{C:attention}万能{}牌不会被削弱，",
                    "计分时提供{X:mult,C:white}X#1#{}倍率"
                },
            },
			j_worm_euda_bitflip = {
                name = "宇宙比特翻转",
                text = {
                    {
                        "根据比特是否翻转，",
                        "获得{C:chips}+#4#{}筹码，",
                        "或者{C:mult}+#5#{}到{C:mult}+#6#{}倍率。",
                        "{C:green}#1# / #2#{}概率翻转比特"
                    },{
                        "比特.已翻转() == {C:attention}#3#；{}"
                    }
                }
            },
            j_worm_evil = {
                name = "邪物",
                text = {
                    "{C:white,X:red}X#2#{}倍率",
                    "在{C:attention}回合{}结束时，",
                    "{C:red}摧毁{}一张随机小丑",
                    "并获得{C:money}$5{}{C:attention}出售价值{}"
                },
                
            },
            j_worm_LittleLight = {
                name = "命运助手",
                text = {{
                    "每使用一张{C:tarot}死神{}",
                    "此小丑获得{X:mult,C:white}X#2#{}倍率",
                    "{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)",
                },{
                    "若所得筹码达到{C:blind}盲注需求{}的{C:attention}25%{}",
                    "则阻止{C:red}死神{}，然后{C:red,E:2}自毁{}"
                }},

            }, 
            j_worm_euda_roadsidepicnic = {
                name = "路边野餐",
                text = {
                    "{C:green}重掷{}花费增加{C:money}$#1#{}",
                    "商店卡牌花费减少{C:money}$#1#{}",
                    "每次{C:green}重掷{}后两个数值增加{C:money}$1{}"
                }
            },
            j_worm_euda_csaber = {
                name = "光剑",
                text = {
                    "{C:green}#1# / #2#{}概率为任意",
                    "{C:chips}+筹码{}来源额外增加{C:chips}+#3#{}筹码"
                },
            },
        },
        euda_Fate = {
            c_worm_euda_crunch = {
                name = {"大坍缩"},
                text = {
                    "将{C:attention}牌组{}中的每张牌",
                    "设为{C:attention}2{}种随机{C:attention}花色{}中的{C:attention}1{}种"
                }
            },
            c_worm_euda_freeze = {
                name = {"大热寂"},
                text = {
                    "将{C:attention}牌组{}中的每张牌",
                    "设为{C:attention}4{}种随机{C:attention}点数{}中的{C:attention}1{} 种"
                }
            },
            c_worm_euda_rip = {
                name = {"大撕裂"},
                text = {
                    "{C:attention}复制{}牌组中的每张牌，",
                    "并将其{C:attention}点数{}{C:attention}减半{}",
                    "{C:inactive}(向下取整)"
                }
            },
            c_worm_euda_slurp = {
                name = {"Big Slurp"},
                text = {
                    "Randomly {C:attention}destroys{} half",
                    "of the {C:attention}deck",
                    "{C:inactive}(Rounded up)"
                }
            },
            c_worm_euda_bounce = {
                name = {"大吞噬"},
                text = {
                    "随机{C:attention}摧毁{}一半",
                    "的{C:attention}牌组{}",
                    "{C:inactive}(向上取整)"
                }
            }
        },
        Spectral = {
            c_worm_euda_bang = {
                name = {"大爆炸"},
                text = {
                    "{C:attention}替换{}牌组中的所有牌",
                    "为{C:attention,E:2}完全随机{}的牌",
                    "{C:inactive}(随机花色、点数、增强、版本、印章)"
                }
            }
        },
        Other = {
            worm_euda_jokecolony_alreadyshipped = {
                name = "笑话群落",
                text = {
                    "{C:inactive}本回合已存入"
                }
            },
            worm_euda_lunarcheese_disabled = {
                name = "月相奶酪",
                text = {
                    "还将削弱",
                    "#1#回合"
                }
            },
            worm_euda_lunarcheese_bonus_retriggers = {
                name = "月相奶酪",
                text = {
                    "拥有#1#次额外重复触发"
                }
            },
            p_worm_euda_avadon_normal = {
                name = "阿瓦顿包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:euda_fate}命运{}牌中选择{C:attention}#1#{}张",
                    "立即使用"
                },
            },
            p_worm_euda_avadon_jumbo = {
                name = "巨型阿瓦顿包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:euda_fate}命运{}牌中选择{C:attention}#1#{}张",
                    "立即使用"
                },
            },
            p_worm_euda_avadon_mega = {
                name = "超级阿瓦顿包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:euda_fate}命运{}牌中选择{C:attention}#1#{}张",
                    "立即使用"
                },
            },
            undiscovered_euda_fate = {
                name = "未发现",
                text = {
                    "在一场没有种子的流程中",
                    "购买这张牌来查看它的作用",
                },
            },
        },
        Planet = {
            c_worm_euda_81p = {
                name = "81P",
                text = {
                    "({V:1}等级#1#{})提升",
                    "{C:attention}#2#{}",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
        }
    },
    misc = {
            poker_hand_descriptions = {
                worm_pkr_euda_nova = {
                   "5张均为{C:attention}百搭{}牌",
                },
            },
            poker_hands = {
                worm_pkr_euda_nova = '星尘'
            },
            dictionary = {
                k_worm_euda_jokecolony_ship_button = "存入",
                k_worm_euda_jokecolony_receive_button = "取出",
                k_worm_euda_specificcolony_ship_button = "存入小丑",
                k_worm_euda_specificcolony_receive_button = "取出小丑",
                k_worm_euda_specificcolony_ship_title = "正在存入群落 ",
                k_worm_euda_specificcolony_receive_title = "从群落取出 ",


                k_worm_euda_cometplanet = "彗星",
      
                k_euda_fate = "命运",
                b_euda_fate_cards = "命运牌",
                k_euda_avadon_pack = "阿瓦顿包",
                k_worm_euda_lunarcheese_message = "芝士满满！",

                ph_LittleLight = "被命运助手拯救"
            },
    }
}

