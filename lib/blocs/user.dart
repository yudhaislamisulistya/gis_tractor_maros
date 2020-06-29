import 'package:thesisgisproject/repositories/repository.dart';

class UserBloc{
  final _repository = Repository();

  addDataUser(userData) {
    _repository.addDataUser(userData);
  }

  changeDataUser(docId, userData) {
    _repository.changeDataUser(docId, userData);
  }

}

final userBloc = new UserBloc();