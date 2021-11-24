part of "../main.dart";

class ADOCategory {
  var categoryId = 0;
  var description = "";
  var descriptionSwedish = "";
  var imageId = 0;

  ADOCategory();

  ADOCategory.fromJson(Map<String, dynamic> json)
      : categoryId = json["categoryId"],
        description = json["description"].toString(),
        descriptionSwedish = json["descriptionSwedish"].toString(),
        imageId = json["imageId"] ?? 0;

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "description": description,
        "descriptionSwedish": descriptionSwedish,
        "imageId": imageId,
      };
}

extension CrudCategory on App {
  onClearCategory(BuildContext context) async {
    chosenCategoryId = categoryIds[0];
    zeroControllersCategories();
    pages._stateMain();
  }

  onDeleteCategory(BuildContext context) async {
    int? prodNr = int.tryParse(chosenCategoryId.split(" ")[0]);
    if (prodNr == null) {
      print("Please chose category to delete");
      return;
    }
    var response = await net.deleteDB(
        "/DeleteCategory?id=" + categories[prodNr]["categoryId"].toString());
    if (response.statusCode == 200) {
      loadAllCategories("delete");
      zeroControllersCategories();
      pages._stateMain();
      print("Category deleted!");
    }
  }

  onCreateCategory(BuildContext context) async {
    ADOCategory category = ADOCategory();
    category.description = controllerCategoryDescription.text;
    category.descriptionSwedish = controllerCategoryDescriptionSwedish.text;

    try {
      category.imageId = int.parse(controllerCategoryImageId.text);
    } catch (e) {
      print(e.toString());
    }
    var response = await net.postDB("/CreateCategory", category.toJson());
    if (response.statusCode == 200) {
      loadAllCategories("create");
      //initIds();
      print(categoryIds);
      pages._stateMain();
      print("category created!");
    }
  }

  // Widget widgetCreateCategory(BuildContext context) {
  //   return ListView(
  //     children: <Widget>[
  //       widgetInputDBEntry("Input description", controllerCategoryDescription),
  //       widgetInputDBEntry("Input description in swedish",
  //           controllerCategoryDescriptionSwedish),
  //       widgetInputDBEntry("ImageId", controllerCategoryImageId),
  //       widgetButton(context, onCreateCategory, "Create Category")
  //     ],
  //   );
  // }

  onUpdateCategory(BuildContext context) async {
    int? prodNr = int.tryParse(chosenCategoryId.split(" ")[0]);
    if (prodNr == null) {
      print("Please chose category to update");
      return;
    }
    chosenCategoryIdOffset = prodNr + 1;
    ADOCategory category = ADOCategory();
    category.categoryId = categories[prodNr]["categoryId"];
    category.description = controllerCategoryDescription.text;
    category.descriptionSwedish = controllerCategoryDescriptionSwedish.text;

    try {
      category.imageId = int.parse(controllerCategoryImageId.text);
      print(category.imageId);
    } catch (e) {
      print(e.toString());
    }
    var response = await net.updateDB("/UpdateCategory", category.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("category updated!");
      loadAllCategories("update");
      //initIds();
      //pages._stateMain();
    }
  }

  onCategoryIdChanged(String value) {
    int? prodNr = int.tryParse(value.split(" ")[0]);
    if (prodNr == null) {
      zeroControllersCategories();
    } else {
      print(prodNr);
      ADOCategory category = ADOCategory.fromJson(categories[prodNr]);
      controllerCategoryDescription.text = category.description;
      controllerCategoryDescriptionSwedish.text = category.descriptionSwedish;

      controllerCategoryImageId.text = category.imageId.toString();
    }
  }

  Widget widgetUpdateCategory(BuildContext context) {
    return ListView(
      children: <Widget>[
        widgetDropDownList(
            pages._stateMain,
            "Category",
            categoryIds,
            (x) => {chosenCategoryId = x, onCategoryIdChanged(x)},
            chosenCategoryId),
        widgetInputDBEntry("Input description", controllerCategoryDescription),
        widgetInputDBEntry("Input description in swedish",
            controllerCategoryDescriptionSwedish),
        widgetInputDBEntry("ImageId", controllerCategoryImageId),
        Row(children: [
          widgetButton(context, onClearCategory, "Clear", 16),
          widgetButton(context, onCreateCategory, "Create", 16),
          widgetButton(context, onUpdateCategory, "Update", 16),
          widgetButton(context, onDeleteCategory, "Delete", 16),
        ]),
      ],
    );
  }
}
