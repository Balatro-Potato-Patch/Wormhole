return {
    descriptions = {
        PotatoPatch = {
            k_team_ibuprofen = {
                name = "Team Ibuprofen",
            },
            d_twigi = {
                name = "Twigi",
                text = {
                    "Lead Programmer", "Artist of", "Eclipse, Supergiant, Nebula", "Extremely Swag B)"
                }
            },
            d_joos = {
                name = "Oasis-J",
                text = {
                    "Lead Artist", "Programmer of", "Cosmic, Dyson Sphere & Event Horizon", '~My body is a machine',
                    'that turns hyperdrive into', 'the worst art ever~'
                }
            },
            d_avery = {
                name = "AveryIGuess",
                text = {
                    "Concept Art", "Frozen Card Idea", "Laika, Shining Star, Permafrost", "Space Heater & Jettison",
                    "Mechanic Ideas", "Chomping Rocks"
                }
            },
        },
        Tarot = {
            c_worm_ibu_mountain = {
                name = '山丘',
                text = {
                    "将{C:attention}#1#{}张",
                    "选中牌强化为",
                    "{C:attention}#2#{}"
                }
            }
        },
        Spectral = {
            c_worm_ibu_eclipse = {
                name = '日食',
                text = {
                    "给予{C:attention}#1#{}张",
                    "选中牌{C:dark_edition}负片{}"
                }
            },
            c_worm_ibu_nebula = {
                name = '星云',
                text = {
                    "给予{C:attention}#1#{}张",
                    "选中牌{C:dark_edition}宇宙{}"
                }
            },
            c_worm_ibu_supergiant = {
                name = '超巨星',
                text = {
                    "将一张选中牌的{C:chips}筹码{}{C:attention}翻三倍{}"
                }
            }
        },
        Edition = {
            e_worm_ibu_cosmicedition = {
                label = "宇宙",
                name = "宇宙",
                text = {
                    "计分时，每级",
                    "{C:attention}所打牌型的等级{}给予{C:mult}+#1#{}倍率"
                },
            }
        },
        Enhanced = {
            m_worm_ibu_frozen = {
                name = '冰冻牌',
                text = {
                    "每回合{C:attention}一次{}",
                    "若被打出或丢弃",
                    "{C:attention}返回手牌{}"
                }
            }
        },
        Joker = {
            j_worm_ibu_enginefailure = {
                name = '引擎故障',
                text = {
                    "{X:mult,C:white}X#1#{}倍率",
                    "若分数{C:attention}着火{}则{C:mult}自毁{}"
                }
            },
            j_worm_ibu_dyson = {
                name = '戴森球',
                text = {
                    "你的{C:attention}消耗牌{}槽位中的",
                    "每张{C:tarot}太阳{}或",
                    "{C:tarot}星星{}牌",
                    "给予{X:mult,C:white}X#1#{}倍率",
                },
            },
            j_worm_ibu_horizon = {
                name = "事件视界",
                text = {
                    "每超出{C:attention}等级最低牌型{}",
                    "1级,给予{X:red,C:white}X#1#{}倍率",
                    "{C:inactive}（当前为：{X:red,C:white}X#2#{C:inactive}倍率）"
                },
            },
            j_worm_ibu_redshift = {
                name = '红移',
                text = {
                    "打出的{C:attention}强化牌{}计分时",
                    "给予{C:mult}+#1#{}倍率"
                }
            },
            j_worm_ibu_permafrost = {
                name = '永久冻土',
                text = {
                    "{C:attention}冰冻牌{}",
                    "总是返回手牌"
                }
            },
            j_worm_ibu_laika = {
                name = '莱卡',
                text = {
                    "根据本局{C:attention}最常用牌型{}",
                    "打出次数，每回合结束获得{C:money}$#2#{}",
                    "{C:inactive}(当前为:{C:money}$#1#{C:inactive})"
                }
            },
            j_worm_ibu_hyperdrive = {
                name = '超空间',
                text = {
                    "获得{C:money}双倍金钱${}",
                    "但{C:attention}底注{}增长速度翻倍"
                }
            },
            j_worm_ibu_terraforming = {
                name = '地球化改造',
                text = {
                    "每当使用一张{C:planet}#1#{}时",
                    "创建一张{C:planet}地球{}",
                    "{C:inactive,s:0.8}所需星球牌每回合变化",
                }
            },
            j_worm_ibu_jettison = {
                name = '抛射',
                text = {
                    '{C:attention}第一张丢弃的{}手牌',
                    '变为{C:attention}冰冻牌{}',
                },
            },
            j_worm_ibu_brood = {
                name = '育母',
                text = {
                    "每当打出一张{C:attention}Q{}时",
                    "摧毁一张随机手牌",
                    "并创建一张{C:attention}J{}"
                }
            },
            j_worm_ibu_warpgate = {
                name = '虫洞',
                text = {
                    "{C:attention}#2#回合{}后出售此牌",
                    "使一张随机小丑牌获得{C:Legendary}永恒{}标签",
                    "{C:inactive}（当前还剩:{C:attention}#1#/#2# {C:inactive}回合）"
                }
            },
            j_worm_ibu_heater = {
                name = '太空加热器',
                text = {
                    '融化打出的{C:attention}冰冻牌{}',
                    '并给予{X:mult,C:white} X#2# {}倍率',
                    '{C:inactive}当前为{X:mult,C:white} X#1# {}'
                },
            },
            j_worm_ibu_asteroidmining = {
                name = '小行星采矿',
                text = {
                    '每张{C:attention}冰冻牌{}计分时',
                    '获得{C:money}$#1#{}'
                },
            },
            j_worm_ibu_shiningstar = {
                name = '闪耀之星',
                text = {
                    "如果打出的牌型是",
                    "单张{C:diamonds}方片{}牌，",
                    "使其重新触发{C:attention}#1#{}次"
                }
            }
        }
    },
    misc = {
        labels = {
            worm_ibu_cosmicedition = '宇宙'
        },
    },
}
