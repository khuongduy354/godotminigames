extends Area2D

signal scored
onready var animation_player=$AnimationPlayer
onready var PointArea = $Point 

export var max_hp = 100 
export var speed = 100 
export var damage =100
var state = null
enum {ATTACK,WALK}
 
func _change_state(new_state): 
	match new_state: 
		ATTACK: 
			animation_player.play("attack")
		WALK: 
			animation_player.play("walk")
	state = new_state
	
func _ready():
	PointArea.connect("area_entered",self,"scored")
	$VisibilityNotifier2D.connect("screen_exited",self,"queue_free")
	
	
func scored(area:Area2D): 
	if area.owner.name == "PlayerBase":
		emit_signal("scored")

func _physics_process(delta):
	position.x -=1

