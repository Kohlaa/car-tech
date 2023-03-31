import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:car_tech/modules/bloc/states.dart';
import 'package:car_tech/modules/layout_screens/screen_one.dart';
import 'package:car_tech/modules/layout_screens/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/components.dart';
import '../../models/login_model.dart';
import '../../models/user_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';


class CarCubit extends Cubit<CarStates> {
  CarCubit() : super(TopShopInitialState());

  static CarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 3;

  IconData icon = Icons.visibility_off;
  bool isVisible = false;

  void visible() {
    isVisible = !isVisible;
    icon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState());
  }
  List<BottomNavyBarItem> tabs = [
    BottomNavyBarItem(
      icon: const Icon(Icons.car_rental),
      title: Text(
        "واحد",
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.car_crash),
      title: Text(
        "اتنين",
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
  ];

  List<Widget> screens = [
    const ScreenOne(),
    const ScreenTwo(),
  ];

  void changeBot(index) {
    emit(ChangeBotNavState());
    currentIndex = index;
    // if (currentIndex == 0) {
    //   getCartItems();
    // }
  }

  void login({
    required String email,
    required String password,
    //dynamic token,
    //required BuildContext? context,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'users/signin',
      data: {
        'email': email,
        'password': password,
        token: CacheHelper.getData(key: "token") ?? '',
      },
    ).then((value) {
      //print(value.data['message']);
      LoginModel loginModel = LoginModel.fromJson(value.data);
      getUserData();
      LoginErrorState(loginModel);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      debugPrint('login error $error');
    });
  }

  UserModel? userModel;

  void getUserData() {
    emit(UserDataLoadingState());
    DioHelper.getData(
      authentication: CacheHelper.getData(key: "token"),
      url: 'users/current-user',
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(UserDataSuccessState(userModel!));
    }).catchError((error) {
      emit(UserDataErrorState());
      debugPrint('get current user error $error'.toString());
    });
  }

}