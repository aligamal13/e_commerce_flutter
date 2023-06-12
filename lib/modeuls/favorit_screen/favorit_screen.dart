import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_state.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayOutCubit>(context);
    return BlocConsumer<LayOutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12.5),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 7.5, horizontal: 12),
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: cubit.favorites.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorManager.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffBCB6B6),

                              offset: Offset(0.0, 1.0), //(x,y)

                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12.5),
                        child: Row(
                          children: [
                            Image.network(
                              cubit.favorites[index].image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.favorites[index].name!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${cubit.favorites[index].price!} \$"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      // add | remove
                                      cubit.addOrRemoveFromFavorites(
                                          productID: cubit.favorites[index].id
                                              .toString());
                                    },
                                    child: Text("Remove"),
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
      },
    );
  }
}
