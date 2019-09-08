extends StaticBody2D

signal ball_entered

func _on_BallDetector_body_entered(body: PhysicsBody2D):
    if body.is_in_group("ball"):
        emit_signal("ball_entered")
