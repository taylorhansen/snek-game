extends Control

func _on_Play_pressed():
    Global.goto_scene(preload("res://world/World.tscn"))

func _on_Quit_pressed():
    get_tree().quit()
