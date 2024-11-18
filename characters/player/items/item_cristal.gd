extends Node2D

onready var timer = $Timer
onready var area_detect = $area_detect
onready var cristal = preload("res://characters/cristal.tscn")

var enemies_in_area = []  # List to keep track of enemies inside the area
var damage_amount = 10    # The amount of damage to apply to enemies

func _ready():
	timer.start()
func _process(delta):
	if global.lvlcristalbool == true:
		damage_amount = damage_amount + 5 + global.plussoulpower
		global.lvlcristalbool = false
		pass

func _on_area_detect_body_entered(body):
	if body.is_in_group("enemy"):  # Assuming enemies are in the 'enemies' group
		enemies_in_area.append(body)

func _on_area_detect_body_exited(body):
	if body in enemies_in_area:
		enemies_in_area.erase(body)

func _on_Timer_timeout():
	if enemies_in_area.size() > 0:
		# Teleport to a random enemy
		var random_enemy = enemies_in_area[randi() % enemies_in_area.size()]
		var new_bullet = cristal.instance()
		new_bullet.damageincrease(damage_amount)
		new_bullet.position = random_enemy.global_position
		get_parent().get_parent().get_parent().add_child(new_bullet)
	# Restart the timer
	timer.start()
