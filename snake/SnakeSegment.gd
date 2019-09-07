extends RigidBody2D
class_name SnakeSegment

onready var _height = $CollisionShape2D.shape.height

# wall bodies currently touching this segment
var _walls: Array = []
var _torque: float = 0

func rotate_left(force: float):
    _torque = -force

func rotate_right(force: float):
    _torque = force

# grips this segment to a wall by changing into a static body
func grip():
    if is_touching_wall():
        mode = MODE_STATIC

func is_gripping():
    return mode == MODE_STATIC

# ungrips this segment from a wall by changing back into a rigid body
func ungrip():
    mode = MODE_RIGID

# checks if we're touching a wall body
func is_touching_wall() -> bool:
    return len(_walls) > 0

func _ready():
    set_physics_process(true)

func _physics_process(delta):
    # apply torque forces
    if _torque != 0:
        apply_impulse(Vector2(0, -_height / 2), Vector2(_torque, 0) * delta)

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
