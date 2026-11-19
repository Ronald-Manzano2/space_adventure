extends Node2D

var destino_final = 170

func _ready() -> void:
	for nave in get_children():
		if nave is Node2D:
			nave.visible = false
			nave.set_process(false)
			nave.set_physics_process(false)

func _on_game_controller_all_destroyed(are_destroyed: Variant) -> void:
	if are_destroyed == true:
		for nave in get_children():
			if nave is Node2D:
				nave.visible = true
				nave.set_process(true)
				nave.set_physics_process(true)
				var tween = create_tween()
				
				var destino = Vector2(position.x, destino_final)
				
				tween.tween_property(self, "position", destino, 3.0)
