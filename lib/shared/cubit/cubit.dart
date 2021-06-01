import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/setting/business_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/technology/technology_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/shared_preferences.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
 NewsCubit() : super(InitialAppState());

  int currentIndex = 0;
  static const String BUSINESS_TITLE = 'Business' ;
   static const String SPORTS_TITLE = 'Sports' ;
  static const  String SCIENCE_TITLE = 'Science' ;
  static const  String SETTING_TITLE = 'Setting' ;
  static const  String  TECHNOLOGY_TITLE = 'Technology' ;
  static const  String  HEALTH_TITLE = 'Health' ;

  List<BottomNavigationBarItem> bottomItems = [
   BottomNavigationBarItem(
    label: BUSINESS_TITLE,
    icon: Icon(
     Icons.business
    ),
   ),
   BottomNavigationBarItem(
    label: SPORTS_TITLE,
    icon: Icon(
     Icons.sports_baseball_outlined
    ),
   ),
   BottomNavigationBarItem(
    label: SCIENCE_TITLE,
    icon: Icon(
     Icons.science_outlined
    ),
   ),
   BottomNavigationBarItem(
    label: TECHNOLOGY_TITLE,
    icon: Icon(
        Icons.computer
    ),
   ),
   BottomNavigationBarItem(
    label: HEALTH_TITLE,
    icon: Icon(
        Icons.healing_outlined
    ),
   ),
   // BottomNavigationBarItem(
   //  label: SETTING_TITLE,
   //  icon: Icon(
   //   Icons.settings
   //  ),
   // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
   SportsScreen(),
   ScienceScreen(),
   TechnologyScreen(),
   HealthScreen(),
   //SettingScreen(),
  ];

  static NewsCubit getInstance(context)=>BlocProvider.of(context);

  void changeBottomNavIndex(int index)
  {
   this.currentIndex = index;
   switch(index)
   {
    case 0: getBusinessNews(); break;
    case 1: getSportsNews(); break;
    case 2: getScienceNews(); break;
    case 3: getTechnologyNews(); break;
    case 4: getHealthNews(); break;

   }
   emit(ChangeBottomNavState());
  }

  List businessList = [];

  void getBusinessNews()
  {
   emit(BusinessLoadingState());
   DioHelper.getDate(
       path:  'v2/top-headlines',
       condition: {
        'country':'eg',
        'category':'business',
        'apiKey': 'c6686e2a8a044b7e8a57576fe80dbe0d'
       }).then((value) {
        businessList = value.data['articles'];
       print('Values   ${businessList.length}');
       emit(BusinessSuccessState());
   }).catchError((error){
    print("ERROR "+error.toString());
    emit(BusinessErrorState(error.toString()));
   });
  }

 List sportsList = [];

 void getSportsNews()
 {
  if(sportsList.length==0)
  {
   emit(SportsLoadingState());
   DioHelper.getDate(

       path:  'v2/top-headlines',
       condition: {
        'country':'eg',
        'category':'sports',
        'apiKey': 'c6686e2a8a044b7e8a57576fe80dbe0d'
       }).then((value) {
    sportsList = value.data['articles'];
    print('Values   ${sportsList.length}');
    emit(SportsSuccessState());
   }).catchError((error) {
    print("ERROR " + error.toString());
    emit(SportsErrorState(error.toString()));
   });
  }
  else
   {
    emit(SportsSuccessState());
   }

 }

 List scienceList = [];

 void getScienceNews()
 {
  emit(ScienceLoadingState());
  if(scienceList.length==0) {
   DioHelper.getDate(

       path: 'v2/top-headlines',
       condition: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'c6686e2a8a044b7e8a57576fe80dbe0d'
       }).then((value) {
    scienceList = value.data['articles'];
    print('Values   ${scienceList.length}');
    emit(ScienceSuccessState());
   }).catchError((error) {
    print("ERROR " + error.toString());
    emit(ScienceErrorState(error.toString()));
   });
  }
  else
   {
    emit(ScienceSuccessState());
   }
 }

 List healthList = [];

 void getHealthNews()
 {
  emit(HealthLoadingState());
  if(healthList.length==0) {
   DioHelper.getDate(

       path: 'v2/top-headlines',
       condition: {
        'country': 'eg',
        'category': 'health',
        'apiKey': 'c6686e2a8a044b7e8a57576fe80dbe0d'
       }).then((value) {
    healthList = value.data['articles'];
    print('Values   ${healthList.length}');
    emit(HealthSuccessState());
   }).catchError((error) {
    print("ERROR " + error.toString());
    emit(HealthErrorState(error.toString()));
   });
  }
  else
  {
   emit(ScienceSuccessState());
  }
 }

 List technologyList = [];

 void getTechnologyNews()
 {
  emit(TechnologyLoadingState());
  if(technologyList.length==0) {
   DioHelper.getDate(

       path: 'v2/top-headlines',
       condition: {
        'country': 'eg',
        'category': 'technology',
        'apiKey': 'c6686e2a8a044b7e8a57576fe80dbe0d'
       }).then((value) {
    technologyList = value.data['articles'];
    print('Values   ${technologyList.length}');
    emit(TechnologySuccessState());
   }).catchError((error) {
    print("ERROR " + error.toString());
    emit(TechnologyErrorState(error.toString()));
   });
  }
  else
  {
   emit(ScienceSuccessState());
  }
 }

 bool isDark = false;


  void changeAppMode({bool isDarkValue})
  {

   if(isDarkValue==null)
    isDark = !isDark;
    else
     isDark = isDarkValue;
    CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
     emit(ChangeAppModeState());
    });

  }
 void call()
 {
  getBusinessNews();
  getSportsNews();
  getScienceNews();
 }


 List searchList = [];

 void searchNews(value)
 {
  emit(SearchLoadingState());

   DioHelper.getDate(

       path: 'v2/everything',
       condition: {
        'q':'$value',
        'apiKey': 'c6686e2a8a044b7e8a57576fe80dbe0d'
       }).then((value) {
   searchList = value.data['articles'];
    print('Values   ${searchList.length}');
    emit(SearchSuccessState());
   }).catchError((error) {
    print("ERROR " + error.toString());
    emit(SearchErrorState(error.toString()));
   });



 }
}