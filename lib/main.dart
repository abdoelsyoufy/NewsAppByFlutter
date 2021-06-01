import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/shared_preferences.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async{
  // use to exau all async
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.getInstance();
  await CacheHelper.getSharedInstance();
  bool getData = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDarkValue: getData,));

}

class MyApp extends StatelessWidget {
  final bool isDarkValue;
  MyApp( {this.isDarkValue});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => NewsCubit()..changeAppMode(isDarkValue: isDarkValue),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {
        },
        builder: (context, state) => MaterialApp(

          debugShowCheckedModeBanner: false,

          theme:ThemeData(
            primaryColor: Colors.green[800],
            scaffoldBackgroundColor: Colors.white,
            accentColor: Colors.green[800],
            bottomNavigationBarTheme:BottomNavigationBarThemeData(
                selectedItemColor: Colors.green[800],
                elevation: 30,
                type: BottomNavigationBarType.fixed

            ) ,
            appBarTheme: AppBarTheme(
                titleSpacing: 15,
                color: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,

                ),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                )

            ),
            textTheme: TextTheme(
              headline4: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                decorationStyle: TextDecorationStyle.double,

              ),

            ),

          ) ,

           darkTheme: ThemeData(
            primaryColor: Colors.green[800],
            scaffoldBackgroundColor: HexColor('333739'),
            accentColor: Colors.green[800],

            bottomNavigationBarTheme:BottomNavigationBarThemeData(
                selectedItemColor: Colors.green[800],
                elevation: 30,
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey

            ) ,
            appBarTheme: AppBarTheme(
              titleSpacing: 15,
                color: HexColor('333739'),
                elevation: 0.0,
                iconTheme: IconThemeData(
                    color: Colors.white
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,


                ),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                )

            ),
            textTheme: TextTheme(
              headline4: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),

          ),
          themeMode: NewsCubit.getInstance(context).isDark ?ThemeMode.dark:ThemeMode.light,
          home: NewsLayout(),

        ),
      ),
    );
  }
}