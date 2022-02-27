import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditations_app/models/item_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int? _playingIndex;

  List<Item> items = [
    Item(
        name: "Forest Sounds",
        audioPath: "meditation_audios/forest.mp3",
        imagePath: "meditation_images/forest.jpeg"),
    Item(
        name: "Ocean Breeze",
        audioPath: "meditation_audios/ocean.mp3",
        imagePath: "meditation_images/ocean.jpeg"),
    Item(
        name: "Night Sounds",
        audioPath: "meditation_audios/night.mp3",
        imagePath: "meditation_images/night.jpeg"),
    Item(
        name: "Windy Evening",
        audioPath: "meditation_audios/wind.mp3",
        imagePath: "meditation_images/wind.jpeg"),
    Item(
        name: "Waterfall",
        audioPath: "meditation_audios/waterfall.mp3",
        imagePath: "meditation_images/waterfall.jpeg"),
  ];

  // Widget getIcon(int index) {
  //   if (index == _playingIndex) {
  //     return Icon(Icons.stop);
  //   } else {
  //     return Icon(Icons.play_arrow);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index].imagePath),
                    )),
                child: ListTile(
                  leading: BorderedText(
                    strokeWidth: 4,
                    strokeColor: Colors.black,
                    child: Text(
                      items[index].name,
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: IconButton(
                    icon: _playingIndex == index
                        ? const FaIcon(
                            Icons.stop_circle_outlined,
                            size: 40,
                          )
                        : const FaIcon(
                            Icons.play_circle_outline,
                            size: 40,
                          ), //Ternary operation
                    onPressed: () async {
                      if (_playingIndex == index) {
                        setState(() {
                          _playingIndex = null;
                        });

                        audioPlayer.stop();
                      } else {
                        try {
                          await audioPlayer.setAsset(items[index]
                              .audioPath); //bu islemin bitmesini bekleyecek alt satırlar.
                          audioPlayer.play();
                          setState(() {
                            _playingIndex = index;
                          });
                        } on SocketException {
                          print("No Internet Connection");
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
