extends KinematicBody2D
#VARIABLE PARA SCRIPT GLOBAL
var global
# Variables para el movimiento
var speed = 70
var velocity = Vector2()

# Variables para la vida del jugador
var score_actual = 0
var vida = 100
var experience = 0
var maxexp = 10
var potions = 0
var levelupchosse_scene = preload("res://characters/player/levelupchosse.tscn")
var inmune = false
# ProgressBar de la UI para mostrar la vida
var vida_progressbar
var exp_progressbar
var animated_sprite

var seconds = 0
var minutes = 0
# Variables for the slash animation
var is_slashing = false
var slash_direction = 1  # 1 for right, -1 for left
var sword_damage = 10

# Variables for the Timer
var slash_timer
#ITEMS!!!
var item_sword = preload("res://characters/player/items/item_sword.tscn")

# Áreas 2D para las colisiones con la espada
var left_area
var right_area
var sword_scene = preload("res://characters/player/items/item_sword.tscn")
var dagger_scene = preload("res://characters/player/items/item_dagger.tscn")
var crossbow_scene = preload("res://characters/player/items/item_crossbow.tscn")
var potion_scene = preload("res://characters/player/items/item_heal.tscn")
var gameover_scene = preload("res://scenes/menus/gameover.tscn")

var cheadstr
var cbodystr
var clegsstr
onready var legs = get_node("character/legs")
onready var body = get_node("character/body")
onready var head = get_node("character/head")
onready var head_icon = get_node("UI/Control/IconPlayer/head") 

onready var pnum = get_node("UI/Control/potionuse/pnum")

onready var joystick = $UI/Control/VirtualJoystick

func _ready():
	self.z_index = 10
	global = get_node("/root/global")
	if global.rank >= 5:
		potions = 5
		if global.rank == 5:
			$UI/Control/potionuse/AnimatedSprite.play("rank5")
			
			pass
		if global.rank == 6:
			$UI/Control/potionuse/AnimatedSprite.play("rank6")
			pass
	else:
		potions = global.rank + 1
	cheadstr = global.cheadstr
	cbodystr = global.cbodystr
	clegsstr = global.clegsstr
	head_icon.play(cheadstr+"_down")
	# Obtener el ProgressBar de la UI
	vida_progressbar = $ProgressBar
	exp_progressbar = $UI/experience
	# Inicializar el ProgressBar con la vida inicial del jugador
	vida_progressbar.value = vida
	exp_progressbar.value = experience
	#SETUP STARTING WEAPON
	if global.startweapon == "sword":
		if global.lvlsword == 0:
			var sword = sword_scene.instance()
			$items.add_child(sword)
			global.lvlsword = global.lvlsword + 1
	if global.startweapon == "dagger":
		if global.lvldagger == 0:
			var dagger = dagger_scene.instance()
			$items.add_child(dagger)
			global.lvldagger = global.lvldagger + 1
	if global.startweapon == "crossbow":
		if global.lvlcrossbow == 0:
			var crossbow = crossbow_scene.instance()
			$items.add_child(crossbow)
			global.lvlcrossbow = global.lvlcrossbow + 1
	$UI/Timer.start()
	legs.play(clegsstr+"_down")
	body.play(cbodystr+"_down")
	head.play(cheadstr+"_down")
	
	pnum.text = str(potions)
#	global.toggle_pause()
#	animated_sprite.play(actualskin+"revive")
#	yield(animated_sprite,"animation_finished")
#	global.toggle_pause()


func _physics_process(delta):
	velocity = Vector2()

	# Use the VirtualJoystick input
	var joystick_input = joystick.get_value()  # get the direction from the plugin joystick

	if joystick_input != Vector2():  # Check if the joystick is being used
		velocity = joystick_input * speed
	else:
		# Fallback to keyboard controls when the joystick is not in use
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1

	# Normalize and move the player
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)

	# Update the player animations based on movement
	update_animation()

func update_animation():
	if velocity.length_squared() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				legs.play(clegsstr + "_right")
				body.play(cbodystr + "_right")
				head.play(cheadstr + "_right")
			else:
				legs.play(clegsstr + "_left")
				body.play(cbodystr + "_left")
				head.play(cheadstr + "_left")
		else:
			if velocity.y > 0:
				legs.play(clegsstr + "_down")
				body.play(cbodystr + "_down")
				head.play(cheadstr + "_down")
			else:
				legs.play(clegsstr + "_up")
				body.play(cbodystr + "_up")
				head.play(cheadstr + "_up")
	else:
		legs.stop()
		body.stop()
		head.stop()

# Método para recibir daño
func recibir_danio(damage):
	if inmune == false:
		$hurt.play()
		$blood.restart()
		$blood.emitting = true
		vida -= damage
		# Actualizar el valor del ProgressBar de la UI con la vida actual del jugador
		vida_progressbar.value = vida
		inmune = true
		# Modulate the AnimatedSprite to grey semi-transparent color
		head.modulate = Color(2, 2, 2, 1)
		body.modulate = Color(2, 2, 2, 1)
		legs.modulate = Color(2, 2, 2, 1)
		$Inmunity.start()
		if vida <= 0:
			global.toggle_pause()
			inmune = true
			# Modulate the AnimatedSprite to grey semi-transparent color
			head.modulate = Color(2, 2, 2, 1)
			body.modulate = Color(2, 2, 2, 1)
			legs.modulate = Color(2, 2, 2, 1)
			$blood.restart()
			$blood.emitting = true
			$Inmunity.start()
			$losesound.play()
			yield($losesound, "finished")
			$UI.visible = false
			$UI/Control.visible = false
			global.score = score_actual
			var gameover = gameover_scene.instance()
			$items.add_child(gameover)
			# Aquí puedes añadir lógica para el manejo de la muerte del jugador
			pass
#METODO PARA LA POCION DE CURA
func curar_dano(cura):
	if global.rank == 5:
		cura = cura + 10
		pass
	if global.rank == 6:
		cura = cura + 20
		pass
	if vida <= 100:
		if (cura+vida) >=100:
			vida = 100
		else:
			vida += cura
		vida_progressbar.value = vida
	$UI.visible = true
	$UI/Control.visible = true
	pass
#METODO POCION DE SPEED
func more_speed(plusspeed):
	speed += plusspeed
	pass

# Método llamado cuando el Timer termina

func add_exp(amount):
	global.shells = global.shells + amount
	score_actual = score_actual + 100
	experience = experience + amount
	exp_progressbar.value = experience
	if experience >= maxexp:
		maxexp = maxexp + 5
		$UI/experience.max_value = maxexp
		var levelup = levelupchosse_scene.instance()
		$items.add_child(levelup)
		experience = 0
		exp_progressbar.value = experience
		pass
	# Add any additional logic for level up or UI updates here

func _on_Timer_timeout():
	seconds += 1
	 # Calcula los minutos y segundos
	minutes = seconds / 60
	var remaining_seconds = seconds % 60
	# Increase global.enemylvl by 1 every minute
	if remaining_seconds == 0:  # Check if it's a new minute
		global.enemylvl = global.enemylvl + 1
		print(global.enemylvl)
	# Actualiza el texto del contador de tiempo
	$UI/Label.text = str(minutes) + ":" + str(remaining_seconds).pad_zeros(2)
	global.minute = minutes
	# Reinicia el temporizador para contar el siguiente segundo
	$UI/Timer.start()

func _on_Inmunity_timeout():
	# Return the AnimatedSprite to its normal color
	head.modulate = Color(1, 1, 1, 1)
	body.modulate = Color(1, 1, 1, 1)
	legs.modulate = Color(1, 1, 1, 1)
	inmune = false
	pass # Replace with function body.

func _on_potionuse_pressed():
	if vida <= 99:
		if potions >= 1:
			var potion = potion_scene.instance()
			$items.add_child(potion)
			potions = potions -1
			pnum.text = str(potions)
	pass # Replace with function body.

func _on_pause_pressed():
	if $UI/Control/rect.visible == true:
		$UI/Control/rect/exit.disabled = true
		$UI/Control/rect.visible = false
	else:
		$UI/Control/rect.visible = true
		$UI/Control/rect/exit.disabled = false
	global.toggle_pause()
	pass # Replace with function body.


func _on_exit_pressed():
	global.reset_weapons_and_enemies()
	global.toggle_pause()
	get_tree().change_scene("res://scenes/mercado.tscn")
	pass # Replace with function body.


func _on_VirtualJoystick_analogic_chage(move):
	pass # Replace with function body.
