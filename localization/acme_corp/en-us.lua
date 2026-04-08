return {
    descriptions = {
        ACME_Gadget = {
            c_worm_acme_ball = {
                name = 'Ball',
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
                name = 'ACME Disintegrator-Inverse-Atron'
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
