extends Area2D
@export var fall_speed = 280

func _ready():
	respawn()

func _process(delta):
	position.y += fall_speed * delta

	if position.y > 650:
		respawn()

func respawn():
	position.y = -50
	position.x = randi_range(50, 1100)

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().current_scene.get_node("DangerSound").play()
		get_tree().current_scene.add_danger_cherry()
		respawn()
