extends Node2D
#var active = true

func _process(delta: float) -> void:
	if position.y<-2600:
		$PointLight2D.remove_from_group("ReduceLight")
		$PointLight2D.enabled=false

func _on_body_entered(body):
	if(body.curCP!=self):
		body.curCP = self
		#active = false
		print('checkpoint')
		get_tree().call_group("Checkpoints","dropFlag")
		$AnimatedSprite2D.play("Up")
		$GPUParticles2D.emitting=true
		$PointLight2D.texture_scale=1.5
		Autoload.camera.add_trauma(0.3)
	# Replace with function body.
 
func dropFlag():
	$AnimatedSprite2D.play("Down")
	$PointLight2D.texture_scale=0.5
 
