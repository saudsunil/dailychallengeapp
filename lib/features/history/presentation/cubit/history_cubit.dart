import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_history.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory getHistory;

  HistoryCubit(this.getHistory) : super(const HistoryState.initial());

Future<void> loadHistory(String userId) async {
  try{
  emit(const HistoryState.loading());


    final history = await getHistory(userId);
    emit(HistoryState.loaded(history: history));

  }
  catch(e){
    emit(HistoryState.error(e.toString()));
  }
}}