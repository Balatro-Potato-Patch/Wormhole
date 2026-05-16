return {
    descriptions = {

        ---POTATO PATCH---
        ------------------
        ---POTATO PATCH---
        
        PotatoPatch = {

            -- Team Name
            PotatoPatchTeam_shrug = {name = [[{f:5}¯\_(ツ)_/¯]]},

            -- RandomsongV2
            PotatoPatchDev_randomsongv2 = {
                name = "RandomsongV2",
                text = {
                    "I couldnt think of",
                    "what to put as sprite",
                    "so here is dancing rory nyte"
                }
            },
            
            -- Microwave
            PotatoPatchDev_microwave = {
                name = "Microwave",
                text = {
                    "locked in",
                    "wow!"
                }
            },
            
            -- Waffle
            PotatoPatchDev_waffle = {
                name = "Waffle",
                text = {
                    "nondescript agender entity",
                    "\"you guys ever listen to {C:edition}MCR{}?\""
                }
            },
            
            -- A Tired Guy
            PotatoPatchDev_atiredguy = {
                name = "A tired guy",
                text = {
                    "seems very tired",
                    "wow!"
                }
            },
            
            -- Edward Robinson
            PotatoPatchDev_edwardrobinson = {
                name = "Edward Robinson",
                text = {
                    "cool name",
                    "wow!"
                }
            },
        },



        ---JOKERS---
        ------------
        ---JOKERS---
        
        Joker = {

            -- SPACEWALK
            j_worm_shrug_spacewalk = {
                name = "太空漫步",
                text = {
                    "如果从上回合到现在",
                    "没有使用过{C:planet}星球{}牌，",
                    "则在{C:attention}回合结束{}时",
                    "生成一个{C:planet}流星标签{}"
                }
            },

            -- OKAY WITH IT
            j_worm_shrug_okay_with_it = {
                name = "勉强接受",
                text = {
                    "在计分前，将{C:attention}1{}张",
                    "随机打出但未计分的牌",
                    "强化为{C:attention}星云牌{}"
                }
            },

            -- BINARY SUNSET
            j_worm_shrug_binary_sunset = {
                name = "双星日落",
                text = {
                    "如果连续{C:attention}2{}次出牌",
                    "牌型均为{C:attention}两对{}",
                    "则创建一张随机的{C:dark_edition}外星生物{}牌",
                    "{C:inactive}(必须有空位){}"
                }
            },

            -- DARK MATTER
            j_worm_shrug_dark_matter = {
                name = "暗物质",
                text = {
                    "你{C:attention}完整牌组{}中",
                    "数量最多的{C:attention}花色{}",
                    "每张牌提供{X:red,C:white}X#1#{}倍率",
                    "数量第二多的{C:attention}花色{}",
                    "每张牌减少{X:red,C:white}X#1#{}倍率",
                    "{C:inactive}(当前倍率{}{X:red,C:white}X#2#{}{C:inactive}){}"
                }
            },
        },



        ---VOUCHERS---
        --------------
        ---VOUCHERS---
        
        Voucher = {

            -- FIRST CONTACT
            v_worm_shrug_first_contact = {
                name = "初次接触",
                text = {
                    "{C:dark_edition}外星生物{}牌",
                    "可能出现在任何",
                    "{C:planet}星球包{}中"
                }
            },

            -- FIRST CONTACT
            v_worm_shrug_trade_network = {
                name = "贸易网络",
                text = {
                    "{C:dark_edition}外星生物{}牌",
                    "可能出现在商店中"
                }
            },
        },



        ---ALIEN SETUP---
        -----------------
        ---ALIEN SETUP---
        
        Other = {
            p_worm_shrug_alien_normal_1 = {
                name = "目击包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:shrug_alien}外星生物{}牌中选择{C:attention}#1#{}张",
                    "立即使用",
                },
            },
            p_worm_shrug_alien_normal_2 = {
                name = "目击包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:shrug_alien}外星生物{}牌中选择{C:attention}#1#{}张",
                    "立即使用",
                },
            },
            p_worm_shrug_alien_jumbo = {
                name = "巨型目击包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:shrug_alien}外星生物{}牌中选择{C:attention}#1#{}张",
                    "立即使用",
                },
            },
            p_worm_shrug_alien_mega = {
                name = "超级目击包",
                text = {
                    "从{C:attention}#2#{}张",
                    "{C:shrug_alien}外星生物{}牌中选择{C:attention}#1#{}张",
                    "立即使用",
                },
            },
            undiscovered_shrug_alien = {
                name = "未发现",
                text = {
                    "在一场没有种子的流程中",
                    "购买这张牌来查看它的作用",
                },
            },
        },



        ---ENHANCEMENTS---
        ------------------
        ---ENHANCEMENTS---

        Enhanced = {

            -- NEBULOUS
            m_worm_shrug_nebulous = {
                name = "星云牌",
                text = {
                    "打出的牌型",
                    "{C:attention}+#1#{}临时等级#2#"
                }
            },

        },



        ---ALIENS---
        ------------
        ---ALIENS---

        shrug_alien = {
            c_worm_shrug_alien_spades = {
                name = '弗拉特伍兹怪物',
                text = {
                    '将牌组中最多{C:attention}#1#{}张',
                    '非{C:spades}黑桃{}牌随机转化为',
                    '{C:spades}黑桃{}，失去{C:money}$#2#',
                }
            },
            c_worm_shrug_alien_hearts = {
                name = '弗雷斯诺夜行者',
                text = {
                    '将牌组中最多{C:attention}#1#{}张',
                    '非{C:hearts}红桃{}牌随机转化为',
                    '{C:hearts}红桃{}，失去{C:money}$#2#',
                }
            },
            c_worm_shrug_alien_clubs = {
                name = '爬虫人',
                text = {
                    '将牌组中最多{C:attention}#1#{}张',
                    '非{C:clubs}梅花{}牌随机转化为',
                    '{C:clubs}梅花{}，失去{C:money}$#2#',
                }
            },
            c_worm_shrug_alien_diamonds = {
                name = '霍普金斯妖精',
                text = {
                    '将牌组中最多{C:attention}#1#{}张',
                    '非{C:diamonds}方片{}牌随机转化为',
                    '{C:diamonds}方片{}，失去{C:money}$#2#',
                }
            },
            c_worm_shrug_alien_martian = {
                name = "火星人",
                text = {
                    "将最多{C:attention}#1#{}张选中的牌",
                    "转化为{C:attention}最左侧{}牌的点数"
                },
            },
            c_worm_shrug_alien_nebulous = {
                name = "???",
                text = {
                    "手中的每张牌",
                    "有{C:green}#1# / #2#{}概率",
                    "变为{C:attention}星云牌{}"
                },
            },
            c_worm_shrug_alien_destroy = {
                name = "齐塔星人",
                text = {
                    "选择{C:attention}1{}张牌，",
                    "{C:red}摧毁{}手中",
                    "所有其他牌"
                },
            },
            c_worm_shrug_alien_skyfish = {
                name = "天鱼",
                text = {
                    "创建一张随机小丑的",
                    "{C:attention}易腐{}复制",
                },
            },
        },
        Tag = {
            tag_worm_shrug_conspiracy = {
                name = "阴谋标签",
                text = {
                    "获得一个免费的",
                    "{C:attention}目击包{}"
                }
            },
        },
    },




    -- MISC
    misc = {

        -- DICTIONARY
        dictionary = {
            k_shrug_plus_meteor = "+标签",
            k_shrug_alien_pack = "外星生物包",
            b_shrug_alien_cards = "外星生物牌",
            k_shrug_alien = "外星生物",
        },
    },
}
