extends ColorRect

func quit() -> void:
	get_tree().quit()

func main_menu()->void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
