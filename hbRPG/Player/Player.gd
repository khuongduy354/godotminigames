extends KinematicBody2D
class_name Player
signal player_die


export (int) var max_speed
export (int)var accel 
export (int)var friction 
export var defense = 10 
export var max_health = 500
export var ROLL_SPEED = 150

enum {WALK,ROLL,ATTACK,IDLE}
var health = max_health setget set_health 
var state =IDLE
var facing_dir = Vector2.RIGHT  
var velocity = Vector2.ZERO

onready var animation_tree=$AnimationTree
onready var HurtBox = $HurtBox
onready var animation_state= animation_tree.get("parameters/playback")
onready var InvinTimer = $InvicibileTimer

func parse_user_json():
	var data = LoadingData.load_user_json() 
	max_speed = data.max_speed 
	accel = data.accel 
	friction = data.friction
func _ready():
	parse_user_json()


func _physics_process(delta):
	prepare_state()
	match state: 
		ATTACK: 
			attack_state()
		WALK: 
			move_state()
		ROLL:
			roll_state()
		IDLE:
			idle_state()
	move_and_slide(velocity)
			
func prepare_state():
	# setup parameters
	var dir = get_input_direction()
	set_anim_tree_param(dir)
	
	# Roll cant take input direction 
	if dir != Vector2.ZERO and state != ROLL:
		facing_dir=dir
	
	if Input.is_action_just_pressed("space"): 
		state = ATTACK
		return
	if Input.is_action_just_pressed("r"): 
		state = ROLL 
		return 

	# No walking while Rolling 
	if state == ROLL: 
		return 

	# Walk
	if dir != Vector2.ZERO:
		state = WALK
	if dir == Vector2.ZERO:
		state = IDLE
func idle_state(): 
	apply_friction()
	animation_state.travel("Idle")
	
func roll_state(): 
	velocity=facing_dir*ROLL_SPEED
	animation_state.travel("Roll")

	
func attack_state():
	animation_state.travel("Attack")
	
func move_state(): 
	var dir = get_input_direction()
	if dir == Vector2.ZERO: 
		state=IDLE
	animation_state.travel("Walk")
	apply_accel(dir,max_speed)
	
func apply_accel(dir,speed):
	velocity=Vector2(move_toward(velocity.x,dir.x*speed,accel),move_toward(velocity.y,dir.y*speed,accel))

func apply_friction():
	velocity = Vector2(move_toward(velocity.x,0,friction),move_toward(velocity.y,0,friction))
	
func get_input_direction():
	var dir: Vector2 = Vector2.ZERO
	dir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	return dir.normalized()

func set_anim_tree_param(dir): 
	if dir != Vector2.ZERO: 
		$rotation_pivot/HitBox.sword_direction = facing_dir
		animation_tree.set("parameters/Roll/blend_position",facing_dir)
		animation_tree.set("parameters/Attack/blend_position",dir)
		animation_tree.set("parameters/Idle/blend_position",dir)
		animation_tree.set("parameters/Walk/blend_position",dir)	



func anim_finished(anim_name):
	match anim_name: 
		"Roll": 
			state = WALK

func set_health(value):
	health = value 
	print(health)
	if health < 0: 
		die()
func die(): 
	emit_signal("player_die")
	#queue_free()
func receive_hit(hitbox): 
	if not hitbox.owner.is_in_group("enemy"):
		return
	set_invicibility(true)
	set_health(health- (hitbox.damage-defense))	

	
func set_invicibility(is_true): 
	if is_true: 
		InvinTimer.start()
		HurtBox.set_deferred("monitoring",false)
	else: 
		InvinTimer.stop() 
		HurtBox.set_deferred("monitoring",true)


func _on_InvicibileTimer_timeout():
	set_invicibility(false)
	
