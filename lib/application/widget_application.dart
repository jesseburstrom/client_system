part of "../main.dart";

extension ApplicationWidgets on Application {
  onVerticalDragUpdate(mainX, mainY) {
    if (application.playerToMove != application.myPlayerId) {
      return;
    }
    //print(ListenerKey.currentContext.size);
    var box = listenerKey.currentContext!.findRenderObject() as RenderBox;
    var position = box.localToGlobal(Offset.zero); //this is global position
    mainY -= position.dy;
    for (var i = 0; i < totalFields; i++) {
      if (mainY >= boardYPos[0][i] &&
          mainY <= boardYPos[0][i] + boardHeight[0][i]) {
        if (!fixedCell[playerToMove][i] && cellValue[playerToMove][i] != -1) {
          if (focusStatus[playerToMove][i] == 0) {
            clearFocus();
            focusStatus[playerToMove][i] = 1;
          }
        }
      }
    }
  }

  Widget widgetDisplayGameStatus(double width, double height) {
    var playerName =
        playerToMove == myPlayerId ? your_ : userNames[playerToMove] + "'s";
    Widget widget = Container(
        width: width,
        height: height,
        color: Colors.white.withOpacity(0.3),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: width,
                  height: height * 0.2,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(playerName + " " + turn_,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)))),
              SizedBox(
                  width: width,
                  height: height * 0.2,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                          gameDices.rollsLeft_ +
                              ": " +
                              (gameDices.nrTotalRolls - gameDices.nrRolls)
                                  .toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey))))
            ]));
    return widget;
  }

  Widget widgetSetupGameBoard(double width, double height) {
    //var cellWidth = min(120.0, width / ((NrPlayers) / 3 + 1.5));
    var cellWidth = width / ((nrPlayers) / 3 + 1.5);
    var left = (width - cellWidth * ((nrPlayers - 1) / 3 + 1.5)) / 2;
    //var cellHeight = min(30.0, height / (TotalFields + 1));

    var cellHeight = height / (totalFields + 1.5);
    var top = (height - cellHeight * totalFields) * 0.75;

    // Setup board cell positions
    for (var i = 0; i < totalFields; i++) {
      boardWidth[0][i] = cellWidth;
      boardHeight[0][i] = cellHeight;
      boardXPos[0][i] = left;
      boardYPos[0][i] = i * cellHeight + top;
    }

    for (var i = 0; i < nrPlayers; i++) {
      for (var j = 0; j < totalFields; j++) {
        boardXPos[i + 1][j] = boardXPos[i][j] + boardWidth[i][j];
        boardYPos[i + 1][j] = boardYPos[0][j];
        boardHeight[i + 1][j] = boardHeight[0][j];
        if (i == playerToMove) {
          boardWidth[i + 1][j] = boardWidth[0][j] / 2;
        } else {
          boardWidth[i + 1][j] = boardWidth[0][j] / 3;
        }
      }
    }

    for (var i = 0; i < nrPlayers; i++) {
      for (var j = 0; j < totalFields; j++) {
        // enlarge dimension of cell in focus
        if (focusStatus[i][j] == 1) {
          boardXPos[i + 1][j] -= boardWidth[0][j] / 4;
          boardWidth[i + 1][j] *= 2;
          boardYPos[i + 1][j] -= boardHeight[0][j] / 2;
          boardHeight[i + 1][j] *= 2;
        }
      }
    }

    var listings = <Widget>[];

    // Place names
    for (var i = 0; i < nrPlayers; i++) {
      listings.add(Positioned(
          left: boardXPos[1 + i][0],
          top: boardYPos[1 + i][0] - cellHeight,
          child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
              width: boardWidth[1 + i][0],
              height: cellHeight,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(userNames[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.8),
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.blueAccent,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ))))));
    }
    // For 'live' translation reset board text
    setAppText();
    for (var i = 0; i < totalFields; i++) {
      listings.add(
        AnimatedBuilder(
            animation: cellAnimationControllers[0][i],
            builder: (BuildContext context, Widget? widget) {
              return Positioned(
                  //key: _cellKeys[0][i],
                  left: boardXPos[0][i] + boardXAnimationPos[0][i],
                  top: boardYPos[0][i] + boardYAnimationPos[0][i],
                  child: Container(
                    width: boardWidth[0][i],
                    height: boardHeight[0][i],
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: appColors[0][i],
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        appText[0][i],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          //color: Colors.blue[800],
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.blue,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ));
            }),
      );
    }

    // add listener object to get drag positions
    // Important it comes after the part over which it should trigger
    listings.add(GestureDetector(
        key: listenerKey,
        onVerticalDragUpdate: (d) {
          onVerticalDragUpdate(d.globalPosition.dx, d.globalPosition.dy);
          globalSetState();
        },
        child: SizedBox(width: width, height: height, child: const Text(""))));

    Widget? focusWidget;
    Widget tmpWidget;
    for (var i = 0; i < nrPlayers; i++) {
      for (var j = 0; j < totalFields; j++) {
        tmpWidget = AnimatedBuilder(
            animation: cellAnimationControllers[i][j],
            builder: (BuildContext context, Widget? widget) {
              return Positioned(
                //key: _cellKeys[i + 1][j],
                left: boardXPos[i + 1][j] + boardXAnimationPos[i + 1][j],
                top: boardYPos[i + 1][j] + boardYAnimationPos[i + 1][j],
                child: GestureDetector(
                    onTap: () {
                      cellClick(i, j);
                      globalSetState();
                    },
                    child: Container(
                        width: boardWidth[i + 1][j],
                        height: boardHeight[i + 1][j],
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: appColors[i + 1][j],
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(appText[i + 1][j],
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ))),
              );
            });
        if (focusStatus[i][j] == 1) {
          focusWidget = tmpWidget;
        } else {
          listings.add(tmpWidget);
        }
      }
    }
    // The focus widget is overlapping neighbor widgets
    // it needs to be last to have priority
    if (focusWidget != null) {
      listings.add(focusWidget);
    }
    return SizedBox(
        width: screenWidth, height: height, child: Stack(children: listings));
  }
}
