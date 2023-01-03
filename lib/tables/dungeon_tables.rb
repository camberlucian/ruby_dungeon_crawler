require_relative "../helpers"
require_relative "../objects/object"
require_relative "../objects/container"

CREATORS = ["wizard", "druid", "ancient", "beholder", "dragon", "dwarf", "lich"]
CLIMATES = ["arctic", "temperate", "desert", "swamp", "jungle"]
FACTIONS = ["undead", "goblin", "beast", "bandit"]
# shorter faction list for mvp
# FACTIONS = ["undead", "goblin", "beast", "bandit", "demon", "nature", "dragon", "spirit", "underdark", "beholder"]
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
        "chapel", "apartment", "storeroom", "lavatory", "kitchen", "larder", "pantry", "passageway", "corridor", "vault", "archive", "infirmary", "library", "observatory", "auditorium", "map room", "well room", "hidden apothecary", "waste room", "mill", "dining hall"
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
        "auction house", "cold storage", "dry storage", "workers quarters", "bath house", "cellar", "abandoned tavern", "smithy", "abandoned market", "guard house", "pavillion"
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
OBJECTS = {
    "furniture" => [{"name" => "ruined bed"}, {"name" => "writing desk"}, {"name" => "empty cot"}, {"name" => "writing desk"}, {"name" => "dining table"}, {"name" => "stone bench"}, {"name" => "wooden bench"}, {"name" => "stone bench"}, {"name" => "ruined sofa"}, {"name" => "credenza"}, {"name" => "unlit brazier"}, {"name" => "wooden stool"}, {"name" => "armchair"}, {"name" => "ragged blanket"}, {"name" => "wooden bunks"}, {"name" => "hearth with wood"}, {"name" => "stained mattress"}, {"name" => "washtub"}, {"name" => "stove"}, {"name" => "pile of rags"}],
    "clutter" => [{"name" => "pile of debris"}, {"name" => "large pile of rubble"}, {"name" => "overturned brazier"}, {"name" => "broken bedframe"}, {"name" => "collapsed section"}, {"name" => "destroyed statue"}, {"name" => "crate of cleared debris"}, {"name" => "rotting pile"}, {"name" => "corroded chains"}, {"name" => "corner full of cobwebs"}, {"name" => "heap of dung"}, {"name" => "pile of food scraps"}, {"name" => "broken tools"}, {"name" => "large puddle of standing water"}, {"name" => "loom"}, {"name" => "large empty cage"}, {"name" => "crate of salts"}, {"name" => "barrel of oil"}],
    "mundane" => [{"name" => "wheelbarrow"}, {"name" => "feed trough"}, {"name" => "shelf of broken dishes"}, {"name" => "stepstool"}, {"name" => "cask of lard"}, {"name" => "drying rack"}, {"name" => "large gong"}, {"name" => "improvised stretcher"}, {"name" => "broken instrument"}, {"name" => "large stone urn"}, {"name" => "stacked cairn"}, {"name" => "lit candelabrum"}, {"name" => "large iron cauldron"}, {"name" => "lit brazier"}, {"name" => "unlit brazier"}, {"name" => "patch of weeds"}, {"name" => "improvised barricade"}, {"name" => "grindstone"}],
    "container" => [{"name" => "barrel"}, {"name" => "crate"}, {"name" => "chest"}, {"name" => "chest of drawers"}, {"name" => "wooden box"}, {"name" => "reinforced crate"}, {"name" => "shelf"}, {"name" => "credenza"}, {"name" => "coffin"},  {"name" => "burlap sack"}, {"name" => "large sack"}, {"name" => "abandoned pack"}, {"name" => "wardrobe"}, {"name" => "cupboard"}],
    "catacomb" => [{"name" => "sarcophagus", "type" => "container"}, {"name" => "looted sarcophagus", "type" => "container"}, {"name" => "burial alcove", "type" => "mundane"}, {"name" => "mausoleum", "type" => "clutter"}, {"name" => "shelf of urns", "type" => "container"}, {"name" => "embalming table", "type" => "furniture"}, {"name" => "large insence burner", "type" => "mundane"}, {"name" => "patch of nitre", "type" => "clutter"}, {"name" => "stone idol", "type" => "mundane"}, {"name" => "empty offering plate", "type" => "mundane"}, ],
    "fort" => [{"name" => "broken weapon rack", "type" => "clutter"}, {"name" => "empty weapon rack", "type" => "mundane"}, {"name" => "weapon rack", "type" => "container"}, {"name" => "map table", "type" => "furniture"}, {"name" => "foot locker", "type" => "container"}, {"name" => "anvil", "type" => "clutter"}, {"name" => "grindstone", "type" => "clutter"}, {"name" => "training dummy", "type" => "mundane"}, {"name" => "broken balista", "type" => "clutter"}, {"name" => "wooden barricade", "type" => "clutter"}, {"name" => "stack of sand bags", "type" => "clutter"} ],
    "monastary" => [{"name" => "kneeling bench", "type" => "furniture"}, {"name" => "lecturn", "type" => "clutter"}, {"name" => "meditation cushion", "type" => "furniture"}, {"name" => "reliquary box", "type" => "container"}, {"name" => "offering box", "type" => "container"}, {"name" => "large insence burner", "type" => "clutter"}, {"name" => "altar", "type" => "clutter"}, {"name" => "shrine", "type" => "clutter"}, {"name" => "wooden pew", "type" => "furniture"}, {"stone" => "stone idol", "type" => "mundane"}, {"name" => "faded fresco", "type" => "mundane"}, {"name" => "crate of insence", "type" => "clutter"}, {"name" => "brewing cask", "type" => "clutter"}],
    "outpost" => [{"name" => "looted storage crate", "type" => "clutter"}, {"name" => "ruined kiosk", "type" => "clutter"}, {"name" => "abandoned kiosk", "type" => "container"}, {"name" => "empty cart", "type" => "clutter"}, {"name" => "cart", "type" => "container"}, {"name" => "display board", "type" => "clutter"}, {"name" => "small stage", "type" => "mundane"}, {"name" => "brewing cask", "type" => "clutter"}, {"name" => "improvised stall", "type" => "clutter"}],
    "lair" => [{"name" => "gibbet", "type" => "clutter"}, {"name" => "huge bell", "type" => "clutter"}, {"name" => "rack of chains", "type" => "mundane"}, {"name" => "torture rack", "type" => "clutter"}, {"name" => "pile of corpses", "type" => "clutter"}, {"name" => "strapped chair", "type" => "furniture"}, {"name" => "pile of rusted fetters", "type" => "mundane"}, {"name" => "iron maiden", "type" => "clutter"}, {"name" => "stocks", "type" => "clitter"}, {"name" => "torture wheel", "type" => "clutter"}, {"name" => "defiled shrine", "type" => "mundane"}, {"name" => "inscribed circle", "type" => "mundane"}],
    "mine" => [{"name" => "mine cart", "type" => "container"}, {"name" => "cart full of ore", "type" => "clutter"}, {"name" => "cart full of rubble", "type" => "clutter"},{"name" => "box of blunted tools", "type" => "mundane"}, {"name" => "stack of support beams", "type" => "clutter"}, {"name" => "collapsed tunnel", "type" => "mundane"}, {"name" => "collapsed tunnel", "type" => "mundane"}, {"name" => "ore grinder", "type" => "clutter"} , {"name" => "rack of chains", "type" => "mundane"}],
    "undead" => [{"name" => "empty sarcophagus", "type" => "mundane"}, {"name" => "decayed corpse", "type" => "mundane"}, {"name" => "empty grave", "type" => "clutter"}, {"name" => "sacrificial altar", "type" => "clutter"}, {"name" => "lecturn", "type" => "clutter"}, {"name" => "alembic", "type" => "mundane"}, {"name" => "tank of embalming fluid", "type" => "clutter"}, {"name" => "opened coffin", "type" => "container"}, {"name" => "sinkhole", "type" => "mundane"}],
    "goblin" => [{"name" => "pile of food scraps", "type" => "mundane"}, {"name" => "pile of burnt furniture", "type" => "mundane"}, {"name" => "grafitti mural", "type" => "mundane"}, {"name" => "scratched out fresco", "type" => "mundane"}, {"name" => "bone cage", "type" => "container"}, {"name" => "pile of dead rats", "type" => "mundane"}, {"name" => "skull totem", "type" => "mundane"}, {"name" => "smoking fire pit", "type" => "mundane"}],
    "beast" => [{"name" => "pile of excrement", "type" => "mundane"}, {"name" => "pile of excrement", "type" => "container"}, {"name" => "partially eaten corpse", "type" => "mundane"}],
    "bandit" => [{"name" => "campsite", "type" => "container"}, {"name" => "grindstone", "type" => "clutter"}, {"name" => "map table", "type" => "furniture"}, {"name" => "loot chest", "type" => "container"}, {"name" => "loot chest", "type" => "container"}, {"name" => "stocks", "type" => "clutter"},{"name" => "empty weapon rack", "type" => "mundane"}, {"name" => "weapon rack", "type" => "container"}]
}

def get_hidden_item(type)
    choice = OBJECTS[type].sample
    object = Container.new(choice["name"], "", choice["type"])
    object.fill(1)
    object
end

def get_event_object(factions)
    types = ["faction"]
    case types.sample
    when "faction"
        get_faction_object(factions.sample)
    end
end

def get_faction_object(faction)
    choice = OBJECTS[faction].sample
    if choice["type"] == "container"
        object = Container.new(choice["name"], "\nIt seems to indicate presence of #{add_article(faction)}.", choice["type"], faction)
        object.fill(rand(6))
        object
    else
        DObject.new(choice["name"], "", choice["type"], faction)
    end
end

def get_object(type)
    choice = OBJECTS[type].sample
    if type == "container"
        object = Container.new(choice["name"])
        object.fill(rand(6))
        object
    else
        DObject.new(choice["name"], "", type)
    end
end

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
    table["factions"] = fill_table(FACTIONS, chars)
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

