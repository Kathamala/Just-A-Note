extends Control

var selected = 1
var chose = false
#1 para start
#-1 para exit

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
		$Start.animation = "Selected"
		$Exit.animation = "Not"
		if Input.is_action_just_pressed("ui_accept") and !chose:
			chose = true
			$Fade/AnimationPlayer.play("Fade_In")
			$Option_Select.play()
	else:
		$Exit.animation = "Selected"
		$Start.animation = "Not"
		if Input.is_action_just_pressed("ui_accept") and !chose:
			chose = true
			get_tree().quit()

func _on_Menu_Music_finished():
	$Menu_Music.play()

func on_Fade_Out_Finished(name):
	if name == "Fade_In":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Game.tscn")

