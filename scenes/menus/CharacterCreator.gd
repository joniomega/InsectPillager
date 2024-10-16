extends Node2D

var teanglish = "Customize your character"
var global
onready var buttonsound = get_node("buttonsound")
onready var buttonsound2 = get_node("buttonsound2")
onready var legs = get_node("character/legs")
onready var body = get_node("character/body")
onready var head = get_node("character/head")

# LOCKED PARTS
var skinhead4 = false
var skinhead5 = false
var skinbody4 = false
var skinbody5 = false
var skinbody6 = false
var skinlegs4 = false

# PARTS
var chead = 1
var cbody = 1
var clegs = 1

# CURRENT PARTS TO STRING
var cheadstr
var cbodystr
var clegsstr 

# MAX DEFAULT
var maxhead = 3
var maxbody = 3
var maxlegs = 3

# UNLOCKED SKINS LIST
var unlocked_heads = []
var unlocked_bodies = []
var unlocked_legs = []

func _ready():
	$control/title.text = teanglish
	global = get_node("/root/global")

	# Load global state for skins
	skinhead4 = global.skinhead4
	skinhead5 = global.skinhead5
	skinbody4 = global.skinbody4
	skinbody5 = global.skinbody5
	skinbody6 = global.skinbody6
	skinlegs4 = global.skinlegs4

	# Initialize unlocked parts lists based on the state
	unlocked_heads = _get_unlocked_heads()
	unlocked_bodies = _get_unlocked_bodies()
	unlocked_legs = _get_unlocked_legs()

	# Set the initial parts
	cheadstr = global.cheadstr
	cbodystr = global.cbodystr
	clegsstr = global.clegsstr

	legs.play(clegsstr+"_down")
	body.play(cbodystr+"_down")
	head.play(cheadstr+"_down")
	legs.stop()
	body.stop()
	head.stop()

func _get_unlocked_heads():
	var heads = [1, 2, 3]  # Always available
	if skinhead4:
		heads.append(4)
	if skinhead5:
		heads.append(5)
	return heads

func _get_unlocked_bodies():
	var bodies = [1, 2, 3]  # Always available
	if skinbody4:
		bodies.append(4)
	if skinbody5:
		bodies.append(5)
	if skinbody6:
		bodies.append(6)
	return bodies
func _get_unlocked_legs():
	var legs = [1, 2, 3]
	if skinlegs4:
		legs.append(4)
	return legs

func _on_head_next_pressed():
	buttonsound2.play()
	chead = _get_next_part(chead, unlocked_heads)
	cheadstr = str(chead)
	_update_character_animation()

func _on_head_prev_pressed():
	buttonsound2.play()
	chead = _get_prev_part(chead, unlocked_heads)
	cheadstr = str(chead)
	_update_character_animation()

func _on_body_next_pressed():
	buttonsound2.play()
	cbody = _get_next_part(cbody, unlocked_bodies)
	cbodystr = str(cbody)
	_update_character_animation()

func _on_body_prev_pressed():
	buttonsound2.play()
	cbody = _get_prev_part(cbody, unlocked_bodies)
	cbodystr = str(cbody)
	_update_character_animation()

func _on_legs_next_pressed():
	buttonsound2.play()
	clegs = _get_next_part(clegs, unlocked_legs)
	clegsstr = str(clegs)
	_update_character_animation()

func _on_legs_prev_pressed():
	buttonsound2.play()
	clegs = _get_prev_part(clegs, unlocked_legs)
	clegsstr = str(clegs)
	_update_character_animation()

func _get_next_part(current, parts):
	var index = parts.find(current)
	index = (index + 1) % parts.size()
	return parts[index]

func _get_prev_part(current, parts):
	var index = parts.find(current)
	index = (index - 1 + parts.size()) % parts.size()
	return parts[index]

func _on_continue_pressed():
	buttonsound.play()
	global.cheadstr = cheadstr
	global.cbodystr = cbodystr
	global.clegsstr = clegsstr
	Transition.change_scene("res://scenes/mercado.tscn")

func _update_character_animation():
	head.play(cheadstr+"_down")
	body.play(cbodystr+"_down")
	legs.play(clegsstr+"_down")
	head.stop()
	body.stop()
	legs.stop()

