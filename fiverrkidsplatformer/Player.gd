extends KinematicBody2D
class_name Player
signal fall_out_map 

export var speed = 200
const GRAVITY =10
export var jump_height=250
var veloc = Vector2.ZERO
onready var anim_player = $AnimationPlayer


func _ready():
	pass # Replace with function body.

# flip when go left or right accordingly
func flip_sprite(dir): 
	if dir.x < 0: 
		$Spritesheet2.flip_h = true
		$Spritesheet1.flip_h = true
		
	elif dir.x > 0:
		$Spritesheet2.flip_h = false
		$Spritesheet1.flip_h = false
		
		
		

func _physics_process(delta):
	var dir = get_input_direction() 
	flip_sprite(dir)

	if dir == Vector2.ZERO: 
		anim_player.play("idle")
		veloc.x=0
	else: 
		anim_player.play("run")
		veloc.x = dir.x * speed
	
	if Input.is_action_just_pressed("space") and is_on_floor():
		veloc.y=-jump_height

			
	veloc.y+=GRAVITY 
	veloc =move_and_slide(veloc,Vector2.UP)


func get_input_direction():
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_dir




