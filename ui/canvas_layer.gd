extends CanvasLayer
const VIDA_1_HIT = preload("uid://c8qu5c517gqpr")
const VIDA_2_HIT = preload("uid://c66c15b0jdqea")
const VIDA_3_HIT = preload("uid://dmad6e8meb5ih")
const VIDA_4_HIT = preload("uid://burra7wockwve")
const VIDA_5_HIT = preload("uid://dhagsaku54ewk")
const VIDA_COMPLETA = preload("uid://d1oyanyug0ssc")

@onready var pantalla_pausa = $PantallaPausa
signal boton_disparando

@onready var boton_disparo = $BotonAtacar

func _ready() -> void:
	pantalla_pausa.hide()
	boton_disparo.pressed.connect(_on_boton_atacar)

func _on_nave_life_update(new_life_count: Variant) -> void:
	if new_life_count >= 5:
		$BarraVida.texture = VIDA_COMPLETA
	elif new_life_count >= 4:
		$BarraVida.texture = VIDA_1_HIT
	elif new_life_count >= 3:
		$BarraVida.texture = VIDA_2_HIT
	elif new_life_count >= 2:
		$BarraVida.texture = VIDA_3_HIT
	elif new_life_count >= 1:
		$BarraVida.texture = VIDA_4_HIT
	elif new_life_count >= 0:
		$BarraVida.texture = VIDA_5_HIT


func _on_game_controller_time_restant(sec_left: Variant) -> void:
	$TextureRect/Label.text = str(sec_left)


func _on_boton_pausa_button_down() -> void:
	get_tree().paused = true
	pantalla_pausa.show()

func _on_boton_atacar():
	boton_disparando.emit()
