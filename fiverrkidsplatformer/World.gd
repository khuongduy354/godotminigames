extends Node2D

var player_hearts = 3
var scores = 0  
var current_level = 1
var required_scores=0
var scene = null

func _ready():
	update_ui()
	load_current_level()
	$Timer.start()

	pass # Replace with function body.
	
func update_ui():
	$UI/Label.text = "Lives: " + str(player_hearts)
	$UI/Label2.text = str(time_convert($Timer.time_left))
	$UI/Label3.text = "Collected: " + str(scores) +"/" + str(required_scores)
	
func _on_coin_collect(): 
	scores += 1
	update_ui()
	if scores >= required_scores: 
		if current_level != 5: 
			current_level+=1 
			load_current_level()


func game_over(): 
	get_tree().change_scene("res://MenuInterface.tscn")
	
func _on_player_hit(): 
	player_hearts-=1 
	# no mroe lives => quit 
	if player_hearts == 0: 
		game_over()
	update_ui()


func load_current_level(): 
	# reset stuffs
	scores = 0  
	player_hearts=3
	$Player.position = $spawnpoint.position
	$Timer.stop()
	$Timer.start()
	
	# remove previous level
	if current_level > 1: 
		remove_child(get_node("Level"+str(current_level-1)))
		
	# load Level1, Level2, Level3,...
	var path = "res://Level"+ str(current_level)+".tscn"
	scene = load(path)
	scene = scene.instance()
	add_child(scene)
	
	# connect signals for each levels
	for obstacle in scene.get_node("Obstacles").get_children(): 
		if obstacle.is_water: 
			obstacle.connect("drown",self,"game_over")
		else: 		
			obstacle.connect("player_hit",self,"_on_player_hit")
	
	required_scores = 0
	for coin in scene.get_node("Coins").get_children(): 
		required_scores+=1
		coin.connect("collected",self,"_on_coin_collect")
	



# seconds to minutes:seconds format
func time_convert(total_seconds: float) -> String:
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	var result: String = "%02d:%02.0f" % [minutes, seconds]
	return result

# update time left 
func _process(delta):
	update_ui()


func _on_Timer_timeout():
	game_over()
