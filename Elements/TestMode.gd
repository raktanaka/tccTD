extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	load_test_menu()
	
func load_test_menu():
	$TestMenu/buttons/TestMode.connect("pressed",self,"start_test")
	$TestMenu/buttons/Return.connect("pressed",self,"return_main")

	
func start_test():
	var params = get_params()
	var towers = params[0]
	var enemies = params[1]
	$TestMenu.queue_free()
	var scene = load('res://Elements/TestScene.tscn').instance()
	scene.init_params(towers, enemies)
	scene.connect("game_finished",self, 'unload_game')
	add_child(scene)

func return_main():
	get_node("TestMenu").queue_free()
	var main_menu = load('res://Elements/GerenciarCena.tscn').instance()
	add_child(main_menu)
	
func get_params():
	var towers
	var enemies
	if $TestMenu/towers/AllGreen.get_button_group().get_pressed_button() == null:
		pass
	else:
		towers = $TestMenu/towers/AllGreen.get_button_group().get_pressed_button().get_name()
	if $TestMenu/enemies/AI.get_button_group().get_pressed_button() == null:
		pass
	else:
		enemies = $TestMenu/enemies/AI.get_button_group().get_pressed_button().get_name()
		
	return [towers, enemies]

