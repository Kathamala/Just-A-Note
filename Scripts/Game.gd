extends Node2D

func _ready():
	$Player.connect("collision", self, "_on_Player_Collision")

func _on_Player_Collision(body):
	if body.name == "Guitar":
		GameEvents.weapons_unlocked.append("Guitar")
		body.queue_free()
	if body.name == "ScaleParchment_E":
		GameEvents.parchments_unlocked.append("E")
		body.queue_free()
	if body.name == "Note_A":
		GameEvents.notes_unlocked.append("A")
		body.queue_free()
