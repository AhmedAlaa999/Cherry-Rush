extends Node2D

var cherries = 0
var danger_cherries = 0
var time_left = 75
var game_ended = false

#IM THE GAMER MAN 
func _ready():
	$Ui/Panel/Cherries.text = "Cherries : 0"
	$Ui/Panel/DangerCherries.text = "Danger Cherries : 0"
	$Ui/Panel/Timer.text = "Timer = 75"
	$Ui/Result.text = ""


func add_cherry():
	if game_ended:
		return

	cherries += 1
	$Ui/Panel/Cherries.text = "Cherries : " + str(cherries)

	# WIN LEVEL 2 to win i mean like 
	if cherries >= 60:
		game_ended = true
		$Ui/Result.text = "YOU BEAT LEVEL 2"
		$Ui/Result.modulate = Color.GREEN
		$WinSound.play()
		$GameTimer.stop()
		await get_tree().create_timer(4).timeout
		get_tree().reload_current_scene()


func add_danger_cherry():
	if game_ended:
		return
	danger_cherries += 1
	$Ui/Panel/DangerCherries.text = "Danger Cherries : " + str(danger_cherries)

	# LOSE or gain balh blah
	if danger_cherries >= 10:
		game_ended = true
		$Ui/Result.text = "YOU LOSE"
		$Ui/Result.modulate = Color.RED
		$LoseSound.play()
		$GameTimer.stop()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://main_map.tscn")


func _on_game_timer_timeout() -> void:
	if game_ended:
		return
	time_left -= 1
	$Ui/Panel/Timer.text = "Timer = " + str(time_left)

	# LOSE BY TIME . Read it bro
	if time_left <= 0:
		game_ended = true
		$Ui/Result.text = "TIME UP"
		$Ui/Result.modulate = Color.RED
		$LoseSound.play()
		$GameTimer.stop()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://main_map.tscn")
