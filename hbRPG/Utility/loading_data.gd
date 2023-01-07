extends Node

func load_user_json(): 
	var data = {}
	var file = File.new()
	if not file.file_exists("user://user.json"):
		return	
	file.open("user://user.json",File.READ)
	data = parse_json(file.get_as_text())
	file.close()
	return data 
