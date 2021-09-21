extends Node2D

func olhe_para():
	var enemy_position = get_global_mouse_position()
	get_node(".").look_at(enemy_position)
	pass

func _on_ViewRadius_body_entered(body):
	pass 

func _physics_process(delta):
	olhe_para()
	pass
	
