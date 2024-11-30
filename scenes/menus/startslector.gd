extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global
var currentlvl = 1
var lvl1locked
var lvl2locked
var lvl3locked
onready var lock = preload("res://assets/ui/icon_lock.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	$levels/lvl.text = tr("label_lvl")+" 1"
	$title.text = tr("ind_choose")
	$continue.text = tr("return_")
	global = get_node("/root/global")
	if global.sstate <=3:
		lvl1locked = false
		lvl2locked = true
		lvl3locked = true
	if global.sstate >= 4:
		lvl1locked = false
		lvl2locked = false
		lvl3locked = true
	if global.sstate >= 5:
		lvl1locked = false
		lvl2locked = false
		lvl3locked = false
	global.startweapon = "crossbow"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentlvl == 1:
		if lvl1locked:
			$levels/lvl.icon=lock
			$levels/lvl.add_color_override("font_color", Color(1, 1, 1))  # White color
		else:
			$levels/lvl.icon=null
			$levels/lvl.add_color_override("font_color", Color(1, 1, 0))  # Yellow
	elif currentlvl == 2:
		if lvl2locked:
			$levels/lvl.icon=lock
			$levels/lvl.add_color_override("font_color", Color(1, 1, 1))  # White color
		else:
			$levels/lvl.icon=null
			$levels/lvl.add_color_override("font_color", Color(1, 0.5, 0))  # Orange
	elif currentlvl == 3:
		if lvl3locked:
			$levels/lvl.icon=lock
			$levels/lvl.add_color_override("font_color", Color(1, 1, 1))  # White color
		else:
			$levels/lvl.icon=null
			$levels/lvl.add_color_override("font_color", Color(1, 0, 0))  # Red
	pass

#Al presionar el boton de la espada te pone esa arma
func _on_sword_button_pressed():
	$buttonsound.play()
	global.startweapon = "sword"
	$sword_button/arrrow.visible = true
	$dagger_button/arrrow.visible = false
	$crossbow_button/arrrow.visible = false
	pass # Replace with function body.

#Al presionar el boton de la daga te pone esa arma
func _on_dagger_button_pressed():
	$buttonsound.play()
	global.startweapon = "dagger"
	$sword_button/arrrow.visible = false
	$dagger_button/arrrow.visible = true
	$crossbow_button/arrrow.visible = false
	pass # Replace with function body.

#Al presionar el boton de la ballesta te pone esa arma
func _on_crossbow_button_pressed():
	$buttonsound.play()
	global.startweapon = "crossbow"
	$sword_button/arrrow.visible = false
	$dagger_button/arrrow.visible = false
	$crossbow_button/arrrow.visible = true
	pass # Replace with function body.

func _on_continue_pressed():
	$buttonsound.play()
	Transition.change_scene("res://scenes/mercado.tscn")
	pass # Replace with function body.

#LEVEL SELECTOR
func _on_lvl_pressed():
	if global.startweapon != null:
		$buttonsound.play()
		if currentlvl == 1:
			global.level = 1
			if global.sstate == 0:
				global.sstate = 1
			Transition.change_scene("res://scenes/level.tscn")
		if currentlvl == 2:
			if global.sstate >=4:
				global.level = 2
				Transition.change_scene("res://scenes/level2.tscn")
			else:
				pass
		if currentlvl == 3:
			if global.sstate >=5:
				global.level = 3
				Transition.change_scene("res://scenes/level3.tscn")
			else:
				pass
		if currentlvl == 4:
			if global.sstate >=6:
				global.level = 4
				Transition.change_scene("res://scenes/level4.tscn")
	pass # Replace with function body.


func _on_next_pressed():
	if currentlvl == 4:
		currentlvl = 1
		$levels/lvl.text = tr("label_lvl")+" 1"
	elif currentlvl == 3:
		currentlvl = 4
		$levels/lvl.text = tr("label_lvl")+" 4"
	elif currentlvl == 2:
		currentlvl = 3
		$levels/lvl.text = tr("label_lvl")+" 3"
	elif currentlvl == 1:
		currentlvl = 2
		$levels/lvl.text = tr("label_lvl")+" 2"
	$levels/levelicon.play(str(currentlvl))
	pass # Replace with function body.


func _on_prev_pressed():
	if currentlvl == 4:
		currentlvl = 3
		$levels/lvl.text = tr("label_lvl")+" 3"
	elif currentlvl == 3:
		currentlvl = 2
		$levels/lvl.text = tr("label_lvl")+" 2"
	elif currentlvl == 2:
		$levels/lvl.text = tr("label_lvl")+" 1"
		currentlvl = 1
	elif currentlvl == 1:
		$levels/lvl.text = tr("label_lvl")+" 4"
		currentlvl = 4
	$levels/levelicon.play(str(currentlvl))
	pass # Replace with function body.


func _on_enter_pressed():
	$levels/lvl.emit_signal("pressed")
	pass # Replace with function body.
