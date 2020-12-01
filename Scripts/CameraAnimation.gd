extends Camera2D

func _ready():
	$Sprite.visible = false

func _process(delta):
	if GameEvents.game_moment == 1:
		$Sprite.visible = true
		$Sprite/AnimationPlayer.play("CorridorWarning")
		get_parent().get_parent().get_child(0).get_child(0).text = "Time Left: " + str(int($Sprite/Timer.time_left))
		
		if int($Sprite/Timer.time_left) <= 0:
			get_tree().change_scene("res://Scenes/Game_Over.tscn")