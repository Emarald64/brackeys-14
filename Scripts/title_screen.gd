extends ColorRect

var sceneToTransition:PackedScene

func _ready():
	$Version.text=FileAccess.open("res://version.txt",FileAccess.READ).get_as_text()

func _on_screen_shake_toggled(toggled_on: bool) -> void:
	Autoload.cameraShake=not toggled_on


func pressedStart() -> void:
	sceneToTransition=load("res://Scenes/world.tscn")
	$AnimationPlayer.play("Fade Out")

func changeScene() -> void:
	get_tree().change_scene_to_packed(sceneToTransition)

func _on_mute_toggled(toggled_on: bool) -> void:
	Autoload.mute=toggled_on
