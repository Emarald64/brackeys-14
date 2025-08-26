extends Camera2D

@export var decay =0.8
@export var max_offset= Vector2(100, 75)
@export var max_roll = 0.1

var trauma = 0.0 
var trauma_power = 2
var trauma_locked= false

var disableShake=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Autoload.camera=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug-2"):
		add_trauma(0.5)
	if trauma and not disableShake:
		if not trauma_locked:trauma = max(trauma - decay * delta, 0)
		var amount = pow(trauma, trauma_power)
		rotation = max_roll * amount * randf_range(-1, 1)
		offset.x = max_offset.x * amount * randf_range(-1, 1)
		offset.y = max_offset.y * amount * randf_range(-1, 1)

func add_trauma(ammount):
	trauma=min(trauma+ammount,1.0)
