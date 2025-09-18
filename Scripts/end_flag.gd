extends Area2D

var activated:=false

func formatTime(time:int)-> String:
	var msec=time%1000
	@warning_ignore("integer_division")
	var sec=time/1000%60
	@warning_ignore("integer_division")
	var minutes=time/60000%60
	@warning_ignore("integer_division")
	var hrs=time/3600000
	if hrs>0:
		return str(hrs)+':'+str(minutes)+':'+str(sec)+'.'+str(msec)
	return str(minutes)+':'+str(sec)+'.'+str(msec)

func hit(body: Node2D) -> void:
	if not activated:
		$AnimatedSprite2D.play("Up")
		activated=true
		$"GPUParticles2D-left".emitting=true
		$"GPUParticles2D-right".emitting=true
		$AnimationPlayer.play("new_animation")
		
		body.animating=true
		
		#Set stats text
		body.get_node("../End Overlay/End Screen/Stats").text= \
		("used warp zone\n" if body.usedWarpZone else "\n") + \
		"Time: "+formatTime(Time.get_ticks_msec()-get_parent().startTimeMS)+'\n'+\
		"Deaths: "+str(body.deathCount)
		
		body.get_node("../AnimationPlayer").play("End")
	
