extends Control

# Inventory grid dimensions
var grid_width = 5
var grid_height = 5
var inventory_grid = []

# Called when the scene is ready
func _ready():
	initialize_inventory_grid()
	
	# Create some test items
	var healing_potion = Item.new("Healing Potion", "Restores health", 1, 1)
	var shotgun = Item.new("Shotgun", "A powerful firearm", 2, 2)
	
	# Add items to specific grid slots
	inventory_grid[0][0] = healing_potion
	inventory_grid[1][1] = shotgun
	update_inventory_display()


# Initialize the inventory grid with empty spaces
func initialize_inventory_grid():
	inventory_grid.resize(grid_height)
	for row in inventory_grid:
		row.resize(grid_width)

# Update the inventory display by creating buttons for each item
func update_inventory_display():
	# Clear existing UI items
	for child in get_children():
		if child is Button:
			child.queue_free()

	# Loop through the inventory grid and display items
	for row in range(grid_height):
		for col in range(grid_width):
			var item = inventory_grid[row][col]
			if item != null:
				var button = Button.new()
				button.text = item.name
				button.tooltip = item.description
				button.rect_min_size = Vector2(100, 100)  # Adjust size if necessary
				# Attach a function to handle item interaction
				button.pressed.connect(self._on_item_pressed, [item])

				add_child(button)

# Handle item press events
func _on_item_pressed(item: Item):
	print("Item pressed: ", item.name)
	# You can add item usage or interaction logic here
