if not SMODS.Attributes["alien"] then
    SMODS.Attribute{
        key = "alien"
    }
end

if not SMODS.Attributes["cat"] then
    SMODS.Attribute{
        key = "cat"
    }
end

if not SMODS.Attributes["fish"] then
    SMODS.Attribute{
        key = "fish"
    }
end

if not SMODS.Attributes["booster"] then
    SMODS.Attribute{
        key = "fish"
    }
end

function print_attributes()
    for key, value in pairs(SMODS.Attributes) do
        print(key)
    end
end