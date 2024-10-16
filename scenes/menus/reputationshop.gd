extends Node2D

var global
onready var rank_nodes = [
	{"rank": get_node("scroll/progress/rank1"), "content": get_node("scroll/progress/rank1/content"), "unlockad": "unlockad1", "unlock_cost": 200},
	{"rank": get_node("scroll/progress/rank2"), "content": get_node("scroll/progress/rank2/content"), "unlockad": "unlockad2", "unlock_cost": 300},
	{"rank": get_node("scroll/progress/rank3"), "content": get_node("scroll/progress/rank3/content"), "unlockad": "unlockad3", "unlock_cost": 350},
	{"rank": get_node("scroll/progress/rank4"), "content": get_node("scroll/progress/rank4/content"), "unlockad": "unlockad4", "unlock_cost": 400},
	{"rank": get_node("scroll/progress/rank5"), "content": get_node("scroll/progress/rank5/content"), "unlockad": "unlockad5", "unlock_cost": 450},
	{"rank": get_node("scroll/progress/rank6"), "content": get_node("scroll/progress/rank6/content"), "unlockad": "unlockad6", "unlock_cost": 500}
]
onready var progressbar = get_node("scroll/progress")
onready var shellicon = preload("res://assets/ui/shell_icon.png")

func _ready():
	global = get_node("/root/global")
	$shells/shells.text = str(global.shells)
	_update_ranks()

func _update_ranks():
	var progress_values = [3, 25, 48, 63, 83, 100, 123]  # Progress values based on rank
	progressbar.value = progress_values[global.rank]
	
	for i in range(rank_nodes.size()):
		var rank_node = rank_nodes[i]
		var rank_button = rank_node["rank"]
		var content = rank_node["content"]
		var unlockad = content.get_node(rank_node["unlockad"])
		
		if global.rank > i:  # Already unlocked, disable button and enable content
			rank_button.text = ""
			rank_button.icon = null
			rank_button.disabled = true
			unlockad.disabled = false
			_set_modulation(content, Color(1, 1, 1, 1))
		elif global.rank == i:  # Current rank, enable only the current rank button
			rank_button.disabled = false
			unlockad.disabled = true
			_set_modulation(content, Color(1, 1, 1, 0.5))
		else:  # Future ranks, disable everything
			rank_button.disabled = true
			unlockad.disabled = true
			_set_modulation(content, Color(1, 1, 1, 0.5))

		# Update the text and icon for the next rank to be unlocked
		if (global.rank-1) == i and i < rank_nodes.size() - 1:
			var next_rank_node = rank_nodes[i + 1]
			var next_rank_button = next_rank_node["rank"]
			next_rank_button.text = str(next_rank_node["unlock_cost"]) + " TO UNLOCK"
			next_rank_button.icon = shellicon

	if global.rank < rank_nodes.size():
		rank_nodes[global.rank]["rank"].disabled = false  # Enable only the current rank button

func _set_modulation(content, color):
	for child in content.get_children():
		if child is CanvasItem:
			child.modulate = color

func _on_continue_pressed():
	$buttonsound.play()
	Transition.change_scene("res://scenes/mercado.tscn")

func _on_rank_pressed(rank_idx):
	var rank_node = rank_nodes[rank_idx]
	
	if global.rank == rank_idx and global.shells >= rank_node["unlock_cost"]:
		global.rank += 1
		global.shells -= rank_node["unlock_cost"]
		_update_ranks()
		$shells/shells.text = str(global.shells)

	if global.rank == rank_idx + 1:  # Enable content for the just-unlocked rank
		var content = rank_node["content"]
		var unlockad = content.get_node(rank_node["unlockad"])
		unlockad.disabled = false
		_set_modulation(content, Color(1, 1, 1, 1))

func _on_rank1_pressed():
	_on_rank_pressed(0)
	$buttonsound.play()
	global.save_game()
func _on_rank2_pressed():
	_on_rank_pressed(1)
	$buttonsound.play()
	global.save_game()
func _on_rank3_pressed():
	_on_rank_pressed(2)
	$buttonsound.play()
	global.save_game()
func _on_rank4_pressed():
	_on_rank_pressed(3)
	$buttonsound.play()
	global.save_game()
func _on_rank5_pressed():
	_on_rank_pressed(4)
	$buttonsound.play()
	global.save_game()
func _on_rank6_pressed():
	_on_rank_pressed(5)
	$buttonsound.play()
	global.save_game()

#REWARDED ADS
func _on_unlockad1_pressed():
	global.skinhead4 = true
	global.save_game()
	pass # Replace with function body.

func _on_unlockad2_pressed():
	global.skinbody4 = true
	global.save_game()
	pass # Replace with function body.

func _on_unlockad3_pressed():
	global.skinhead5 = true
	global.save_game()
	pass # Replace with function body.

func _on_unlockad4_pressed():
	global.skinbody5 = true
	global.save_game()
	pass # Replace with function body.

func _on_unlockad5_pressed():
	global.skinlegs4 = true
	global.save_game()
	pass # Replace with function body.

func _on_unlockad6_pressed():
	global.skinbody6 = true
	global.save_game()
	pass # Replace with function body.
