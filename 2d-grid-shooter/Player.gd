extends KinematicBody2D
signal hit

export var speed = 400 
var screen_size
var bullets = preload("res://Bullet.tscn")
var bullet_speed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity =Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	move_and_slide(velocity)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LM"): 
		fire()



func _on_body_entered(body):
	if "Enemy" in body.name: 
		hide() # Player disappears after being hit.
		emit_signal("hit")
		
func fire(): 
	var bullet = bullets.instance()
	bullet.position = position 
	bullet.rotation_degrees = rotation_degrees
	bullet.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet)
