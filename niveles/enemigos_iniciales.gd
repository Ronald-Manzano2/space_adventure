extends Node2D

@export var destion_final = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	
	var destino = Vector2(position.x, destion_final)
	
	tween.tween_property(self, "position", destino, 3.0)
	
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
