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
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            width: containerWidth,
            height: heightCaption,
            //child: Center(
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
                    ))))));

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
                      Colors.greenAccent.withOpacity(0.5),
                      Colors.lightBlueAccent.withOpacity(0.5)
                    ],
                    stops: [0.0, loopAnimation.value],
                  )),
              child: Scrollbar(
                //showTrackOnHover: true,
                child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: highscores.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: heightCaption,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: containerWidth * 0.15,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          "  " + (index + 1).toString() + ".",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black54)))),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 0, bottom: 0),
                                  width: containerWidth * 0.5,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(highscores[index]["name"],
                                          style: const TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black)))),
                              Container(
                                  width: containerWidth * 0.25,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          highscores[index]["score"]
                                                  .toString() +
                                              "  ",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent))))
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
