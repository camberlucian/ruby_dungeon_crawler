require_relative "../objects/item"

ITEM_TYPES = ["mundane"]
ITEMS = {
    "mundane" => ["broken arrow", "cracked bottle", "broken hilt", "hand tool", "food scraps", "dented helmet", "torn sack", "dull knife", "beaker", "mortar and pestle", "clay bowl", "funnel", "roll of parchment", "human skull", "unknown skull", "wooden spatula", "wooden spoon", "coil of wire", "dull crystal", "brush", "comb", "kettle", "wooden pipe", "cracked plate", "quill", "saucer", "tankard", "whetstone", "pouch of nails", "bar of soap", "bolt of cloth", "set of dice", "cloth doll", "lump of resin", "dead rat", "small mirror", "seweing kit", "lantern", "pot of oil", "scale", "ruined book", "piece of chalk", "empty food tin", "plank", "metal ingot"]
}

def get_container_inventory(amt)
    i = 0
    inventory = []
    while i < amt
        type = ITEM_TYPES.sample
        inventory << Item.new(ITEMS[type].sample)
        i += 1
    end
    inventory
end