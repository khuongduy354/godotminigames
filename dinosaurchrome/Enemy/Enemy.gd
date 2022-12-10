extends Area2D

signal die

onready var animation_player=$AnimationPlayer

export var max_hp = 100 
export var speed = 100 
export var damage =10
export var defense = 100 
var current_hp = 100  setget set_current_hp 

var state = null

func set_current_hp(value):
	current_hp = clamp(value,0,max_hp)
	print(current_hp)
	if current_hp==0:
		_change_state(Global.DIE)
		emit_signal("die")
		
func _change_state(new_state): 
	match new_state: 
		Global.ATTACK: 
			animation_player.play("attack")
		Global.WALK: 
			animation_player.play("walk")
	state = new_state
	
func _ready():
	$VisibilityNotifier2D.connect("screen_exited",self,"queue_free")
	self.connect("die",self,"queue_free")

func _physics_process(delta):
	_change_state(Global.ATTACK)
	position.x -=1

func take_damage(damage):
	damage -= defense
	set_current_hp(current_hp-damage)

