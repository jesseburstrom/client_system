part of "../main.dart";

class Pages {
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

  Future navigateToMainAppHandlerPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MainAppHandler()));
  }
}
