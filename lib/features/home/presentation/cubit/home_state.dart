abstract class HomeState{
  final int selectedIndex;

  const HomeState(this.selectedIndex);
}

class HomeInitial extends HomeState {
  const HomeInitial(): super(0);
}

class HomeTabChanged extends HomeState {
  const HomeTabChanged(super.selectedIndex);
}