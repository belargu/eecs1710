# karaoke machine
a program that detects audio from a mic & compares the pitch to a midi

sing as well as you can for the most points!

highly recommend calibrating your mic in the program before playing, every mic is different

### how it works
processing detects audio input at a certain amp threshold, then draws the frequency as many little lines scrolling across the screen

the frequency is compared with the chosen midi file (that is also drawn on screen)

the color of the voice lines turns more yellow the more on key you are, and of course points are added to the score

## you can add your own midis!
put any midi in the data folder and add new Song(<file name>,<channel of vocal melody>,<duration of song in seconds>) to the songList
