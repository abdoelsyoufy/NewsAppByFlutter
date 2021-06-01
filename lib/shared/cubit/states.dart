abstract class NewsStates {}

class InitialAppState extends NewsStates{}
class ChangeBottomNavState extends NewsStates{}
class   BusinessSuccessState extends NewsStates{}
class BusinessErrorState extends NewsStates{
  final String error;
  BusinessErrorState(this.error);
}
class BusinessLoadingState extends NewsStates{}

class   SportsSuccessState extends NewsStates{
   String name;

   SportsSuccessState({final String name})
   {
     this.name = name;
   }
}
class SportsErrorState extends NewsStates{
  final String error;
  SportsErrorState(this.error);
}
class SportsLoadingState extends NewsStates{}

class  ScienceSuccessState extends NewsStates{}
class ScienceErrorState extends NewsStates{
  final String error;
  ScienceErrorState(this.error);
}
class ScienceLoadingState extends NewsStates{}


class   HealthSuccessState extends NewsStates{}
class HealthErrorState extends NewsStates{
  final String error;
 HealthErrorState(this.error);
}
class HealthLoadingState extends NewsStates{}

class  TechnologySuccessState extends NewsStates{}
class TechnologyErrorState extends NewsStates{
  final String error;
  TechnologyErrorState(this.error);
}
class TechnologyLoadingState extends NewsStates{}


class  SearchSuccessState extends NewsStates{}
class SearchErrorState extends NewsStates{
  final String error;
  SearchErrorState(this.error);
}
class  SearchLoadingState extends NewsStates{}


class ChangeAppModeState extends NewsStates{}
