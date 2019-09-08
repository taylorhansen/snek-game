extends Control

onready var label: = $Label

# shows the win menu
func appear(play_time: float):
    visible = true
    # round _play_time to nearest 10th
    var rounded_time = round(play_time * 10) / 10
    label.text = "YOU WIN\nPLAY TIME: " + str(rounded_time) + "s"
