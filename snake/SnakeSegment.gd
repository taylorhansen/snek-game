extends RigidBody2D

onready var _pin_joint: PinJoint2D = $PinJoint2D

# Attaches a rigid body to the top joint. Must be a PhysicsBody2D
func attach_to(node: NodePath):
    _pin_joint.node_b = node
    print("a", _pin_joint.node_a, "b", _pin_joint.node_b)
