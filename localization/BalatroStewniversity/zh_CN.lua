return {
    descriptions = {
        Joker = {
            j_worm_stew_stew_earth = {
                name = "炖汤地球",
                text = {
                    '{X:mult,C:white}X#1#{}倍率,',
                    '如果分数{C:attention}着火{},增加{X:mult,C:white}X#2#{}倍率',
                    '否则失去{X:mult,C:white}X#3#{}倍率'
                },
            },

            j_worm_stew_flat_earth = {
                name = '超平坦地球',
                text = {
                    "你{C:attention}牌组{}中每有一张",
                    "非{C:spades}黑桃{}牌便{C:chips}+#2#{}筹码",
                    "{C:inactive}(当前为{C:chips}+#1#{C:inactive}筹码)",
                } 
            },

            j_worm_stew_dinosaur_earth = {
                name = '恐龙地球',
                text = {
                    '{C:green}#1# / #2#{}概率',
                    '{C:attention}-#4#{}底注',
                    '然后所有恐龙地球在回合结束时',
                    '在回合结束时{C:red,E:2}灭绝{}'
                }
            },

            j_worm_stew_dinosaur_earth_alt = {
                name = '恐龙地球',
                text = {
                    '{s:2,E:1,C:red}灭绝!'
                }
            },

            j_worm_stew_impact_crater = {
                name = '陨石坑',
                text = {
                    '{C:green}#2# / #3#{}概率在离开{C:attention}商店{}时',
                    '创建一个{C:attention,T:tag_meteor}#1#'
                    }
            },

            j_worm_stew_staged_landing = {
                name = '分级着陆',
                text = {
                    '在本回合每弃一张{C:clubs}梅花{}牌',
                    '这个小丑获得{C:mult}+#2#{}倍率',
                    '{C:inactive}(当前为{C:mult}+#1#{C:inactive}倍率)'
                }
            },

            j_worm_stew_stardust = {
                name = '星尘',
                text = {
                    '每打出{C:attention}#2#{C:inactive} [#3#]张{C:diamonds}方片{}牌计分',
                    '这个小丑获得{C:money}$#1#{}{C:attention}售卖价值{'
                }
            },

            j_worm_stew_8_ball_earth = {
                name = '8号球地球',
                text = {
                    '如果打出的牌型是{C:attention}#1#',
                    '用随机{C:tarot}塔罗{}, {C:planet}星球{},或{C:inactive,s:0.8}(小概率){} {C:spectral}幻灵{}牌',
                    '{C:attention}填满{}你的消耗牌槽位',
                    '{C:inactive}(必须有空间)'
                }
            },

            j_worm_stew_stargazer = {
                name = '观星者',
                text = {
                    '每拥有一张{C:tarot}星星{}或{C:planet}星球{}牌',
                    '便获得{X:mult,C:white}X#1#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#2#{C:inactive}倍率)'
                }
            },

            j_worm_stew_geocentrism = {
                name = '地心说',
                text = {
                    "打出的",
                    "{C:hearts}红桃{}花色牌",
                    "计分时{X:mult,C:white} X#1# {}倍率",
                }
            },

            j_worm_stew_astrologer = {
                name = '占星师',
                text = {
                    "使用一张{C:tarot}塔罗{}牌后",
                    "创建一张{C:planet}星球{}牌",
                    "{C:inactive}(必须有空间)",
                }
            },

            j_worm_stew_cheese_moon = {
                name = '芝士月亮',
                text = {
                    '接下来的{C:attention}#1#{}次出牌',
                    '{C:green}#2# / #3#{}概率摧毁计分时的',
                    '{C:attention}最后{}一张牌'
                }
            },

            j_worm_stew_chicken_egg = {
                name = '悖论地球',
                text = {
                    '触发时{C:chips}+筹码{}等同于两倍',
                    '{C:chips}筹码{}',
                }
            },

            j_worm_stew_chicken_egg_alt = {
                name = '悖论地球',
                text = {
                    "{X:chips,C:white}X#1#{}筹码"
                }
            },

            j_worm_stew_capitalism = {
                name = '纯净小丑',
                text = {
                    "当前金钱每比利息上限低{C:money}$#3#{}",
                    "便{C:chips}+#2#{}筹码",
                    "{C:inactive}(当前为{C:chips}+#1#{C:inactive}筹码)",
                    " {s:0.8,C:inactive}-------",
                    "{s:0.8,C:inactive}\"我要逃到",
                    "{s:0.8,C:inactive}那个唯一没被",
                    "{s:0.8,C:inactive}资本主义污染的地方!\"",
                }
            },

            j_worm_stew_sputnik = {
                name = '航天探测器',
                text = {
                    "{C:inactive}[正在接收传输...]"
                }
            },

            j_worm_stew_starfish_earth = {
                name = '海洋地球鱼',
                text = {
                    "在回合结束时",
                    "你每拥有{C:money}$#2#{}",
                    '便获得{C:money}$#1#{}'
                }
            },

        },

        Tarot = {
            c_worm_stew_orbit = {
                name = "轨道",
                text = {
                    "每个高于{C:attention}1{}{C:attention}级{}的牌型",
                    "使你获得{C:money}$#1#{}",
                    "{C:inactive}(最高{C:money}$#2#{C:inactive})",
                    '{C:inactive}(当前为{C:money}$#3#{C:inactive})'
                },
           },
        },

        Spectral = {
            c_worm_stew_solar_flare = {
                name = "太阳耀斑",
                text = {
                    "{C:attention}削弱{}你的所有手牌",
                    "{C:attention}每张{}削弱的手牌{C:attention}升级{}一种随机牌型",
                },
           },
        },


        Edition = {
            e_worm_stew_stellar = {
                name = "群星",
                text = {
                    "{C:green}#1# / #2#{}概率",
                    "升级打出的{C:attention}牌型{}"
                },
            }
        },

        Tag = {
            tag_worm_stew_stellar = {
                name = "群星标签",
                text = {
                    "下个商店中没有{C:dark_edition}版本{}的",
                    "{C:attention}小丑{}免费并且变为{C:dark_edition}群星",
                },
           },
        },

        Blind = {
            bl_worm_stew_pull = {
                name = "牵引力",
                text = {
                    "本局游戏中",
                    "每个玩过的回合",
                    "+2X盲注大小",
                },
           },
        },

        PotatoPatch = {
            stew = {
                name = "Balatro Stewniversity"
            },
            stupxd = {
                name = "stupxd",
                text = {
                    "Play {C:red}Balatro{}, I heard",
                    "it's a great game!",
                }
            },
            PLagger = {
                name = "PLagger",
                text = {
                    "Shout out {C:money}Cheese{C:green}Pear{} and {C:green}Phrog{}, you two are",
                    'the {s:2,E:1,C:attention}GOAT{s:0.8,C:inactive}Lybear Lybear{}',
                    '',
                    'Also Ado nation rise up'
                }
            },
            dottykitty = {
                name = "dottykitty",
                text = {
                    "Did you know?",
                    "When the big bang happened,",
                    "DrSpectred was there.",
                    "He wrote a paragraph about it.",
                }
            },
            Wingcap = {
                name = "Wingcap",
                text = {
                    "Did you know you can",
                    "play RuneScape on your",
                    "phone as well as your",
                    "second monitor?",
                }
            },
            tuzzo = {
                name = "tuzzo",
                text = {
                    "This stew is new to me,",
                    "but I am honored to be a part of it",
                }
            },
            HonuKane = {
                name = "HonuKane",
                text = {
                    "womp womp",
                }
            },
            harmonywoods = {
                name = "harmonywoods",
                text = {
                    "womp womp",
                }
            },
        },
    },
    misc = {
        dictionary = {
            k_worm_stew_dinos_extinct = '灭绝',
            k_worm_stew_yum = 'Yum!',
            k_worm_stew_cook = 'Let Him Cook!',
            k_worm_stew_uncook = 'Stove\'s Off...',
        },
        labels = {
            worm_stew_stellar = '群星'
        },
        achievement_names = {
            ach_worm_stew_spaced_joker = '太空小丑',
            ach_worm_stew_extinction_event = '灭绝事件',
            ach_worm_stew_true_communist = '真正的共产主义者',
            ach_worm_stew_perpetual_stew = '永续炖菜',
        },
        achievement_descriptions = {
            ach_worm_stew_spaced_joker = '拥有一张群星版本的太空小丑',
            ach_worm_stew_extinction_event = '遇到一场灭绝事件',
            ach_worm_stew_true_communist = '使用纯净小丑获得至少+750筹码',
            ach_worm_stew_perpetual_stew = '使用炖汤地球获得至少x10倍率',
        }
        

    },
}
