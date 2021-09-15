import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_testing/common/constants/app_utils.dart';
import 'package:interview_testing/data/model/data_listing.dart';
import 'package:interview_testing/data/repository/user_repository.dart';

class CategoryDataEvent {}

class CategoryDataRefreshEvent extends CategoryDataEvent {
  String? email;
  String? type;
  String? code;
  CategoryDataRefreshEvent({this.email, this.type, this.code});
}

class CategoryDataState {}

class CategoryDataInitialState extends CategoryDataState {}

class CategoryDataLoadingState extends CategoryDataState {}

class CategoryDataSuccessState extends CategoryDataState {
  DataItem dataList;
  CategoryDataSuccessState(this.dataList);
}

class CategoryDataErrorState extends CategoryDataState {
  String errorMessage;
  CategoryDataErrorState(this.errorMessage);
}

class CategoryDataBloc extends Bloc<CategoryDataEvent, CategoryDataState> {
  DataRepository dataRepository;
  AppUtils appUtils;

  CategoryDataBloc(this.dataRepository, this.appUtils) : super(CategoryDataInitialState());

  @override
  Stream<CategoryDataState> mapEventToState(CategoryDataEvent event) async* {
    try {
      if(event is CategoryDataRefreshEvent) {
        yield CategoryDataLoadingState();
        var response = await dataRepository.getCategoryWiseData();
        if(response.isSuccess) {
          yield CategoryDataSuccessState(response.data[0]);
        } else {
          yield CategoryDataErrorState(response.error);
        }
      }
    } catch(e, stacktrace) {
      print("$e : $stacktrace");
      yield CategoryDataErrorState(e.toString());
    }
  }

}