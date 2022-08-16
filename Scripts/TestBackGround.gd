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

var type_cell_define = {
	# "nothing": -1
	"bg": 0,
	"u": 1,
	"ur": 2,
	"r": 3,
	"rd": 4,
	"d": 5,
	"dl": 6,
	"l": 7,
	"ul": 8,
	"urd": 9,
	"rdl": 10,
	"udl": 11,
	"url": 12,
	"urdl": 13,
	"ud": 14,
	"rl": 15
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_file()
#	print(file_data)
	pass # Replace with function body.


func update_ui(level):
	load_file()
	clear()
	for color in file_data["levels"][str(level)]:
		for pos in file_data["levels"][str(level)][color]:
			# set background for playable zone
			set_cell(int(pos[0]), int(pos[1]), type_cell_define["bg"])
			
	# set edge cover playable zone
	for x in range(0,11):
		for y in range(0,11):
			var type_cell = ""
			if get_cell(x, y) != type_cell_define["bg"]:
				if get_cell(x, y-1) == type_cell_define["bg"]:
					type_cell += "u"
				if get_cell(x+1, y) == type_cell_define["bg"]:
					type_cell += "r"
				if get_cell(x, y+1) == type_cell_define["bg"]:
					type_cell += "d"
				if get_cell(x-1, y) == type_cell_define["bg"]:
					type_cell += "l"
				if len(type_cell) > 0:
					set_cell(x, y, type_cell_define[type_cell])


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
