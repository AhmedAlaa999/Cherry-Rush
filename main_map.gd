extends Node2D

var cherries = 0
var danger_cherries = 0
var time_left = 90
var game_ended = false


func _ready():
	$Ui/Panel/Cherries.text = "Cherries : 0"
	$Ui/Panel/DangerCherries.text = "Danger Cherries : 0"
	$Ui/Panel/Timer.text = "Timer = 90"
	$Ui/Result.text = ""

#I leave the space beacuse i think it is cool
func add_cherry():
	if game_ended:
		return
	cherries += 1
	$Ui/Panel/Cherries.text = "Cherries : " + str(cherries)

	# WIN or lose dont trust me 
	if cherries >= 40:
		game_ended = true
		$Ui/Result.text = "LEVEL 1 COMPLETE"
		$Ui/Result.modulate = Color.GREEN
		$WinSound.play()
		$GameTimer.stop()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://level_2.tscn")

func add_danger_cherry():
	if game_ended:
		return
	danger_cherries += 1
	$Ui/Panel/DangerCherries.text = "Danger Cherries : " + str(danger_cherries)

	# LOSE or win i said dont trust me dont read 
	if danger_cherries >= 10:
		game_ended = true
		$Ui/Result.text = "YOU LOSE"
		$Ui/Result.modulate = Color.RED
		$LoseSound.play()
		$GameTimer.stop()
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()


func _on_game_timer_timeout() -> void:
	if game_ended:
		return
	time_left -= 1
	$Ui/Panel/Timer.text = "Timer = " + str(time_left)

	if time_left <= 0:
		game_ended = true
		$Ui/Result.text = "TIME UP"
		$Ui/Result.modulate = Color.RED
		$LoseSound.play()
		$GameTimer.stop()
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
