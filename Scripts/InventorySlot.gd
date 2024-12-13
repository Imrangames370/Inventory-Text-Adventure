extends Control

class_name InventorySlot  # This will make this class accessible globally.

@export var item_name: String = "Item"  # Item name placeholder
@export var item_weight: float = 1.0  # Item weight
@export var item_shape: String = "rect"  # Shape type: rectangle, L-shape, etc.

var drag_offset: Vector2 = Vector2.ZERO  # To keep track of drag offset
var is_occupied: bool = false  # Track if the slot is occupied

func _ready():
	set_custom_minimum_size(Vector2(64, 64))  # Set minimum size for the slot
	var shape = create_item_shape(item_shape)  # Create the item shape based on the type
	add_child(shape)  # Add item shape to the slot
	if not is_occupied:
		clear_slot()

func create_item_shape(shape_type: String) -> Node:
	var shape: Node
	match shape_type:
		"rect":
			shape = Panel.new()
			shape.custom_minimum_size = Vector2(50, 50)  # Use rect_size directly in Godot 4
		# Add cases for other shapes (e.g., L-shape)
		_:
			shape = Panel.new()
			shape.custom_minimum_size = Vector2(64, 64)  # Default to rectangle if no match
	return shape

# Handle drag start
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			drag_offset = event.position - global_position
			show_drag_preview()  # Show a preview of the item when dragging

# Set drag preview (optional, can be improved)
func show_drag_preview():
	var preview = Panel.new()
	preview.custom_minimum_size = Vector2(64, 64)  # Use rect_size for the preview in Godot 4
	preview.modulate = Color(0.7, 0.7, 0.7)  # Slightly transparent preview
	get_parent().add_child(preview)
	preview.global_position = get_global_position()
	preview.position = drag_offset

# Handle drop logic (on mouse release)
func _on_item_drop(item: InventorySlot) -> void:
	if not is_occupied:
		item.global_position = global_position  # Move item to the new slot
		is_occupied = true  # Mark slot as occupied
		item.is_occupied = false  # Release the old slot
		clear_slot()

func clear_slot():
	# Logic to reset slot when item is removed or slot is empty
	is_occupied = false


func update_item(new_name: String, new_weight: float, new_shape: String) -> void:
	item_name = new_name
	item_weight = new_weight
	item_shape = new_shape
	var shape = create_item_shape(item_shape)
	add_child(shape)
