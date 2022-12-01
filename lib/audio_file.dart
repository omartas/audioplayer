import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancedPlayer, required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {

  Duration _duration = new Duration();
  Duration _position = new Duration();
  //https://dosya.co/k3tmmqqtoohq/audio.mp3.html
  double volume =1;
  bool isPlaying=false;
  bool isPaused=false;
  bool isLoop=false;
  bool isRepeat=false;
  Color color =Colors.black;

  List<IconData> _icons =[
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState(){
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) { setState((){
      _duration = d;
    }); });
    this.widget.advancedPlayer.onPositionChanged.listen((p) { setState((){
      _position = p;
    }); });
    //this.widget.advancedPlayer.setSourceUrl(path);
    this.widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState((){
        _position = Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying=true;
        }else{
          isPlaying=false;
        }
      });
    });
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });});
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }

  Widget btnSlow(){
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_sharp),
      padding: EdgeInsets.only(bottom: 10),
      onPressed: (){
        setState((){
          this.widget.advancedPlayer.setPlaybackRate(volume);
          volume=volume-0.1;
        });
      },
    );
  }Widget btnRepeat(){
    return IconButton(
      icon: Icon(Icons.repeat),
      padding: EdgeInsets.only(bottom: 10),
      onPressed: (){
        setState((){
        });
      },
    );
  }
  Widget btnLoop(){
    return IconButton(
      color: color,
      icon: Icon(Icons.loop),
      padding: EdgeInsets.only(bottom: 10),
      onPressed: () {
        print("aaaaaaaaa");
        if (isRepeat == false) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
            print(isRepeat);
          });
        }
        else if (isRepeat == true) {
          isRepeat=false;
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          color = Colors.black;
          print(isRepeat);

        }
      }
    );
  }
  Widget btnFast(){
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios),
      padding: EdgeInsets.only(bottom: 10),
      onPressed: (){
        setState((){
          this.widget.advancedPlayer.setPlaybackRate(volume);
          volume=volume+0.1;
          print(volume);
        });
      },
    );
  }
  Widget btnStart(){
    return IconButton(
      icon: isPlaying==false?Icon(_icons[0],size: 50,color: Colors.blue,):Icon(_icons[1],size: 50,color: Colors.blue,),
      padding: EdgeInsets.only(bottom: 10),
      onPressed: (){
      if(isPlaying==false){
        this.widget.advancedPlayer.play(AssetSource(this.widget.audioPath));
        setState((){
          isPlaying = true;
        });
      }else if(isPlaying == true){
        this.widget.advancedPlayer.pause();
        setState((){
          isPlaying = false;
        });
      }
      },
    );
  }
  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnLoop(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnRepeat()
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left :20.0,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split(".")[0]),
                Text(volume.toString()),
                Text(_duration.toString().split(".")[0]),
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
