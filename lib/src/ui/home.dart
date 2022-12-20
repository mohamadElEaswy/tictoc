import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/provider.dart';
import 'gradinat_backgroung.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final LogicProvider provider = ref.watch(logicProvider);
    // if X turn
    Color xColor = !provider.oTurn ? Colors.white : Colors.grey;
    // if O turn
    Color oColor = provider.oTurn ? Colors.white : Colors.grey;

    Color gridTextColor(int index) => provider.displayElement[index] == "X"
        ? Colors.redAccent
        : Colors.greenAccent;
    return Scaffold(
      body: GradiantBackground(
        child: Column(
          children: <Widget>[
            Expanded(
              // creating the ScoreBoard
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Player X',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        Text(
                          provider.xScore.toString(),
                          style: TextStyle(fontSize: 18, color: xColor),
                        ),
                        Container(
                          color: xColor,
                          height: !provider.oTurn ? 3 : 0,
                          width: 50,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Player O',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                          ),
                        ),
                        Text(
                          provider.oScore.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: oColor,
                          ),
                        ),
                        // const SizedBox(height: 1),
                        Container(
                          color: oColor,
                          height: provider.oTurn ? 3 : 0,
                          width: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // Creating the Board for Tic tac toe
              flex: 4,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        provider.tapped(index: index, context: context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Center(
                          child: Text(
                            provider.displayElement[index],
                            style: TextStyle(
                              color: gridTextColor(index),
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(

                // Button for Clearing the Enter board
                // as well as Scoreboard to start allover again
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  // color: Colors.indigo[50],
                  // textColor: Colors.black,
                  onPressed: provider.clearScoreBoard,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Clear Score Board",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  // filling the boxes when tapped with X
  // or O respectively and then checking the winner function

}
