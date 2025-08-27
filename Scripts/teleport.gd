extends Area2D

@export var teleportPos:Vector2
@export var teleportTarget:Node2D


func _on_body_entered(body: Node2D) -> void:
	
	if body.hook!=null:body.hook.queue_free()
	if teleportTarget==null:
		body.position=teleportPos
	else:
		body.position=teleportTarget.position
	var dark=body.get_node("Hurtbox").overlaps_area(body.get_node("../Dark Zone"))
	body.get_node("../CanvasModulate").color=(Color(0.392,0.392,0.392) if dark else Color(1,1,1))
	body.get_node("PointLight2D").enabled=dark
	body.get_node("PointLight2D").texture_scale=(1.5 if dark else 0)
	get_tree().set_group("ReduceLight","enabled",dark)
