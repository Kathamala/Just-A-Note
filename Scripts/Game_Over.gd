extends Control

func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu.tscn")
