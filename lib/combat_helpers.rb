def add_random_value(object, attribute)
    object.send(attribute) + rand(object.combat_die)
  end
  
  def compare_attributes(player, monster, attribute)
    player_value = add_random_value(player, attribute)
    monster_value = add_random_value(monster, attribute)
    if player_value > monster_value
      return :player
    elsif monster_value > player_value
      return :monster
    else
      return :tie
    end
  end
  
  def calculate_scores(player, monster)
    attributes = ["martial", "strength", "speed", "armor", "slash", "blunt", "pierce", "magic", "endurance", "size"]
    player_score = 0
    monster_score = 0
    attributes.each do |attribute|
      case compare_attributes(player, monster, attribute)
      when :player
        player_score += 1
      when :monster
        monster_score += 1
      end
    end
    return {player_score: player_score, monster_score: monster_score}
  end
  
  def reduce_attributes(object, n, attributes)
    n.times do
      object.send(attributes.sample) -= 1
    end
  end
  
  def determine_winner(player, monsters)
    remaining_monsters = monsters.dup
    monsters.each do |monster|
      scores = calculate_scores(player, monster)
      if scores[:player_score] > scores[:monster_score]
        reduce_attributes(player, scores[:monster_score], ["martial", "strength", "speed", "armor", "slash", "blunt", "pierce", "magic", "endurance", "size"])
        remaining_monsters.delete(monster)
      elsif scores[:monster_score] > scores[:player_score]
        return remaining_monsters
      end
    end
    if remaining_monsters.empty?
      return player
    else
      return remaining_monsters
    end
  end
  