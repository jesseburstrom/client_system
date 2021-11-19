part of "../main.dart";

extension LayoutApp on App {
  // [
  //  chat.widgetChat,
  //  animationsScroll.widgetEmptyContainer
  //  ]
  List<Widget> layoutTopToBottom(double w, double h, List<Function> widgets) {
    var pos = List<Pos>.filled(widgets.length, Pos(w, h, 0, 0));
    pos[0] = Pos(w * 0.50, h * 0.50, w * 0.25, h * 0.25);
    pos[1] = Pos(w, h * 0.25, 0, h * 0.75);

    return [
      Positioned(
          left: pos[0].l, top: pos[0].t, child: widgets[0](pos[0].w, pos[0].h)),
      Positioned(
          left: pos[1].l, top: pos[1].t, child: widgets[1](pos[1].w, pos[1].h)),
    ];
  }

  // [
  //  chat.widgetChat,
  //  animationsScroll.widgetEmptyContainer
  //  ]
  List<Widget> layoutLeftToRight(double w, double h, List<Function> widgets) {
    var pos = List<Pos>.filled(widgets.length, Pos(w, h, 0, 0));
    pos[0] = Pos(w * 0.50, h * 0.50, w * 0.25, h * 0.25);
    pos[1] = Pos(w, h * 0.25, 0, h * 0.75);

    return [
      Positioned(
          left: pos[0].l, top: pos[0].t, child: widgets[0](pos[0].w, pos[0].h)),
      Positioned(
          left: pos[1].l, top: pos[1].t, child: widgets[1](pos[1].w, pos[1].h)),
    ];
  }
}
