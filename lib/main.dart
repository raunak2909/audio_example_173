import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String audioUrl = "https://raag.fm/files/mp3/128/Hindi-Singles/23303/Kesariya%20(Brahmastra)%20-%20(Raag.Fm).mp3";
  AudioPlayer? player;
  Duration currPosValue = Duration.zero;
  Duration? totalPosValue = Duration.zero;
  Duration bufferedPosValue = Duration.zero;

  @override
  void initState() {
    super.initState();
    setUpMyAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressBar(
                thumbColor: Colors.amber,
                  thumbGlowColor: Colors.amber.withOpacity(0.1),
                  progress: currPosValue,
                  total: totalPosValue!,
                  buffered: bufferedPosValue,
                onSeek: (newSeekValue){
                    player!.seek(newSeekValue);
                    setState(() {

                    });
                },
                progressBarColor: Colors.amber,
                bufferedBarColor: Colors.grey,
                baseBarColor: Colors.black.withOpacity(0.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Icon(Icons.skip_previous),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(player!.playing){
                        player!.pause();
                      } else {
                        player!.play();
                      }
                      setState(() {

                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: player!.playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Icon(Icons.skip_next),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setUpMyAudioPlayer() async{
    player = AudioPlayer();
    totalPosValue = await player!.setUrl(audioUrl);
    player!.play();
    
    player!.positionStream.listen((event) {
      currPosValue = event;
      setState(() {
        
      });
    });

    player!.bufferedPositionStream.listen((event) {
      bufferedPosValue = event;
      setState(() {

      });
    });
    
    
  }
}


