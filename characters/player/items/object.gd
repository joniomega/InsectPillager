extends Node2D

# Reference the Sprite and Tween nodes
var global
var playerr
onready var icon = $canvas/object/icon
onready var label_title = $canvas/object/title
onready var label_description = $canvas/object/title/desc
onready var statlabel = $canvas/object/statchange
onready var staticon = $canvas/object/statchange/iconstat
onready var bt = $canvas/buttons/buttontake
onready var br = $canvas/buttons/buttonrecy
onready var animation = $canvas/animation

# Define object type and objects list
export var object_type: String = "a"
var objecttt = "magnetcollar"
var objects = ["greenshell ring", "double plate ring", "book of horrors", "bluecristal collar", "ancient bug knife", "beak totem", "verdant shield"]
var objfinal

# Define the stat effects, colors, and descriptions for each object
var object_stats = {
	"greenshell ring": {"stat": "resistance", "value": 4, "description_key": "desc_greenshell_ring"},
	"double plate ring": {"stat": "sharpness", "value": 4, "description_key": "desc_double_plate_ring"},
	"book of horrors": {"stat": "soulpower", "value": 4, "description_key": "desc_book_of_horrors"},
	"bluecristal collar": {"stat": "speed", "value": 7, "description_key": "desc_bluecristal_collar"},
	"ancient bug knife": {"stat": "sharpness", "value": 6, "description_key": "desc_ancient_bug_knife"},
	"beak totem": {"stat": "speed", "value": 10, "description_key": "desc_beak_totem"},
	"verdant shield": {"stat": "resistance", "value": 6, "description_key": "desc_verdant_shield"}
}

# Define colors for each stat type
var stat_colors = {
	"resistance": Color(0, 0.7, 0),  # Green
	"sharpness": Color(0.8, 0.1, 0),  # Orange
	"soulpower": Color(0.5, 0, 0.5),  # Purple
	"speed": Color(0, 0.3, 0.8)  # Light Blue
}

func _ready():
	$canvas.visible = false
	bt.disabled = true
	br.disabled = true
	global = get_node("/root/global")
	# Start the scale animation
	$star/animation.play("default")
	# Generate an Item if it not set
	if object_type == "a":
		randomize()
		generateobj()
	else:
		pass

func generateobj():
	# Select a random object
	var random_index2 = randi() % objects.size()
	objfinal = objects[random_index2]
	
	# Update UI elements with the object name and icon
	icon.play(objfinal)
	label_title.text = objfinal
	label_title.text = tr("obj"+str(objfinal))
	# Apply the stat change and color based on the selected object
	var selected_stat = object_stats[objfinal]
	if selected_stat:
		statlabel.text = "+" + str(selected_stat["value"]) + " " + tr(selected_stat["stat"])
		staticon.play(selected_stat["stat"])  # Assumes you have icons for each stat
		statlabel.add_color_override("font_color", stat_colors[selected_stat["stat"]])  # Set font color
		label_description.text = tr(selected_stat["description_key"])  # Usa la clave para traducir la descripción
	

func _on_Area2D_body_entered(body):
	
	if body.is_in_group("player"):
		playerr = body
		$canvas.visible = true
		animation.play("opening")
		$canvas/audio.play()
		global.toggle_pause()
		bt.disabled = false
		br.disabled = false
	pass

func _on_Button_pressed():
	$canvas/buttons/buttontake.disabled = true
	# Update the player's stats based on the selected object
	var selected_stat = object_stats.get(objfinal)
	if selected_stat:
		match selected_stat["stat"]:
			"resistance":
				global.plusresistance += selected_stat["value"]
			"sharpness":
				global.plussharpness += selected_stat["value"]
			"soulpower":
				global.plussoulpower += selected_stat["value"]
			"speed":
				global.plusspeed += selected_stat["value"]
	$canvas.visible = false
	global.toggle_pause()
	playerr.reloadstats(selected_stat["stat"])
	queue_free()
	pass

