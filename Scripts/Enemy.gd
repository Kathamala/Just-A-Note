extends KinematicBody2D

var motion = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	position += (Player.position - position)/50
	move_and_collide(motion)


func _on_Hitbox_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
