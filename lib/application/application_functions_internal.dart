part of "../main.dart";

extension ApplicationFunctionsInternal on Application {
  clearFocus() {
    focusStatus = [];
    for (var i = 0; i < nrPlayers; i++) {
      focusStatus.add(List.filled(totalFields, 0));
    }
  }

  cellClick(int player, int cell) {
    if (player == playerToMove &&
        myPlayerId == playerToMove &&
        !fixedCell[player][cell] &&
        cellValue[player][cell] != -1) {
      audio.playLocal("harp");
      Map<String, dynamic> msg = {};
      msg["diceValue"] = gameDices.diceValue;
      msg["gameId"] = gameId;
      msg["playerIds"] = playerIds;
      msg["player"] = player;
      msg["cell"] = cell;
      msg["action"] = "sendSelection";
      print(msg);
      net.sendToClients(msg);
      calcNewSums(player, cell);
    } else {
      audio.playLocal("thud");
    }
  }

  calcNewSums(int player, int cell) {
    if (gameDices.unityDices) {
      gameDices.sendResetToUnity();
      if (nrPlayers == 1) {
        gameDices.sendStartToUnity();
      }
    }

    appColors[playerToMove + 1][cell] = Colors.green.withOpacity(0.7);
    fixedCell[playerToMove][cell] = true;
    // Update Sums
    var sum = 0;
    var totalSum = 0;
    var ts = 0;
    for (var i = 0; i < 6; i++) {
      if (fixedCell[playerToMove][i]) {
        ts++;
        sum += cellValue[playerToMove][i] as int;
      }
    }
    totalSum = sum;
    appText[playerToMove + 1][6] = sum.toString();
    if (sum >= bonusSum) {
      appText[playerToMove + 1][7] = bonusAmount.toString();
      totalSum += bonusAmount;
    } else {
      if (ts != 6) {
        appText[playerToMove + 1][7] = (sum - bonusSum).toString();
      } else {
        appText[playerToMove + 1][7] = "0";
      }
    }
    for (var i = 8; i <= totalFields - 2; i++) {
      if (fixedCell[playerToMove][i]) {
        totalSum += cellValue[playerToMove][i] as int;
      }
    }
    appText[playerToMove + 1][totalFields - 1] = totalSum.toString();
    cellValue[playerToMove][totalFields - 1] = totalSum;

    // New Rolls
    for (var i = 0; i < totalFields; i++) {
      if (!fixedCell[playerToMove][i]) {
        appText[playerToMove + 1][i] = "";
        cellValue[playerToMove][i] = -1;
      }
    }

    clearFocus();
    if (!fixedCell[playerToMove].contains(false)) {
      // Game finished
      //gameStarted = false;
      // for (var i = 0; i < NrPlayers; i++) {
      //   highscore.Update(userName, CellValue[i][TotalFields - 1]);
      // }
      highscore.updateHighscore(
          userName, cellValue[myPlayerId][totalFields - 1]);
    }
    playerToMove = (playerToMove + 1) % nrPlayers;

    for (var i = 0; i < totalFields; i++) {
      if (fixedCell[playerToMove][i]) {
        appColors[0][i] = Colors.white.withOpacity(0.7);
      } else {
        appColors[0][i] = Colors.white.withOpacity(0.3);
      }
    }
    for (var i = 0; i < nrPlayers; i++) {
      for (var j = 0; j < totalFields; j++) {
        if (!fixedCell[i][j]) {
          if (i == playerToMove) {
            appColors[i + 1][j] = Colors.greenAccent.withOpacity(0.3);
          } else {
            appColors[i + 1][j] = Colors.grey.withOpacity(0.3);
          }
        }
      }
    }
    gameDices.clearDices();
    animation.animateBoard();
  }
}
