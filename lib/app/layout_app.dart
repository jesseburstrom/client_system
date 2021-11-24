part of "../main.dart";

extension LayoutApp on App {
  // [
  //  chat.widgetChat,
  //  animationsScroll.widgetEmptyContainer
  //  widgetCRUD
  //  ]
  List<Widget> layoutTopToBottom(
      BuildContext context, double w, double h, List<Function> widgets) {
    var pos = List<Pos>.filled(widgets.length, Pos(w, h, 0, 0));
    pos[0] = Pos(w * 0.20, h * 0.25, w * 0.80, h * 0.75);
    pos[1] = Pos(w, h * 0.25, w, h * 0.75);
    pos[2] = Pos(w * 0.7, h, 0, 0);
    pos[3] = Pos(w * 0.3, h, pos[2].w, 0);
    return [
      Positioned(
          left: pos[0].l, top: pos[0].t, child: widgets[0](pos[0].w, pos[0].h)),
      Positioned(
          left: pos[1].l, top: pos[1].t, child: widgets[1](pos[1].w, pos[1].h)),
      Positioned(
          left: pos[2].l,
          top: pos[2].t,
          child: widgets[2](context, pos[2].w, pos[2].h)),
      Positioned(
          left: pos[3].l,
          top: pos[3].t,
          child: widgets[3](context, pos[3].w, pos[3].h)),
    ];
  }

  List<Widget> layoutLeftToRight(
      BuildContext context, double w, double h, List<Function> widgets) {
    var pos = List<Pos>.filled(widgets.length, Pos(w, h, 0, 0));
    pos[0] = Pos(w * 0.20, h * 0.25, w * 0.75, h * 0.75);
    pos[1] = Pos(w, h * 0.25, w, h * 0.75);
    pos[2] = Pos(w * 0.7, h, 0, 0);
    pos[3] = Pos(w * 0.3, h, pos[2].w, 0);
    return [
      Positioned(
          left: pos[0].l, top: pos[0].t, child: widgets[0](pos[0].w, pos[0].h)),
      Positioned(
          left: pos[1].l, top: pos[1].t, child: widgets[1](pos[1].w, pos[1].h)),
      Positioned(
          left: pos[2].l,
          top: pos[2].t,
          child: widgets[2](context, pos[2].w, pos[2].h)),
      Positioned(
          left: pos[3].l,
          top: pos[3].t,
          child: widgets[3](context, pos[3].w, pos[3].h)),
    ];
  }
}
