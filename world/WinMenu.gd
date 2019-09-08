extends Control

onready var label: = $Label

# used for tracking play time
var _play_time: = 0.0
var _timing: = true

# shows the win menu
func show():
    _timing = false
    visible = true
    # round _play_time to nearest 10th
    var play_time = round(_play_time * 10) / 10
    label.text = "YOU WIN\nPLAY TIME: " + str(play_time) + "s"

func _ready():
    set_process(true)

func _process(delta):
    if _timing:
        _play_time += delta
