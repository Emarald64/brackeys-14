extends Area2D

@export var teleportPos:Vector2
@export var teleportTarget:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_body_entered(body: Node2D) -> void:
	if body.hook!=null:body.hook.queue_free()
	if teleportTarget==null:
		body.position=teleportPos
	else:
		body.position=teleportTarget.position
