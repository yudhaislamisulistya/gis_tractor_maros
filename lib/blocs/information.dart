
import 'package:thesisgisproject/repositories/repository.dart';
class InformationBloc {
  final _repository = Repository();
  get allInformations {
    return _repository.getDataInformations();
  }
}

final informationBloc = new InformationBloc();
