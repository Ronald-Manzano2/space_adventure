extends RigidBody2D
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body: Node) -> void:
	if body is Nave:
		animation_player.play("impacto")
		if body.has_method("damage_received"):
			body.damage_received()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "impacto":
		queue_free()
