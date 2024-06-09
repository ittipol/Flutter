import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/request/user_register_request.dart';
import 'package:flutter_demo/domain/entities/register/user_register_entity.dart';
import 'package:flutter_demo/domain/repositories/user_register_repository.dart';
import 'package:flutter_demo/presentation/views/user/user_register/user_register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRegisterController extends StateNotifier<UserRegisterState> {

  final UserRegisterRepository userRegisterRepository;

  UserRegisterController({
    required this.userRegisterRepository
  }) : super(UserRegisterState()); 

  Future<Result<UserRegisterEntity>> register({required String email, required String password, required String name}) async {

    // final cancelToken = CancelToken();
    final request = UserRegisterRequest(
      email: email,
      password: password,
      name: name
    );

    var result = await userRegisterRepository.register(request);

    await Future.delayed(const Duration(milliseconds: 1000));

    return result;
  }

}