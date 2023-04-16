extends KinematicBody2D
signal picked_stone 
signal picked_mango
signal gameover

export var speed = 100
export var jump_height=250

onready var anim_player = $AnimationPlayer
var StoneScene = preload("res://StoneBullet.tscn")
const GRAVITY =5

var can_shoot = true
var stones = 0
var mangos = 0

var veloc = Vector2.ZERO
enum {
	MOVE, SHOOT
}
var state =MOVE 
func flip_sprite(dir): 
	if dir.x < 0: 
		$BoySpritesheet.flip_h = true
		
	elif dir.x > 0:
		$BoySpritesheet.flip_h = false
		
func _ready():
	pass 
func move_state(): 
	var dir = get_input_direction() 
	flip_sprite(dir)
	if dir == Vector2.ZERO: 
		anim_player.play("idle")
	else: 
		anim_player.play("walk")
		
	
	veloc.x = dir.x * speed
	
	if Input.is_action_just_pressed("space") and is_on_floor():
		veloc.y=-jump_height
	
	if Input.is_action_just_pressed("left_click"):
		state = SHOOT
		veloc=Vector2.ZERO
		
func shoot_state(): 
	if can_shoot: 
		anim_player.play("shoot")
		shoot()
		can_shoot=false
func shoot(): 
	if stones <= 0: 
		return
	
	var bullet = StoneScene.instance()
	bullet.global_position = $shoot_pos.global_position
	bullet.direction = global_position.direction_to(get_global_mouse_position()) 
	add_child(bullet)
	MusicPlayer.get_node("Shoot").play()
	stones-=1
		
func _on_shoot_finished(): 
	can_shoot = true
	state = MOVE

func _physics_process(delta):
	match state: 
		MOVE:
			move_state()	
		SHOOT: 
			shoot_state()
	veloc.y+=GRAVITY
	move_and_slide(veloc,Vector2.UP)


func get_input_direction():
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_dir

func collect(isStone:bool): 
	if isStone: 
		stones+=1
		emit_signal("picked_stone")
	else: 
		mangos+=1
		if mangos == 5: 
			self.emit_signal("gameover")
		
