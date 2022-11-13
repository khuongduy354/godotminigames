extends "pawn.gd"
onready var grid = get_parent()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func _process(e):
	var move_direction = get_input_direction()
	if not move_direction:
		return
	var target_pos = grid.request_move(self,move_direction)
	$Sprite.rotation = move_direction.angle()
	if target_pos:
		move_to(target_pos)	
		set_process(false)
		timer.connect("timeout",self,"_on_delay_timeout")
		timer.wait_time=0.5
		add_child(timer)
		timer.start()
		
func _on_delay_timeout():
	set_process(true)


func move_to(target): 
	position = target

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
