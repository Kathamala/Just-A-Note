extends Control

var selected = 1

func _ready():
	$Fade.visible = true
	$Fade/AnimationPlayer.play("Fade_Out")
# warning-ignore:return_value_discarded
	$Fade/AnimationPlayer.connect("animation_finished", self, "on_Fade_Out_Finished")

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		$Option_Change.play()
		selected *= -1
	if Input.is_action_just_pressed("ui_down"):
		$Option_Change.play()
		selected *= -1

	if selected > 0:
		$MenuImage.animation = "Start"
		if Input.is_action_just_pressed("ui_accept"):
			$Fade/AnimationPlayer.play("Fade_In")
			$Option_Select.play()
	else:
		$MenuImage.animation = "Exit"
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().quit()

func _on_Menu_Music_finished():
	$Menu_Music.play()

func on_Fade_Out_Finished(name):
	if name == "Fade_In":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Game.tscn")

