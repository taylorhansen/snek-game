extends Node2D

const ROTATE_FORCE = 1000
const SEGMENT_SCALING = 0.75

# tail segment
onready var _tail: SnakeSegment = $Tail
onready var _seg2: SnakeSegment = $SnakeSegment2
onready var _seg3: SnakeSegment = $SnakeSegment3
onready var _seg4: SnakeSegment = $SnakeSegment4
# head segment
onready var _head: SnakeSegment = $Head

func _input(event: InputEvent):
    # head grip
    if event.is_action_pressed("head_grip"):
        _head.grip()
    elif event.is_action_released("head_grip"):
        _head.ungrip()
    # head left
    if event.is_action_pressed("head_left"):
        _head_left()
    elif event.is_action_released("head_left"):
        _head_stop()
    # head right
    if event.is_action_pressed("head_right"):
        _head_right()
    elif event.is_action_released("head_right"):
        _head_stop()
    # tail grip
    elif event.is_action_pressed("tail_grip"):
        _tail.grip()
    elif event.is_action_released("tail_grip"):
        _tail.ungrip()

func _head_left():
    if not _tail.is_touching_wall() or not _tail.is_gripping():
        _head_stop()
        return
    # apply a force to each segment excluding tail
    var force = ROTATE_FORCE
    for seg in [_seg2, _seg3, _seg4, _head]:
        seg.rotate_left(force)
        force *= SEGMENT_SCALING

func _head_right():
    if not _tail.is_touching_wall() or not _tail.is_gripping():
        _head_stop()
        return
    # apply a force to each segment excluding tail
    var force = ROTATE_FORCE
    for seg in [_seg2, _seg3, _seg4, _head]:
        seg.rotate_right(force)
        force *= SEGMENT_SCALING

func _head_stop():
    for seg in [_seg2, _seg3, _seg4, _head]:
        seg.rotate_left(0)
