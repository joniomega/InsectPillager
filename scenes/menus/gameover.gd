extends Node2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	if global.minute >=5:
		if global.level == 1:
			global.sstate = 4
			var start = Dialogic.start("win1")
			add_child(start)
		elif global.level == 2:
			global.sstate = 5
			var start = Dialogic.start("win2")
			add_child(start)
		elif global.level == 3:
			global.sstate = 6
			var start = Dialogic.start("win3")
			add_child(start)
	global.save_game()
	#RELLENAR ELS LABELS SCORE I SHELLS
	$Control/scoretitle/score.text = str(global.score)
	$Control/scoretitle2/shells.text = str(global.shells)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#sale del menu de game over
func _on_exit_pressed():
	$buttonsound.play()
	yield($buttonsound, "finished")
	global.reset_weapons_and_enemies()
	global.toggle_pause()
	get_tree().change_scene("res://scenes/mercado.tscn")
	#Transition.change_scene("res://scenes/mercado.tscn")
	pass # Replace with function body.


func _on_revive_pressed():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.curar_dano(100)
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.
