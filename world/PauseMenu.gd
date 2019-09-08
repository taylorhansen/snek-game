extends Control

signal pause

func _input(event: InputEvent):
    if event.is_action_pressed("pause"):
        emit_signal("pause")