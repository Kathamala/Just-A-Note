extends Control

var selected = 1
var chose = false
#1 para Retry
#-1 para Menu

func _ready():
	$Fade.visible = true
	$Fade/AnimationPlayer.play("Fade_Out")
# warning-ignore:return_value_discarded
	$Fade/AnimationPlayer.connect("animation_finished", self, "on_Fade_Out_Finished")

func _process(_delta):
	if Input.is_action_just_pressed("ui_up") and !chose:
		$Option_Change.play()
		selected *= -1
	if Input.is_action_just_pressed("ui_down") and !chose:
		$Option_Change.play()
		selected *= -1

	if selected > 0:
		$Retry.animation = "Selected"
		$Menu.animation = "Not"
		if Input.is_action_just_pressed("ui_accept") and !chose:
			chose = true
			$Fade/AnimationPlayer.play("Fade_In")
			$Option_Select.play()
	else:
		$Menu.animation = "Selected"
		$Retry.animation = "Not"
		if Input.is_action_just_pressed("ui_accept") and !chose:
			chose = true
			$Fade/AnimationPlayer.play("Fade_In")
			$Option_Select.play()

func _on_Menu_Music_finished():
	$Game_Over_Music.play()

func on_Fade_Out_Finished(name):
	if name == "Fade_In":
# warning-ignore:return_value_discarded
		if selected == 1:
			get_tree().change_scene("res://Scenes/Game.tscn")
		else:
			get_tree().change_scene("res://Scenes/Menu.tscn")

