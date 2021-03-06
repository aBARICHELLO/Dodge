extends Node

export (PackedScene) var Enemy
var score

func _ready():
	randomize()

func new_game():
	$Music.play()
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")

func _game_over():
	$Music.stop()
	$Death.play()
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$HUD.show_game_over()

func _on_StartTimer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_EnemyTimer_timeout():
	$EnemyPath/SpawnLocation.set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	var direction = $EnemyPath/SpawnLocation.rotation + PI/2
	enemy.position = $EnemyPath/SpawnLocation.position
	direction += rand_range(deg2rad(0), deg2rad(360))
	enemy.rotation = direction
	enemy.set_linear_velocity(Vector2(rand_range(enemy.MIN_SPEED, enemy.MAX_SPEED), 0).rotated(direction))
