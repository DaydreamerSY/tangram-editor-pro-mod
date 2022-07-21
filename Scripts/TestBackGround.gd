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
			set_cell(int(pos[0]), int(pos[1]), 0)


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
