import 'package:apside72_ref/views/nav/nav_drawer.dart';
import 'package:apside72_ref/views/player/audio_player.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Apside Le Mans ref'),
      ),
      body: const Center(
        child: AudioPlayerView(),
      ),
    );
  }
}