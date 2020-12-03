extends Node2D

func _ready():
# warning-ignore:return_value_discarded
	$HUD/Fade/AnimationPlayer.play("Fade_Out")
	$Player.connect("collision", self, "_on_Player_Collision")
	GameEvents.current = GameEvents.max_amount
	$HUD/Label.visible = false

func _on_Player_Collision(body):
	if body.name == "Guitar":
		GameEvents.weapons_unlocked.append("Guitar")
		body.queue_free()
		GameEvents.current_weapon = "Guitar"
	if body.name == "ScaleParchment_E":
		GameEvents.parchments_unlocked.append("E")
		body.queue_free()
	if body.name == "Note_A":
		GameEvents.notes_unlocked.append("A")
		body.queue_free()
	if body.name == "Note_B":
		GameEvents.notes_unlocked.append("B")
		body.queue_free()
	if body.name == "Note_C":
		GameEvents.notes_unlocked.append("C")
		body.queue_free()
	if body.name == "Note_D":
		GameEvents.notes_unlocked.append("D")
		body.queue_free()
	if body.name == "Note_E":
		GameEvents.notes_unlocked.append("E")
		body.queue_free()
	if body.name == "Note_F":
		GameEvents.notes_unlocked.append("F")
		body.queue_free()
	if body.name == "Note_G":
		GameEvents.notes_unlocked.append("G")
		body.queue_free()
	if body.name == "Green_Guitar_Pick":
		GameEvents.collectables_unlocked.append(body.name)
		body.queue_free()		
	if body.is_in_group("Enemy"):
		GameEvents.current -= 10
		body.get_parent().knockback()
	if body.name == "CorridorLimitIn":
		GameEvents.game_moment = 1
		$HUD/Label.visible = true
		$Player/MainCamera/Sprite/Timer.start()
	if body.name == "CorridorLimitOut":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Game_Over.tscn")

func _on_MinduimJam_finished():
	$Player/MinduimJam.play()
