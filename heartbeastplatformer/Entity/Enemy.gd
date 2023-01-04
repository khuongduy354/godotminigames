extends KinematicBody2D
class_name Enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var speed = 10
export var damage=10

var dir = Vector2(1,0)
var veloc = Vector2.ZERO
onready var rightcheck = $rightedgecheck
onready var leftcheck = $leftedgecheck


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var is_fall = !rightcheck.is_colliding() or !leftcheck.is_colliding()
	if is_on_wall() or is_fall: 
		dir = -dir
	veloc = dir * speed
	move_and_slide(veloc)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
