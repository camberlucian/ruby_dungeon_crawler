CREATORS = ["wizard", "druid", "necromancer", "beholder", "dragon", "dwarf"]
CLIMATES = ["arctic", "temperate", "desert", "swamp", "jungle"]
FACTIONS = ["undead", "goblin", "beast", "bandit", "demon", "nature", "dragon", "spirit", "underdark", "beholder"]
FUNCTIONS = ["catacomb", "fort", "monastary", "outpost", "compound", "lair", "mine"]
MATERIALS = { "stone":
    {
        "name": "stone",
        "colors": ["black", "dark grey", "grey", "blue grey", "brown", "dark orange", "dark red"],
        "adjectives": ["carved", "chipped", "weathered", "cracked", "volcanic", "crumbling", "jagged", "sandy", "smoothed"],
        "climates": ["all"]
    },
    "brick": {
        "name": "brick",
        "colors": ["black", "dark grey", "grey", "blue grey", "brown", "dark orange", "dark red"],
        "adjectives": ["carved", "chipped", "weathered", "cracked", "crumbling", "ancient"],
        "climates": ["all"]
    },
    "ice": {
        "name": "ice",
        "colors": ["white", "grey", "black", "blue"],
        "adjectives": ["carved", "smoothed", "melting", "chipped", "weeping"],
        "climates": ["arctic"]
    }
}
ROOM_TYPES = {
    "general": [
        "chapel"
    ],
    "catacomb": [
        "gallery", "atrium", "chamber", "passageway", "corridor", "hypogeum", "tomb", "crypt", "grotto", "annex", "bone pit"
    ],
    "fort": [
        "large_hall", "barracks", "solar", "lavatory", "kitchen", "larder", "pantry", "gatehouse", "guardroom", "cabinet", "storeroom"
    ],

}

def get_material(climate)
    possible = []
    MATERIALS.each do |material|
        if martial["climates"].include?(climate) || materials["climates"] == ["all"]
            possible << material.name
        end
    end
    material = MATERIALS[possible.sample]
    {"name": material["name"], "color": material["colors"].sample, "adjective": material["adjectives"].sample}
end

def load_dungeon_build_table()
    chars = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).chars
    table = Hash.new
    table["creators"] = fill_table(CREATORS, chars)
    table["climates"] = fill_table(CLIMATES, chars)
    table["factions"] = fill_table(CREATORS, chars)
    table["functions"] = fill_table(FUNCTIONS, chars)
    table
end

def fill_table(list, characters)
    table = Hash.new
    i = 0
    characters.each do |char|
        table[char] = list[i]
        i += 1
        if i == list.size
            i = 0
        end
    end
    table
end

