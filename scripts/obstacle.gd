extends Area2D

# New: This creates a custom list in your Inspector where you can drop multiple images!
@export var obstacle_textures: Array[Texture2D] = []

@onready var player = get_parent().get_node_or_null("Player")

# Assumes your obstacle scene has a Sprite2D node inside it named "Sprite2D"
@onready var sprite = $Sprite2D 

func _ready():
	# If you loaded images into the list, choose one at random
	if obstacle_textures.size() > 0 and sprite:
		var random_index = randi() % obstacle_textures.size()
		sprite.texture = obstacle_textures[random_index]

func _process(delta):
	if player:
		position.y += player.current_speed * delta
	else:
		position.y += 300.0 * delta
		
	if position.y > 800.0:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		var main_node = get_parent()
		if main_node.has_method("trigger_game_over"):
			main_node.trigger_game_over()
