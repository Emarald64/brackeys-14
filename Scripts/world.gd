extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug-teleport"):
		$Player.position=$"Debug-teleport target".position
	if $"Light Change".has_overlapping_bodies():
		var value=max(min((-1687.8947-Autoload.player.position.y)*0.0011875,1.0),0.392)
		$CanvasModulate.color=Color(value,value,value)
		
		#min color 0.392
		# diff color 0.608
		#min pos -2018
		#max pos -2530
		# diff pos -512
