extends CharacterBody2D

@export var curCP:Node2D
const SPEED = 500.0
const JUMP_VELOCITY = -650.0
const hookScene=preload("res://scenes/grapple.tscn")
var hasjumped=false
var started_timer=false
var hook:Area2D=null
@export var canGrapple=true

func _process(delta: float) -> void:
	if hook!=null:
		$"Line2D".set_point_position(0,(hook.position-position))
		$"Line2D".show()
	else:
		$"Line2D".hide()
 
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		velocity=Vector2.ZERO
		if hook !=null:hook.queue_free()
		position=curCP.position
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if not started_timer:
			$coyoteTimer.start()
			started_timer=true
	else:
		hasjumped=false
		started_timer=false
		$coyoteTimer.stop()
	# Handle jump.
	if ((Input.is_action_pressed("jump") and not $JumpTimer.is_stopped()) or (Input.is_action_just_pressed("jump")) and (not $coyoteTimer.is_stopped() or is_on_floor() or (hook!=null and hook.latched and position.distance_squared_to(hook.position)<1250))):
		#if not hasjumped:
			#$AudioStreamPlayer.play()
		$coyoteTimer.stop()
		if not hasjumped:$JumpTimer.start()
		velocity.y+= JUMP_VELOCITY*((0.5 if not hasjumped or (hook!=null and hook.latched and position.distance_squared_to(hook.position)<=1250) else 0) + (delta*5))
		#print(velocity.y)
		if(hook!=null and hook.latched and position.distance_squared_to(hook.position)<1250):
			hook.retract() 
		hasjumped=true

	if Input.is_action_just_pressed("grapple") and canGrapple:
		if hook==null:
			var hookPoints=$"Grapple point finder".get_overlapping_bodies()
			if len(hookPoints)>0:
				hook=hookScene.instantiate()
				var closestHook:Node2D
				var closestHookDistance=100000000000000000
				for area in hookPoints:
					var distance=position.distance_squared_to(area.global_position)
					if closestHookDistance>distance:
						closestHook=area
						closestHookDistance=distance
				hook.position=position
				hook.rotation=(closestHook.position-position).angle()+(PI/2) 
				hook.velocity=Vector2.from_angle(hook.rotation-(PI/2))*2000
				hook.player=self
				add_sibling(hook)
		elif hook.latched:
			hook.retracting=true
			hook.latched=false
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x= lerp(velocity.x,direction*SPEED,(15 if is_on_floor() else 5) * delta)

	move_and_slide()
