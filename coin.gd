extends Area2D

@onready var player = get_parent().get_node_or_null("Player")

func _process(delta):
	if player:
		position.y += player.current_speed * delta
	else:
		position.y += 300.0 * delta
		
	# Delete itself if it scrolls off the bottom screen edge
	if position.y > 800.0:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		var main_node = get_parent()
		if main_node.has_method("add_coin"):
			main_node.add_coin()
		
		# Instantly delete the coin so you can't collect it twice
		queue_free()
