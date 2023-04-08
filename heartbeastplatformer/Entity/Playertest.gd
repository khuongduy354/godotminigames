extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var dir = get_input_direction()
	var veloc = Vector2.ZERO
	veloc.y+=10
	veloc.x=move_toward(veloc.x,dir.x*100,50)
	move_and_slide(veloc)
func get_input_direction():
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	return input_dir
