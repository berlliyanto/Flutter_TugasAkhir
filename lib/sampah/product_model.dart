List<ProductModel> productFromJson(dynamic str) => List<ProductModel>.from((str).map((x)=>ProductModel.fromJSON(x)));


class ProductModel {
  late String? id;
  late String? productName;
  late String? productImage;
  late int? productPrice;

  ProductModel(
    {this.id, this.productName, this.productImage, this.productPrice}
  );

  ProductModel.fromJSON(Map<String, dynamic> json){
    id = json["_id"];
    productName = json["productName"];
    productImage = json["productImage"];
    productPrice = json["productPrice"];
  }

  Map<String , dynamic> toJson(){
    final data = <String, dynamic>{};

    data["_id"] = id;
    data["productName"] = productName;
    data["productImage"] = productImage;
    data["productPrice"] = productPrice;
    
    return data;
  }
}