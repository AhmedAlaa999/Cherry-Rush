extends Area2D
@export var fall_speed = 250

func _ready():
	respawn()

func _process(delta):
	position.y += fall_speed * delta

# the cherry reach top and bottom like that
	if position.y > 650:
		respawn()

func respawn():
	position.y = -50
	position.x = randi_range(50, 1100)

func spawn_feedback():
	var scene_to_spawn = preload("res://Pickups/Feedback/feedback.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)
	new_scene_instance.global_position = global_position

func _on_body_entered(body):
	if body.name == "Player":
		spawn_feedback()
		get_tree().current_scene.get_node("CherrySound").play()
		get_tree().current_scene.add_cherry()
		respawn()
