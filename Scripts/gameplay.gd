extends Node2D

var typewriter_speed = 0.05  # Time delay between each character
var typewriter_text = ""  # The full text to be revealed
var typewriter_index = 0  # Current index of the text being revealed

# Preload the inventory scene
var inventory_scene = preload("res://Scenes/inventory.tscn")

# Example story events
var story_events = [
	{
		"text": "You wake up in a dark room. What do you do?",
		"choices": [
			{"text": "Search the room", "next_event": 1},
			{"text": "Call for help", "next_event": 2}
		]
	},
	{
		"text": "You find a flashlight. It still works. What next?",
		"choices": [
			{"text": "Turn it on", "next_event": 3},
			{"text": "Save the battery", "next_event": 4}
		]
	},
	{
		"text": "You hear a distant sound. Do you investigate?",
		"choices": [
			{"text": "Yes", "next_event": 3},
			{"text": "No", "next_event": 4}
		]
	}
]

var current_event = 0  # Index of the current story event

# Nodes
@onready var story_text = $Panel/StoryText
@onready var choices_container = $Panel/ChoicesContainer

func _ready():
	display_event(current_event)

func typewriter_start(full_text: String):
	# Initialize typewriter variables
	typewriter_text = full_text
	typewriter_index = 0
	story_text.text = ""  # Clear the label initially
	# Start the typewriter effect
	call_deferred("_typewriter_tick")

func _typewriter_tick():
	if typewriter_index < typewriter_text.length():
		story_text.text += typewriter_text[typewriter_index]  # Add the next character
		typewriter_index += 1
		# Call this function again after a short delay
		await get_tree().create_timer(typewriter_speed).timeout
		_typewriter_tick()


func display_event(event_index):
	if event_index < 0 or event_index >= story_events.size():
		print("Error: Invalid event index: ", event_index)
		return
	
	var event_data = story_events[event_index]
	
	# Start the typewriter effect for the story text
	typewriter_start(event_data["text"])
	
	# Clear previous choices
	for child in choices_container.get_children():
		child.queue_free()
	
	# Display new choices
	for choice in event_data["choices"]:
		var button = Button.new()
		button.text = choice["text"]
		button.pressed.connect(func() -> void:
			_on_choice_selected(choice["next_event"])
		)
		choices_container.add_child(button)


func _on_choice_selected(next_event_index):
	# Move to the next story event
	current_event = next_event_index
	display_event(current_event)



# Show the inventory scene when needed
func show_inventory():
	var inventory_instance = inventory_scene.instantiate()
	add_child(inventory_instance)
