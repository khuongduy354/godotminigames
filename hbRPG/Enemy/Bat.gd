extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_health = 100
export var defense =10
export var speed = 40
export var knockback_force =100
onready var chase_timer = $ChaseTimer
onready var DeathEffect =preload("res://Enemy/BatDeathEffect.tscn")
onready var WanderController = preload("res://Enemy/WanderController.tscn")

var wander_controller
enum {CHASE,IDLE,WANDER } 
var state = IDLE
var player
var veloc = Vector2.ZERO
var knockback = Vector2.ZERO 
var current_health = max_health

func _ready():	
	wander_controller  = WanderController.instance()
	add_child(wander_controller)
func _physics_process(delta):
	$AnimationPlayer.play("fly")
	apply_friction()
	knockback = move_and_slide(knockback)
	match state: 
		CHASE: 
			chase()
		IDLE: 
			if wander_controller.shouldWander:
				state = WANDER
			else: 
				state = IDLE
		WANDER:
			veloc = wander_controller.wander_veloc
			wander_controller.shouldWander = false
			state = IDLE
	veloc = move_and_slide(veloc)
	
func receive_hit(hitbox:PlayerHitbox): 
	if not hitbox is PlayerHitbox:
		return 
	current_health -= hitbox.damage - defense
	if current_health <= 0: 
		die()
	knock_back(hitbox.sword_direction)

func die():
	var death_effect = DeathEffect.instance() 
	death_effect.global_position = global_position
	get_tree().root.add_child(death_effect)
	queue_free()
	AudioPlayer.play(AudioPlayer.EnemyDie)

func knock_back(dir):
	knockback = dir * knockback_force
func apply_friction(): 
	knockback = knockback.move_toward(Vector2.ZERO,1)



func chase(): 
	if can_chase(): 
		veloc = veloc.move_toward((player.global_position-global_position).normalized()*speed,10)

func _on_PlayerDetection_body_entered(body):
	if body is Player: 
		player = body
		state = CHASE
		if !chase_timer.is_stopped(): 
			chase_timer.stop()


func _on_ChaseTimer_timeout():
	player = null 
	state = IDLE 

func can_chase(): 
	if player == null: 
		return false 
	return true
func _on_PlayerDetection_body_exited(body):
	if body is Player:
		chase_timer.start()
