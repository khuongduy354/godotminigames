extends TileMap


var player = load("res://Entity/Player.tscn")
onready var spawn_point = $spawnpoint
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()
	VisualServer.set_default_clear_color(Color.lightblue)
	$Checkpoint.connect("body_checkpointed",self,"check_point")

func check_point(): 
	spawn_point.position=$Checkpoint.position

func spawn_player(): 
	var player_instance:Player = player.instance()
	player_instance.position = spawn_point.position
	player_instance.connect("player_die",self,"spawn_player")
	player_instance.connect_camera($Camera2D.get_path())
	add_child(player_instance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
