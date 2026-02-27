import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_history.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory getHistory;

  HistoryCubit(this.getHistory) : super(HistoryInitial());

Future<void> loadHistory(String userId) async {
  emit(HistoryLoading());

  try{
    final history = await getHistory(userId);
    emit(HistoryLoaded(history));

  }
  catch(e){
    emit(HistoryError(e.toString()));
  }
}}