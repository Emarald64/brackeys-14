extends Area2D
var latched = false
var velocity: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity*delta
func retract():
	pass
func body_shape_entered(body):
	if(body.get_collision_layer_value(3)):
		latched = true
	else
		
