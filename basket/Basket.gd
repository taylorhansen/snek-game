extends StaticBody2D

signal ball_entered

onready var _yay: = $Yay
onready var _green_confetti: = $GreenConfetti
onready var _red_confetti: = $RedConfetti

func _on_BallDetector_body_entered(body: PhysicsBody2D):
    if body.is_in_group("ball"):
        _yay.play()
        _green_confetti.emitting = true
        _red_confetti.emitting = true

# emit the game over signal after the basket congratulates the player
func _on_Yay_finished():
    emit_signal("ball_entered")
