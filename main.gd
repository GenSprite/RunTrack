extends Node2D

var score = 0

# NEW
var obstacle_speed = 250.0

@onready var score_label = $UI/ScoreLabel

func _process(delta):
	score += delta * 10

	score_label.text = "Score: " + str(int(score))

	# difficulty scaling
	obstacle_speed += delta * 6
