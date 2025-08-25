extends PathFollow2D

const FORWARD=true
const BACKWARD=false

@export var movementSpeed:float
var currentProgress=0.0
var direction=FORWARD


func _physics_process(delta: float) -> void:
	if loop:progress_ratio+=movementSpeed*delta
	else:
		var testProgress=progress_ratio+(movementSpeed*delta*(1 if direction==FORWARD else -1))
		if testProgress>1:
			direction=BACKWARD
			testProgress=2-testProgress
		elif testProgress<0:
			direction=FORWARD
			testProgress=-testProgress
		progress_ratio=testProgress
