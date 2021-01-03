extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

#func create_grass_effect():
#	if Input.is_action_just_pressed("attack"):
#		var grassEffect = GrassEffect.instance()
#
##		var main = get_tree().current_scene
##		main.add_child(grassEffect)
#		get_parent().add_child(grassEffect)
#		# this line below render the effect in the position of the object		
#		grassEffect.global_position = global_position
#		queue_free()
		

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
		
#	var main = get_tree().current_scene
#	main.add_child(grassEffect)
	get_parent().add_child(grassEffect)
	# this line below render the effect in the position of the object		
	grassEffect.global_position = global_position
	
	
func _on_HurtBox_area_entered(_area):
	create_grass_effect()
	queue_free()
