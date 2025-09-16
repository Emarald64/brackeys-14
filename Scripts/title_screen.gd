extends ColorRect

var sceneToTransition:PackedScene

func _ready():
	if FileAccess.file_exists("user://savegame.save"):print("save exists")
	$Continue.visible=FileAccess.file_exists("user://savegame.save")

func _on_screen_shake_toggled(toggled_on: bool) -> void:
	Autoload.cameraShake=not toggled_on


func pressedStart(load:bool) -> void:
	print(load)
	Autoload.loadSave=load
	ResourceLoader.load_threaded_request("res://Scenes/world.tscn")
	$AnimationPlayer.play("Fade Out")

func changeScene() -> void:
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://Scenes/world.tscn"))

func _on_mute_toggled(toggled_on: bool) -> void:
	Autoload.mute=toggled_on
