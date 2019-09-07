extends RigidBody2D
class_name SnakeSegment

# wall bodies currently touching this segment
var _walls: Array = []

# grips this segment to a wall by changing into a static body
func grip():
    if _is_touching_wall():
        mode = MODE_STATIC

# ungrips this segment from a wall by changing back into a rigid body
func ungrip():
    mode = MODE_RIGID

# checks if we're touching a wall body
func _is_touching_wall() -> bool:
    return len(_walls) > 0

func _on_SnakeSegment_body_entered(body: Node):
    if body is StaticBody2D:
        if (body as StaticBody2D).get_collision_layer_bit(1):
            _walls.append(body)

func _on_SnakeSegment_body_exited(body: Node):
    if body is StaticBody2D:
        if (body as StaticBody2D).get_collision_layer_bit(1):
            var index = _walls.find(body)
            if index > 0:
                _walls.remove(index)
