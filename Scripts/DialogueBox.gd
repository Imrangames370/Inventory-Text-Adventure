extends Control

@export var typing_speed: float = 0.05  # Speed of typing (seconds per character)
var dialogue_lines: Array = []  # Array to hold dialogue text
var current_line: int = 0  # Tracks the current dialogue line
var is_typing: bool = false  # Tracks if text is still being typed

@onready var dialogue_label: Label = $BackgroundPanel/DialogueText
@onready var next_button: Button = $NextButton


func _ready():
	next_button.disabled = true
	next_button.connect("pressed", Callable(self, "_on_next_pressed"))
	# Add some placeholder dialogue for testing
	dialogue_lines = [
		"You wake up in a bunker. The air smells damp.",
		"Looking around, you see the supplies are almost gone.",
		"It's time to venture out... but what awaits you outside?"
	]

	start_dialogue()

func start_dialogue():
	current_line = 0
	display_next_line()

func display_next_line():
	if current_line < dialogue_lines.size():
		next_button.disabled = true
		is_typing = true
		dialogue_label.text = ""  # Clear previous text
		await _type_text(dialogue_lines[current_line])
		is_typing = false
		next_button.disabled = false
		current_line += 1
	else:
		print("End of dialogue.")  # Placeholder for dialogue end logic

func _type_text(line: String) -> void:
	for i in range(line.length()):
		dialogue_label.text += line[i]
		await _wait_for_seconds(typing_speed)

# Helper function to wait for a specific duration
func _wait_for_seconds(seconds: float) -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.start(seconds)
	await timer.timeout
	timer.queue_free()

func _on_next_pressed():
	if not is_typing:
		display_next_line()
