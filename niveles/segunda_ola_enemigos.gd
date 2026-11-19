extends Node2D


@export var destion_final = 200
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for nave in get_children():
		if nave is Node2D:
			nave.visible = false
			nave.set_process(false)
			nave.set_physics_process(false)
	timer.start()

func _on_timer_timeout() -> void:
	for nave in get_children():
		if nave is Node2D:
			nave.visible = true
			nave.set_process(true)
			nave.set_physics_process(true)
	
	var tween = create_tween()
	
	var destino = Vector2(position.x, destion_final)
	
	tween.tween_property(self, "position", destino, 3.0)
