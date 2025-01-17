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
	if global.sstate == 0:
		$back/Puppetpriest/IconTalk.visible = false
		$back/shieldwarrior/IconTalk.visible = false
		$back/Guard2/IconTalk.visible = false
	pass

func _process(delta):
	if int(Dialogic.get_variable("ondialog")) == 1:
		$currentcamera/ambience.stream_paused = true
	if int(Dialogic.get_variable("ondialog")) == 0:
		$currentcamera/ambience.stream_paused = false
	pass


func _on_shopbutton_pressed():
	buttonsound2.play()
	Transition.change_scene("res://scenes/menus/CharacterCreator.tscn")
	pass

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


func _on_backtomenu_pressed():
	Transition.change_scene("res://scenes/mainmenu.tscn")
	pass # Replace with function body.


func _on_showplusmenu_pressed():
	OS.shell_open("https://www.youtube.com/@joniomega4")
	pass # Replace with function body.
