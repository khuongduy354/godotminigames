extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_ammo = 10
onready var shoot_timer = $bullet_rate 
onready var reload_timer = $reloadTimer
onready var slider = get_parent().get_node("HSlider")
onready var shoot_position :=$shootposition
const BulletScene = preload("res://Bullet.tscn")
var bulletInMagazine = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	reload_timer.connect("timeout",self,"refill_ammo")
	
func refill_ammo():
	bulletInMagazine=max_ammo
	
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if not reload_timer.is_stopped():
		return
	
	if Input.is_action_pressed("spaced"):
		if bulletInMagazine > 0:
			shoot()
		else: 
			reload()
		
		
		
func reload(): 
	if not reload_timer.is_stopped(): 
		return
	reload_timer.start()
	
func set_fire_rate(value) -> void:
	shoot_timer.wait_time = 1/value
	print(shoot_timer.wait_time)
	
func set_reload_time(value):
	reload_timer.wait_time=value
func set_max_ammo(value):
	max_ammo=value

func shoot(): 
	if not shoot_timer.is_stopped() :
		return 
	
	var bullet := BulletScene.instance()
	bullet.global_position = shoot_position.global_position
	bullet.direction=global_position.direction_to(get_global_mouse_position())
	add_child(bullet)
	bulletInMagazine-=1
	shoot_timer.start()
		 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
