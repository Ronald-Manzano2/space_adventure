extends Node2D

@export var asteroide1: PackedScene = preload("uid://vtr5bp3hxir7")
@export var asteroide2: PackedScene = preload("uid://bdk2wufdcxje4")
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	generar_enemigo()

func generar_enemigo():
	var asteroide = asteroide1.instantiate() if randf() > 0.5 else asteroide2.instantiate()
	var rand_position_x = randf_range(50.0, 250.0)
	asteroide.get_node("Sprite2D").scale = Vector2(0.1, 0.1)
	asteroide.get_node("CollisionShape2D").scale = Vector2(0.1, 0.1)
	asteroide.global_position = Vector2(rand_position_x, -100)
	
	add_child(asteroide)
	
	var rand_diagonal = randf() > 0.5
	
	if asteroide is RigidBody2D:
		if rand_diagonal:
			var direccion_x = 1 if randf() > 0.5 else -1
			asteroide.apply_central_impulse(Vector2(200 * direccion_x, 500))
		else:
			asteroide.apply_central_impulse(Vector2(0, 500))
