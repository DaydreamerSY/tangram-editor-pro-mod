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

var color_saver =  {}

var POINTER

var current_color_selected
var current_color_pos_selected
var current_color
var is_selected = false

var Clock
var is_started = false
var time_elapsed = 0.0

var zone = {
	"0": [12, 1],
	"1": [17, 1],
	"2": [12, 6],
	"3": [17, 6],
	"4": [12, 11],
	"5": [17, 11],
	"6": [1, 12],
	"7": [6, 12],
	"8": [1, 17],
	"9": [6, 17],
}

var play_zone = []


func transalte_pos(level, color):
	var top_most_y = 99
	var left_most_x = 99
	
	if color == '10':
		color_saver[color] = file_data["levels"][str(level)][color]
		return color_saver[color]
	
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
			
	color_saver[color] = new_color_pos
	return new_color_pos
	

func clear_cache():
	color_saver = {}
	time_elapsed = 0.0
	is_selected = false
	is_started = false
	Clock.text = _format_seconds(time_elapsed, true)
	play_zone = []


# Called when the node enters the scene tree for the first time.
func _ready():
	load_file()
	
	Clock = get_node("../UI/Clock")
	pass # Replace with function body.
	
	
func _process(delta):
	if Input.is_action_just_pressed("placeBlock"):		

		var mouse_pos = get_viewport().get_mouse_position()
		var tile_pos = world_to_map(mouse_pos)
		current_color = get_cell(tile_pos[0], tile_pos[1])
		if current_color in range(0,10):
			current_color_selected = str(current_color)
			current_color_pos_selected = tile_pos
			is_selected = true

	if is_selected:
		if !is_started:
			is_started = true
			update_text_Start_btn()
		var mouse_pos = get_viewport().get_mouse_position()
		update_pos_of_set_color(current_color_selected, current_color_pos_selected, mouse_pos)
		update_ui_after_move()
		
			
	if Input.is_action_just_released("placeBlock"):
		if is_selected:
			is_selected = false
			if check_win():
				is_started = false
				update_text_Start_btn()
		
	if is_started:
		time_elapsed += delta
		Clock.text = _format_seconds(time_elapsed, true)
	
	pass
	
func check_win():
	for pos in play_zone:
		if get_cell(pos[0], pos[1]) == -1:
			return false
	return true

func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func update_pos_of_set_color(color_selected, current_pos, new_view_pos):
	var new_tile = world_to_map(new_view_pos)
	var x_distance = new_tile.x - current_pos.x
	var y_distance = new_tile.y - current_pos.y
	
	current_color_pos_selected[0] += x_distance
	current_color_pos_selected[1] += y_distance

	for pos in color_saver[color_selected]:
		pos[0] += x_distance
		pos[1] += y_distance
		
	
	pass


func update_ui(level):
	load_file()
	for color in file_data["levels"][str(level)]:
		for pos in file_data["levels"][str(level)][color]:
			play_zone.append(pos)
	clear()
	for color in file_data["levels"][str(level)]:
		var color_pos = transalte_pos(level, color)
		if color_pos == null:
			return
		for pos in color_pos:
			set_cell(pos[0], pos[1], int(color))
			
		
func update_ui_after_move():
	clear()
	for color in color_saver:
#		var color_pos = transalte_pos(level, color)
#		if color_pos == null:
#			return
		for pos in color_saver[color]:
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



func update_text_Start_btn():
	var start_btn = get_node("../UI/Start")
	if is_started:
		start_btn.text = "STOP"
	else:
		start_btn.text = "START"


func _on_Start_button_up():
	is_started = !is_started
	update_text_Start_btn()
	pass # Replace with function body.
