extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = preload("res://Player.tscn")
var enemy = preload("res://Enemy.tscn")
onready var enem_timer = $enemytimer

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_ins = player.instance()
	player_ins.position=$spawn_player.position
	add_child(player_ins)


func spawn_enemy(): 
	var enemy_ins = enemy.instance()
	enemy_ins.position.y=$spawn_enem.position.y
	var width = get_viewport_rect().size.x
	enemy_ins.position.x=randf() * width 
	add_child(enemy_ins)


func _on_enemytimer_timeout():
	spawn_enemy()
