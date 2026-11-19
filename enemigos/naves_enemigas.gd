class_name NaveEnemiga
extends RigidBody2D

const BALAS_ENEMIGAS = preload("uid://c07w8khli1juc")
@onready var animation_plater = $AnimationPlayer
signal destroyed(is_destroyed)
@export var life = 3
var ya_destruida = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animation_plater.play("disparar")

func atacar():
	var bala_enemiga = BALAS_ENEMIGAS.instantiate()
	var ejeX = $CollisionShape2D.position.x
	var ejeY = $CollisionShape2D.position.y + 25
	bala_enemiga.position = Vector2(ejeX, ejeY)
	add_child(bala_enemiga)
	bala_enemiga.apply_central_impulse(Vector2(0, 250))


func _on_body_entered(body: Node) -> void:
	if ya_destruida == true: return
	
	if body is Balas_aliadas:
		life = life - 1
	if life <= 0:
		ya_destruida = true
		set_process(false)
		set_physics_process(false)
		animation_plater.play("destruccion")
		destroyed.emit(true)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destruccion":
		queue_free()
