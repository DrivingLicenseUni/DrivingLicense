import 'package:license/data/remote/signin_data.dart';

class LoginData {
  String email;
  String password;

  final RemoteDataSource _dataSource = RemoteDataSource();

  Future<void> login(String email, String password) async {
    await _dataSource.login(email, password);
  }

  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  LoginData({required this.email, required this.password});
}
