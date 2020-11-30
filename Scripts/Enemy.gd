extends KinematicBody2D

var motion = Vector2()
var Player

var sight_distance = 700
var speed = 20
var velocity = Vector2()

var rng = 0
var dead = false

export var enemy_note = "A"

func _ready():
	Player = get_parent().get_parent().get_node("Player")
	velocity.x = 7
	
func _physics_process(delta):
	if	(abs(Player.position.x - position.x) < sight_distance):
		if (abs(Player.position.y - position.y) < sight_distance):
			position += (Player.position - position)/100
			move_and_collide(motion)
			if Player.position.x - position.x > 0:
				$Sprite.flip_h = false
			elif Player.position.x - position.x < 0:
				$Sprite.flip_h = true
		else:
			move_and_slide(velocity*speed)
			if velocity.x > 0:
				$Sprite.flip_h = false
			elif velocity.x < 0:
				$Sprite.flip_h = true
	else:
		move_and_slide(velocity*speed)
		if velocity.x > 0:
			$Sprite.flip_h = false
		elif velocity.x < 0:
			$Sprite.flip_h = true

func _on_Hitbox_body_entered(body):
	if "Bullet" in body.name:
		for i in range(0, 7):
			if GameEvents.E_Parchment[i] == body.bullet_note:
				if GameEvents.E_Parchment[i+1] == enemy_note:
					queue_free()

	if body.is_in_group("Bullet_Limit"):
		velocity.x *= -1
