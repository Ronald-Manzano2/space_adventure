extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect/VBoxContainer/Button.pressed.connect(reiniciar)

func reiniciar():
	get_tree().paused = false
	get_tree().reload_current_scene()
