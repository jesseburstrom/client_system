part of "../main.dart";

class ADOCategoryProduct {
  var categoryId = 0;
  var productId = 0;

  ADOCategoryProduct();

  ADOCategoryProduct.fromJson(Map<String, dynamic> json)
      : categoryId = json["categoryId"] ?? 0,
        productId = json["productId"] ?? 0;

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "productId": productId,
      };
}

extension CrudCategoryProduct on App {
  onDeleteCategoryProduct(BuildContext context) async {
    int? prodNr = int.tryParse(chosenCategoryProductId.split(" ")[0]);
    if (prodNr == null) {
      print("Please chose categoryProduct to delete");
      return;
    }
    var response = await net.deleteDB("/DeleteCategoryProduct?idCategory=" +
        categoryProducts[prodNr]["categoryId"].toString() +
        "&idProduct=" +
        categoryProducts[prodNr]["productId"].toString());
    if (response.statusCode == 200) {
      loadAllCategoryProducts("delete");
      //zeroControllersCategories();
      pages._stateMain();
      print("CategoryProducts deleted!");
    }
  }

  onCreateCategoryProduct(BuildContext context) async {
    int? prodNr1 = int.tryParse(chosenCategoryProduct1Id.split(" ")[0]);
    int? prodNr2 = int.tryParse(chosenCategoryProduct2Id.split(" ")[0]);
    if (prodNr1 == null || prodNr2 == null) {
      print("Please chose categoryProduct connection to create");
      return;
    }

    ADOCategoryProduct categoryProduct = ADOCategoryProduct();
    categoryProduct.categoryId = categories[prodNr1]["categoryId"];
    categoryProduct.productId = products[prodNr2]["productId"];

    var response =
        await net.postDB("/CreateCategoryProduct", categoryProduct.toJson());
    if (response.statusCode == 200) {
      loadAllCategoryProducts("create");
      //initIds();
      print(categoryProductIds);
      pages._stateMain();
      print("categoryProduct created!");
    }
  }

  Widget widgetUpdateCategoryProduct(BuildContext context) {
    return ListView(
      children: <Widget>[
        widgetDropDownList(
            pages._stateMain,
            "CategoryProduct",
            categoryProductIds,
            (x) => {chosenCategoryProductId = x},
            chosenCategoryProductId),
        widgetButton(context, onDeleteCategoryProduct, "Delete", 16),
        widgetDropDownList(pages._stateMain, "Category", categoryProduct1Ids,
            (x) => {chosenCategoryProduct1Id = x}, chosenCategoryProduct1Id),
        widgetDropDownList(pages._stateMain, "Product", categoryProduct2Ids,
            (x) => {chosenCategoryProduct2Id = x}, chosenCategoryProduct2Id),
        widgetButton(context, onCreateCategoryProduct, "Create", 16),
      ],
    );
  }
}
