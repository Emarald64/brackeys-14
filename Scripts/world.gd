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
	$Player.position.x=(save_file.get_16())*32
	$Player.position.y=(2-save_file.get_16())*32
	
	$Player.deathCount=save_file.get_16()
	startTimeMS-=save_file.get_32()*1000
	
	var x = save_file.get_8()
	$Player.usedWarpZone=bool(x&0x02)
	if bool(x&0x02):print('used warp')
	if x&0x01:
		print("has hook")
		$Player.canGrapple=true
		$AnimationPlayer.play("Show tutorial sign 2")

	$Player.updateLight()
		#min color 0.392
		# diff color 0.608
		#min pos -2018
		#max pos -2530
		# diff pos -512
