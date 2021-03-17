import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/game_button.dart';

import 'custom_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Gamebutton> buttonlist;
  var player1;
  var player2;
  var activeplayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonlist = doInit();
  }

  List<Gamebutton> doInit() {
    player1 = List();
    player2 = List();
    activeplayer = 1;
    var GameButtons = <Gamebutton>[
      Gamebutton(id: 1),
      Gamebutton(id: 2),
      Gamebutton(id: 3),
      Gamebutton(id: 4),
      Gamebutton(id: 5),
      Gamebutton(id: 6),
      Gamebutton(id: 7),
      Gamebutton(id: 8),
      Gamebutton(id: 9),
    ];
    return GameButtons;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonlist = doInit();
    });
  }

  void playgame(Gamebutton gb) {
    setState(() {
      if (activeplayer == 1) {
        gb.text = 'x';
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = '0';
        gb.bg = Colors.black;
        activeplayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkwinner();
      if (winner == -1) {
        if (buttonlist.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => CustomDialog(
                    "Game Tied",
                    "press the reset button to start again ",
                    resetGame,
                  ));
        } else {
          activeplayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  int checkwinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3))
      winner = 1;
    if (player2.contains(1) && player2.contains(2) && player2.contains(3))
      winner = 2;
    if (player1.contains(4) && player1.contains(5) && player1.contains(6))
      winner = 1;
    if (player2.contains(4) && player2.contains(5) && player2.contains(6))
      winner = 2;
    if (player1.contains(7) && player1.contains(8) && player1.contains(9))
      winner = 1;
    if (player2.contains(7) && player2.contains(8) && player2.contains(9))
      winner = 2;
    if (player1.contains(1) && player1.contains(4) && player1.contains(7))
      winner = 1;
    if (player2.contains(1) && player2.contains(4) && player2.contains(7))
      winner = 2;
    if (player1.contains(2) && player1.contains(5) && player1.contains(8))
      winner = 1;
    if (player2.contains(2) && player2.contains(5) && player2.contains(8))
      winner = 2;
    if (player1.contains(6) && player1.contains(3) && player1.contains(9))
      winner = 1;
    if (player2.contains(6) && player2.contains(3) && player2.contains(9))
      winner = 2;
    if (player1.contains(5) && player1.contains(3) && player1.contains(7))
      winner = 1;
    if (player2.contains(5) && player2.contains(3) && player2.contains(7))
      winner = 2;
    if (player1.contains(1) && player1.contains(5) && player1.contains(9))
      winner = 1;
    if (player2.contains(1) && player2.contains(5) && player2.contains(9))
      winner = 2;

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            "Player 1 won ",
            "press the reset button to start again",
            resetGame,
          ),
        );
      }
      if (winner == 2) {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            "Player 2 won ",
            "press the reset button to start again",
            resetGame,
          ),
        );
      }
    }
    return winner;
  }

  void autoPlay() {
    var emptycells = List();
    var list = List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptycells.add(cellID);
      }
    }
    var r = Random();
    var randomindex = r.nextInt(emptycells.length - 1);
    var cellID = emptycells[randomindex];
    int i = buttonlist.indexWhere((p) => p.id == cellID);
    playgame(buttonlist[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: buttonlist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9),
              itemBuilder: (context, i) => SizedBox(
                height: 100,
                width: 100,
                child: RaisedButton(
                  padding: EdgeInsets.all(8),
                  onPressed: buttonlist[i].enabled
                      ? () => playgame(buttonlist[i])
                      : null,
                  child: Text(
                    buttonlist[i].text,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: buttonlist[i].bg,
                  disabledColor: buttonlist[i].bg,
                ),
              ),
            ),
          ),
          RaisedButton(
              color: Colors.red,
              padding: EdgeInsets.all(20),
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: resetGame),
        ],
      ),
    );
  }
}
