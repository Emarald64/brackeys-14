extends Node2D
var active = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if(active):
		body.curCP = self
		active = false
		$AnimatedSprite2D.play("Up")
		$GPUParticles2D.emitting=true
	# Replace with function body.
 
 
