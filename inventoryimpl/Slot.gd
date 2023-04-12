extends TextureRect
class_name Slot

@onready var item:Item = null
var current_stack:int = 0

var ItemClass = preload("res://Item.tscn")
func ready(): 
	pass
	

func remove_item_from_slot():
	remove_child(item)
	item = null
	
func stack_item(): 
	if item.stackSize == current_stack: 
		return 
	current_stack+=1 
	
func place_item(new_item):
	item = new_item 
	item.position = Vector2(0,0)
	add_child(item)
	

func create_and_place(item_name): 
	var _item = ItemClass.instantiate() 
	add_child(_item)
	_item.create_item(item_name)
	current_stack =1
	item = _item
