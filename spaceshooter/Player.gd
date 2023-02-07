extends KinematicBody2D
class_name Player

export var speed =200
var bullet = preload("res://Bullet.tscn")

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		shoot()
	var dir = get_input_direction() 
	move_and_slide(dir*speed)

func shoot(): 
	var bullet_ins:Bullet = bullet.instance()
	bullet_ins.global_position=$shoot_pos.global_position
	bullet_ins.direction = Vector2.UP
	add_child(bullet_ins)
func get_input_direction():
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_dir
