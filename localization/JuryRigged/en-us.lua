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
    },
    PotatoPatch = {
      PotatoPatchTeam_JuryRigged = { name = "JuryRigged" },
      PotatoPatchDev_DowFrin = { name = "DowFrin", text = { { "Hopefully i remember to change this after im done testing lol" }, { "oh also we have multi box support" } } },
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
      k_worm_jr_satellite = "Satellite",
      b_worm_jr_satellites = "Satellites",
      b_worm_jr_satellite_cards = "Satellite Cards",


      -- Satellite names for Run Info
      worm_jr_satellites_new_horizon = "New Horizon",
      worm_jr_satellites_messenger = "MESSENGER",
      worm_jr_sattellites_tianwen_4 = "Tianwen-4",
      worm_jr_sattellites_venera_9 = "Venera 9",
      worm_jr_sattellites_galileo = "Galileo",
      worm_jr_sattellites_cassini_huygens = "Cassini-Huygens",
      worm_jr_sattellites_sputnik_1 = "Sputnik 1",
      worm_jr_sattellites_mariner_9 = "Mariner 9",
      worm_jr_sattellites_voyager_2 = "Voyager 2",
      worm_jr_sattellites_death_egg = "Death Egg",
      worm_jr_sattellites_dawn = "Dawn",
      worm_jr_sattellites_manhole_cover = "Manhole Cover",

      -- Satellite ability descriptions for Run Info
      jr_satellite_descriptions_new_horizon = "This satellite {C:mult}fixes{} your {C:attention}marriage{}"
    }
  }
}
