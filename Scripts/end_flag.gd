extends Area2D

var activated:=false

func hit(body: Node2D) -> void:
	if not activated:
		print("hit")
		$AnimatedSprite2D.play("Up")
		activated=true
		$"GPUParticles2D-left".emitting=true
		$"GPUParticles2D-right".emitting=true
		$AnimationPlayer.play("new_animation")
		
		body.animating=true
		body.get_node("../End Overlay/End Screen/Death Count").text="Deaths: "+str(body.deathCount)
		body.get_node("../AnimationPlayer").play("End")
	
