extends Node2D

onready var MainMenu = $Menu
onready var Options = $Opciones
var global
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spanish_locales = [
		"es", "es_AR", "es_BO", "es_CL", "es_CO", "es_CR", "es_CU", "es_DO",
		"es_EC", "es_SV", "es_GT", "es_HN", "es_MX", "es_NI", "es_PA",
		"es_PY", "es_PE", "es_PR", "es_ES", "es_UY", "es_VE"
	]
var catalan_locales = ["ca", "ca_ES"]

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	
	#SET LOCAL TO ES IF ITS A SPANISH COUNTRY
	var system_language = OS.get_locale()
	if system_language in spanish_locales or system_language in catalan_locales:
		TranslationServer.set_locale("es")  # Use Spanish
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Método llamado cuando se presiona el botón de "play" i inicia el juego
func _on_play_pressed():
	$buttonsound.play()
	Transition.change_scene("res://scenes/mercado.tscn")
	pass

# Método llamado cuando se presiona el botón de "opciones" i entra en el menu de opciones
func _on_options_pressed():
	$buttonsound.play()
	show_and_hide(Options,MainMenu)

func show_and_hide(first,Second):
	first.show()
	Second.hide()

# Método llamado cuando se presiona el botón de "salir" i sale del juego
func _on_exit_pressed():
	$buttonsound.play()
	get_tree().quit()

# Método llamado cuando se cambia la pantalla a fullscreem
#func _on_CheckBox_toggled(button_pressed):
#	OS.window_fullscreen = button_pressed


# Método llamado cuando cambia el valor del control deslizante "Master"
func _on_Master_value_changed(value):
	Volumen(0,value)


func Volumen(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index,value)


# Método llamado cuando cambia el valor del volumne de la musica
func _on_Music_value_changed(value):
	Volumen(1,value)


# Método llamado cuando cambia el valor del volumen de los efectos
func _on_Efects_value_changed(value):
	Volumen(2,value)


# Método llamado cuando se presiona el botón de "volver al menú" para salir de las opciones
func _on_Volver_al_menu_pressed():
	$buttonsound.play()
	show_and_hide(MainMenu,Options)


func _on_Button_pressed():
#	global.sstate = 1
#	get_tree().change_scene("res://scenes/mercado.tscn")
	pass # Replace with function body.


func _on_es_pressed():
	TranslationServer.set_locale("es")  # Use Spanish
	pass # Replace with function body.


func _on_en_pressed():
	TranslationServer.set_locale("en")  # Use Spanish
	
	pass # Replace with function body.


func _on_testing_pressed():
	get_tree().change_scene("res://addons/admob/test/Example.tscn")
	pass # Replace with function body.
