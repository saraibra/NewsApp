import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return BlocConsumer<NewsCubit,NewsStates>(listener: (context,state){},
    builder: (context,state){
      List<dynamic> list = NewsCubit.get(context).searchList;
      return  Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: ( value) {
                    if (value.isEmpty) {
                      return 'Search must be not empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  icon: Icons.search),
            ),
            Expanded(child: articleBuilder(list, context,isSearch: true))
          ],
        ),
      );
    },
    );
  }
}
