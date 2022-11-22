import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CyberMuyuu());
}

class CyberMuyuu extends StatelessWidget {
  const CyberMuyuu({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '赛博木鱼',
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: const Color(0xff6750a4)),
      home: const CyberMuyuuHome(title: '赛博木鱼'),
    );
  }
}

class CyberMuyuuHome extends StatefulWidget {
  const CyberMuyuuHome({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CyberMuyuuHome> createState() => _CyberMuyuuHomeState();
}

class _CyberMuyuuHomeState extends State<CyberMuyuuHome> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  //Incrementing counter after click
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  //Reset counter
  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('counter');
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('累计功德: $_counter'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.restart_alt_rounded),
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      title: const Text('确定要重置功德吗'),
                      content: const Text('累积的功德将会清空'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, '取消');
                            },
                            child: const Text('取消')),
                        TextButton(
                            onPressed: () {
                              _resetCounter();
                              Navigator.pop(context, '确定');
                            },
                            child: const Text('确定'))
                      ],
                    )
                  );
            },
          ),
          IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
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
                                Text('敲电子木鱼\n积赛博功德',
                                    style: TextStyle(fontSize: 28)),
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
                }));
              })
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            _incrementCounter();
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('功德+1')));
          },
          child: Image(
            fit: BoxFit.fitWidth,
            width: window.physicalSize.height,
            image: const AssetImage('assets/muyuu.png'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
