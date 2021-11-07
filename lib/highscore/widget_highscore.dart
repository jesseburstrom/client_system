part of "../main.dart";

extension HighscoreWidget on Highscore {
  Widget widgetHighscore(double width, double height) {
    var containerWidth = width;
    var heightCaption = height / 6.4;
    var containerHeight = height - heightCaption;
    var left = 0.0, top = 0.0;

    List<Widget> listings = <Widget>[];

    listings.add(Positioned(
        left: left,
        top: top,
        child: SizedBox(
            width: containerWidth,
            height: heightCaption,
            child: Center(
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(highscores_,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blue[800],
                          shadows: const [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.red,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        )))))));

    listings.add(AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? widget) {
          return Positioned(
            left: left,
            top: top + heightCaption,
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlueAccent.withOpacity(0.7),
                      Colors.indigoAccent.withOpacity(0.7)
                    ],
                    stops: [0.0, loopAnimation.value],
                  )),
              child: Scrollbar(
                //showTrackOnHover: true,
                child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: highscoreText.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: heightCaption,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          "  " + (index + 1).toString() + ".",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic)))),
                              Container(
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(highscoreText[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)))),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          highscoreValue[index].toString() +
                                              "  ",
                                          style: const TextStyle(
                                              color: Colors.yellow))))
                            ]),
                      );
                    }),
              ),
            ),
          );
        }));
    return SizedBox(
        width: width, height: height, child: Stack(children: listings));
  }
}
