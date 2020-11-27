extends KinematicBody2D

export var sequence = ["A", "A#", "C", "C#"]
export var time_between_notes = 1
var notes_right = 0

var player_in_area = false

func _ready():
	$ColorRect/GuideText.text = "| "
	for i in range(sequence.size()):
		$ColorRect/GuideText.text += sequence[i] + " | "
	$ColorRect.modulate.a = 0
	
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/NerkoOne-Regular.ttf")
	dynamic_font.size = float($ColorRect.rect_size.x) / sequence.size()
	$ColorRect.rect_size.x = $ColorRect/GuideText.rect_size.x*2
	$ColorRect.rect_size.y = dynamic_font.size*1.25
	$ColorRect/GuideText.add_font_override("font", dynamic_font)
	print(sequence)

func _process(delta):
	$Timer.wait_time = time_between_notes
	
	if player_in_area and GameEvents.current_weapon != "Empty_Hand":
		if Input.is_action_just_pressed("Shoot_A"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("A#")
			else:
				check_note_in_array("A")
		if Input.is_action_just_pressed("Shoot_B"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("B#")
			else:
				check_note_in_array("B")		
		if Input.is_action_just_pressed("Shoot_C"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("C#")
			else:
				check_note_in_array("C")			
		if Input.is_action_just_pressed("Shoot_D"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("D#")
			else:
				check_note_in_array("D")	
		if Input.is_action_just_pressed("Shoot_E"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("E#")
			else:
				check_note_in_array("E")	
		if Input.is_action_just_pressed("Shoot_F"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("F#")
			else:
				check_note_in_array("F")
		if Input.is_action_just_pressed("Shoot_G"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("G#")
			else:
				check_note_in_array("G")	

func _on_Play_Area_body_entered(body):
	if "Player" in body.name:
		$ColorRect.modulate.a = 0.5
		player_in_area = true
		
func _on_Play_Area_body_exited(body):
	if "Player" in body.name:
		$ColorRect.modulate.a = 0
		player_in_area = false

func check_note_in_array(note):
	var note_existst = false
	
	for i in range (GameEvents.notes_unlocked.size()):
		if note[0] == GameEvents.notes_unlocked[i]:
			note_existst = true
			break
	
	if !note_existst:
		return
	
	if sequence[notes_right] == note:
		print("Yes: ", note)
		notes_right += 1
		
	if notes_right == sequence.size():
		queue_free()
