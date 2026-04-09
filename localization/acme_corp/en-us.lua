return {
    descriptions = {
        ACME_Gadget = {
            c_worm_acme_ball = {
                name = 'ACME "Bounce-O-Matic" Spherical Impact Projectile',
                text = {
                    '{X:attention,C:white}After{} scoring {C:attention}#1# #2#{},',
                    '{X:attention,C:white}Use{} to give a random {C:attention}enhancement',
                    'to all {C:attention}unenhanced Face Cards',
                    '{C:attention}held in hand'
                }
            },
            c_worm_acme_ball_alt = {
                name = 'Ball',
                text = {
                    'Give a random {C:attention}enhancement',
                    'to all {C:attention}unenhanced Face Cards',
                    '{C:attention}held in hand'
                }
            },
            c_worm_acme_ray_gun = {
                name = 'ACME Disintegrator-Inverse-Atron',
                text = {
                    "{X:attention,C:white}After{} selling {C:attention}#1#{} cards",
                    "{X:attention,C:white}Use{} to apply a random {C:dark_edition}Edition{}",
                    "to a random held {C:attention}Joker{}",
                    "{S:0.8,C:inactive}(Currently {C:attention,S:0.8}#2#{}{S:0.8,C:inactive})"
                }
            },


            c_worm_acme_jam = {
                name = 'ACME Spreadable Berry Conserve',
                text = {
                    '{X:attention,C:white}After{C:attention} #1# #2#{} trigger in hand,',
                    '{X:attention,C:white}Use{} to {C:attention}upgrade{} every',
                    '{E:1,C:legendary}poker hand{} by {C:attention}1 Level'
                }
            },
            c_worm_acme_jam_alt = {
                name = 'ACME Spreadable Berry Conserve',
                text = {
                    '{C:attention}Upgrade{} every',
                    '{E:1,C:legendary}poker hand',
                    'by {C:attention}1 Level'
                }
            },
            c_worm_acme_trash = {
                name = 'ACME Accumulated Resources and Detritus',
                text = {
                    '{X:attention,C:white}After{C:attention} #1#{} #2# are discarded,',
                    '{X:attention,C:white}Use{} to get a random {C:attention}Perishable',
                    '{C:dark_edition}Negative {C:attention}Food Joker',
                }
            },
            c_worm_acme_trash_alt = {
                name = 'ACME Accumulated Resources and Detritus',
                text = {
                    '{X:attention,C:white}Use{} to get a random {C:attention}Perishable',
                    '{C:dark_edition}Negative {C:attention}Food Joker',
                }
            },
            c_worm_acme_mr_jr = {
                name = 'Legally Distinct ACME Automated Helper',
                text = {
                    '{X:attention,C:white}After{} opening {C:attention}#1# #2#{},',
                    '{X:attention,C:white}Use{} to create a random {C:mult}rare{} Joker',
                    '{C:inactive}Fixed {C:green}1 in 25{C:inactive} chance to become',
                    '{C:Legendary}Legendary{C:inactive} at the end of the shop',
                    '{C:inactive}(Must have room)'
                }
            },
            c_worm_acme_mr_jr_legendary = {
                name = 'Legally Distinct ACME Automated Helper',
                text = {
                    '{X:attention,C:white}After{} opening {C:attention}#1# #2#{},',
                    '{X:attention,C:white}Use{} to create a random {C:Legendary}Legendary{} Joker',
                    '{C:inactive}(Must have room)'
                }
            },
            c_worm_acme_mr_jr_alt = {
                name = 'Legally Distinct ACME Automated Helper',
                text = {
                    '{X:attention,C:white}Use{} to create a random {C:mult}rare{} Joker',
                    '{C:inactive}Fixed {C:green}1 in 25{C:inactive} chance to become',
                    '{C:Legendary}Legendary{C:inactive} at the end of the shop',
                    '{C:inactive}(Must have room)'
                }
            },
            c_worm_acme_mr_jr_legendary_alt = {
                name = 'Legally Distinct ACME Automated Helper',
                text = {
                    '{X:attention,C:white}Use{} to create a random {C:Legendary}Legendary{} Joker',
                    '{C:inactive}(Must have room)'
                }
            },
            c_worm_acme_wineglass = {
                name = 'ACME Refill-O-Matic Stemware',
                text = {
                    '{X:attention,C:white}After{} a {C:attention}glass card{} is destroyed,',
                    '{X:attention,C:white}Use{} to create {C:attention}#1#{} permanent',
                    '{C:attention}glass #2#{} of selected card.',
                    '{C:inactive}Number increases by 1 whenever',
                    '{C:inactive}a glass card is destroyed.'
                }
            },
            c_worm_acme_wineglass_alt = {
                name = 'ACME Refill-O-Matic Stemware',
                text = {
                    '{X:attention,C:white}Use{} to create {C:attention}#1#{} permanent',
                    '{C:attention}glass #2#{} of selected card.',
                    '{C:inactive}Number increases by 1 whenever',
                    '{C:inactive}a glass card is destroyed.'
                }
            },
        },
        Joker = {
            j_worm_ACME_enterprise = {
                name = "Enterprise Joker",
                text = {
                    '{C:chips}+#1#{} Chips for each',
                    '{C:attention}unique{} {C:planet}Planet{} card',
                    'used this run',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)'
                },
            },
            j_worm_acme_test_dummy = {
                name = 'Test Dummy',
                text = {
                    '{C:acme_gadget}Gadgets{} become {C:dark_edition}Negative',
                    'when obtained'
                }
            },
        },
        Other = {
            undiscovered_acme_gadget = {
                name = 'Undiscovered',
                text = {
                    'Purchase or use',
                    'this card in an',
                    'unseeded run to',
                    'learn what it does',
                },
            },
        },
        PotatoPatch = {
            PotatoPatchTeam_ACME = {
                name = 'ACME Corporation',
            },
            PotatoPatchDev_RadiationV2 = {
                name = "RadiationV2",
                text = {
                    { "It's" },
                },
            },
            PotatoPatchDev_FlameThrowerFIM = {
                name = "FlameThrowerFIM",
                text = {
                    { "Snowing" },
                },
            },
            PotatoPatchDev_Opal = {
                name = "Opal",
                text = {
                    { "On" },
                },
            },
            PotatoPatchDev_Youh = {
                name = "Youh !",
                text = {
                    { "Mount" },
                },
            }
            ,
            PotatoPatchDev_Basil_Squared = {
                name = "Basil_Squared",
                text = {
                    { "Fuji" },
                },
            }
        }
    },
    misc = {
        dictionary = {
            k_acme_gadget = 'Gadget',
            b_acme_gadget_cards = 'Gadget Cards',
            k_aces = 'Aces',
            k_ace = 'Ace',
            k_boosters = 'Booster Packs',
            k_booster = 'Booster Pack',
            k_cards = 'Cards',
            k_card = 'Card',
            k_copies = 'Copies',
            k_copy = 'Copy',
            k_stocked = 'in stock',
            k_remaining = 'Remaining',

            k_acme_test_dummy_1 = 'Crash!',
            k_acme_test_dummy_2 = 'Bang!',
            k_acme_test_dummy_3 = 'Wallop!',
            k_acme_test_dummy_4 = 'Hello.',
        },
        labels = {
            acme_gadget = 'Gadget',
        }
    }
}
