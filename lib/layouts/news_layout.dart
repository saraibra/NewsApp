import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              NewsCubit newsCubit = NewsCubit.get(context);
              newsCubit.getBusiness();
              return Scaffold(
                appBar: AppBar(
                  title: Text('News App'),
                  actions: [
                    IconButton(onPressed: () {
                      navigateTo(context,SearchScreen());
                    }, icon: Icon(Icons.search)),
                    IconButton(
                        onPressed: () {
                          NewsCubit.get(context).changeAppMode();
                        }, icon: Icon(Icons.brightness_4)),
                  ],
                ),
                body: newsCubit.screens[newsCubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: newsCubit.bottomItems,
                  currentIndex: newsCubit.currentIndex,
                  onTap: (index) => newsCubit.changeBottomNavBar(index),
                ),
              );
            });
  }
}
