extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var isDead = false
onready var animation_player = $AnimationPlayer
onready var DeathSprite = $Death 
onready var WalkSprite = $Walk
signal player_hit
# Called when the node enters the scene tree for the first time.
func _ready():	
	$Hurt.hide()
	$Area2D.connect("area_entered",self,"_handle_area_entered")
	
func _handle_area_entered(area): 
	if area.name == "Enemy":
		isDead=true
		DeathSprite.hide()
		WalkSprite.hide()
		$Hurt.show()
		animation_player.play("die")	
		yield(animation_player,"animation_finished")
		animation_player.play("RESET")
		emit_signal("player_hit")
	
func _physics_process(delta):
	if not isDead:
		if Input.is_action_pressed("down"):
			WalkSprite.hide()
			DeathSprite.show()
			animation_player.play("crouch")
		else: 
			WalkSprite.show() 
			DeathSprite.hide() 
			animation_player.play("walk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


