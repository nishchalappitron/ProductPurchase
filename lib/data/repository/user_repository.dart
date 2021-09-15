import 'package:injectable/injectable.dart';
import 'package:interview_testing/data/model/data_listing.dart';
import 'package:interview_testing/data/network/result.dart';
import 'package:interview_testing/data/repository/base/base_repository.dart';
import 'package:interview_testing/data/service/data_service.dart';

@lazySingleton
class DataRepository extends BaseRepository {

  Future<Result<List<DataItem>>> getCategoryWiseData() async =>
      safeCall(DataService(await dio).getCategoryWiseData());
}
