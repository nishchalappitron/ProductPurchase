import 'package:dio/dio.dart';
import 'package:interview_testing/data/model/data_listing.dart';
import 'package:retrofit/retrofit.dart';

part 'data_service.g.dart';

@RestApi()
abstract class DataService {
  factory DataService(Dio dio) = _DataService;

  @GET("/5dfccffc310000efc8d2c1ad")
  Future<List<DataItem>> getCategoryWiseData();

}
