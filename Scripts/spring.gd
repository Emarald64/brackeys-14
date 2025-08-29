extends Area2D

@export var strength := 1000.0

func _on_body_entered(body: Node2D) -> void:
	body.velocity=Vector2(sin(rotation)*strength,-cos(rotation)*strength)
	print("spring:",body.velocity,"frame:",Engine.get_physics_frames())
	$AnimatedSprite2D.play()
	body.get_node("Jump Sound").play()
