extends Node2D
#var active = true


func _on_body_entered(body):
	if(body.curCP!=self):
		body.curCP = self
		#active = false
		print('checkpoint')
		$AnimatedSprite2D.play("Up")
		$GPUParticles2D.emitting=true
		$PointLight2D.texture_scale=1.5
		Autoload.camera.add_trauma(0.3)
	# Replace with function body.
 
 
