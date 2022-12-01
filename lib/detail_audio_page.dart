import 'package:audioplayer23102022/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayer23102022/app_colors.dart' as AppColors;

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({Key? key, required this.booksData, required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advencedPlayer;

  @override
  void initState(){
    super.initState();
    advencedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: AppColors.audioBlueBackground,
              ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading:
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                    advencedPlayer.stop();
                    Navigator.pop(context);
                  }),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          Positioned(
            top: screenHeight * 0.2,
            left: 0,
            right: 0,
            height: screenHeight * 0.36,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.1,),
                  Text(
                    this.widget.booksData[this.widget.index]["title"],
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",),
                  ),
                  Text(
                    this.widget.booksData[this.widget.index]["text"],
                    style: TextStyle(
                      fontSize: 20,
                      ),
                  ),
                  AudioFile(advancedPlayer: advencedPlayer,audioPath: this.widget.booksData[this.widget.index]["audio"]),
                ],
              ),
            ),
          ),
          Positioned(
            height: screenHeight*0.18,
            top : screenHeight*0.12,
            left: (screenWidth-150)/2,
            right: (screenWidth-150)/2,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.audioGreyBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white,width: 2),
              ),
              child: Padding(
                padding:EdgeInsets.all(20),
                child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white,width: 5 ),
                  image: DecorationImage(image: AssetImage(this.widget.booksData[this.widget.index]["img"]),fit: BoxFit.cover,),
                ),
              ),
              ),
          ),
          ),
        ],
      ),
    );
  }
}
