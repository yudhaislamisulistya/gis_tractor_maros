
import 'package:thesisgisproject/repositories/repository.dart';
class TractorBloc {
  final _repository = Repository();
  get allTractors {
    return _repository.getDataTractors();
  }

  get fiveTractor {
    return _repository.getDataTractorsFiveLimit();
  }
}

final tractorBloc = new TractorBloc();
