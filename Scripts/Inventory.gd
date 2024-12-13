extends Control

@onready var grid_container: GridContainer = $GridContainer

var inventory_slots: Array = []  # Array to hold all inventory slots
var rows: int = 4  # Number of rows
var columns: int = 5  # Number of columns

var items_data: Array  # Declare the array to hold items data

func _ready():
	create_inventory_grid()
	load_items_from_json()
	
	set_custom_minimum_size(Vector2(64, 64))
	#if is_occupied:
		#var shape = create_item_shape(item_shape)
		#add_child(shape)
	#else:
		#clear_slot()

func create_inventory_grid():
	print("create_inventory_grid called")
	# Clear existing children to prevent duplication
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.queue_free()

	inventory_slots.clear()  # Clear the inventory slots array

	# Create new slots
	for i in range(rows * columns):
		var slot = preload("res://Scenes/InventorySlot.tscn").instantiate()
		grid_container.add_child(slot)
		inventory_slots.append(slot)

	print("Inventory grid created with ", inventory_slots.size(), " slots.")


func load_items_from_json():
	var file = FileAccess.open("res://Data/items.json", FileAccess.READ)  # Open the JSON file
	if file == null:
		print("Failed to open file.")
		return

	var json = JSON.new()  # Create a new JSON instance
	var result = json.parse(file.get_as_text())  # Parse the file content
	file.close()

	if result != OK:
		print("Failed to parse JSON")
		return

	# Store parsed data into items_data array
	items_data = json.get_data()  # Get the parsed JSON data

	# Debug: Print loaded items
	for item in items_data:
		print(item)

	# Update inventory slots based on the loaded item data
	# Update inventory slots based on the loaded item data
	for i in range(min(items_data.size(), inventory_slots.size())):
		var slot = inventory_slots[i]
		var item_data = items_data[i]
		
		# Extract properties from the JSON data
		var item_name = item_data.get("name", "Default Item")
		var item_weight = item_data.get("weight", 1.0)
		var item_shape = item_data.get("shape", "rect")
		
		# Update the slot with item data
		slot.update_item(item_name, item_weight, item_shape)
