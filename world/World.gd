extends Node2D

onready var _pause_menu = $CanvasLayer/PauseMenu
onready var _win_menu = $CanvasLayer/WinMenu

# used for tracking play time
var _play_time: = 0.0
var _timing: = true

func _ready():
    set_process(true)

func _process(delta):
    if _timing:
        _play_time += delta

# pauses the game and brings up the pause menu
func _pause():
    # toggle pause state if we're already paused
    if not visible:
        _unpause()
        return
    _pause_game()
    _pause_menu.visible = true

# unpauses the game and hides the pause menu
func _unpause():
    _unpause_game()
    _pause_menu.visible = false

# quits the game
func _quit():
    get_tree().quit()

# stops the timer and waits for the win animation to stop
func _on_Basket_ball_entered():
    _timing = false

# brings up the win menu now that the game is over
func _on_Basket_game_over():
    _pause_game()
    _win_menu.appear(_play_time)

# pauses the game state
func _pause_game():
    visible = false
    get_tree().paused = true

# unpauses the game state
func _unpause_game():
    visible = true
    get_tree().paused = false

# restarts the game
func _restart():
    Global.goto_scene(load("res://world/World.tscn"))
    _unpause_game()
