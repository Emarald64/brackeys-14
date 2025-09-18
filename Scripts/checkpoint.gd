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
		print(position)
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
	var world=player.get_parent()
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if save_file==null:print("cant open save")
	save_file.store_16(int(position.x/32)+16)
	save_file.store_16(2-int(position.y/32))
	save_file.store_16(player.deathCount)
	save_file.store_32((Time.get_ticks_msec()-world.startTimeMS)/1000)
	save_file.store_8(
		int(player.canGrapple) | \
		int(player.usedWarpZone)<<1 | \
		int(world.secondQuest)<<2
	)
	save_file.close()
