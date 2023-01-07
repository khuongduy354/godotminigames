extends Node


onready var timer = $WanderChanceTimer
export var wander_range = 10

var shouldWander = false
var wander_veloc = Vector2.ZERO
var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()
	timer.start()
func _on_WanderChanceTimer_timeout():
	var number = rng.randi_range(1,10)
	# 20% wander
	if number <=2:
		shouldWander = true	
		wander_veloc = Vector2(rng.randi_range(-wander_range,wander_range),rng.randf_range(-wander_range,wander_range))
	else: 
		shouldWander = false
	
