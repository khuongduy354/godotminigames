extends Node

const PLAYER_JUMP = preload("res://mixkit-retro-game-notification-212.wav")


func play_audio(type):
	for audio in self.get_children():
		if not audio.playing:
			audio.stream = type
			audio.play()
			break
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
