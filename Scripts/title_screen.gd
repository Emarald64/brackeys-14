extends ColorRect

var sceneToTransition:PackedScene

func _ready():
	$Continue.disabled=not FileAccess.file_exists("user://savegame.save")

func _on_screen_shake_toggled(toggled_on: bool) -> void:
	Autoload.cameraShake=not toggled_on


func start(loadSave:bool) -> void:
	Autoload.loadSave=loadSave
	ResourceLoader.load_threaded_request("res://Scenes/world.tscn")
	$AnimationPlayer.play("Fade Out")

func pressedNewGame() -> void:
	if FileAccess.file_exists("user://savegame.save"):$ConfirmationDialog.show()
	else:start(false)

func changeScene() -> void:
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://Scenes/world.tscn"))

func _on_mute_toggled(toggled_on: bool) -> void:
	Autoload.mute=toggled_on


func pressedStart(extra_arg_0: bool) -> void:
	pass # Replace with function body.
