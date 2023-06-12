import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/componints/components.dart';
import 'package:flutter_ecomrce_test/models/product_model.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_state.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final pageConterol = PageController();
  final conterolrSerch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayOutCubit>(context);

    return BlocConsumer<LayOutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              defultTextFormFild(
                context,
                prefixIcon: Icon(Icons.search),
                labelText: 'search',
                type: TextInputType.text,
                validator: (v) {

                },
                onChanged: (inpout) {
                  cubit.getFilterProducts(inpout: inpout);
                },
                controller: conterolrSerch,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 140,
                  width: double.infinity,
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
                  child: PageView.builder(
                    controller: pageConterol,
                    itemCount: cubit.banners.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        cubit.banners[index].url!,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: pageConterol,
                    count: cubit.banners.length,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 20.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: ColorManager.app),
                  ),
                ),
              ),
              Divider(
                height: 5,
                color: ColorManager.app,
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Categorys",style: TextStyle(color: ColorManager.app,fontSize: 18,fontWeight: FontWeight.bold),),
              ),

              cubit.catgorys.isEmpty
                  ? Center(child: CupertinoActivityIndicator()):  SizedBox(
                  height: MediaQuery.of(context).size.height/4.7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount:
                      cubit.catgorys.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {

                          },
                          child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 140,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:  Radius.circular(10),topLeft:Radius.circular(10),topRight: Radius.circular(10) ),
                                          color: ColorManager.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffBCB6B6),
                                              offset: Offset(0.0, 1.0), //(x,y)
                                              blurRadius: 5.0,
                                            ),
                                          ],

                                        ),clipBehavior: Clip.antiAlias,
                                        child:Column(
                                          children: [
                                            Image.network(
                                                cubit.catgorys[index]
                                                    .url
                                                    .toString(),
                                                fit: BoxFit.fill,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /6,
                                                width:double.infinity,


                                            ),




                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:  Radius.circular(10)),

                                          color: ColorManager.black.withOpacity(.6),

                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                                cubit.catgorys[index]
                                                    .title
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager.white,
                                                    //fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              )
                          ),
                        );
                      },
                    ),
                  ),
                ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Product",style: TextStyle(color: ColorManager.app,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              cubit.homes.isEmpty
                  ? Center(child: CupertinoActivityIndicator())
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.filterProducts.isEmpty?
                            cubit.homes.length:
                          cubit.filterProducts.length,
                            itemBuilder: (context, index) {
                              return widgetProduct(context, productModel: cubit.filterProducts.isEmpty ?
                              cubit.homes[index] :
                              cubit.filterProducts[index],
                                  cubit: cubit);
                            },  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:.62,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 10


                        ),),
                      )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
      },
    );
  }
}



Widget widgetProduct(context,{required ProductModel productModel,required LayOutCubit cubit})=>Stack(
  alignment: Alignment.bottomRight,
  children: [
        Column(

      children: [

        InkWell(

            onTap: () {},

            child: Padding(

              padding: const EdgeInsets.all(4.0),

              child: Container(

                height: 250,

                decoration: BoxDecoration(

                  borderRadius:

                  BorderRadius.circular(12),

                  color: ColorManager.white,

                  boxShadow: const [

                    BoxShadow(

                      color: Color(0xffBCB6B6),

                      offset:

                      Offset(0.0, 1.0), //(x,y)

                      blurRadius: 5.0,

                    ),

                  ],

                ),

                clipBehavior: Clip.antiAlias,

                child: Column(

                  children: [

                    SizedBox(height: 5,),

                    Image.network(

                      productModel.image

                          .toString(),

                      fit: BoxFit.fitWidth,

                      height: MediaQuery.of(context)

                          .size

                          .height /

                          4.5,

                      width: double.infinity,

                    ),

                    Container(

                      width: 140,

                      child: Center(

                        child: Text(

                            productModel

                                .name

                                .toString(),

                            overflow: TextOverflow

                                .ellipsis,

                            maxLines: 1,

                            style: Theme.of(context)

                                .textTheme

                                .bodyLarge!

                                .copyWith(

                                color:

                                ColorManager

                                    .black,

                                //fontSize: 12,

                                fontWeight:

                                FontWeight

                                    .bold)),

                      ),

                    ),

                    Container(

                      width: 140,

                      child: Center(

                        child: Text(

                            productModel

                                .description

                                .toString(),

                            overflow: TextOverflow

                                .ellipsis,

                            maxLines: 1,

                            style: Theme.of(context)

                                .textTheme

                                .bodyLarge!

                                .copyWith(

                                color:

                                ColorManager

                                    .black,

                                //fontSize: 12,

                                fontWeight:

                                FontWeight

                                    .bold)),

                      ),

                    ),

                    Container(

                      width: 140,

                      child: Center(

                        child: FittedBox(

                          fit: BoxFit.scaleDown,

                          child: Text("\$"+

                              productModel

                                  .price

                                  .toString(),

                              overflow: TextOverflow

                                  .ellipsis,

                              maxLines: 1,

                              style: Theme.of(context)

                                  .textTheme

                                  .bodyLarge!

                                  .copyWith(

                                  color:

                                  ColorManager

                                      .black,

                                  //fontSize: 12,

                                  fontWeight:

                                  FontWeight

                                      .bold)),

                        ),

                      ),

                    ),

                    const SizedBox(

                      height: 4,

                    )

                  ],

                ),

              ),

            )),

      ],

    ),
    Positioned(
      bottom: 11,
      right: 5,
      child:  IconButton(
        icon: Icon(
          Icons.favorite,
          size: 20,
          color: cubit.favoritesID.contains(productModel.id.toString())? Colors.red : Colors.grey,
        ),
        onPressed: ()
        {
          // Add | remove product favorites
          cubit.addOrRemoveFromFavorites(productID: productModel.id.toString());
        },
      )
    ),
    Positioned(
      top: 10,
      left: 10,
      child:  CircleAvatar(
        backgroundColor: ColorManager.black,

        child: IconButton(onPressed: (){
          cubit.AddOrRemoveProductFromCard(id: productModel.id.toString());


        },
icon: Icon(Icons.add_shopping_cart_outlined,
color: cubit.cartID.contains(productModel.id.toString())? Colors.red : Colors.white,

)
        ),
      )
    )
  ],
);


