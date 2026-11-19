class_name Nave
extends CharacterBody2D

@export var speed = 500
@export var life = 5
@onready var timer: Timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var sound = $AudioStreamPlayer
signal player_dead(is_dead)

signal life_update(new_life_count)

var sonido_disparo = preload("uid://cbn1ajghtqgmn")

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
	var bala = BALAS_ALIADAS.instantiate()
	
	add_child(bala)
	sound.stream = sonido_disparo
	sound.play()
	
	bala.add_collision_exception_with(self)
	
	var colision = $CollisionShape2D
	
	var centro_colision = colision.global_position + (colision.shape.extents * colision.global_scale)
	var altura_mitad = colision.shape.extents.y * colision.global_scale.y + 50
	
	bala.global_position = Vector2(centro_colision.x - 12 , centro_colision.y - altura_mitad)

func damage_received():
	print("La nave ha sufrido 1 daño")
	life = life - 1
	life_update.emit(life)
	if life == 0:
		player_dead.emit(true)
		animation_player.play("destruccion")
		set_physics_process(false)
		$CollisionShape2D.set_deferred("disabled", true)


func _on_canvas_layer_boton_disparando() -> void:
	disparar()
