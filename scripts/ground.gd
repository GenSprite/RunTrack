extends Sprite2D

@export var scroll_speed: float = 300.0
@export var reset_position: float = -720.0
@export var limit_position: float = 720.0

func _process(delta):
	position.y += scroll_speed * delta

	if position.y >= limit_position:
		position.y = reset_position
