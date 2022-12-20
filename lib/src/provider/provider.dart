import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ChangeNotifierProvider<LogicProvider> logicProvider =
    ChangeNotifierProvider<LogicProvider>((_) => LogicProvider());

class LogicProvider extends ChangeNotifier {
  // declarations
  bool oTurn = true;

  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  void tapped({required int index, required BuildContext context}) {
    if (displayElement[index].isEmpty) {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }
      oTurn = !oTurn;
      checkWinner(context);
      notifyListeners();
    }
  }
  bool winner = false;
  void checkWinner(BuildContext context) {

    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      showWinDialog(winner: displayElement[0], context: context);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      showWinDialog(winner: displayElement[3], context: context);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      showWinDialog(winner: displayElement[6], context: context);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {

      showWinDialog(winner: displayElement[0], context: context);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      showWinDialog(winner: displayElement[1], context: context);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      showWinDialog(winner: displayElement[2], context: context);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      showWinDialog(winner: displayElement[0], context: context);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      showWinDialog(winner: displayElement[2], context: context);
    } else
      if (filledBoxes == 9 && !winner )
      {
      showDrawDialog(context);
    }
  }

  void showWinDialog({required String winner, required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\"  $winner +  \" is Winner!!!"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void showDrawDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  winner = true;
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    for (int i = 0; i < 9; i++) {
      displayElement[i] = '';

    }
    notifyListeners();

    filledBoxes = 0;
  }

  void clearScoreBoard() {
    xScore = 0;
    oScore = 0;
    for (int i = 0; i < 9; i++) {
      displayElement[i] = '';
    }
    notifyListeners();
    filledBoxes = 0;
  }
}
