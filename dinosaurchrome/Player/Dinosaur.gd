extends Node2D

onready var animation_player = $AnimationPlayer

signal player_hit

enum  {IDLE,WALK,DIE,ATTACK,HURT,CROUCH,JUMP}
var state = null 

func _ready():	
	pass
	


func _change_state(new_state): 
	match new_state: 
		IDLE: 
			pass
		HURT: 
			animation_player.play("hurt")	
#			yield(animation_player,"animation_finished")
#			animation_player.play("RESET")
		CROUCH: 
			animation_player.play("crouch")
		WALK:
			animation_player.play("walk")
		ATTACK: 
			animation_player.play("attack")
		DIE: 
			animation_player.play("die")
		JUMP:
			animation_player.play("jump")
	state = new_state

func _physics_process(delta):
	if state != DIE:
		if Input.is_action_pressed("down"):
			_change_state(CROUCH)
		else: 
			_change_state(WALK)
			

func _on_Area2D_area_entered(area):
	if area.name == "Enemy":
		_change_state(HURT) 
		emit_signal("player_hit")
