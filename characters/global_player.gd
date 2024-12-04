extends Node

var is_paused = false
var actualhp
var buttonon = false

# SKIN PLAYER
var cheadstr = "1"
var cbodystr = "1"
var clegsstr = "1"
var skinhead4 = false
var skinbody4 = false
var skinhead5 = false
var skinbody5 = false
var skinlegs4 = false
var skinbody6 = false

# STORY STATE
var sstate = 0

# CURRENCY
var shells = 0
var rank = 0

# DURING EACH RUN DURING EACH RUN DURING EACH RUN
var level = 0
var minute = 0
	#PLAYER PLUS STATS
var plusresistance = 0
var plussoulpower = 0
var plussharpness = 0
var plusspeed = 0

var bigenemy = false
var score = 0
var startweapon = null
var lvlsword = 0
var lvlswordbool = false
var lvldagger = 0
var lvlcrossbow = 0
var lvlbubble = 0
var lvlbubblebool = false
var lvlscythe = 0
var lvlscythebool = false
var lvlcristal = 0
var lvlcristalbool = false
var lvlaxerang = 0
var lvlaxerangbool = false
var enemylvl = 1
var enemimax = 80
var enemitotal = 0
var enemibigtotal = 0
var exporbmax = 80
var exporbtotal = 0

# File path for saving
var save_file_path = "user://savegame.dat"

func _ready():
	load_game()
	# Get the system locale language (e.g., "es", "en")
	

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = not get_tree().paused

# Method to get the list of all skin-related variables
func get_skin_variables():
	return {
		"skinhead4": skinhead4,
		"skinhead5": skinhead5,
		"skinbody4": skinbody4,
		"skinbody5": skinbody5,
		"skinbody6": skinbody6,
		"skinlegs4": skinlegs4
	}

# Method to set the skin-related variables from a dictionary
func set_skin_variables(skin_data):
	if skin_data.has("skinhead4"):
		skinhead4 = skin_data["skinhead4"]
	if skin_data.has("skinhead5"):
		skinhead5 = skin_data["skinhead5"]
	if skin_data.has("skinbody4"):
		skinbody4 = skin_data["skinbody4"]
	if skin_data.has("skinbody5"):
		skinbody5 = skin_data["skinbody5"]
	if skin_data.has("skinbody6"):
		skinbody6 = skin_data["skinbody6"]
	if skin_data.has("skinlegs4"):
		skinlegs4 = skin_data["skinlegs4"]

# SAVE PROGRESS FUNCTION
func save_game():
	var save_data = {
		"sstate": sstate,
		"shells": shells,
		"rank": rank,
		"cheadstr": cheadstr,
		"cbodystr": cbodystr,
		"clegsstr": clegsstr,
		"skin_variables": get_skin_variables()
	}
	var file = File.new()
	if file.open(save_file_path, File.WRITE) == OK:
		file.store_var(save_data)
		file.close()

# LOAD SAVE FUNCTION
func load_game():
	var file = File.new()
	if file.file_exists(save_file_path):
		if file.open(save_file_path, File.READ) == OK:
			var save_data = file.get_var()
			file.close()
			sstate = save_data.get("sstate", 0)
			shells = save_data.get("shells", 0) 
			rank = save_data.get("rank", 0)       
			cheadstr = save_data.get("cheadstr", "1")
			cbodystr = save_data.get("cbodystr", "1")
			clegsstr = save_data.get("clegsstr", "1")
			set_skin_variables(save_data.get("skin_variables", {}))
func reset_weapons_and_enemies():
	# Reset plus stats
	plusresistance = 0
	plussoulpower = 0
	plussharpness = 0
	plusspeed = 0
	# Reset weapon levels to 0
	lvlsword = 0
	lvldagger = 0
	lvlcrossbow = 0
	lvlbubble = 0
	lvlscythe = 0
	lvlcristal = 0
	lvlaxerang = 0
	# Reset boolean flags to false
	lvlswordbool = false
	lvlbubblebool = false
	lvlscythebool = false
	lvlcristalbool = false
	lvlaxerangbool = false
	# Reset enemy level to 1 (default)
	enemylvl = 1
	enemitotal = 0
	exporbtotal = 0
	# Optionally reset other game-specific variables if necessary
	level = 0
	minute = 0
