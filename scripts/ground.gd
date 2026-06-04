extends Sprite2D

@export var reset_position: float = -720.0
@export var limit_position: float = 720.0

# Dynamic reference to your Player node
@onready var player = get_parent().get_node_or_null("Player")

func _process(delta):
	if player:
		# Scroll at the player's real-time velocity status
		position.y += player.current_speed * delta
	else:
		position.y += 300.0 * delta # Fallback safety
		
	if position.y >= limit_position:
		position.y = reset_position
