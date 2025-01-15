
import 'package:injectable/injectable.dart';

import '../data/repository/auth_repository_impl.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/use_cases/auth/auth_usecases.dart';
import '../domain/use_cases/auth/login_usecases.dart';
import '../domain/use_cases/auth/register_usercases.dart';
import 'firebase_service.dart';

@module
abstract class AppModule {

  // inicializa el servicio de firebase
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();



  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl();



  @injectable
  AuthUseCases get authUseCases => AuthUseCases(

    login: LogininUseCase(authRepository),
    register: RegisterUseCase(authRepository),


  );


}
