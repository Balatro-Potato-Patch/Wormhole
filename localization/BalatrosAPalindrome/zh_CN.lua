return {
    descriptions = {
        PotatoPatch = {
            PotatoPatchDev_Nogardagem = {
                name = "{E:worm_bap_text_funny}Nogardagem{}",
                text = { "worm worm worm worm worm", "worm worm worm worm worm", "worm worm worm worm worm", "worm worm worm worm worm", "worm worm worm worm worm" }
            },
            PotatoPatchDev_NerdyBread42 = {
                name = "{E:worm_bap_text_funny}NerdyBread42{}",
                text = { "NerdyBread42" }
            },
            PotatoPatchDev_IzzyWizz = {
                name = "{E:worm_bap_text_funny}IzzyWizz{}",
                text = { "IzzyWizz" }
            },
            PotatoPatchDev_Knightingale0 = {
                name = "{E:worm_bap_text_funny}Knightingale0{}",
                text = { "<3" }
            }
        },
        Edition = {
            e_worm_bap_void = {
                name = '虚无',
                label = '虚无',
                text = {
                    "{C:attention}持有{}时{C:chips}#1#{}筹码",
                    "从不计分"
                }
            }
        },
        Tarot = {
            c_worm_bap_abyss = {
                name = '深渊',
                text = {
                    "获得{C:money}$#1#{}然后",
                    "创建{C:attention}#2#{}张随机",
                    "{T:e_worm_bap_void}虚无{}牌",
                }
            }
        },
        Planet = {
            c_worm_bap_nothing = {
                name = '无',
                text = {
                    "({V:1}lvl.#1#{})升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率",
                    "{C:chips}+#4#{}筹码",
                },
            }
        },
        Joker = {
            j_worm_bap_milky_way = {
                name = '银河牛奶',
                text = {
                    "接下来的{C:attention}#1#{}个回合",
                    "每个回合结束",
                    "创建一张{C:planet}星球{}牌",
                    "{C:inactive}(必须有空间)",
                }
            },
            j_worm_bap_andromeda = {
                name = '仙女座星系',
                text = {
                    "每回合第一个打出的{C:attention}牌型{}",
                    "每有一级便获得{C:money}$#1#{}"
                },
            },
            j_worm_bap_solar_panel = {
                name = '太阳能板',
                text = {
                    "{C:hearts}红桃{}花色牌计分时",
                    "给予{C:mult}+4{}倍率",
                    "{C:diamonds}方片{}花色牌计分时",
                    "给予{C:chips}+25{}筹码"
                }
            },
            j_worm_bap_artemis_3 = {
                name = '阿耳忒弥斯3号',
                text = {
                    "当{C:attention}盲注{}被选中时",
                    "创建一个",
                    "{C:dark_edition}负片{}{C:tarot}月亮{}牌",
                }
            },
            j_worm_bap_space_walk = {
                name = '太空漫步',
                text = {
                    "接下来的{C:attention}#1#{}个回合",
                    "在回合开始时创建一个{C:dark_edition}负片{}{C:attention}太空小丑{}",
                    "{C:inactive}(必须有空间)",
                    -- "当{C:attention}盲注{}被选中时",
                    -- "创建一个",
                    -- "{C:attention}太空小丑{}",
                    -- "{C:inactive}(必须有空间){}",
                }
            },
            j_worm_bap_vacuum = {
                name = '真空吸尘器',
                text = {
                    "如果打出的牌包含",
                    "{T:e_worm_bap_void}虚无{}牌,{X:mult,C:white}X2{}倍率",
                }
            },
            j_worm_bap_space_worm = {
                name = '太空蠕虫',
                text = {
                    "当{C:attention}盲注{}被选中时,",
                    "{C:attention}摧毁{}来自{B:1,V:2}Wormhole{}的小丑",
                    "右侧的小丑,然后给予{X:mult,C:white} X#1# {}倍率",
                    "{C:inactive}(当前为{X:mult,C:white} X#2# {C:inactive}倍率)",
                }
            },
            j_worm_bap_regular_worm = {
                name = '蠕虫',
                text = {
                    "每打出过一张{T:e_worm_bap_void}虚无{}牌",
                    "给予{X:mult,C:white} X#1# {} 倍率",
                    "{C:attention}移除{} {T:e_worm_bap_void}虚无{}版本",
                    "{C:inactive}(当前为{X:mult,C:white} X#2# {C:inactive}倍率)"
                }
            }
        }
    },
    misc = {
        poker_hands = {
            worm_bap_void = '空手'
        },
        poker_hand_descriptions = {
            worm_bap_void = { "5张虚无版本的牌" }
        },
        labels = {
            worm_bap_void = '虚无',
        },
    }
}
