import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/utils/constants/constants.dart';

part 'sql_state.dart';

class SqlCubit extends Cubit<SqlState> {
  SqlCubit() : super(SqlInitialState());

  static SqlCubit get(context) => BlocProvider.of(context);

  SqlDioHelper sqlDioHelper = SqlDioHelper();

  /// Sql Function
  Future<void> sqlFunction({
    required String user,
    required String password,
    required String server,
    required String database,
    required String syncMethod,
    required String syncTime,
    required bool wantSync,
  }) async {
    emit(SqlLoadingState());
    await sqlDioHelper.postData(endPoint: SQLConstants.sqlUrl, body: {
        "user": "sa",
        "password": "123",
        "server": "DESKTOP-JLL2NO7",
        "database": "newdb",
        "syncMethod": "once",
        "syncTime":"1:13 PM",
        "wantSync": true,
    }).then((response) {
      print(response.data);
      emit(SqlSuccessState());
    }).catchError((error) {
      print(error);
      emit(SqlErrorState());
    });
  }
}
