extends Node2D

const scena_final = preload("res://ui/game_over.tscn")
signal all_destroyed(are_destroyed)

@export var time_sec = 120
var naves_destruidas = 0
var oleadas_terminadas = false

signal time_restant(sec_left)

func _ready() -> void:
	if $"/root/PistaAudio":
		$"/root/PistaAudio".play()


func game_over(titulo):
	$"/root/PistaAudio".stop()
	var game_over_ui = scena_final.instantiate()
	game_over_ui.get_node("ColorRect/VBoxContainer/Label").text = titulo
	add_child(game_over_ui)
	get_tree().paused = true

func sumar_naves():
	if oleadas_terminadas: return
	
	naves_destruidas += 1
	print("Nave destruidas:", naves_destruidas)
	if naves_destruidas >= 5:
		oleadas_terminadas = true
		all_destroyed.emit(true)

func _on_timer_timeout() -> void:
	if time_sec > 0:
		time_sec = time_sec - 1
	elif time_sec <= 0:
		game_over("SE ACABÓ EL TIEMPO")
	time_restant.emit(time_sec)


func _on_nave_player_dead(is_dead: Variant) -> void:
	if is_dead == true:
		await  get_tree().create_timer(3.0).timeout
		game_over("PERDISTE MUCHA VIDA")

func _on_nave_inicial_1_destroyed(is_destroyed: Variant) -> void:
	if is_destroyed == true:
		sumar_naves()

func _on_nave_inicial_2_destroyed(is_destroyed: Variant) -> void:
	if is_destroyed == true:
		sumar_naves()

func _on_naves_enemigas_destroyed(is_destroyed: Variant) -> void:
	if is_destroyed == true:
		sumar_naves()

func _on_naves_enemigas_2_destroyed(is_destroyed: Variant) -> void:
	if is_destroyed == true:
		sumar_naves()

func _on_naves_enemigas_3_destroyed(is_destroyed: Variant) -> void:
	if is_destroyed == true:
		sumar_naves()


func _on_nave_jefe_final_destroyed(is_destroyed: Variant) -> void:
	if is_destroyed == true:
		await get_tree().create_timer(1.5).timeout
		game_over("HAS GANADO")
