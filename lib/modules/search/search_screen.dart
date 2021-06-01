import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.getInstance(context);
        TextStyle darkStyle = TextStyle(color: Colors.white);
        TextStyle lightStyle = TextStyle(color: Colors.black);
        var articles =cubit.searchList;
        return  Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [

                 Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      prefixIcon:Icon(Icons.search,color: cubit.isDark? Colors.white:Colors.black,),
                      labelStyle: cubit.isDark?darkStyle:lightStyle,

                    ),
                      onChanged: (value){
                        NewsCubit.getInstance(context).searchNews(value);
                      },
                    keyboardType: TextInputType.text,
                    style: cubit.isDark?darkStyle:lightStyle,

                    // style: NewsCubit().isDark==false?TextStyle(color: Colors.white,fontSize: 18):TextStyle(color: Colors.black,fontSize: 18),



                  ),
                ),
                 //state is! SearchErrorState?
                 Expanded(child: articlesBuilder(articles, NewsCubit.getInstance(context).isDark))
                 // Center(
                 //       child: Text('Not Found',style: cubit.isDark?darkStyle:lightStyle,),
                 //     ),
              ],
            )
        );
      },
    );
  }
}
