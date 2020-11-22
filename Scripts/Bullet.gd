extends RigidBody2D

var bullet_note = ""

func _ready():
	$Timer.start()
	pass
	
func _process(delta):
	if(!$VisibilityNotifier2D.is_on_screen()):
		kill_bullet()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullet_Limit"):
		kill_bullet()

func _on_Timer_timeout():
	kill_bullet()

func kill_bullet():
	queue_free()
	GameEvents.bullet_count -= 1
