extends ColorRect



func _on_screen_shake_toggled(toggled_on: bool) -> void:
	Autoload.camera.disableShake=toggled_on
