extends Node2D
#var active = true

func _ready() -> void:
	if position.y<-2600:
		$PointLight2D.remove_from_group("ReduceLight")
		$PointLight2D.enabled=false

func _on_body_entered(body):
	if(body.curCP!=self):
		body.curCP = self
		#active = false
		get_tree().call_group("Checkpoints","dropFlag")
		$AnimatedSprite2D.play("Up")
		$GPUParticles2D.emitting=true
		$PointLight2D.texture_scale=1.5
		Autoload.camera.add_trauma(0.3)
		save(body)
	# Replace with function body.
 
func dropFlag():
	$AnimatedSprite2D.play("Down")
	$PointLight2D.texture_scale=0.5

func save(player:Node2D):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if save_file==null:print("cant open save")
	save_file.store_float(player.position.x)
	save_file.store_float(player.position.y)
	save_file.store_32(player.deathCount)
	save_file.store_8(int(player.canGrapple))
	save_file.close()
