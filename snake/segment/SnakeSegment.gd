extends RigidBody2D

# hitbox height
onready var _height = $CollisionShape2D.shape.height

onready var _grab_sound: AudioStreamPlayer2D = $GrabSound
onready var _grab_release_sound: AudioStreamPlayer2D = $GrabReleaseSound

# current torque value
var _torque: float = 0
# whether to apply the rotational force to the top or the bottom
var _top: bool = true

# grips this segment to a wall by changing into a static body
func grip():
    if is_touching_wall():
        if not is_gripping():
            _grab_sound.play()
        mode = MODE_STATIC

# checks if we're currently gripping something
func is_gripping():
    return mode == MODE_STATIC

# ungrips this segment from a wall by changing back into a rigid body
func ungrip():
    if is_gripping():
        _grab_release_sound.play()
    mode = MODE_RIGID

# checks if we're touching a wall body
func is_touching_wall() -> bool:
    for body in get_colliding_bodies():
        if body.is_in_group("wall"):
            return true
    return false

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