import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Song> _songs;
  MusicFinder audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    audioPlayer = MusicFinder();
    var songs = await MusicFinder.allSongs();
    songs = List.from(songs);
    setState(() {
      _songs = songs;
    });
  }

  Future _playLocal(String url) async {
    final result = await audioPlayer.play(url, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Music App"),
        ),
        body: ListView.builder(
          itemCount: _songs.length,
          itemBuilder: (BuildContext, int index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(_songs[index].title[0]),
              ),
              title: Text(_songs[index].title[0]),
              onTap: () => _playLocal(_songs[index].uri),
            );
          },
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Music",
      home: home(),
    );
  }
}
