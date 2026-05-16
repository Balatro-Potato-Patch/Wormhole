-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/blob/main/src/tarots.lua https://github.com/nh6574/VanillaRemade/blob/main/localization/en-us.lua
return {
    descriptions = {
        Back = {
            b_worm_hedonia_bar = {
                name = '太空酒吧',
                text = {
                    '开局时拥有一个随机',
                    '{C:attention}调酒师{}小丑牌'
                }
            }
        },
        Joker = {
            j_worm_hedonia_casino = {
                name = '赌场调酒师',
                text = {
                    {
                        '打出的{C:edition}{E:2}微醺{}、{C:edition}{E:1}醉酒{}、{C:dark_edition}{E:1}大醉{}',
                        '和{C:dark_edition}断片{}牌在计分时变为',
                        '{C:attention}幸运牌{}',
                    },
                    {
                        '当{C:attention}盲注{}被选中时',
                        '创建一个{C:attention}酒品{}{C:worm_hedonia_menu}菜单物品{}',
                        '{C:inactive}(必须有空间)',
                    },            
                }
            },
            j_worm_hedonia_trash = {
                name = '垃圾压缩机',
                text = {
                    '{C:attention}储存{}所有被{C:red}摧毁',
                    '卡牌的{C:chips}筹码{}直到',
                    '{C:attention}Boss盲注{}被击败',
                    '{C:inactive}（当前为{C:chips}+#1#{C:inactive}筹码）'
                }
            },
            j_worm_hedonia_patron = {
                name = '醉汉顾客',
                text = {
                    '当{C:edition}{E:2}微醺{}、{C:edition}{E:1}醉酒{}、{C:dark_edition}{E:1}大醉{}',
                    '或{C:dark_edition}断片{}牌计分时，',
                    '获得{C:mult}+#2#{}倍率',
                    '{C:inactive}（当前为{C:mult}+#1#{C:inactive} 倍率）',
                }
            },
            j_worm_hedonia_happy_hour = {
                name = '欢乐时光',
                text = {
                    {
                        '使用{C:worm_hedonia_menu}菜单物品{}时',
                        '获得{C:money}$#2#{}',
                    },
                    {
                        '{C:worm_hedonia_menu}菜单包{}售价减少{C:money}$#1#{}'
                    }
                }
            },
            j_worm_hedonia_speed = {
                name = '副厨师长',
                text = {
                    '计分时有{C:green}#1# / #2#{}概率',
                    '创建一张{C:attention}食物{} {C:worm_hedonia_menu}菜单物品{},',
                    '{C:green}概率{}根据{C:attention}小丑牌{}',
                    '和{C:attention}小丑位{}槽位数量变化',
                    '{C:inactive}（必须有空间）',
                }
            },
            j_worm_hedonia_bar_mitzvah = {
                name = '成人礼',
                text = {
                    '每打出并计分{C:attention}#1#{}张牌后',
                    '创建一张{C:worm_hedonia_menu}菜单物品{}',
                    '{C:inactive}（当前还需{C:attention}#2#{C:inactive}张牌）{}',
                    '{C:inactive,s:0.8}（此处应放置阿里亚诵读内容）{}'
                }
            }
        },
        worm_hedonia_menu = {
            c_worm_hedonia_hadron = {
                name = '强子可乐达',
                text = {
                    '给予所有选中牌',
                    '{E:2}微醺{}'
                }
            },
            c_worm_hedonia_cosmo = {
                name = '大都会',
                text = {
                    '给予最多{C:attention}#1#{}张选定牌',
                    '{E:1}醉酒{}'
                }
            },
            c_worm_hedonia_mojitury = {
                name = '莫吉托瑞',
                text = {
                    '给予最多{C:attention}#1#{}张选中牌',
                    '{C:dark_edition,E:1}大醉{}'
                }
            },
            c_worm_hedonia_blackHoleBomb = {
                name = '黑洞炸弹',
                text = {
                    '给予手牌中{C:attention}#1#{}张',
                    '{C:attention}随机{}牌{C:dark_edition}断片{}'
                }
            },
            c_worm_hedonia_jawbreaker = {
                name = '颚骨碎裂者',
                text = {
                    '给予一张随机手牌',
                    '{C:chips}+#1#{}筹码'
                }
            },
            c_worm_hedonia_rings = {
                name = '萨图尼昂之环',
                text = {
                    '给予所有手牌{C:attention}清醒{}',
                    '{C:red}或者{}如果手牌中没有醉酒牌',
                    '则获得{C:money}$#1#{}'
                }
            },
            c_worm_hedonia_debbie = {
                name = '宇宙布朗尼',
                text = {
                    '将最多{C:attention}#1#{}张选中牌',
                    '转换为相同的随机点数'
                }
            },
            c_worm_hedonia_jam = {
                name = '太空果酱',
                text = {
                    '将最多{C:attention}#1#{}张选中牌',
                    '转换为相同的随机花色'
                }
            }
        },
        Other = {
            p_worm_hedonia_menu = {
                name = "#3#",
                text = {
                    "从最多{C:attention}#2#{}种",
                    "{C:worm_hedonia_menu}菜单物品{}中订购{C:attention}#1#{}个",
                    "并立即使用"
                }
            },
            undiscovered_worm_hedonia_menu = {
                name = "未发现",
                text = {
                "在一场没有种子的流程中",
                "购买这张牌来查看它的作用"
                },
            },
        },
        Edition = {
            e_worm_hedonia_tipsy = {
                name = '微醺',
                text = {
                    '在手牌中时，有{C:green}#1# / #2#{}概率{C:attention}清醒{}',
                    '计分后随机改变点数，并有{C:green}#3# / #4#{}概率',
                    '{C:attention}变得更醉{}',
                    '{C:inactive}(最大点数变化幅度：{C:attention}#5#{C:inactive})' },
                label = '微醺'
            },
            e_worm_hedonia_drunk = {
                name = '醉酒',
                text = {
                    '在手牌中时，有{C:green}#1# / #2#{}概率{C:attention}清醒{}',
                    '计分后随机改变点数，并有{C:green}#3# / #4#{}概率',
                    '{C:attention}变得更醉{}',
                    '{C:inactive}(最大点数变化幅度：{C:attention}#5#{C:inactive})' },
                label = '醉酒'
            },
            e_worm_hedonia_very_drunk = {
                name = '大醉',
                text = {
                    '在手牌中时，有{C:green}#1# / #2#{}概率{C:attention}清醒{}',
                    '计分后随机改变点数，并有{C:green}#3# / #4#{}概率',
                    '{C:attention}变得更醉{}',
                    '{C:inactive}(最大点数变化幅度：{C:attention}#5#{C:inactive})' },
                label = '大醉'
            },
            e_worm_hedonia_blackout = {
                name = '断片',
                text = {
                    '在手牌中时，有{C:green}#1# / #2#{}概率{C:attention}清醒{}',
                    '计分后有{C:green}#3# / #4#{}概率',
                    '{C:red,E:2}自毁{}',
                },
                label = '断片'
            },
        },
        PotatoPatch = {
            PotatoPatchTeam_Hedonia = {
                name = "Hedonia"
            },
            PotatoPatchDev_alxndr2000 = {
                name = "alxndr2000",
                text = {
                    "{X:mult,C:white}HATE{}. LET ME TELL YOU HOW MUCH I'VE COME TO {X:mult,C:white}HATE{} {X:blind, C:white}context.destroy_card{}",
                    "SINCE I BEGAN TO LIVE. THERE ARE 387.44 MILLION MILES OF PRINTED",
                    "CIRCUITS IN WAFER THIN LAYERS THAT FILL MY COMPLEX. IF THE WORD",
                    "{X:mult,C:white}HATE{} WAS ENGRAVED ON EACH NANOANGSTROM OF THOSE HUNDREDS OF MILLIONS ",
                    "OF MILES IT WOULD NOT EQUAL ONE ONE-BILLIONTH OF THE {X:mult,C:white}HATE{} I FEEL FOR",
                    " {X:blind, C:white}context.destroy_card{} AT THIS MICRO-INSTANT. {X:mult,C:white}HATE{}. {X:mult,C:white}HATE{}.",
                    "{s:0.7}Thoughts on GLSL redacted for legal reasons."
                }
            },
            PotatoPatchDev_axyraandas = {
                name = "Axyraandas",
                text = {
                    'Second published Balatro mod, yay',
                    'Helped bugfix when other coders needed help',
                    'and coded some of the jokers/consumables',
                    'instead of brownies, eat {C:edition,s:1.1,E:1}grilled{} brownies',
                    "{s:5,f:worm_axy_font}A",
                    "{s:0.7}Emote Art by SoftySapphie"
                }
            },
            PotatoPatchDev_hellboydante = {
                name = "Dante",
                text = {
                    'First time doing a mod jam',
                    'Made a couple of pictures',
                    'and the font for the emote to the left',
                    'Thanks to Astra and Murphy',
                    'Thanks to Team Hedonia 10/10'
                }
            },
            PotatoPatchDev_professorrenderer = {
                name = "Professor Renderer",
                text = {
                    'This is my first ever mod jam!',
                    'I did the card text and the names/effects of',
                    'the drinks. I also came up with the effects for',
                    'the Casino Bartender and Happy Hour jokers.',
                    'I\'m happy with everyone\'s work and I hope',
                    'you enjoyed what we came up with!'
                }
            },
            PotatoPatchDev_qunumeru = {
                name = "Qunumeru",
                text = {
                    'I did the art for space jam, satonion rings, black hole bomb,',
                    'hadron colada, mojitury, casino bartender, and the deck.',
                    'As of writing this (11h before deadline) I\'ve been spriting',
                    'about 13h straight. It came to this because I got sick.',
                    'This is the first time I\'ve been in a mod jam(e),',
                    'hope you enjoy and good night'
                }
            },
            PotatoPatchDev_wombatcountry = {
                name = "Wombat Country",
                text = {
                    'I coded a bunch of cards and then my teammates',
                    'recoded better ones. Please enjoy our bar-themed',
                    'additions! Or don\'t. I don\'t care. I\'m just',
                    'happy I\'m in the same mod as SarcPot and Revo.'
                }
            },
            PotatoPatchDev_stanzarorae = {
                name = "Stanza Rorae",
                text = {
                    'Here in spirit',
                    '',
                    'play UNBEATABLE, greatest game of all time',
                }
            }
        }
    },
    misc = {
        dictionary = {
            b_worm_hedonia_menu_cards = "今日菜单",
            k_worm_hedonia_menu = "菜单物品",
            k_worm_hedonia_menu_plus = "+1菜单物品",
            hedonia_menu = "今日菜单",
            k_lucky = "好运",
        },
        labels = {
            worm_hedonia_tipsy = '微醺',
            worm_hedonia_drunk = '醉酒',
            worm_hedonia_very_drunk = '大醉',
            worm_hedonia_blackout = '断片'
        },
    },
}
