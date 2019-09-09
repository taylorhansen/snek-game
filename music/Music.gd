extends AudioStreamPlayer

# list of AudioStreams to play shuffled
export(Array) var songs = []

func _ready():
    _select_song(null)

# plays a random song that isn't the one given as an argument
func _select_song(except: AudioStream):
    var i = int(rand_range(0, len(songs) - 1))
    var song = songs[i]
    if song == except:
        # reroll
        _select_song(except)
    else:
        # set the selected song to play
        stream = song
        play()

func _on_Music_finished():
    # select a new song that isn't the one we just finished
    _select_song(stream)
