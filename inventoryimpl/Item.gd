extends Node2D
class_name Item

var stackSize:int 
var item_name:String
var attack: int 
var damage: int 

@export var item_data:Resource 
@onready var icon_rect = $icon
@onready var icon_path =""

func _ready():
#	print(item_data.data)
	pass

func load_stats(data,_item_name): 
	stackSize = data.stackSize
	item_name = _item_name
	if data.category == "Weapon": 
		attack=data.attack
		damage = data.damage
	
func create_item(name): 
	if item_data.data.has(name): 
		load_stats(item_data.data.get(name),name)
		icon_path = "res://item_icons/"+name+".png"
		
		if icon_rect != null:
			icon_rect.texture = load(icon_path)
		else:
			print("item not in scene")
	else: 
		print("Unknown Item")
	
	
