part of "../main.dart";

class PageMain extends StatefulWidget {
  const PageMain({Key? key}) : super(key: key);

  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  postFrameCallback(BuildContext context) {
    pages._contextMain = context;
    pages._postFrameCallbackMain(context);
  }

  @override
  void initState() {
    super.initState();
    pages._stateMain = state;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => postFrameCallback(context));
    pages._initStateMain();
  }

  @override
  void dispose() {
    super.dispose();
    pages._disposeMain();
  }

  @override
  Widget build(BuildContext context) {
    return pages._pageMain(context);
  }
}

class PageDynamic extends StatefulWidget {
  const PageDynamic({Key? key}) : super(key: key);

  @override
  _PageDynamicState createState() => _PageDynamicState();
}

class _PageDynamicState extends State<PageDynamic>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  postFrameCallback(BuildContext context) {
    pages._context = context;
    pages._postFrameCallback(context);
  }

  @override
  void initState() {
    super.initState();
    pages._state = state;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => postFrameCallback(context));
    pages._initState();
  }

  @override
  void dispose() {
    super.dispose();
    pages._dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pages._page(context);
  }
}

class Pages {
  Pages() {
    zeroCallbacks();
    zeroCallbacksMain();
    _postFrameCallbackMain = attemptLogin;
  }

  late Function _page,
      _pageMain,
      _state,
      _stateMain,
      _initState,
      _initStateMain,
      _postFrameCallback,
      _postFrameCallbackMain,
      _dispose,
      _disposeMain;
  late BuildContext _context, _contextMain;

  zeroCallbacks() {
    _page = defaultPage;
    _initState = emptyFunction;
    _postFrameCallback = emptyFunctionContext;
    _dispose = emptyFunction;
  }

  zeroCallbacksMain() {
    _pageMain = defaultPage;
    _initStateMain = emptyFunction;
    _postFrameCallbackMain = emptyFunctionContext;
    _disposeMain = emptyFunction;
  }

  emptyFunction() {}

  emptyFunctionContext(BuildContext context) {}

  Widget defaultPage(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future navigateToDynamicPage(
      BuildContext context, Map<String, dynamic> functions,
      [bool replace = true]) async {
    zeroCallbacks();
    if (functions["page"] != null) {
      _page = functions["page"];
    }
    if (functions["initState"] != null) {
      _initState = functions["initState"];
    }
    if (functions["postFrameCallback"] != null) {
      _postFrameCallback = functions["postFrameCallback"];
    }
    if (functions["dispose"] != null) {
      _dispose = functions["dispose"];
    }
    if (replace) {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const PageDynamic()));
    } else {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageDynamic()));
    }
  }

  Future navigateToMainPage(
      BuildContext context, Map<String, dynamic> functions,
      [bool replace = true]) async {
    zeroCallbacksMain();
    if (functions["page"] != null) {
      _pageMain = functions["page"];
    }
    if (functions["initState"] != null) {
      _initStateMain = functions["initState"];
    }
    if (functions["postFrameCallback"] != null) {
      _postFrameCallbackMain = functions["postFrameCallback"];
    }
    if (functions["dispose"] != null) {
      _disposeMain = functions["dispose"];
    }
    if (replace) {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const PageMain()));
    } else {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PageMain()));
    }
  }
}
