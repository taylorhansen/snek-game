extends Node2D

onready var _pause_menu = $CanvasLayer/PauseMenu

# pauses the game and brings up the pause menu
func _pause():
    # toggle pause state if we're already paused
    if not visible:
        _unpause()
        return
    visible = false
    get_tree().paused = true
    _pause_menu.visible = true

# unpauses the game and hides the pause menu
func _unpause():
    visible = true
    get_tree().paused = false
    _pause_menu.visible = false

func _quit():
    get_tree().quit()
