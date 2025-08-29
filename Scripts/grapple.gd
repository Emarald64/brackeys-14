extends Area2D
var latched = false
var retracting = false
var velocity: Vector2
var player:CharacterBody2D
var stuck=false
var latchLocation:Vector2
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var offset=player.position-position
	if latched and offset.length_squared()>0:
		var pull=(min(max((offset+player.velocity).length()-offset.length(),0)+3500,4000))
		print("grapple pull:",pull)
		player.velocity=player.velocity-(delta*offset/offset.length()*pull)
		if player.velocity.length_squared()>640000:
			player.velocity/=(player.velocity.length()/800)
		#print(player.velocity.length())
		if offset.length_squared()>122500:
			retracting=true
			latched=false
	else:
		if offset.length_squared()>62500:retracting=true
		if retracting:
			if offset.length_squared()<1200:queue_free()
			else:velocity=2000*offset/offset.length()
		if not stuck:position += velocity*delta
func hit():
	if not retracting:
		latched = true
		#if position.distance_squared_to(latchLocation)<729:
		position=latchLocation
	
func retract() -> void:
	retracting=true
	latched=false

func testGrappleFail() -> void:
	stuck=true
	await get_tree().physics_frame
	stuck=false
	if not has_overlapping_bodies():retract()
