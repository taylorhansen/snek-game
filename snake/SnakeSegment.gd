extends RigidBody2D
class_name SnakeSegment

# hitbox height
onready var _height = $CollisionShape2D.shape.height

onready var _grab_sound: AudioStreamPlayer2D = $GrabSound
onready var _grab_release_sound: AudioStreamPlayer2D = $GrabReleaseSound
onready var _hit_sound: AudioStreamPlayer2D = $HitSound
onready var _thump_sound: AudioStreamPlayer2D = $ThumpSound

# current torque value
var _torque: float = 0
# whether to apply the rotational force to the top or the bottom
var _top: bool = true
# queued collision processing for a contacted body
var _contact_body = null

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

func _on_SnakeSegment_body_entered(body: Node):
    # register wall contacts for collision processing in _integrate_forces
    if body.is_in_group("wall"):
        _contact_body = body

func _integrate_forces(state: Physics2DDirectBodyState):
    if _contact_body != null:
        # search contacts for the recently collided body
        for i in range(state.get_contact_count()):
            var obj = state.get_contact_collider_object(i)
            if _contact_body == obj:
                # get contact normal and our velocity at the point of contact
                var normal = state.get_contact_local_normal(i)
                var vel = state.linear_velocity
                # vector projection of velocity onto collision normal
                # don't need to include normal.length_squared() since it's
                #  guaranteed to be 1
                var proj = normal.dot(vel) * normal
                # play a sound based on how "hard" the collision was
                var len2 = proj.length_squared()
                print("normal ", normal, " vel ", vel, " proj ", proj, " len2 ",
                    len2)
                #if len2 > 200: _thump_sound.play()
                #else: _hit_sound.play()
                break
        _contact_body = null
