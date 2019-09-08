extends Node2D

const ROTATE_FORCE = 1500
const SEGMENT_SCALING = 0.75

# tail segment
onready var _tail: = $Tail
onready var _seg2: = $SnakeSegment2
onready var _seg3: = $SnakeSegment3
onready var _seg4: = $SnakeSegment4
# head segment
onready var _head: = $Head

func _ready():
    set_process(true)

func _process(delta):
    # head grip
    if Input.is_action_pressed("head_grip"): _head.grip()
    else: _head.ungrip()

    # tail grip
    if Input.is_action_pressed("tail_grip"): _tail.grip()
    else: _tail.ungrip()

    # head rotate (can only happen if tail is gripped and head is free)
    if Input.is_action_pressed("head_left") and _tail.is_gripping() and \
            not _head.is_gripping():
        _rotate_tip(true, true)
    elif Input.is_action_pressed("head_right") and _tail.is_gripping() and \
            not _head.is_gripping():
        _rotate_tip(true, false)
    # tail rotate (can only happen if head is gripped and tail is free)
    elif Input.is_action_pressed("tail_left") and _head.is_gripping() and \
            not _tail.is_gripping():
        _rotate_tip(false, true)
    elif Input.is_action_pressed("tail_right") and _head.is_gripping() and \
            not _tail.is_gripping():
        _rotate_tip(false, false)
    # stop rotation of all segments if no suitable rotate input
    else:
        for seg in [_tail, _seg2, _seg3, _seg4, _head]:
            seg.rotate_stop()

# starts rotating one of the snake's tips
func _rotate_tip(head: bool, left: bool):
    # make sure the other tip doesn't rotate
    var tip: = _tail if head else _head
    tip.rotate_stop()

    # decide which segments will be rotated
    # earlier indexes are given greater torque since they're lifting up
    #  themselves and other segments
    var segments: Array
    if head: segments = [_seg2, _seg3, _seg4, _head]
    else: segments = [_seg4, _seg3, _seg2, _tail]

    # apply a force to each selected segment
    var force = ROTATE_FORCE
    for seg in segments:
        # "top" param should be true if we're rotating the head, false if tail
        if left: seg.rotate_left(force, head)
        else: seg.rotate_right(force, head)
        force *= SEGMENT_SCALING
