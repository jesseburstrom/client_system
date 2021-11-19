part of '../main.dart';

extension LayoutApplication on Application {
  // [
  //                   highscore.widgetHighscore,
  //                   widgetSetupGameBoard,
  //                   gameDices.widgetDices,
  //                   chat.widgetChat,
  //                   animationsScroll.widgetEmptyContainer,
  //                   widgetDisplayGameStatus
  //                 ]
  List<Widget> layoutTopToBottom(double w, double h, List<Function> widgets) {
    var pos = List<Pos>.filled(widgets.length, Pos(w, h, 0, 0));
    pos[0] = Pos(w * 0.45, h * 0.20, w * 0.025, 0);
    pos[1] = Pos(w, h * 0.45, 0, pos[0].h);
    pos[2] = Pos(w, h * 0.25, 0, pos[0].h + pos[1].h);
    pos[3] = Pos(w * 0.45, h * 0.16, w * 0.525, h * 0.04);
    pos[4] = Pos(w * 0.6, h - pos[0].h - pos[1].h - pos[2].h, w * 0.4,
        pos[0].h + pos[1].h + pos[2].h);
    pos[5] = Pos(w * 0.35, h * 0.11, w * 0.03, h * 0.885);

    return [
      // Unity plugin can be offended by widgets they are not wrapped in a stack, in this case the highscore is problem
      Positioned(
          left: pos[2].l, top: pos[2].t, child: widgets[2](pos[2].w, pos[2].h)),
      Stack(children: [
        Positioned(
            left: pos[0].l,
            top: pos[0].t,
            child: widgets[0](pos[0].w, pos[0].h)),
        Positioned(
            left: pos[1].l,
            top: pos[1].t,
            child: widgets[1](pos[1].w, pos[1].h)),
        Positioned(
            left: pos[3].l,
            top: pos[3].t,
            child: widgets[3](pos[3].w, pos[3].h)),
        Positioned(
            left: pos[5].l,
            top: pos[5].t,
            child: widgets[5](pos[5].w, pos[5].h)),
        Positioned(
            left: pos[4].l,
            top: pos[4].t,
            child: widgets[4](pos[4].w, pos[4].h)),
      ])
    ];
  }

  // [
  //                   widgetSetupGameBoard,
  //                   gameDices.widgetDices,
  //                   highscore.widgetHighscore,
  //                   chat.widgetChat,
  //                   animationsScroll.widgetEmptyContainer,
  //                   widgetDisplayGameStatus
  //                 ]

  List<Widget> layoutLeftToRight(double w, double h, List<Function> widgets) {
    var pos = List<Pos>.filled(widgets.length, Pos(w, h, 0, 0));
    pos[0] = Pos(w * 0.35, h, 0, 0);
    pos[1] = Pos(w * 0.45, gameDices.unityDices[0] ? pos[1].w * 9 / 16 : h,
        pos[0].w, gameDices.unityDices[0] ? h - pos[1].h : 0);
    pos[2] = Pos(w * 0.18, h * 0.8, w * 0.81, 0);
    pos[3] = Pos(w * 0.19, h * 0.3, w * 0.61, h * 0.05);
    pos[4] = Pos(w * 0.37, h - pos[2].h, pos[0].w + w * 0.085, -h * 0.08);
    pos[5] = Pos(w * 0.15, h * 0.3, pos[0].w + w * 0.1, h * 0.05);

    return [
      // Unity plugin can be offended by widgets they are not wrapped in a stack, in this case the highscore is problem
      Positioned(
          left: pos[1].l, top: pos[1].t, child: widgets[1](pos[1].w, pos[1].h)),
      Stack(children: [
        Positioned(
            left: pos[4].l,
            top: pos[4].t,
            child: widgets[4](pos[4].w, pos[4].h)),
        Positioned(
            left: pos[0].l,
            top: pos[0].t,
            child: widgets[0](pos[0].w, pos[0].h)),
        Positioned(
            left: pos[2].l,
            top: pos[2].t,
            child: widgets[2](pos[2].w, pos[2].h)),
        Positioned(
            left: pos[3].l,
            top: pos[3].t,
            child: widgets[3](pos[3].w, pos[3].h)),
        Positioned(
            left: pos[5].l,
            top: pos[5].t,
            child: widgets[5](pos[5].w, pos[5].h)),
      ])
    ];
  }
}
