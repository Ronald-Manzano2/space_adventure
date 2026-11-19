class_name Asteroide2
extends RigidBody2D

var vida = 2
var damage_done = false
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body is Nave:
		if not damage_done:
			print("Jugador golpeado")
			damage_done = true
			vida = 0
			animation_player.play("destruccion")
			if body.has_method("damage_received"):
				body.damage_received()
	elif body is Balas_aliadas:
		vida = vida - 1
		if vida == 0:
			animation_player.play("destruccion")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destruccion":
		queue_free()
