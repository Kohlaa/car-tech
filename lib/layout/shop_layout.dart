import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/bloc/cubit.dart';
import '../modules/bloc/states.dart';

class CarLayout extends StatelessWidget {
  const CarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CarCubit.get(context);
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            // appBar: AppBar(
            //   centerTitle: true,
            //   title: RichText(
            //     text: TextSpan(children: [
            //       // if(TopShopCubit.get(context).currentIndex == 0)
            //       //   const TextSpan(
            //       //   text: 'Your fav products will appear here',
            //       //   style: TextStyle(
            //       //       fontSize: 20,
            //       //       //fontWeight: FontWeight.w900,
            //       //       color: Colors.deepOrange,
            //       //       ),
            //       // ),
            //       // if(TopShopCubit.get(context).currentIndex != 0)
            //       TextSpan(
            //         text: 'farZa',
            //         style: GoogleFonts.aBeeZee(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: const Color(0xFFFFFFFF),
            //             shadows: [
            //               const BoxShadow(
            //                 color: Colors.blue,
            //                 blurRadius: 10,
            //                 spreadRadius: 100,
            //               )
            //             ]),
            //       ),
            //     ]),
            //   ),
            // ),
            body: SafeArea(child: cubit.screens[cubit.currentIndex]),
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: cubit.currentIndex,
              showElevation: true,
              containerHeight: 60,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              iconSize: 30,
              onItemSelected: (index) => cubit.changeBot(index),
              items: cubit.tabs,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        );
      },
    );
  }
}
// ResponsiveNavigationBar(
// selectedIndex: cubit.currentIndex,
// onTabChange: (index) {
// cubit.changeBot(index);
// },
// navigationBarButtons: cubit.tabs,
// backgroundGradient: gradient,
// inactiveIconColor: Colors.blue,
// textStyle: const TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// ),
// )