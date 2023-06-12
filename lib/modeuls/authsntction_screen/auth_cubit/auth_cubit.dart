import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_cubit/auth_stuts.dart';
import 'package:flutter_ecomrce_test/shird/locl_netowerk/locl-netowrk.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthStates> {

  AuthCubit() : super(AuthInitialState());

  void register(
      {required String name, required String email, required String phone, required String password}) async {
    emit(RegisterLoadingState());
    http.Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/register"),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        }
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      //emit(state)
      emit(RegisterSuccessState());
    }
    else {
      //emit(faild)

      emit(RegisterFailedState(message: responseBody["message"]));
    }
  }


  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      http.Response response = await http.post(
          Uri.parse("https://student.valuxapps.com/api/login"),
          body: {

            'email': email,
            'password': password,
          }
      );
      if (response.statusCode == 200) {
        //emit(state)
        {
          var responseData = jsonDecode(response.body);

          if (responseData['status'] == true) {
            //  debugPrint("User Login Success and his Data is :${responseData['data']['token'] }");

           await CachedNetwork.insertToCache(key: "token", value: responseData['data']['token']);

            emit(LoginSuccessState());
          }
          else {
            //emit(faild)
            debugPrint(
                "User Login Success and his Data is :${responseData['message'] }");

            emit(LoginFailedState(message: responseData["message"]));
          }
        }
      }
    } catch (e) {
      emit(LoginFailedState(message: e.toString()));
    }
  }

}