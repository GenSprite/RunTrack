extends Area2D

var speed = 250.0

func _process(delta):
	position.y += speed * delta
