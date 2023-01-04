extends KinematicBody2D
class_name Player 
signal player_die
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {CLIMB, MOVE}
var state = MOVE
var is_in_ladder=false  
var was_on_floor = is_on_floor()
var double_jump=1
var bounce_jump=false # bounce after double jump, runs out after time 
export(Resource) var MovementData

onready var max_speed = MovementData.max_speed
onready var jump_height=MovementData.jump_height
onready var health = MovementData.health
onready var GRAVITY =MovementData.GRAVITY

onready var coyoteTimer = $CoyoteJump

var veloc = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var dir =get_input_direction()
	was_on_floor = is_on_floor()
	prepare_state()
	match state: 
		CLIMB: 
			climb(dir.x)
		MOVE: 
			move(dir.x)
	apply_x_accel(dir.x)

func prepare_state():
	if Input.is_action_pressed("ui_up") and is_in_ladder:
		set_state("climb")
	if not is_in_ladder: 
		set_state("move")

func climb(dir): 
	if Input.is_action_pressed("ui_up"):
		veloc.y=-50
	elif Input.is_action_pressed("ui_down"):
		veloc.y=50
	else: 
		veloc.y=0
	move_and_slide(veloc,Vector2.UP)


func move(dir): 
	# buffer, coyote, double jump implemented
	veloc.y+=GRAVITY
	# coyote allows jump after falling a bit
	if was_on_floor and !is_on_floor(): 
		coyoteTimer.start()
	# double jump reset 
	if is_on_floor():
		double_jump=1

	if Input.is_action_pressed("space"):
		if is_on_floor() or !coyoteTimer.is_stopped():
			veloc.y=-jump_height
			bounce_jump=false
			GameAudio.play_audio(GameAudio.PLAYER_JUMP)
		else: 
			if Input.is_action_just_pressed("space") and double_jump > 0: 
				double_jump-=1
				veloc.y=-jump_height
				GameAudio.play_audio(GameAudio.PLAYER_JUMP)
				
			bounce_jump=true
			$BounceJump.start()
	move_and_slide(veloc,Vector2.UP)

func set_in_ladder(isInLad:bool):
	is_in_ladder = isInLad
	
	
func set_state(state_str): 
	if state_str == "climb":
		state = CLIMB
	if state_str == "move":
		state = MOVE 
		
func connect_camera(path):
	$RemoteTransform2D.remote_path=path

func get_input_direction():
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	return input_dir

func take_damage(damage):
	health -= damage

func die(): 
	remove_child($VisibilityNotifier2D)
	self.queue_free()
	emit_signal("player_die")	
	
func _on_Hurtbox_body_entered(body):
	if body is Enemy: 
		self.take_damage(body.damage)

func apply_x_accel(dir):
	veloc.x=move_toward(veloc.x,dir*max_speed,20)
	
func apply_friction():
	veloc.x = move_toward(veloc.x,0,20)


func _on_BounceJump_timeout():
	bounce_jump=false

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	die()
