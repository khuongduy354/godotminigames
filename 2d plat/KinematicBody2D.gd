extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
onready var animation = $AnimatedSprite
func _physics_process(delta):
	var velocity = Vector2(0,0)
	var speed = 10 
	animation.play("default")
	
	if Input.is_action_pressed("right"):
		animation.play("right")
		velocity.x += 1
	if Input.is_action_pressed("left"):
		animation.play("left")		
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed 
	set_linear_velocity(get_linear_velocity()+velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
