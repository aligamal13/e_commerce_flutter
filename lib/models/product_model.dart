class ProductModel{

  String?name;
  String? description;
  String ?image;
  int ?price;
  int ?id;

  ProductModel.fromJson({required Map<String,dynamic>data}){

    id=data['id'].toInt();
    description=data['description'].toString();
    image =data['image'].toString();
    name =data['name'].toString();
    price=data['price'].toInt();


  }

}