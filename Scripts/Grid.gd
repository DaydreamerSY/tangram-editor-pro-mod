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

var current_level_id = 1

var lv_selector
var level_text
var save_button
var is_overwrite

func get_level_id():
	return current_level_id

# Called when the node enters the scene tree for the first time.
func _ready():
	
	lv_selector = get_node("../UI/LevelSelector")
	level_text = get_node("../UI/Level")
	save_button = get_node("../UI/Save")
	is_overwrite = get_node("../UI/Overwrite")

	load_file()		
	update_grid_from_save(1)
	_on_Level_text_changed()
		
	pass # Replace with function body.
	

func update_grid_from_save(level):
	is_overwrite.set_pressed(false)
	clear()
	print(file_data)
	for color in file_data["levels"][str(level)]:
		for pos in file_data["levels"][str(level)][color]:
			set_cell(int(pos[0]), int(pos[1]), int(color))




func convert_to_cell_pos(mouse_pos):
	var tile_pos = world_to_map(mouse_pos)
	return tile_pos
	

func change_tile(mouse_pos, id):
	var tile_pos = convert_to_cell_pos(mouse_pos)
	set_cell(tile_pos[0], tile_pos[1], id)
	

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
	update_ui()


func update_ui():
#	print(file_data["levels"])
	lv_selector.clear()
	for level in file_data["levels"]:
		lv_selector.add_item(str(level), int(level))
	level_text.text = str(current_level_id)


func _on_Button_clear_pressed():
	clear()
	pass # Replace with function body.
	

func _on_Save_pressed():
	
	var used_color = {}

	var list_cells = get_used_cells()
	for cell in list_cells:
		var id = get_cell(cell[0], cell[1])
		if !(id in used_color):
			used_color[id] = []
			used_color[id].append([cell[0], cell[1]])
		else:
			used_color[id].append([cell[0], cell[1]])
			
	file_data["levels"][current_level_id] = used_color
	save_file()
	pass


func _on_LevelSelector_item_selected(index):
	var optionBtnLevel = get_node("../UI/LevelSelector")
	var level = int(optionBtnLevel.get_item_text(index))
	update_grid_from_save(level)
	level_text.text = str(level)
	current_level_id = level
	_on_Level_text_changed()
	pass # Replace with function body.


func _on_Level_text_changed():
	current_level_id = level_text.text
	if current_level_id in file_data["levels"]:
		save_button.set_disabled(true)
	pass # Replace with function body.


func _on_LoadFromFile_pressed():
	load_file()
	pass # Replace with function body.


func _on_CheckBox_toggled(button_pressed):
	if is_overwrite.is_pressed():
		save_button.set_disabled(false)
	else:
		save_button.set_disabled(true)
	pass # Replace with function body.

func set_selector(new_id):
	lv_selector.select(int(new_id)-1)
