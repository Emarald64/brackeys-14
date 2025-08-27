extends ColorRect

var sceneToTransition:PackedScene

func _on_screen_shake_toggled(toggled_on: bool) -> void:
	Autoload.cameraShake=not toggled_on


func pressedStart() -> void:
	sceneToTransition=load("res://Scenes/world.tscn")
	$AnimationPlayer.play("Fade Out")

func changeScene() -> void:
	print(get_tree().change_scene_to_packed(sceneToTransition))
