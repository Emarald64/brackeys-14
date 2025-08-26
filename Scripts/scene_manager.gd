extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pressedStart() -> void:
	$AnimationPlayer.play("Fade Out Title Screen")
	add_child(preload("res://Scenes/world.tscn").instantiate())


func _on_animation_player_animation_changed(old_name: StringName, new_name: StringName) -> void:
	if old_name=="Fade Out Title Screen":
		$"Title Screen".queue_free()
