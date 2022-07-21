extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var file_data = {
	"levels": {
		1: {},
		2: {},
		3: {},
		4: {},
		5: {},
		6: {},
		7: {},
		8: {},
		9: {},
		10: {}
	}
}

var zone = {
	"0": [11, 1],
	"1": [16, 1],
	"2": [11, 6],
	"3": [16, 6],
	"4": [11, 11],
	"5": [16, 11],
	"6": [1, 11],
	"7": [6, 11],
	"8": [1, 16],
	"9": [6, 16],
}

func transalte_pos(level, color):
	var top_most_y = 99
	var left_most_x = 99
	
	if color == '10':
		return file_data["levels"][str(level)][color]
	
	for pos in file_data["levels"][str(level)][color]:
		if pos[1] < top_most_y:
			top_most_y = pos[1]
		if pos[0] < left_most_x:
			left_most_x = pos[0]
	var new_color_pos = []
	
	var y_distance = top_most_y - zone[color][1]
	var x_distance = left_most_x - zone[color][0]
	
	for pos in file_data["levels"][str(level)][color]: 
		new_color_pos.append([pos[0]-x_distance, pos[1]-y_distance])
			
	return new_color_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	load_file()
	pass # Replace with function body.


func update_ui(level):
	load_file()
	clear()
	for color in file_data["levels"][str(level)]:
		var color_pos = transalte_pos(level, color)
		if color_pos == null:
			return
		for pos in color_pos:
			set_cell(pos[0], pos[1], int(color))
			
			
			


func save_file():
	var file = File.new()
	file.open("user://file_data.json", File.WRITE)
	file.store_line(to_json(file_data))
	file.close()
	
	
func load_file():
	var file = File.new()
	if !(file.file_exists("user://file_data.json")):
		 save_file()
		 return
	file.open("user://file_data.json", File.READ)
	var data = parse_json(file.get_as_text())
	file_data = data
