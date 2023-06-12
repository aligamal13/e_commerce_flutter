
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_state.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayOutCubit>(context);
    return Scaffold(
        body: BlocConsumer<LayOutCubit,LayoutStates>(
            listener:(context,state){},
            builder:(context,state){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                child: Column(
                  children:
                  [
                    Expanded(
                        child: cubit.carts.isNotEmpty ?
                        ListView.separated(
                            itemCount: cubit.carts.length,
                            separatorBuilder: (context,index){
                              return SizedBox(height: 12,);
                            },
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorManager.appsplash
                                ),
                                child: Row(
                                  children:
                                  [
                                    Image.network(cubit.carts[index].image!,height: 100,width: 100,fit: BoxFit.fill,),
                                    SizedBox(width: 12.5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:
                                        [
                                          Text(cubit.carts[index].name!,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                          SizedBox(height: 5,),
                                          Row(
                                            children:
                                            [
                                              Text("${cubit.carts[index].price!} \$",style: TextStyle(color: ColorManager.white),),
                                              SizedBox(width: 5,),

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:
                                            [
                                              OutlinedButton(
                                                  onPressed: ()
                                                  {
                                                    cubit.addOrRemoveFromFavorites(productID: cubit.carts[index].id.toString());
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: cubit.favoritesID.contains(cubit.carts[index].id.toString()) ? Colors.red : Colors.grey,
                                                  )
                                              ),
                                              IconButton(
                                                onPressed: (){
                                                  cubit.AddOrRemoveProductFromCard(id: cubit.carts[index].id.toString());
                                                },
                                                icon: Icon(Icons.delete,color: Colors.red,),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        ) :
                        Center(child: Text("Loading....."),)
                    ),
                    Container(
                      child: Text("TotalPrice : ${cubit.totalPrice} \$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                    )
                  ],
                ),
              );
            }
        )
    );
  }
}