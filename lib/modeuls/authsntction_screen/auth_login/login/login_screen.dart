import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/componints/components.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_cubit/auth_stuts.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_login/regster/regster_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/bottom_screen/Bottom_screen.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final conterolemail = TextEditingController();

  final conterolpassword = TextEditingController();

  final formkey = GlobalKey<FormState>();

   bool isEye=true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (BuildContext context, state) {
            if(state is LoginSuccessState){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottomScreen()));
            }else if(state is LoginFailedState){
              showDialog(context: context, builder:(context) =>
                AlertDialog(
                  content:Text(state.message,
                  style: TextStyle(
                    color: ColorManager.white
                  ),) ,
                  backgroundColor: ColorManager.erorr,

                ),);
            }
          },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              body: Form(
                key: formkey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 55),
                        child: Image.asset('assets/login.png'),
                      ),

                      //name

                      //email
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defultTextFormFild(
                          context,
                          controller: conterolemail,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'pleas meeil';
                            }
                          },
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      //phone
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defultTextFormFild(
                          context,
                          controller: conterolpassword,
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'pleas password';
                            }
                          },
                          labelText: 'password',
                          prefixIcon: Icon(Icons.password),
                          obscureText: false,
                        suffixIcon: isEye?IconButton(onPressed: (){
                         setState(() {
                           isEye;
                         });
                        },
                            icon: Icon(Icons.remove_red_eye_outlined)):
                        IconButton(onPressed: (){
                          setState(() {
                            isEye;
                          });
                        },
                            icon: Icon(Icons.visibility_off))

                        ),
                      ),
                      //countercode


                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: defultButton(
                              color: ColorManager.gryn,
                              width: double.infinity,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).login(

                                      email: conterolemail.text,

                                      password: conterolpassword.text);
                                }
                              },
                              text: state is LoginLoadingState?"Loading":'login',
                              textcolor: ColorManager.white,
                              appsize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [

                           Text(
                               "forget your Password?",style: TextStyle(
                             color: ColorManager.black,
                             fontWeight: FontWeight.normal,

                           )
                           ),
                           TextButton(

                               child: Text("    Click here",style: TextStyle(
                                   color: ColorManager.gryn,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 15),

                           ), onPressed: () {
                                 navgiTo(context, RegisterScreen());
                           },
                           ),
                         ],
                       ),
                     )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
