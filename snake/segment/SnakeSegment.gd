extends RigidBody2D

# hitbox height
onready var _height = $CollisionShape2D.shape.height

onready var _grab_sound: AudioStreamPlayer2D = $GrabSound
onready var _grab_release_sound: AudioStreamPlayer2D = $GrabReleaseSound

# current torque value
var _torque: float = 0
# whether to apply the rotational force to the top or the bottom
var _top: bool = true
var _attached = null

# grips this segment to a nearby wall or other object
func grip():
    # early return: already gripping something
    if is_gripping(): return

    # checks if we just gripped something
    var gripped: = false

    for body in get_colliding_bodies():
        if body.is_in_group("wall"):
            # gripping a wall
            gripped = mode != MODE_STATIC
            mode = MODE_STATIC
            _attached = body
            break
        elif body.is_in_group("ball"):
            var path: = self.get_path()
            gripped = body.is_attached_to(path)
            body.attach_to(path)
            _attached = body
            break

    # play grab sound
    if gripped: _grab_sound.play()

# checks if we're currently gripping an object
func is_gripping() -> bool:
    return _attached != null

# checks if we're currently gripping a wall
func is_gripping_wall() -> bool:
    return _attached and _attached.is_in_group("wall") and mode == MODE_STATIC

# checks if we're currently gripping a ball
func is_gripping_ball() -> bool:
    return _attached and _attached.is_in_group("ball")

# ungrips this segment from a wall by changing back into a rigid body
func ungrip():
    # checks if we just ungripped something
    var ungripped: = false

    if is_gripping_wall():
        # change back into a static body
        ungripped = true
        mode = MODE_RIGID
        _attached = null
    elif is_gripping_ball():
        # detach from the ball
        ungripped = true
        _attached.detach()
        _attached = null

    if ungripped:
        _grab_release_sound.play()

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
