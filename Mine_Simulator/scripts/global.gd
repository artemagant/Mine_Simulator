extends Node

var rocks = 0
var rocks_spawn_couldown = 2.5
var rocks_spawn_per_onec = 1
var start_amoun_rocks = 25
var max_rocks = 500
var rocks_connecting = false

var chances = {
	"rock": 0.50,
	"copper": 1.0,
}
var rock := 0
var rock_gain_base = 4
var copper := 0
var copper_gain_base = 2

var damage = 1
var luck_multiplayer = 1

var sell_button_show = false


#
# Система сохранения
#

const PATH_TO_SAVE_FILE = "user://savegame.save" # Путь к сохранению

func save(): # Функция сохранения игры
	var save_file = FileAccess. open(PATH_TO_SAVE_FILE, FileAccess.WRITE)
	if save_file == null:
		print_debug("Ошибка при загрузке файлов сохранения")
		return
	
	var game_data = { # Все переменные, которые я сохраняю
		"rocks_spawn_couldown" = rocks_spawn_couldown,
		"rocks_spawn_per_onec" = rocks_spawn_per_onec,
		"start_amoun_rocks" = start_amoun_rocks,
		"max_rocks" = max_rocks,
		"chances" = chances, 
		
		"rock" = rock, 
		"rock_gain_base" = rock_gain_base,
		"copper" = copper, 
		"copper_gain_base" = copper_gain_base,
		
		"luck_multiplayer" = luck_multiplayer,
		"damage" = damage, 
	}
	var json_string = JSON. stringify(game_data)
	save_file.store_line(json_string)
	save_file.close()

func load_game():
	if not FileAccess. file_exists(PATH_TO_SAVE_FILE):
		return false
	
	var save_file = FileAccess. open(PATH_TO_SAVE_FILE, FileAccess. READ)
	if save_file == null:
		print_debug("Ошибка при загрузке файлов сохранения")
		return
	
	var json_string = save_file.get_line()
	save_file.close()
	
	var json = JSON. new()
	var parse_result = json. parse(json_string)
	
	if parse_result != OK:
		print("Ошибка паркинга JSON файла")
		return false
	
	var data = json. data
	
	#
	# Получаем данные
	#
	rocks_spawn_couldown = data. get("rocks_spawn_couldown", 2.5)
	rocks_spawn_per_onec = data. get("rocks_spawn_per_onec", 1)
	start_amoun_rocks = data. get("start_amoun_rocks", 25)
	max_rocks = data. get("max_rocks", 500)
	chances = data. get("chances", {"rock": 0.5, "copper": 1.0})
	
	rock = data. get("rock", 0)
	rock_gain_base = data. get("rock_gain_base", 4)
	copper = data. get("copper", 0)
	copper_gain_base = data. get("copper_gain_base", 2)
	
	luck_multiplayer = data. get("luck_multiplayer", 1)
	damage = data. get("damage", 1)
