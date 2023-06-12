import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_login/login/login_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_login/regster/regster_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/bottom_screen/Bottom_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/profile_screen.dart';
import 'package:flutter_ecomrce_test/shird/constint/constint.dart';
import 'package:flutter_ecomrce_test/shird/locl_netowerk/locl-netowrk.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await CachedNetwork.cacheInitalization();

token= CachedNetwork.getCacheData(key: "token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => LayOutCubit()..getBannersData()..getcatgorysData()..getHomesData()..getFavorites()..getCarts(),),
      ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: token !=null && token != ""? BottomScreen():LoginScreen()
      ),
    );
  }
}
