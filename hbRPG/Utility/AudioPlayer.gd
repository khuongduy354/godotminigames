extends Node2D
const EnemyDie = preload("res://Action RPG Resources/Music and Sounds/EnemyDie.wav")
const Evade = preload("res://Action RPG Resources/Music and Sounds/Evade.wav")
const Hit = preload("res://Action RPG Resources/Music and Sounds/Hit.wav")
const Hurt = preload("res://Action RPG Resources/Music and Sounds/Hurt.wav")
const Music = preload("res://Action RPG Resources/Music and Sounds/Music.mp3")

func play(type):
	for audio in self.get_children(): 
		if not audio.playing: 
			audio.stream = type 
			audio.play() 
			break
