import 'package:thesisgisproject/repositories/repository.dart';

class HistoryBloc{
  final _repository = new Repository();

  addDataHistory(historyData) {
    _repository.addDataHistory(historyData);
  }

  get allHistories{
    return _repository.getDataHistories();
  }

}

final historyBloc = new HistoryBloc();