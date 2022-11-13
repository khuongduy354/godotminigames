extends Node2D
signal game_over


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const GRAVITY = 10
const FLAP_ACCEL = 150
const MAX_FALLSPEED =300 

var veloc = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


func _process(delta):
	pass

var motion = Vector2() 
func _physics_process(delta):
	motion.y+= GRAVITY
	motion.x = $".".get_linear_velocity().x
	if motion.y > MAX_FALLSPEED: 
		motion.y = MAX_FALLSPEED 
	if Input.is_action_just_pressed("FLAP"): 
		motion.y = -FLAP_ACCEL
	$".".set_linear_velocity(motion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Bird_body_entered(body):
	emit_signal("game_over")
		
