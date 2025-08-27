extends CharacterBody2D

@export var curCP:Node2D
const SPEED = 500.0
const JUMP_VELOCITY = -750.0
const hookScene=preload("res://Scenes/grapple.tscn")
var hasjumped=false
var started_timer=false
var hook:Area2D=null
var deathCount=0
@export var canGrapple=true

func _ready():
	Autoload.player=self

func _process(_delta: float) -> void:
	if velocity.y>200:$Eyes.position.y=5
	elif velocity.y<-200:$Eyes.position.y=-5
	else:$Eyes.position.y=0
 	
	if hook!=null:
		$"Line2D".set_point_position(0,(hook.position-position))
		$"Line2D".show()
	else:
		$"Line2D".hide()
 
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		respawn()
	
	# Add the gravity.
	if not is_on_floor():
		if $AnimatedSprite2D.frame==0 or not $JumpTimer.is_stopped():$AnimatedSprite2D.frame=2
		velocity += get_gravity() * delta * (0.8 if hook != null and hook.latched else 1)
		if not started_timer:
			$coyoteTimer.start()
			started_timer=true
	else:
		$AnimatedSprite2D.frame=0
		hasjumped=false
		started_timer=false
		$coyoteTimer.stop()
	# Handle jump.
	if ((Input.is_action_pressed("jump") and not $JumpTimer.is_stopped()) or (Input.is_action_just_pressed("jump") and (not $coyoteTimer.is_stopped() or is_on_floor() or (hook!=null and hook.latched and position.distance_squared_to(hook.position)<2500)))):
		if not hasjumped:
			#$AudioStreamPlayer.play()
			$AnimatedSprite2D.frame=1
		$coyoteTimer.stop()
		if not hasjumped and (hook ==null or not hook.latched):$JumpTimer.start()
		var delta_y=JUMP_VELOCITY*((0.5 if not hasjumped or (hook!=null and hook.latched and position.distance_squared_to(hook.position)<=1250) and Input.is_action_just_pressed("jump") else 0.0) + (delta*5))
		#print("jump velocity:",delta_y)
		velocity.y+= delta_y
		#print(velocity.y)
		if(hook!=null and hook.latched and position.distance_squared_to(hook.position)<2500):
			hook.retract() 
		hasjumped=true

	if Input.is_action_just_pressed("grapple") and canGrapple:
		if hook==null:
			var hookPoints=$"Super Graple Point Locater 300".get_overlapping_bodies()
			if len(hookPoints)>0:
				var closestHook:Node2D
				var closestHookDistance=100000000000000000
				for area in hookPoints:
					var distance=position.distance_squared_to(area.global_position)
					if closestHookDistance>distance:
						closestHook=area
						closestHookDistance=distance
				var target=Autoload.closestPointOnRec(Rect2(closestHook.global_position- (closestHook.get_node("CollisionShape2D").shape.size/2),closestHook.get_node("CollisionShape2D").shape.size),position)
				print(target)
				hook=hookScene.instantiate()
				hook.position=position
				hook.rotation=(target-position).angle()+(PI/2) 
				hook.velocity=Vector2.from_angle(hook.rotation-(PI/2))*2000
				hook.latchLocation=target-(Vector2(0,-26).rotated(hook.rotation))
				hook.player=self
				add_sibling(hook)
		elif hook.latched:
			hook.retracting=true
			hook.latched=false
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.y+=Input.get_axis("move_up", "move_down")*200*delta
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x= lerp(velocity.x,direction*SPEED,(15 if is_on_floor() else 5) * delta)

	move_and_slide()

func respawn():
	deathCount+=1
	velocity=Vector2.ZERO
	if hook !=null:hook.queue_free()
	position=curCP.position
	Autoload.camera.add_trauma(0.3)

func pickup(area: Area2D) -> void:
	if area.get_meta("pickupType")=="grapple":
		canGrapple=true
		area.queue_free()
		Autoload.camera.add_trauma(0.5)
		get_node("../AnimationPlayer").play("Show tutorial sign 2")
 
