extends Node2D
var active = true


func _on_body_entered(body):
	if(active):
		body.curCP = self
		active = false
		$AnimatedSprite2D.play("Up")
		$GPUParticles2D.emitting=true
		$PointLight2D.texture_scale=1.5
	# Replace with function body.
 
 
