import 'package:flutter/material.dart';

class CyberMuyuuAbout extends StatefulWidget {
  const CyberMuyuuAbout({super.key});

  @override
  State<CyberMuyuuAbout> createState() => _CyberMuyuuAboutState();
}

class _CyberMuyuuAboutState extends State<CyberMuyuuAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: const <Widget>[
                  Text('敲电子木鱼\n积赛博功德', style: TextStyle(fontSize: 28)),
                  SizedBox(
                    height: 30,
                    width: 150,
                  ),
                  Text('BPCC图一乐作品')
                ],
              ),
            ),
          )),
    );
  }
}
