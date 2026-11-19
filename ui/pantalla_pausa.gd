extends CanvasLayer


func _on_boton_continuar_button_down() -> void:
	get_tree().paused = false
	hide()


func _on_boton_reiniciar_button_down() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
