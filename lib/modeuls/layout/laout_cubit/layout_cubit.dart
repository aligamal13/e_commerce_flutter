
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecomrce_test/models/banners.dart';
import 'package:flutter_ecomrce_test/models/category.dart';
import 'package:flutter_ecomrce_test/models/product_model.dart';
import 'package:flutter_ecomrce_test/models/user_model.dart';
import 'package:flutter_ecomrce_test/modeuls/cart_screen/cart_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/catgory_screen/catgory_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/favorit_screen/favorit_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/home_screen/hom_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_state.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/profile_screen.dart';
import 'package:flutter_ecomrce_test/shird/constint/constint.dart';
import 'package:http/http.dart'as http;
class LayOutCubit extends Cubit<LayoutStates>{

  LayOutCubit(): super(LayoutInitialStates());
  int bottomNavIndex = 0 ;
  List<Widget> layoutScreens = [HomeScreen() , CatgoryScreen(), FavoritScreen(), CartScreen(), ProfileScreen()];
  void changeBottomNavIndex({required int index})
  {
    bottomNavIndex = index;
    // Emit state
    emit(GetUserDataSuccessStates());
  }
  UserModel? userModel;
  void getUserData()async{
    emit(GetUserDataLoadingStates());
 http.Response response= await  http.get(
      Uri.parse('https://student.valuxapps.com/api/profile'),
      headers: {
        'Authorization':token!,

      }
    );
 var responData=jsonDecode(response.body);
 if(responData['status']==true)
   {
 userModel =UserModel.fromJson(data: responData['data']);
 emit(GetUserDataSuccessStates());
   }
 else{
   emit(GetUserFailedStates(error: "error"));
 }
  }

//banner
  List<BannerModel> banners = [];
  void getBannersData() async {
    http.Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/banners")
    );
    final responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data'] )
      {
        banners.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannersSuccessState());
    }
    else
    {
      emit(FailedToGetBannersState());
    }
  }



  //catgorys



  List<CategoryModel> catgorys = [];
  void getcatgorysData() async {
    http.Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories")
    );
    final responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['data'] )
      {
        catgorys.add(CategoryModel.fromJson(data: item));
      }
      emit(GetcatgorysSuccessState());
    }
    else
    {
      emit(FailedToGetcatgorysState());
    }
  }





  //home


  List<ProductModel> homes = [];
  void getHomesData() async {
    http.Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/home")
    );
    final responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['products'] )
      {
        homes.add(ProductModel.fromJson(data: item));
      }
      emit(GetcatgorysSuccessState());
    }
    else
    {
      emit(FailedToGetcatgorysState());
    }
  }



  //search
List<ProductModel>filterProducts=[];

  void getFilterProducts({required String inpout}){
   filterProducts= homes.where((element) => element.name!.toLowerCase().startsWith(inpout.toLowerCase())).toList();
    emit(FilterProductState());


}




  List<ProductModel> favorites = [];
  // set مفيش تكرار
  Set<String> favoritesID = {};
  Future<void> getFavorites() async {
    favorites.clear();
    http.Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          "lang" : "en",
          "Authorization" : token!
        }
    );
    // http
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      // loop list
      for( var item in responseBody['data']['data'] )
      {
        // Refactoring
        favorites.add(ProductModel.fromJson(data: item['product']));
        favoritesID.add(item['product']['id'].toString());
      }
      print("Favorites number is : ${favorites.length}");
      emit(GetFavoritesSuccessState());
    }
    else
    {
      emit(FailedToGetFavoritesState());
    }
  }



  //remove


  void addOrRemoveFromFavorites({required String productID}) async {
    http.Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          "lang" : "ar",
          "Authorization" : token!
        },
        body:
        {
          "product_id" : productID
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      if( favoritesID.contains(productID) == true )
      {
        // delete
        favoritesID.remove(productID);
      }
      else
      {
        // add
        favoritesID.add(productID);
      }
      await getFavorites();
      emit(AddOrRemoveItemFromFavoritesSuccessState());
    }
    else
    {
      emit(FailedToAddOrRemoveItemFromFavoritesState());
    }
  }


  List<ProductModel>carts=[];
  Set<String>cartID={};
int totalPrice=0;
Future<void> getCarts()async{
  carts.clear();
http.Response response=  await  http.get(
      Uri.parse("https://student.valuxapps.com/api/carts"),
      headers: {
        "Authorization":token!,
        "lang":"en",
      }
    );
var responseBody=jsonDecode(response.body);
   totalPrice=responseBody['data']['total'].toInt();
  if (responseBody["status"]==true){
    for(var item in responseBody['data']['cart_items']){
      cartID.add(item['product']['id'].toString());
      carts.add(ProductModel.fromJson(data: item['product']));
    }
emit(GetCartsSuccessState());
  }
  else{
    emit(FailedToGetCartsState());
  }
}


void AddOrRemoveProductFromCard({required String id})async{
   http.Response response= await http.post(
Uri.parse("https://student.valuxapps.com/api/carts"),
  body:{
  "product_id":id
  },
  headers: {
  "Authorization":token!,
    "Lang":"en"
  }

);
   var responseBody=jsonDecode(response.body);
   if(responseBody['status']==true){

     cartID.contains(id)==true? cartID.remove(id):cartID.add(id);
    await getCarts();
       emit(AddToCartsSuccessState());
   }
   else{
     emit(FailedAddToCartsState());

   }
}

}