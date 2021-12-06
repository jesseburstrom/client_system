part of "../main.dart";

class Audio {
  Audio() {}

  var audioPlayer = AudioPlayer();

  playLocal(String sound) async {
    // 'blipp' 'light_pling' 'pling' 'thud' 'kliiing'

    await audioPlayer.setAsset("assets/audio/" + sound + ".mp3");
    audioPlayer.play();
    print("played: " + sound);
  }
}
