extends Node2D

onready var animation_player = $AnimationPlayer

signal player_hit
signal die 

export var max_hp = 100 
export var speed = 100 
export var damage =10
export var defense = 0
var current_hp = 100  setget set_current_hp 

func set_current_hp(value):
	current_hp = clamp(value,0,max_hp)
	print(current_hp)
	if current_hp==0:
		_change_state(Global.DIE)
		emit_signal("die")
		

var state = Global.WALK
func _ready():	
	animation_player.connect("animation_finished",self,"_on_anim_finished")

func _on_anim_finished(anim_name): 
	state = Global.WALK

func _change_state(new_state): 
	match new_state: 
		Global.HURT: 
			animation_player.play("hurt")
		Global.CROUCH: 
			animation_player.play("crouch")
		Global.WALK:
			animation_player.play("walk")
		Global.ATTACK: 
			animation_player.play("attack")
		Global.DIE: 
			animation_player.play("die")
		Global.JUMP:
			animation_player.play("jump")
	state = new_state

func _physics_process(delta):
	if state != Global.DIE:
		if Input.is_action_pressed("down"):
			_change_state(Global.CROUCH)
		if Input.is_action_just_pressed("spaced"):
			_change_state(Global.ATTACK)
		if state == Global.WALK: 
			_change_state(Global.WALK)
		

func take_damage(damage):
	_change_state(Global.HURT)
	damage -= defense
	set_current_hp(current_hp-damage)
