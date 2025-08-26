extends ColorRect



func _on_screen_shake_toggled(toggled_on: bool) -> void:
	Autoload.cameraShake=not toggled_on
