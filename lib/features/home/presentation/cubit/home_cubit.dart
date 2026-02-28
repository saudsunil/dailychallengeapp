import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(const HomeInitial());

  void changeTab(int index){
    emit(HomeTabChanged(index));
  }
}