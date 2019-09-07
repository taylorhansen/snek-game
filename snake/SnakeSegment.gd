extends RigidBody2D

var walls: Array = []

func is_touching_wall() -> bool:
    return len(walls) > 0

func _on_SnakeSegment_body_entered(body: Node):
    if body is StaticBody2D:
        if (body as StaticBody2D).get_collision_layer_bit(1):
            walls.append(body)

func _on_SnakeSegment_body_exited(body: Node):
    if body is StaticBody2D:
        if (body as StaticBody2D).get_collision_layer_bit(1):
            var index = walls.find(body)
            if index > 0:
                walls.remove(index)
