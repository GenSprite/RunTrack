extends Area2D

var speed = 250.0

func _ready():
	speed = get_parent().obstacle_speed

func _process(delta):
	position.y += speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		print("GAME OVER")
		get_tree().reload_current_scene()
