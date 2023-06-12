import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/componints/components.dart';
import 'package:flutter_ecomrce_test/modeuls/authsntction_screen/auth_login/login/login_screen.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_state.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  TableRow tableRow = TableRow(children: [
    Padding(
      padding: EdgeInsets.all(10),
      child: Text('الأسم'),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text('الفون'),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text('الايميل'),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text('البينات'),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayOutCubit()..getUserData(),
      child: BlocConsumer<LayOutCubit, LayoutStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          final cubit = BlocProvider.of<LayOutCubit>(context);
          return Scaffold(
            body: cubit.userModel != null
                ? Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Table(
                            border: TableBorder.all(),
// defaultColumnWidth: FixedColumnWidth(70),
                            children: <TableRow>[
                              tableRow,
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: FittedBox

                                    (fit:BoxFit.scaleDown
                                      ,child: Text(cubit.userModel!.name.toString())),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child:
                                      FittedBox(fit:BoxFit.scaleDown,
                                          child: Text(cubit.userModel!.phone.toString())),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child:
                                      Text(cubit.userModel!.email.toString()),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child:
                                      Text(cubit.userModel!.token.toString()),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      defultButton(
                          color: ColorManager.app,
                          width: 280,
                          onPressed: (){
                            navgiToAndFinsh(context, LoginScreen());

                          },
                          text: "تسجيل خروج",
                          appsize: 15,
                          textcolor: ColorManager.white,
                          fontWeight: FontWeight.bold),
                    ],
                  )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
