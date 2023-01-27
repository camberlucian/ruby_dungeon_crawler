require_relative "./object"

class Door < DObject
	attr_reader :description, :locked, :key_id
	
	def initialize(key_id, locked, name = "door", desc = "It is otherwise plain", type = "mundane", faction = "none")
        super(name, desc, type, "none")
        @name = name
		@locked = locked
		@key_id = key_id
	end
	
	def unlock(key)
		if key.id == @key_id
			@locked = false
			puts "You unlock the door with the key."
		else
			puts "The key does not fit the lock."
		end
	end
end
