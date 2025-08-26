extends StaticBody2D


func _on_activate():
	$Sprite2D/ShardEmitter.shatter()
	set_collision_layer_value(1,false)
