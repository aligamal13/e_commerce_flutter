import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/models/category.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';

class CatgoryScreen extends StatelessWidget {
  const CatgoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<CategoryModel>catgoryData=BlocProvider.of<LayOutCubit>(context).catgorys;

    return Scaffold(
      body: GridView.builder(
        itemCount: catgoryData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,

            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
          ), itemBuilder:(context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: ColorManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffBCB6B6),
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  Expanded(child: Image.network(catgoryData[index].url.toString(),fit: BoxFit.fill,)),
                  SizedBox(height: 10,),
                  Text(catgoryData[index].title.toString()),
                ],),
              ),
            );
          },),
    );
  }
}
