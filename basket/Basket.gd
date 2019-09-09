extends StaticBody2D

# emitted once the win animation starts
signal ball_entered
# emitted once the win animation finishes playing
signal game_over

onready var _yay: = $Yay
onready var _green_confetti: = $GreenConfetti
onready var _brown_confetti: = $BrownConfetti

func _on_BallDetector_body_entered(body: PhysicsBody2D):
    if body.is_in_group("ball"):
        _yay.play()
        _green_confetti.emitting = true
        _brown_confetti.emitting = true
        emit_signal("ball_entered")

# emit the game over signal after the basket congratulates the player
func _on_Yay_finished():
    emit_signal("game_over")
