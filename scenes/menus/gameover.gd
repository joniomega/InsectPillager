extends CanvasLayer

var global
onready var admob = $AdMob
onready var console_output = $output
var max_lines = 50

func _ready()->void:
	# Redirige los mensajes de consola
	print("Console output redirection started!")
	MobileAds.initialize()
	
	global = get_node("/root/global")
	#ADMOB CONNECTS
	admob.connect("rewarded_video_loaded",self,"rewardedad_loaded")
	admob.connect("rewarded",self,"rewardad_finished")
	admob.connect("rewarded_video_failed_to_load",self,"rewardad_failed")
	admob.connect("rewarded_video_closed",self,"rewardad_closed")
	admob.connect("rewarded_video_opened",self,"rewardad_opened")
	if global.minute >= 5:
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
		elif global.level == 4:
			global.sstate = 7
			var start = Dialogic.start("win4")
			add_child(start)
	global.save_game()
	check_internet_connection()
	# Update labels
	$Control/scoretitle/score.text = str(global.score)
	$Control/scoretitle2/shells.text = str(global.shells)

func _on_exit_pressed()->void:
	$buttonsound.play()
	yield($buttonsound, "finished")
	global.reset_weapons_and_enemies()
	global.toggle_pause()
	get_tree().change_scene("res://scenes/mercado.tscn")

func _on_revive_pressed()->void:
	admob.load_rewarded_video()
	$Label.text = "loading ad..."
	pass

func rewardedad_loaded()->void:
	$Label.text = "ad fully loaded"
	admob.show_rewarded_video()
	_revive_player() 
	pass

func rewardad_finished(currency : String, amount : int)->void:
	$Label.text = "ad finished"
	_revive_player()

func rewardad_failed():
	$Label.text = "ad failed to load"
	pass
func rewardad_closed():
	$Label.text = "ad closed"
	pass
func rewardad_opened():
	$Label.text = "ad opened"
	pass

func _revive_player()->void:
	var player = get_tree().get_nodes_in_group("player")[0]
	player.curar_dano(100)
	global.toggle_pause()
	queue_free()
# NUEVA FUNCION: Comprobar si hay conexión a Internet
func check_internet_connection():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")

	# Realiza una solicitud a Google para comprobar la conexión
	var url = "https://www.google.com"
	http_request.request(url)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		$Label.text = "Internet is available"
	else:
		$Label.text = "No internet connection"

# Captura la salida de la consola y la muestra en pantalla
func _capture_console(message: String) -> void:
	# Añade el mensaje al RichTextLabel
	console_output.add_text(message.strip_edges() + "\n")
	# Elimina las líneas antiguas si exceden el máximo
	var lines = console_output.get_text().split("\n")
	if lines.size() > max_lines:
		lines = lines[-max_lines]  # Mantén solo las últimas `max_lines` líneas
	console_output.text = "\n".join(lines)  # Actualiza el texto en pantalla

# Ejemplo para probar mensajes en consola
func _on_test_button_pressed():
	print("Button pressed at time: " + str(OS.get_ticks_msec()))
