extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var buttonsound2 = get_node("currentcamera/buttonsound2")

onready var shellcount = get_node("currentcamera/shells/Label")
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	global.save_game()
	global.load_game()
	shellcount.text = str(global.shells)
	if global.sstate == 0:
		var start = Dialogic.start("start")
		add_child(start)
		$currentcamera/ambience.stream_paused = true
	else:
		$currentcamera/ambience.stream_paused = false
		pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(Dialogic.get_variable("ondialog")) == 1:
		$currentcamera/ambience.stream_paused = true
	if int(Dialogic.get_variable("ondialog")) == 0:
		$currentcamera/ambience.stream_paused = false
	pass


#Una vez clicas el boton de la tienda de armaduras se abre el menu de las armaduras para poder comprarlas
func _on_shopbutton_pressed():
	buttonsound2.play()
	Transition.change_scene("res://scenes/menus/CharacterCreator.tscn")
	pass # Replace with function body.

func _on_enterdungeon_pressed():
	buttonsound2.play()
	Transition.change_scene("res://scenes/menus/startslector.tscn")
	pass

func _on_reputationshp_pressed():
	if global.sstate == 2:
		global.sstate = 3
	buttonsound2.play()
	Transition.change_scene("res://scenes/menus/reputationshop.tscn")
	pass # Replace with function body.


func _on_talkguard_pressed():
	global.sstate = 2
	var start = Dialogic.start("guards")
	add_child(start)
	pass # Replace with function body.


func _on_talkshieldwarrior_pressed():
	global.sstate = 2
	var start = Dialogic.start("shield1")
	add_child(start)
	pass # Replace with function body.


func _on_talkppriest_pressed():
	global.sstate = 2
	var start = Dialogic.start("ppriest")
	add_child(start)
	pass # Replace with function body.
