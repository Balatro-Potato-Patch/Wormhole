return {
  descriptions = {
    worm_jr_satellite = {
      sat_worm_new_horizon = {
        name = "New Horizon",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "After playing a {C:attention}#2#{},",
            "draw {C:attention}#1#{} more card#3#"
          }
        }
      },
      sat_worm_messenger = {
        name = "MESSENGER",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand is a {C:attention}#2#{},",
            "{C:attention}unscored{} cards have a {C:green}#3# in #4#",
            "chance to give {C:money}$#1#{}"
          }
        }
      },
      sat_worm_tianwen_4 = {
        name = "Tianwen 4",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "create {C:attention}#1#{} cop#3# of",
            "#4#random scoring card#5#"
          }
        }
      },
      sat_worm_sputnik_1 = {
        name = "Sputnik 1",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "last played card gives",
            "{C:white,X:mult}X#3#{} Mult when scored"
          }
        }
      },
      sat_worm_mariner_9 = {
        name = "Mariner 9",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand is a",
            "{C:attention}#2#{}, gain {C:money}$#1#{} per card",
            "of the rank of the {C:attention}#2#",
            "in your {C:attention}full deck"
          }
        }
      },
      sat_worm_voyager_2 = {
        name = "Voyager 2",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "cards in scoring hand",
            "permanently gain {C:white,X:mult}X#3#{} Mult"
          }
        }
      },
      sat_worm_manhole_cover = {
        name = "Manhole Cover",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "retrigger {C:attention}#1#{} card#3#",
            "at random"
          }
        }
      },
    },
    Voucher = {
      v_worm_jr_launch_pad = {
        name = 'Launch pad',
        text = {
          "Adds {C:attention}#1#{} {C:worm_jr_satellite}Satellite{} card",
          "to opened {C:Planet}Celestial{} packs"
        }
      },
      v_worm_jr_flyby = {
        name = 'Fly-By',
        text = {
          "{C:worm_jr_satellite}Satellite{} cards create a {C:dark_edition}Negative{} {C:planet}Planet{} card",
          "for their {C:attention}corresponding hand type{} when used"
        }
      },
    },
    Joker = {
      j_worm_jr_transponder = {
        name = "Transponder",
        text = {
          "Gains {X:mult,C:white}X#1#{} Mult for",
          "every {C:worm_jr_satellite}Satellite{} above 0",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
      },
      j_worm_jr_nasa = {
        name = "NASA",
        text = {
          "After defeating a {C:attention}Boss Blind{}, create the",
          "corresponding {C:worm_jr_satellite}Satellite{} card",
          "for your {C:attention}last played hand",
        }
      },
    },
    Other = {
      p_worm_jr_orbital_normal = {
        name = "Orbital Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:worm_jr_satellite}Satellite{} cards",
          "to be used immediately"
        }
      },
      p_worm_jr_orbital_jumbo = {
        name = "Jumbo Orbital Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:worm_jr_satellite}Satellite{} cards",
          "to be used immediately"
        }
      },
      p_worm_jr_orbital_mega = {
        name = "Mega Orbital Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:worm_jr_satellite}Satellite{} cards",
          "to be used immediately"
        }
      },
    },
    Tag = {
      tag_worm_jr_planetarium = {
        name = "Planetarium Tag",
        text = {
          "Gives a free",
          "{C:worm_jr_satellite}Mega Orbital Pack"
        }
      },
    },
    PotatoPatch = {
      PotatoPatchTeam_JuryRigged = { name = "JuryRigged" },
      PotatoPatchDev_DowFrin = { name = "DowFrin", text = { { "Hopefully i {C:red}remember{} to change this after im done testing lol" }, { "oh also we have multi box support" } } },
      PotatoPatchDev_Maelmc = { name = "Maelmc", text = { "Insert something here" } },
      PotatoPatchDev_Inky = { name = "Inky", text = { "Got something to say?" } },
      PotatoPatchDev_DoggFly = { name = "DoggFly", text = { "Just here to take up space" } },
      PotatoPatchDev_AbelSketch = { name = "AbelSketch", text = { "Did you know that strings are immutable in lua" } },
      PotatoPatchDev_Blanthos = { name = "Blanthos", text = { "blanthos blanthos blanthos" } },
      PotatoPatchDev_NinjaBanana = { name = "NinjaBanana", text = { "Something about a bright one" } },
    }
  },
  misc = {
    dictionary = {
      -- Standard badge text
      k_worm_jr_satellite = "Satellite",
      -- For Death Egg and Manhole
      k_worm_jr_satellite_fake = "Satellite..?",

      b_worm_jr_satellites = "Satellites",
      b_worm_jr_satellite_cards = "Satellite Cards",

      worm_jr_orbital_pack = "Orbital Pack",

      -- Satellite names for Run Info
      worm_jr_satellites_new_horizon = "New Horizon",
      worm_jr_satellites_messenger = "MESSENGER",
      worm_jr_satellites_tianwen_4 = "Tianwen-4",
      worm_jr_satellites_venera_9 = "Venera 9",
      worm_jr_satellites_galileo = "Galileo",
      worm_jr_satellites_cassini_huygens = "Cassini-Huygens",
      worm_jr_satellites_sputnik_1 = "Sputnik 1",
      worm_jr_satellites_mariner_9 = "Mariner 9",
      worm_jr_satellites_voyager_2 = "Voyager 2",
      worm_jr_satellites_death_egg = "Death Egg",
      worm_jr_satellites_dawn = "Dawn",
      worm_jr_satellites_manhole_cover = "Manhole Cover",

      worm_jr_plus_satellite = "+1 Satellite",
    }
  }
}
