extends Node2D

var startTimeMS:int

func _ready():
	startTimeMS=Time.get_ticks_msec()
	if Autoload.loadSave:loadSave()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("debug-teleport"):
		#$Player.position=$"Debug-teleport target".position
	if $"Light Change".has_overlapping_bodies():
		var value=max(min((-1687.8947-Autoload.player.position.y)*0.0011875,1.0),0.392)
		$CanvasModulate.color=Color(value,value,value)
		$DirectionalLight2D.energy=max(min((2530+Autoload.player.position.y)/1024,0.5),0.0)
		$DirectionalLight2D.enabled=Autoload.player.position.y>-2530
		Autoload.player.get_node("PointLight2D").enabled=Autoload.player.position.y>-2530
		Autoload.player.get_node("PointLight2D").texture_scale=(-2530-Autoload.player.position.y)*1.5/512
		get_tree().set_group("ReduceLight","enabled",Autoload.player.position.y>-2530)

func loadSave():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	$Player.position.x=save_file.get_float()
	$Player.position.y=save_file.get_float()
	$Player.deathCount=save_file.get_32()
	var byte=save_file.get_8()
	$Player.canGrapple=bool(byte)
	$Player.updateLight()
	$AnimationPlayer.play("Show tutorial sign 2")

		#min color 0.392
		# diff color 0.608
		#min pos -2018
		#max pos -2530
		# diff pos -512
