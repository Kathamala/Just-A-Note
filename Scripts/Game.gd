extends Node2D

func _ready():
	$Player.connect("collision", self, "_on_Player_Collision")
	GameEvents.current = GameEvents.max_amount

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
		
	if body.is_in_group("Enemy"):
		GameEvents.current -= 10

