extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {UP, SMASH,IDLE} 
var state = SMASH
var veloc = Vector2(0,10)
var mock_position =Vector2.ZERO
onready var idle_timer = $IdleTimer

export var idle_time = 1
export var smash_height = 100
export var up_veloc = -2 
export var smash_veloc = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	idle_timer.wait_time = idle_time
func _physics_process(delta):
	print(state)
	match state: 
		UP: 
			move_up()
		SMASH:
			smash()
		IDLE: 
			idle()

func idle(): 
	veloc.y = 0
	if idle_timer.is_stopped():
		idle_timer.start()
	$Particles2D.emitting = true

func smash(): 
	veloc.y=smash_veloc
	var collider = move_and_collide(veloc)
	if collider != null: 
		mock_position = self.position
		state = IDLE

func move_up(): 
	$Particles2D.emitting = false
	veloc.y=up_veloc
	if mock_position.distance_to(self.position) > smash_height: 
		state = SMASH
	move_and_collide(veloc)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body is Player:
		if body.has_method("die"): 
			body.die()


func _on_IdleTimer_timeout():
	state = UP
