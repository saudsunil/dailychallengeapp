import '../../domain/entities/history.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_datasource.dart';
import '../models/history_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remote;

  HistoryRepositoryImpl(this.remote);

  @override
  Future<List<History>> getHistory(String userId) async {
    final data = await remote.getHistory(userId);

    return data
        .map((json) => HistoryModel.fromJson(json))
        .toList();
  }
}