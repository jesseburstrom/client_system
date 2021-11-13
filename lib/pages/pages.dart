part of "../main.dart";

class Pages {
  Future navigateToAuthenticatePage(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PageAuthenticate()));
  }

  Future navigateToAuthenticatePageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PageAuthenticate()));
  }

  Future navigateToRequestPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PageGameRequest()));
  }

  Future navigateToSelectPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PageGameSelect()));
  }

  Future navigateToSelectPage(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PageGameSelect()));
  }

  Future navigateToMainAppHandlerPage(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MainAppHandler()));
  }

  Future navigateToMainAppHandlerPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MainAppHandler()));
  }
}
