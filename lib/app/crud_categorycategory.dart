part of "../main.dart";

class ADOCategoryCategory {
  var categoryCategoryId = 0;
  var categoryId1 = 0;
  var categoryId2 = 0;

  ADOCategoryCategory();

  ADOCategoryCategory.fromJson(Map<String, dynamic> json)
      : categoryCategoryId = json["categoryCategoryId"] ?? 0,
        categoryId1 = json["categoryId1"] ?? 0,
        categoryId2 = json["categoryId2"] ?? 0;

  Map<String, dynamic> toJson() => {
        "categoryCategoryId": categoryCategoryId,
        "categoryId1": categoryId1,
        "categoryId2": categoryId2,
      };
}

extension CrudCategoryCategory on App {
  onDeleteCategoryCategory(BuildContext context) async {
    int? prodNr = int.tryParse(chosenCategoryCategoryId.split(" ")[0]);
    if (prodNr == null) {
      print("Please chose categoryCategory to delete");
      return;
    }
    var response = await net.deleteDB("/DeleteCategoryCategory?id=" +
        categoryCategories[prodNr]["categoryCategoryId"].toString());
    if (response.statusCode == 200) {
      loadAllCategoryCategories("delete");
      //zeroControllersCategories();
      pages._stateMain();
      print("CategoryCategory deleted!");
    }
  }

  onCreateCategoryCategory(BuildContext context) async {
    int? prodNr1 = int.tryParse(chosenCategoryCategory1Id.split(" ")[0]);
    int? prodNr2 = int.tryParse(chosenCategoryCategory2Id.split(" ")[0]);
    if (prodNr1 == null || prodNr2 == null) {
      print("Please chose category connection to create");
      return;
    }

    ADOCategoryCategory categoryCategory = ADOCategoryCategory();
    categoryCategory.categoryId1 = categories[prodNr1]["categoryId"];
    categoryCategory.categoryId2 = categories[prodNr2]["categoryId"];

    var response =
        await net.postDB("/CreateCategoryCategory", categoryCategory.toJson());
    if (response.statusCode == 200) {
      loadAllCategoryCategories("create");
      //initIds();
      print(categoryCategoryIds);
      pages._stateMain();
      print("categoryCategory created!");
    }
  }

  Widget widgetUpdateCategoryCategory(BuildContext context) {
    return ListView(
      children: <Widget>[
        widgetDropDownList(
            pages._stateMain,
            "CategoryCategory",
            categoryCategoryIds,
            (x) => {chosenCategoryCategoryId = x},
            chosenCategoryCategoryId),
        widgetButton(context, onDeleteCategoryCategory, "Delete", 16),
        widgetDropDownList(pages._stateMain, "Category1", categoryCategory1Ids,
            (x) => {chosenCategoryCategory1Id = x}, chosenCategoryCategory1Id),
        widgetDropDownList(pages._stateMain, "Category2", categoryCategory2Ids,
            (x) => {chosenCategoryCategory2Id = x}, chosenCategoryCategory2Id),
        widgetButton(context, onCreateCategoryCategory, "Create", 16),
      ],
    );
  }
}
