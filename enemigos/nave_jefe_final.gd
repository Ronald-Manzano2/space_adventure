extends RigidBody2D

var ESCENA_BALASENEMIGAS = preload("uid://c07w8khli1juc")
@export var life = 10
@export var dur_ataque = 3
@export var dur_pausa = 2

@onready var animation_player = $AnimationPlayer
signal destroyed(is_destroyed)

@onready var timer = $Timer
@onready var armaDerecha = $arma_derecha
@onready var armaIzquierda = $arma_izquierda

var en_pausa = false
var tiempo_atacando = 0

func _ready() -> void:
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	animation_player.play("disparo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if en_pausa: return
	
	if not animation_player.is_playing():
		animation_player.play("disparo")
	
	tiempo_atacando += delta
	if tiempo_atacando >= dur_ataque:
		tiempo_atacando = 0.0
		en_pausa = true
		animation_player.pause()
		timer.start(dur_pausa)

func _on_timer_timeout():
	en_pausa = false
	animation_player.play("disparo")

func ataque_derecha():
	var origen = Vector2(armaDerecha.position.x, armaDerecha.position.y + 15)
	var impulso = Vector2(0, 250)
	var angulos = [0.0, 45, -45]
	
	for angulo in angulos:
		var bala_enemiga = ESCENA_BALASENEMIGAS.instantiate()
		bala_enemiga.position = origen
		add_child(bala_enemiga)
		bala_enemiga.apply_central_impulse(impulso.rotated(deg_to_rad(angulo)))
	
func ataque_izquierda():
	var origen = Vector2(armaIzquierda.position.x, armaIzquierda.position.y + 15)
	var impulso = Vector2(0, 250)
	var angulos = [0.0, 45, -45]
	
	for angulo in angulos:
		var bala_enemiga = ESCENA_BALASENEMIGAS.instantiate()
		bala_enemiga.position = origen
		add_child(bala_enemiga)
		bala_enemiga.apply_central_impulse(impulso.rotated(deg_to_rad(angulo)))

var ya_destruida = false
func _on_body_entered(body: Node) -> void:
	if ya_destruida == true: return
	
	if body is Balas_aliadas:
		if life > 0:
			life = life - 1
		elif life <= 0:
			ya_destruida = true
			animation_player.play("destruccion")
			destroyed.emit(true)
