extends Control


func _on_new_game_pressed() -> void:
	print("new Game Press")
	
func _on_load_game_pressed() -> void:
	print("load Game Press")

func _on_options_pressed() -> void:
	print("Options Press")


func _on_quit_pressed() -> void:
	get_tree().quit()
