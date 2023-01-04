extends KinematicBody2D

export var speed = 300
export var jump_height = 100
export var gravity = 4
onready var animation = $AnimatedSprite

var velocity = Vector2.ZERO
func _ready():
	pass

func _physics_process(delta):
	velocity.x = get_input_direction()*speed
	velocity.y+=gravity
	if Input.is_action_just_pressed("jump"): 
		velocity.y = -jump_height
	velocity=move_and_slide(velocity)
	
func get_input_direction() :
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir = input_dir.normalized()
	return input_dir.x
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
