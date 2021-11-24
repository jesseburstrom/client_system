part of "../main.dart";

class App extends LanguagesApp with InputItems {
  App() {
    languagesSetup();
    setup();
    net.setCallbacks(callbackOnClientMsg, callbackOnServerMsg);
    net.connectToServer();
  }

  var animation = AnimationsApp();
  var tabController = TabController(length: 2, vsync: _PageDynamicState());
  var images = [
    "assets/images/bk/banner.jpg",
    "assets/images/bk/campaign.jpg",
    "assets/images/bk/desserts.jpg",
    "assets/images/bk/drinks.jpg",
    "assets/images/bk/green.jpg",
    "assets/images/bk/kingjr.jpg",
    "assets/images/bk/meals.jpg",
    "assets/images/bk/singles.jpg",
    "assets/images/bk/snacks.jpg",

    "assets/images/bk/meals/chicken_fish.jpg",
    "assets/images/bk/meals/flame_grilled_beef.jpg",
    "assets/images/bk/meals/green.jpg",

    "assets/images/bk/snacks/chili_cheese.jpg",
    "assets/images/bk/snacks/dip.jpg",
    "assets/images/bk/snacks/king_fries.jpg",
    "assets/images/bk/snacks/king_onion_rings.jpg",
    "assets/images/bk/snacks/king_wings.jpg",
    "assets/images/bk/snacks/minimorötter.jpg",
    "assets/images/bk/snacks/nuggets.jpg",
    "assets/images/bk/snacks/sweet_potato_fries.jpg",
  ];
  List<dynamic> products = [],
      categories = [],
      categoryProducts = [],
      categoryCategories = [];
  List<String> productIds = [];
  String chosenProductId = "";
  int chosenProductIdOffset = 0;

  List<String> categoryIds = [];
  String chosenCategoryId = "";
  int chosenCategoryIdOffset = 0;

  List<String> categoryCategoryIds = [];
  String chosenCategoryCategoryId = "";
  List<String> categoryCategory1Ids = [];
  String chosenCategoryCategory1Id = "";
  List<String> categoryCategory2Ids = [];
  String chosenCategoryCategory2Id = "";

  List<String> categoryProductIds = [];
  String chosenCategoryProductId = "";
  List<String> categoryProduct1Ids = [];
  String chosenCategoryProduct1Id = "";
  List<String> categoryProduct2Ids = [];
  String chosenCategoryProduct2Id = "";

  //var controllerProductId = TextEditingController();
  var controllerProductDescription = TextEditingController();
  var controllerProductDescriptionSwedish = TextEditingController();
  var controllerProductPrice = TextEditingController();
  var controllerProductImageId = TextEditingController();

  //var controllerCategoryId = TextEditingController();
  var controllerCategoryDescription = TextEditingController();
  var controllerCategoryDescriptionSwedish = TextEditingController();
  var controllerCategoryImageId = TextEditingController();

  initIds([init = false]) {
    productIds = [""];
    categoryProduct1Ids = [""];
    categoryProduct2Ids = [""];

    for (var i = 0; i < products.length; i++) {
      productIds
          .add(i.toString() + " " + products[i]["description"].toString());

      categoryProduct2Ids
          .add(i.toString() + " " + products[i]["description"].toString());
    }

    categoryProductIds = [""];
    ADOCategory cat;
    ADOProduct prod;
    for (var i = 0; i < categoryProducts.length; i++) {
      cat = findCategoryWithId(categoryProducts[i]["categoryId"]);
      prod = findProductWithId(categoryProducts[i]["productId"]);

      categoryProductIds.add(i.toString() +
          " " +
          cat.description.toString() +
          " " +
          prod.description.toString());
    }

    if (init) {
      chosenProductId = productIds[0];
      chosenCategoryProductId = categoryProductIds[0];
      chosenCategoryProduct1Id = categoryIds[0];
      chosenCategoryProduct2Id = productIds[0];
    }

    categoryIds = [""];
    categoryCategory1Ids = [""];
    categoryCategory2Ids = [""];

    for (var i = 0; i < categories.length; i++) {
      categoryIds
          .add(i.toString() + " " + categories[i]["description"].toString());
      categoryCategory1Ids
          .add(i.toString() + " " + categories[i]["description"].toString());
      categoryCategory2Ids
          .add(i.toString() + " " + categories[i]["description"].toString());

      categoryProduct1Ids
          .add(i.toString() + " " + categories[i]["description"].toString());
    }

    categoryCategoryIds = [""];
    ADOCategory cat1, cat2;
    for (var i = 0; i < categoryCategories.length; i++) {
      cat1 = findCategoryWithId(categoryCategories[i]["categoryId1"]);
      cat2 = findCategoryWithId(categoryCategories[i]["categoryId2"]);

      categoryCategoryIds.add(i.toString() +
          " " +
          cat1.description.toString() +
          " " +
          cat2.description.toString());
    }

    if (init) {
      chosenCategoryId = categoryIds[0];
      chosenCategoryCategoryId = categoryCategoryIds[0];
      chosenCategoryCategory1Id = categoryIds[0];
      chosenCategoryCategory2Id = categoryIds[0];
    }
  }

  ADOCategory findCategoryWithId(int id) {
    ADOCategory category = ADOCategory();
    for (var i = 0; i < categories.length; i++) {
      if (categories[i]["categoryId"] == id) {
        category = ADOCategory.fromJson(categories[i]);
        break;
      }
    }
    return category;
  }

  ADOProduct findProductWithId(int id) {
    ADOProduct product = ADOProduct();
    for (var i = 0; i < products.length; i++) {
      if (products[i]["productId"] == id) {
        product = ADOProduct.fromJson(products[i]);
        break;
      }
    }
    return product;
  }

  Future loadAllCategoryProducts([action = ""]) async {
    var response = await net.getDB("/GetAllCategoryProducts");
    List<dynamic> json = [];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      print("Error getting categoryProducts");
    }
    try {
      json = jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
    print(json.length);
    categoryProducts = json;
    initIds();
    switch (action) {
      case "create":
        chosenCategoryProductId =
            categoryProductIds[categoryProductIds.length - 1];
        pages._stateMain();
        break;

      case "delete":
        chosenCategoryProductId = "";
        pages._stateMain();
        break;
    }
  }

  Future loadAllProducts([action = ""]) async {
    var response = await net.getDB("/GetAllProducts");
    List<dynamic> json = [];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      print("Error getting products");
    }
    try {
      json = jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
    print(json.length);
    products = json;
    initIds();
    switch (action) {
      case "create":
        chosenProductId = productIds[productIds.length - 1];
        pages._stateMain();
        break;
      case "update":
        chosenProductId = productIds[chosenProductIdOffset];
        pages._stateMain();
        break;
      case "delete":
        chosenProductId = "";
        pages._stateMain();
        break;
    }
  }

  Future loadAllCategoryCategories([action = ""]) async {
    var response = await net.getDB("/GetAllCategoryCategories");
    List<dynamic> json = [];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      print("Error getting categoryCategories");
    }
    try {
      json = jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
    print(json.length);
    categoryCategories = json;
    initIds();
    switch (action) {
      case "create":
        chosenCategoryCategoryId =
            categoryCategoryIds[categoryCategoryIds.length - 1];
        pages._stateMain();
        break;

      case "delete":
        chosenCategoryCategoryId = "";
        pages._stateMain();
        break;
    }
  }

  Future loadAllCategories([action = ""]) async {
    var response = await net.getDB("/GetAllCategories");
    List<dynamic> json = [];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      print("Error getting categories");
    }
    try {
      json = jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
    print(json.length);
    categories = json;
    initIds();
    switch (action) {
      case "create":
        chosenCategoryId = categoryIds[categoryIds.length - 1];
        pages._stateMain();
        break;
      case "update":
        chosenCategoryId = categoryIds[chosenCategoryIdOffset];
        pages._stateMain();
        break;
      case "delete":
        chosenCategoryId = "";
        pages._stateMain();
        break;
    }
  }

  zeroControllersProducts() {
    controllerProductDescription.text = "";
    controllerProductDescriptionSwedish.text = "";
    controllerProductPrice.text = "0";
    controllerProductImageId.text = "0";
  }

  zeroControllersCategories() {
    controllerCategoryDescription.text = "";
    controllerCategoryDescriptionSwedish.text = "";
    controllerCategoryImageId.text = "0";
  }

  postFrameCallback(BuildContext context) async {
    animationsScroll.animationController.repeat(reverse: true);
  }

  navigateToApp(BuildContext context, [bool replace = true]) {
    pages.navigateToMainPage(
        context,
        {
          "page": widgetScaffold,
          "postFrameCallback": postFrameCallback,
          "dispose": animationsScroll.animationController.stop
        },
        replace);
  }

  initStateSettings() {
    print("initStateSettings");
    loadAllProducts();
    loadAllCategories();
    loadAllCategoryCategories();
    loadAllCategoryProducts();
  }

  navigateToSettings(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(
        context,
        {"page": widgetScaffoldSettings, "initState": initStateSettings},
        replace);
  }

  chatCallbackOnSubmitted(String text) {
    pages._stateMain();
    Map<String, dynamic> msg = {};
    msg["chatMessage"] = userName + ": " + text;
    msg["action"] = "chatMessage";
    msg["playerIds"] = [net.socketConnectionId];
    print(msg);
    net.sendToClients(msg);
  }

  setup() {}
}
