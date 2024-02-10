abstract class NewsAppStates{}

class InitState extends NewsAppStates{}

class ChangeNavBar extends NewsAppStates{}

class GetBusinessSuccsessState extends NewsAppStates{}

class GetBusinessErrorState extends NewsAppStates{

  final String error;

  GetBusinessErrorState(this.error);

}

class GetBusinessLoadingState extends NewsAppStates{}

class GetSportsSuccsessState extends NewsAppStates{}

class GetSportsErrorState extends NewsAppStates{

  final String error;

  GetSportsErrorState(this.error);

}

class GetSportsLoadingState extends NewsAppStates{}

class GetScienceSuccsessState extends NewsAppStates{}

class GetScienceErrorState extends NewsAppStates{

  final String error;

  GetScienceErrorState(this.error);

}

class GetScienceLoadingState extends NewsAppStates{}

class GetSearchSuccsessState extends NewsAppStates{}

class GetSearchErrorState extends NewsAppStates{

  final String error;

  GetSearchErrorState(this.error);

}

class GetSearchLoadingState extends NewsAppStates{}

class RefreshIndicatorColor extends NewsAppStates{}

