extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global
var option1 = "test"
var option2 = "test"
var option3 = "test"
var items = ["sword", "dagger", "crossbow", "bubble", "scythe", "cristal", "axerang"]

var sword_scene = preload("res://characters/player/items/item_sword.tscn")
var dagger_scene = preload("res://characters/player/items/item_dagger.tscn")
var crossbow_scene = preload("res://characters/player/items/item_crossbow.tscn")
var heal_scene = preload("res://characters/player/items/item_heal.tscn")
var bubble_scene = preload("res://characters/player/items/item_bubble.tscn")
var scythe_scene = preload("res://characters/player/items/item_scythe.tscn")
var cristal_scene = preload("res://characters/player/items/item_cristal.tscn")
var axerang_scene = preload("res://characters/player/items/item_axerang.tscn")

func _ready():
	$Label.text = tr("chossewp")
	global = get_node("/root/global")
	if global:
		global.toggle_pause()  # Pausing the game
		$animation.play("start")
	else:
		$option1.text = "Player not found" # Mensaje de error si player no se encuentra
	# This ensures that the random number generator is initialized differently each time the game starts
	randomize()
	choose_random_item()
	

func choose_random_item():
	# Get a random index for the items array
	var random_index1 = randi() % items.size()
	var random_index2 = randi() % items.size()
	var random_index3 = randi() % items.size()
	while random_index1 == random_index2 or random_index1 == random_index3 or random_index3 == random_index2:
		random_index2 = randi() % items.size()
		random_index3 = randi() % items.size()
		pass
	# Choose the item based on the random index
	option1 = items[random_index1]
	option2 = items[random_index2]
	option3 = items[random_index3]
	# Assuming the 'icon' has animations with the same names as the items
	# Set the animation of the icon to the chosen item
	$option1/icon.play(option1)
	$option1.text = option1
	$option2/icon.play(option2)
	$option2.text = option2
	$option3/icon.play(option3)
	$option3.text = option3
	update_option_text(option1, $option1, $option1/icon)
	update_option_text(option2, $option2, $option2/icon)
	update_option_text(option3, $option3, $option3/icon)
	
# Function to update the text for a given option
func update_option_text(option, label, iconcolor):
	if option == "sword" and global.lvlsword >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)
	elif option == "bubble" and global.lvlbubble >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)
	elif option == "dagger" and global.lvldagger >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)
	elif option == "crossbow" and global.lvlcrossbow >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)
	elif option == "scythe" and global.lvlscythe >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)
	elif option == "cristal" and global.lvlcristal >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)
	elif option == "axerang" and global.lvlaxerang >= 1:
		label.text = "+damage"
		label.add_color_override("font_color", Color(10, 10, 0.5))
		iconcolor.modulate = Color(1.3, 1.3, 0.5, 1)

func _on_option1_pressed():
	$option1.disabled = true
	$buttonsound.play()
	yield($buttonsound, "finished")
	if option1 == "sword":
		if global.lvlsword == 0:
			var sword = sword_scene.instance()
			get_parent().add_child(sword)
			global.lvlsword = global.lvlsword +1
		else:
			$option1.text = option1 +"+damage"
			global.lvlswordbool = true
			global.lvlsword = global.lvlsword +1
		pass
	if option1 == "axerang":
		if global.lvlaxerang == 0:
			var axerang = axerang_scene.instance()
			get_parent().add_child(axerang)
			global.lvlaxerang = global.lvlaxerang +1
		else:
			$option1.text = option1 +"+damage"
			global.lvlaxerangbool = true
			global.lvlaxerang = global.lvlaxerang +1
		pass
	if option1 == "bubble":
		if global.lvlbubble == 0:
			var bubble = bubble_scene.instance()
			get_parent().add_child(bubble)
			global.lvlbubble = global.lvlbubble +1
		else:
			$option1.text = option1 +"+damage"
			global.lvlbubblebool = true
			global.lvlbubble = global.lvlbubble +1
		pass
	if option1 == "scythe":
		if global.lvlscythe == 0:
			var scythe = scythe_scene.instance()
			get_parent().add_child(scythe)
			global.lvlscythe = global.lvlscythe +1
		else:
			$option1.text = option1+"+damage"
			global.lvlscythebool = true
			global.lvlscythe = global.lvlscythe +1
	if option1 == "cristal":
		if global.lvlcristal == 0:
			var cristal = cristal_scene.instance()
			get_parent().add_child(cristal)
			global.lvlcristal = global.lvlcristal +1
		else:
			$option1.text = option1+"+damage"
			global.lvlcristalbool = true
			global.lvlcristal = global.lvlcristal +1
	if option1 == "dagger":
		if global.lvldagger == 0:
			var dagger = dagger_scene.instance()
			get_parent().add_child(dagger)
			global.lvldagger = global.lvldagger +1
		else:
			global.lvldagger = global.lvldagger +1
			$option1.text = option1+"+damage"
		pass
	if option1 == "crossbow":
		if global.lvlcrossbow == 0:
			var crossbow = crossbow_scene.instance()
			get_parent().add_child(crossbow)
			global.lvlcrossbow = global.lvlcrossbow +1
		else:
			global.lvlcrossbow = global.lvlcrossbow +1
			$option1.text = option1+"+damage"
		pass
	if option1 == "potion":
		var potion = heal_scene.instance()
		get_parent().add_child(potion)
		pass
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.


func _on_option2_pressed():
	$option2.disabled = true
	$buttonsound.play()
	yield($buttonsound, "finished")
	if option2 == "sword":
		if global.lvlsword == 0:
			var sword = sword_scene.instance()
			get_parent().add_child(sword)
			global.lvlsword = global.lvlsword +1
		else:
			global.lvlswordbool = true
			global.lvlsword = global.lvlsword +1
			$option2.text = option2+"+damage"
		pass
	if option2 == "axerang":
		if global.lvlaxerang == 0:
			var axerang = axerang_scene.instance()
			get_parent().add_child(axerang)
			global.lvlaxerang = global.lvlaxerang +1
		else:
			$option2.text = option1 +"+damage"
			global.lvlaxerangbool = true
			global.lvlaxerang = global.lvlaxerang +1
		pass
	if option2 == "bubble":
		if global.lvlbubble == 0:
			var bubble = bubble_scene.instance()
			get_parent().add_child(bubble)
			global.lvlbubble = global.lvlbubble +1
		else:
			$option2.text = option2 +"+damage"
			global.lvlbubblebool = true
			global.lvlbubble = global.lvlbubble +1
		pass
	if option2 == "scythe":
		if global.lvlscythe == 0:
			var scythe = scythe_scene.instance()
			get_parent().add_child(scythe)
			global.lvlscythe = global.lvlscythe +1
		else:
			$option2.text = option1+"+damage"
			global.lvlscythebool = true
			global.lvlscythe = global.lvlscythe +1
	if option2 == "cristal":
		if global.lvlcristal == 0:
			var cristal = cristal_scene.instance()
			get_parent().add_child(cristal)
			global.lvlcristal = global.lvlcristal +1
		else:
			$option2.text = option2+"+damage"
			global.lvlcristalbool = true
			global.lvlcristal = global.lvlcristal +1
	if option2 == "dagger":
		if global.lvldagger == 0:
			var dagger = dagger_scene.instance()
			get_parent().add_child(dagger)
			global.lvldagger = global.lvldagger +1
		else:
			global.lvldagger = global.lvldagger +1
			$option2.text = option2+"+damage"
		pass
	if option2 == "crossbow":
		if global.lvlcrossbow == 0:
			var crossbow = crossbow_scene.instance()
			get_parent().add_child(crossbow)
			global.lvlcrossbow = global.lvlcrossbow +1
		else:
			global.lvlcrossbow = global.lvlcrossbow +1
			$option2.text = option2+"+damage"
		pass
	if option2 == "potion":
		var potion = heal_scene.instance()
		get_parent().add_child(potion)
		pass
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.


func _on_option3_pressed():
	$option3.disabled = true
	$buttonsound.play()
	yield($buttonsound, "finished")
	if option3 == "sword":
		if global.lvlsword == 0:
			var sword = sword_scene.instance()
			get_parent().add_child(sword)
			global.lvlsword = global.lvlsword +1
		else:
			global.lvlswordbool = true
			global.lvlsword = global.lvlsword +1
			$option3.text = option3+" + damage"
		pass
	if option3 == "axerang":
		if global.lvlaxerang == 0:
			var axerang = axerang_scene.instance()
			get_parent().add_child(axerang)
			global.lvlaxerang = global.lvlaxerang +1
		else:
			$option3.text = option1 +"+damage"
			global.lvlaxerangbool = true
			global.lvlaxerang = global.lvlaxerang +1
		pass
	if option3 == "bubble":
		if global.lvlbubble == 0:
			var bubble = bubble_scene.instance()
			get_parent().add_child(bubble)
			global.lvlbubble = global.lvlbubble +1
		else:
			$option3.text = option3 +"+damage"
			global.lvlbubblebool = true
			global.lvlbubble = global.lvlbubble +1
		pass
	if option3 == "scythe":
		if global.lvlscythe == 0:
			var scythe = scythe_scene.instance()
			get_parent().add_child(scythe)
			global.lvlscythe = global.lvlscythe +1
		else:
			$option3.text = option1+"+damage"
			global.lvlscythebool = true
			global.lvlscythe = global.lvlscythe +1
	if option3 == "cristal":
		if global.lvlcristal == 0:
			var cristal = cristal_scene.instance()
			get_parent().add_child(cristal)
			global.lvlcristal = global.lvlcristal +1
		else:
			$option3.text = option3+"+damage"
			global.lvlcristalbool = true
			global.lvlcristal = global.lvlcristal +1
	if option3 == "dagger":
		if global.lvldagger == 0:
			var dagger = dagger_scene.instance()
			get_parent().add_child(dagger)
			global.lvldagger = global.lvldagger +1
		else:
			global.lvldagger = global.lvldagger +1
			$option3.text = option3+" + damage"
		pass
	if option3 == "crossbow":
		if global.lvlcrossbow == 0:
			var crossbow = crossbow_scene.instance()
			get_parent().add_child(crossbow)
			global.lvlcrossbow = global.lvlcrossbow +1
		else:
			global.lvlcrossbow = global.lvlcrossbow +1
			$option3.text = option3+" + damage"
		pass
	if option3 == "potion":
		var potion = heal_scene.instance()
		get_parent().add_child(potion)
		pass
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.




func _on_press1_pressed():
	$option1.emit_signal("pressed")
	disableall()
	pass # Replace with function body.


func _on_press2_pressed():
	$option2.emit_signal("pressed")
	disableall()
	pass # Replace with function body.


func _on_press3_pressed():
	$option3.emit_signal("pressed")
	disableall()
	pass # Replace with function body.

func disableall():
	$option1.disabled = true
	$option2.disabled = true
	$option3.disabled = true
	$option1/press1.disabled = true
	$option2/press2.disabled = true
	$option3/press3.disabled = true
	pass
