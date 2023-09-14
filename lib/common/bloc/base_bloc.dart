import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';


abstract class BaseBloc<T, R> extends Bloc<T, R> {
  BaseBloc(initialState) : super(initialState);

  void handleNetworkError(
    final DioError exception,
    Emitter<BaseState> emit,
  ) {
    if (exception.response?.statusCode == 401) {
      return emit(
        UnauthenticatedError(),
      );
    }
    return;
  }
}
