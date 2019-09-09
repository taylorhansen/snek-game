extends RigidBody2D

# hitbox height
onready var _height = $CollisionShape2D.shape.height


# current torque value
var _torque: float = 0
# whether to apply the rotational force to the top or the bottom
var _top: bool = true


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
    # apply torque by applying force to both sides, centered around the other
    #  side
    if _torque != 0:
        var offset: = Vector2(0, _height / 2)
        var force: = Vector2(_torque, 0)
        var impulse: Vector2 = force * delta
        apply_impulse(offset, -impulse)
        apply_impulse(-offset, impulse)
