part of "../main.dart";

class ADOProduct {
  var productId = 0;
  var description = "";
  var descriptionSwedish = "";
  var price = 0;
  var imageId = 0;

  ADOProduct();

  ADOProduct.fromJson(Map<String, dynamic> json)
      : productId = json["productId"],
        description = json["description"].toString(),
        descriptionSwedish = json["descriptionSwedish"].toString(),
        price = json["price"] ?? 0,
        imageId = json["imageId"] ?? 0;

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "description": description,
        "descriptionSwedish": descriptionSwedish,
        "price": price,
        "imageId": imageId,
      };
}

extension CrudProducts on App {
  onClearProduct(BuildContext context) async {
    chosenProductId = productIds[0];
    zeroControllersProducts();
    pages._stateMain();
  }

  onDeleteProduct(BuildContext context) async {
    int? prodNr = int.tryParse(chosenProductId.split(" ")[0]);
    if (prodNr == null) {
      print("Please chose product to delete");
      return;
    }
    var response = await net.deleteDB(
        "/DeleteProduct?id=" + products[prodNr]["productId"].toString());
    if (response.statusCode == 200) {
      loadAllProducts("delete");
      zeroControllersProducts();
      pages._stateMain();
      print("product deleted!");
    }
  }

  onCreateProduct(BuildContext context) async {
    ADOProduct product = ADOProduct();
    product.description = controllerProductDescription.text;
    product.descriptionSwedish = controllerProductDescriptionSwedish.text;
    try {
      product.price = int.parse(controllerProductPrice.text);
    } catch (e) {
      print(e.toString());
    }
    try {
      product.imageId = int.parse(controllerProductImageId.text);
    } catch (e) {
      print(e.toString());
    }
    var response = await net.postDB("/CreateProduct", product.toJson());
    if (response.statusCode == 200) {
      loadAllProducts("create");
      //initIds();
      print(productIds);
      pages._stateMain();
      print("product created!");
    }
  }

  Widget widgetCreateProduct(BuildContext context) {
    return ListView(
      children: <Widget>[
        widgetInputDBEntry("Input description", controllerProductDescription),
        widgetInputDBEntry("Input description in swedish",
            controllerProductDescriptionSwedish),
        widgetInputDBEntry("Price", controllerProductPrice),
        widgetInputDBEntry("ImageId", controllerProductImageId),
        widgetButton(context, onCreateProduct, "Create Product")
      ],
    );
  }

  onUpdateProduct(BuildContext context) async {
    int? prodNr = int.tryParse(chosenProductId.split(" ")[0]);
    if (prodNr == null) {
      print("Please chose product to update");
      return;
    }
    chosenProductIdOffset = prodNr + 1;
    ADOProduct product = ADOProduct();
    product.productId = products[prodNr]["productId"];
    product.description = controllerProductDescription.text;
    product.descriptionSwedish = controllerProductDescriptionSwedish.text;
    try {
      product.price = int.parse(controllerProductPrice.text);
    } catch (e) {
      print(e.toString());
    }
    try {
      product.imageId = int.parse(controllerProductImageId.text);
    } catch (e) {
      print(e.toString());
    }
    var response = await net.updateDB("/UpdateProduct", product.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("product updated!");
      loadAllProducts("update");
      //initIds();
      //pages._stateMain();
    }
  }

  onProductIdChanged(String value) {
    int? prodNr = int.tryParse(value.split(" ")[0]);
    if (prodNr == null) {
      zeroControllersProducts();
    } else {
      print(prodNr);
      ADOProduct product = ADOProduct.fromJson(products[prodNr]);
      controllerProductDescription.text = product.description;
      controllerProductDescriptionSwedish.text = product.descriptionSwedish;
      controllerProductPrice.text = product.price.toString();
      controllerProductImageId.text = product.imageId.toString();
    }
  }

  Widget widgetUpdateProduct(BuildContext context) {
    return ListView(
      children: <Widget>[
        widgetDropDownList(
            pages._stateMain,
            "Product",
            productIds,
            (x) => {chosenProductId = x, onProductIdChanged(x)},
            chosenProductId),
        widgetInputDBEntry("Input description", controllerProductDescription),
        widgetInputDBEntry("Input description in swedish",
            controllerProductDescriptionSwedish),
        widgetInputDBEntry("Price", controllerProductPrice),
        widgetInputDBEntry("ImageId", controllerProductImageId),
        Row(children: [
          widgetButton(context, onClearProduct, "Clear", 16),
          widgetButton(context, onCreateProduct, "Create", 16),
          widgetButton(context, onUpdateProduct, "Update", 16),
          widgetButton(context, onDeleteProduct, "Delete", 16),
        ]),
      ],
    );
  }
}
