import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class  NewsLayout extends StatelessWidget {
  //https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=c6686e2a8a044b7e8a57576fe80dbe0d
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.getInstance(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
                'NewsApp'
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                  },),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                 NewsCubit.getInstance(context).changeAppMode();
                },),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            onTap: (value) {
              cubit.changeBottomNavIndex(value);
            },
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
      listener: (context, state) {

      },
    );
  }
}
