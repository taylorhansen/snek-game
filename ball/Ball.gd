extends RigidBody2D

onready var _groove_joint = $GrooveJoint2D

# path to the node that will be attached to this one
# must derive from PhysicsBody2D
func attach_to(body: NodePath):
    _groove_joint.node_b = body

# checks if this object is currently attached to the given one
func is_attached_to(body: NodePath):
    return _groove_joint.node_b == body

# detaches this object's groove joint
func detach():
    _groove_joint.node_b = NodePath("")
