import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layouts/news_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/cashe_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async{
  //Bloc.observer = MyBlocOberver();
  WidgetsFlutterBinding.ensureInitialized(); // this method for making sure that async methods started before runing app
  DioHelper.init();
 await CasheHelper.init();
 bool? isDark = CasheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({Key? key,required this.isDark}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeAppMode(sharedValue: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  appBarTheme: AppBarTheme(
                      titleSpacing: 20,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      titleTextStyle:
                          TextStyle(color: Colors.black, fontSize: 20),
                      iconTheme: IconThemeData(color: Colors.black),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark)),
                  primarySwatch: Colors.deepOrange,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      elevation: 20)),
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                  appBarTheme: AppBarTheme(
                      backgroundColor: HexColor('333739'),
                      elevation: 0,
                      titleSpacing: 20,
                      titleTextStyle:
                          TextStyle(color: Colors.white, fontSize: 20),
                      iconTheme: IconThemeData(color: Colors.white),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333739'),
                          statusBarIconBrightness: Brightness.light)),
                  primarySwatch: Colors.deepOrange,
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: HexColor('333739'),
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20)),
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: NewsLayout(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
