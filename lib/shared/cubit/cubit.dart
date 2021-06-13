import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/cashe_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> titles = ['Business', 'Sports', 'Science', 'Settings'];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
      print(index);
    } else if (index == 1){
      getSports();
            print(index);

    }
    else if (index == 2) getScience();
    emit(BottomNavBarState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '61435190aa714365b9a7bcb8eedd800f'
    }).then((value) {
      print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '61435190aa714365b9a7bcb8eedd800f'
      }).then((value) {
        print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '61435190aa714365b9a7bcb8eedd800f'
      }).then((value) {
        print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;
  void changeAppMode({bool? sharedValue}) {
    if (sharedValue != null) {
      isDark = sharedValue;
      emit(ChangeAppThemeState());
    } else {
      isDark = !isDark;
      CasheHelper.putData(key: 'isDark', value: isDark)
          .then((value) => emit(ChangeAppThemeState()));
    }
  }

  List<dynamic> searchList = [];
void getSearch(String value){
      emit(NewsGetSearchLoadingState());
    if (searchList.length == 0) {
      DioHelper.getData(url: "v2/everything", query: {
        'q': '$value',
        'apiKey': '61435190aa714365b9a7bcb8eedd800f'
      }).then((value) {
        print(value.data['articles'][0]['title']);
        searchList = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
}
}
