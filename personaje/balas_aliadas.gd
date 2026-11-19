class_name Balas_aliadas
extends RigidBody2D

@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_central_impulse(Vector2(0, -500))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body is NaveEnemiga or Asteroide1 or Asteroide2:
		animation_player.play("impacto")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "impacto":
		queue_free()
