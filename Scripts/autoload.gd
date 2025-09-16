extends Node

var player:CharacterBody2D
var camera:Camera2D
var cameraShake:=true
var mute:=false
var loadSave:=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func closestPointOnRec(rec:Rect2,pos:Vector2) -> Vector2:
	var out=Vector2.ZERO
	if pos.x<rec.position.x:out.x=rec.position.x
	elif pos.x>rec.end.x:out.x=rec.end.x
	else:out.x=pos.x
	
	if pos.y<rec.position.y:out.y=rec.position.y
	elif pos.y>rec.end.y:out.y=rec.end.y
	else:out.y=pos.y
	return out;
