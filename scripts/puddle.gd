extends Area2D

@export var boost_duration: float = 1.5 
@onready var player = get_parent().get_node_or_null("Player")

func _process(delta):
	if player:
		position.y += player.current_speed * delta
	else:
		position.y += 300.0 * delta
	
	if position.y > 800.0:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		# 1. Boost the player
		if body.has_method("apply_boost_effect"):
			body.apply_boost_effect(boost_duration)
		
		# 2. Tell Main to play the sound (Just like the coin!)
		var main_node = get_parent()
		if main_node.has_method("play_boost_sound"):
			main_node.play_boost_sound()
			
		# 3. Delete the puddle instantly
		queue_free()
