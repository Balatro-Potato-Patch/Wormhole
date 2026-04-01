SMODS.Joker {
    key = "alienx",
    rarity = 4,
    cost = 1,
    config = {
        extra = {

        }
    },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {

            }
        }
    end,
    loc_txt = {
        name = 'Alien X',
        text = {
            "Used planet cards",
            "have a {C:green}1 in 5{} chance",
            "to level up all hands"
        }
    },
    calculate = function(self,card,context)
        
    end
}