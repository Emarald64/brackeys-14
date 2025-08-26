extends Area2D

signal activate
var powered=false


func hit(body: Node2D) -> void:
	if not powered:
		activate.emit()
		$AnimatedSprite2D.frame=1
		$PointLight2D.texture_scale=1
		powered=true
	
