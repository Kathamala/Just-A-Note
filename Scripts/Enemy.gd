extends KinematicBody2D

var motion = Vector2()
var Player

var sight_distance = 700
var speed = 20
var velocity = Vector2()

var rng = 0
var dead = false

export var enemy_note = "A"

signal dead

var knockback_force = 150

func _ready():
	$ColorRect/Label.text = enemy_note
	Player = get_parent().get_parent().get_node("Player")
	velocity.x = 7
	
func _physics_process(_delta):
	if	(abs(Player.position.x - position.x) < sight_distance):
		if (abs(Player.position.y - position.y) < sight_distance):
			position += (Player.position - position)/100
# warning-ignore:return_value_discarded
			move_and_collide(motion)
			if Player.position.x > position.x:
				velocity.x = abs(velocity.x)
				velocity.y = abs(velocity.y)
				$Sprite.flip_h = false
			elif Player.position.x < position.x:
				velocity.x = abs(velocity.x)*-1
				velocity.y = abs(velocity.y)*-1
				$Sprite.flip_h = true
		else:
# warning-ignore:return_value_discarded
			move_and_slide(velocity*speed)
			if velocity.x > 0:
				$Sprite.flip_h = false
			elif velocity.x < 0:
				$Sprite.flip_h = true
	else:
# warning-ignore:return_value_discarded
		move_and_slide(velocity*speed)
		if velocity.x > 0:
			$Sprite.flip_h = false
		elif velocity.x < 0:
			$Sprite.flip_h = true
	
	if velocity != Vector2(0, 0):
		$Sprite.play("Walking")
	else:
		$Sprite.play("Idle")

func _on_Hitbox_body_entered(body):
	if "Bullet" in body.name:
		for i in range(0, 7):
			if GameEvents.E_Parchment[i] == body.bullet_note:
				if GameEvents.E_Parchment[i+1] == enemy_note:
					emit_signal("dead")
					queue_free()

	if body.is_in_group("Bullet_Limit"):
		velocity.x *= -1

func knockback():
# warning-ignore:return_value_discarded
	move_and_slide(-velocity*speed*knockback_force)
