extends Resource

# Define the properties of an inventory item
class_name Item

var name: String
var description: String
var width: int  # Width of the item in the grid (number of columns it occupies)
var height: int  # Height of the item in the grid (number of rows it occupies)

# Create sample items
var healing_potion = Item.new("Healing Potion", "Restores health", 1, 1)
var shotgun = Item.new("Shotgun", "A powerful firearm", 2, 2)


# Constructor to initialize the item properties
func _init(name: String, description: String, width: int, height: int):
	self.name = name
	self.description = description
	self.width = width
	self.height = height
