CREATORS = ["wizard", "druid", "ancient", "beholder", "dragon", "dwarf", "lich"]
CLIMATES = ["arctic", "temperate", "desert", "swamp", "jungle"]
FACTIONS = ["undead", "goblin", "beast", "bandit", "demon", "nature", "dragon", "spirit", "underdark", "beholder"]
FUNCTIONS = ["catacomb", "fort", "monastary", "outpost", "lair", "mine"]
MATERIALS = { "stone" =>
    {
        "name" => "stone",
        "colors" => ["black", "dark grey", "grey", "blue grey", "brown", "dark orange", "dark red"],
        "adjectives" => ["carved", "chipped", "weathered", "cracked", "volcanic", "crumbling", "jagged", "sandy", "smoothed"],
        "climates" => ["all"]
    },
    "brick" => {
        "name" => "brick",
        "colors" => ["black", "dark grey", "grey", "blue grey", "brown", "dark orange", "dark red"],
        "adjectives" => ["carved", "chipped", "weathered", "cracked", "crumbling", "ancient"],
        "climates" => ["all"]
    },
    "ice" => {
        "name" => "ice",
        "colors" => ["white", "grey", "black", "blue"],
        "adjectives" => ["carved", "smoothed", "melting", "chipped", "weeping"],
        "climates" => ["arctic"]
    }
}
ROOM_TYPES = {
    "general" => [
        "chapel", "apartment", "storeroom", "lavatory", "kitchen", "larder", "pantry", "passageway", "corridor", "vault", "archive", "infirmary", "library", "observatory", "auditorium", "map room", "well room", "hidden apothecary", "waste room"
    ],
    "catacomb" => [
        "gallery", "atrium", "chamber", "hypogeum", "tomb", "crypt", "grotto", "annex", "bone pit", 
    ],
    "fort" => [
        "large_hall", "barracks", "solar", "gatehouse", "guardroom", "cabinet", "casemate", "cellar", "armory", "smithy"
    ],
    "monastary" => [
        "oratory", "reliquary", "cloister", "chapter hall", "refectory", "dormatory", "temple", "stupa", "residence hall", "meditation hall", "conservatory", "sun room"
    ],
    "outpost" => [
        "auction house", "cold storage", "dry storage", "workers quarters", "bath house", "cellar", "abandoned tavern", "smithy", "abandoned market", "guard house"
    ],
    "lair" => [
        "cesspit", "torture chamber", "natural cavern", "narrow tunnel", "throne room", "statuary", "gaol", "trophy room", "ballroom"
    ],
    "mine" => [
        "workshop", "sinkhole", "abandoned quarry", "open shaft", "mining tunnel", "mushroom cavern", "cart station"
    ],
    "wizard" => [
        "laboratory", "study", "library", "lecture hall", "enchanting room", "summoning circle", "scroll room"
    ],
    "druid" => [
        "circle of standing stones", "sacraficial chamber", "fungus garden", "animal's den", "overgrown chamber", "apothecary"
    ],
    "ancient" => [
        "ruined temple", "large fire pit", "collapsed hall", "burned library", "fighting pit"
    ],
    "beholder" => [
        "blasted tunnel", "carnarium", "hall of eyes", "mass grave"
    ],
    "dragon" => [
        "looted treasure room", "chamber scorched to ash", "offering room", "melted gaol"
    ],
    "dwarf" => [
        "mushroom garden", "master smithy", "hall of lords", "colonnade hall", "ruined brewery", "armory", "dormatory", "chorus hall", "hammer room"
    ],
    "lich" => [
        "hall of lore", "vortex chamber", "summoning room", "defiled chapel", "torture chamber", "room of skulls", 
    ]
}

def get_room_types(creator, function)
    rooms = ROOM_TYPES[creator].concat(ROOM_TYPES[function])
    rooms.concat(ROOM_TYPES["general"])
end

def get_material(climate)
    possible = []
    MATERIALS.each do |name, material|
        if material[ "climates"].include?(climate) || material[ "climates"] == ["all"]
            possible << name
        end
    end
    material = MATERIALS[possible.sample]
    {"name" => material["name"], "color" => material[ "colors"].sample, "adjective" => material["adjectives"].sample}
end

def load_dungeon_build_table()
    chars = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a)
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

