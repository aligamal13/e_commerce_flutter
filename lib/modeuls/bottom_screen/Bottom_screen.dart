import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_cubit.dart';
import 'package:flutter_ecomrce_test/modeuls/layout/laout_cubit/layout_state.dart';
import 'package:flutter_ecomrce_test/recources/color_managr.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayOutCubit>(context);
    return BlocConsumer<LayOutCubit,LayoutStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.appsplash,
            elevation: 0,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomNavIndex,
            selectedItemColor: ColorManager.app,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index)
            {
              cubit.changeBottomNavIndex(index: index);
            },
            items:
            const
            [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
            ],
          ),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}