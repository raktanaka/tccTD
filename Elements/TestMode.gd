extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	load_test_menu()
	
func load_test_menu():
	$TestMenu/towers/PlayersChoice.set_pressed(true)
	$TestMenu/enemies/AI.set_pressed(true)
	$TestMenu/buttons/TestMode.connect("pressed",self,"test_mode_pressed")
	$TestMenu/buttons/Return.connect("pressed",self,"return_main")
	
func test_mode_pressed():

	var params = get_params()
	var towers = params[0]
	var enemies = params[1]
	get_node("TestMenu").queue_free()
	var scene = load('res://Elements/MainScene.tscn').instance()
	scene.connect("game_finished",self, 'unload_game')
	scene.init_params(towers, enemies)
	add_child(scene)
	if towers != 'PlayersChoice':
		scene.test_mode_build_towers()

func return_main():
	
	get_node("TestMenu").queue_free()
	get_tree().change_scene("res://Elements/GerenciarCena.tscn")
	#var main_menu = load('res://Elements/GerenciarCena.tscn').instance()
	#add_child(main_menu)

# Getter for Test Mode parameters
func get_params():
	var towers = $TestMenu/towers/AllGreen.get_button_group().get_pressed_button().get_name()
	var enemies = $TestMenu/enemies/AI.get_button_group().get_pressed_button().get_name()
	
	return [towers, enemies]

func unload_game(result):
	get_node("MainScene").queue_free()
	get_tree().change_scene("res://Elements/TestMode.tscn")
	#var test_menu = load('res://Elements/TestMode.tscn').instance()
	#add_child(test_menu)
