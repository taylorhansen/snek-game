extends Node2D

# SnakeSegment NodePaths that will be attached together to form the snake.
# Should be ordered bottom to top.
export(Array) var segments setget set_segments

# Sets SnakeSegment attachments where the array must contain SnakeSegment
# NodePaths.
func set_segments(a: Array):
    segments = a

func _ready():
    # setup SnakeSegment attachments
    if len(segments) <= 1: return
    for i in range(0, len(segments) - 1):
        get_node(segments[i]).attach_to(segments[i + 1])
