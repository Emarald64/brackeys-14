extends Area2D
var latched = false
var retracting = false
var velocity: Vector2
var player:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var offset=player.position-position
	if latched:
		var pull=(min(max((offset+player.velocity+(player.get_gravity()*delta)).length()-offset.length(),0)+4000,5000))
		print(pull)
		player.velocity-=delta*offset/offset.length()*pull
		if offset.length_squared()>160000:
			retracting=true
			latched=false
	else:
		if offset.length_squared()>90000:retracting=true
		if retracting:
			if offset.length_squared()<1200:queue_free()
			else:velocity=2000*offset/offset.length()
		position += velocity*delta
func hit(body):
	latched = not retracting
	
func retract() -> void:
	retracting=true
	latched=false
