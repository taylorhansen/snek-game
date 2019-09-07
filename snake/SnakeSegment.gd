extends RigidBody2D
class_name SnakeSegment

# hitbox height
onready var _height = $CollisionShape2D.shape.height

# wall bodies currently touching this segment
var _walls: Array = []
# current torque value
var _torque: float = 0
# whether to apply the rotational force to the top or the bottom
var _top: bool = true

# grips this segment to a wall by changing into a static body
func grip():
    if is_touching_wall():
        mode = MODE_STATIC

# checks if we're currently gripping something
func is_gripping():
    return mode == MODE_STATIC

# ungrips this segment from a wall by changing back into a rigid body
func ungrip():
    mode = MODE_RIGID

# checks if we're touching a wall body
func is_touching_wall() -> bool:
    return len(_walls) > 0

# rotates this segment to the left, where top will apply the force to the top of
#  the segment if true, or bottom if false
func rotate_left(force: float, top: bool):
    _torque = -force
    _top = top

# rotates this segment to the right, where top will apply the force to the top
#  of the segment if true, or bottom if false
func rotate_right(force: float, top: bool):
    _torque = force
    _top = top

# stops rotation
func rotate_stop():
    _torque = 0

func _ready():
    set_physics_process(true)

func _physics_process(delta):
    # apply torque forces
    # apply the force to the top or bottom by switching the sign of the height
    #  and torque values
    if _torque != 0:
        var offset_sign = -1 if _top else 1
        var offset: = Vector2(0, offset_sign * _height / 2)
        var force: = Vector2(-offset_sign * _torque, 0)
        apply_impulse(offset, force * delta)

func _on_SnakeSegment_body_entered(body: Node):
    # collision bit 1 is for walls so if the collider has that we can add it to
    #  the _walls array
    if body is StaticBody2D:
        if (body as StaticBody2D).get_collision_layer_bit(1):
            _walls.append(body)

func _on_SnakeSegment_body_exited(body: Node):
    if body is StaticBody2D:
        if (body as StaticBody2D).get_collision_layer_bit(1):
            var index = _walls.find(body)
            if index > 0:
                _walls.remove(index)
