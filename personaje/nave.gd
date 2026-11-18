extends CharacterBody2D

@export var speed = 500
@export var life = 10
@onready var punto_disparo: Node2D = $"."
@onready var timer: Timer = $Timer

const BALAS_ALIADAS = preload("uid://d0vf2kjxar3r6")

const NAVE_DERECHA = preload("uid://cqapayi5ht37p")
const NAVE_IZQUIERDA = preload("uid://d3bd65c4jcxkc")
const NAVE_STATICA = preload("uid://tf34rxg1i1sb")

func _physics_process(delta: float) -> void:
	
	var direction_y = Input.get_axis("arriba","abajo")
	var direction_x = Input.get_axis("izquierda", "derecha")
	
	velocity.x = speed * direction_x
	velocity.y = speed * direction_y
	
	if velocity.x > 0:
		$Sprite2D.texture = NAVE_DERECHA
	else:
		if velocity.x < 0:
			$Sprite2D.texture = NAVE_IZQUIERDA
		else:
			$Sprite2D.texture = NAVE_STATICA
	
	var space_pressed = Input.is_action_pressed("disparar")
	if space_pressed and timer.is_stopped():
		disparar()
		timer.start()
	
	move_and_slide()

func disparar():
# 1. Instanciamos la bala
	var bala = BALAS_ALIADAS.instantiate()
	
	add_child(bala)
	
	var sprite = bala.get_node("Sprite2D")
	var col = bala.get_node("CollisionShape2D")
	sprite.scale = Vector2(0.09, 0.09)
	col.scale = Vector2(0.1, 0.1)
	
	var colision = $CollisionShape2D
	
	var centro_colision = colision.global_position + (colision.shape.extents * colision.global_scale)
	var altura_mitad = colision.shape.extents.y * colision.global_scale.y + 60
	
	bala.global_position = Vector2(centro_colision.x - 12 , centro_colision.y - altura_mitad)
