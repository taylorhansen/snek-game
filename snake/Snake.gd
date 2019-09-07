extends Node2D

# tail segment
onready var _tail: SnakeSegment = $Tail
# head segment
onready var _head: SnakeSegment = $Head

func _input(event: InputEvent):
    # execute grip actions
    if event.is_action_pressed("head_grip"):
        _head.grip()
    elif event.is_action_released("head_grip"):
        _head.ungrip()
    elif event.is_action_pressed("tail_grip"):
        _tail.grip()
    elif event.is_action_released("tail_grip"):
        _tail.ungrip()
