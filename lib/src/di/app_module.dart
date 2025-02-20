
import 'package:injectable/injectable.dart';
import 'package:timbox/src/data/repository/archivo_repository_impl.dart';
import 'package:timbox/src/domain/repository/archivo_repository.dart';
import 'package:timbox/src/domain/use_cases/archivo/archivo_usescases.dart';

import '../data/repository/auth_repository_impl.dart';
import '../data/repository/colaborador_repository_impl.dart';
import '../data/repository/post_repository_impl.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/colaborador_repository.dart';
import '../domain/repository/post_repository.dart';
import '../domain/use_cases/archivo/obtener_archivo_usecase.dart';
import '../domain/use_cases/archivo/subir_archivo_usecases.dart';
import '../domain/use_cases/auth/auth_usecases.dart';
import '../domain/use_cases/auth/login_usecases.dart';
import '../domain/use_cases/auth/lost_pasword_usecases.dart';
import '../domain/use_cases/auth/register_usercases.dart';
import '../domain/use_cases/auth/update_password_usecase.dart';
import '../domain/use_cases/colaborador/colaborador_usecases.dart';
import '../domain/use_cases/colaborador/delete_colaborador_usecase.dart';
import '../domain/use_cases/colaborador/get_colaborador_usecase.dart';
import '../domain/use_cases/colaborador/registerColaborador_usecase.dart';
import '../domain/use_cases/colaborador/update_colaborador_usecase.dart';
import '../domain/use_cases/post/add_post_usecase.dart';
import '../domain/use_cases/post/delte_post_usecase.dart';
import '../domain/use_cases/post/fetchPost_usecase.dart';
import '../domain/use_cases/post/post_usecases.dart';
import '../domain/use_cases/post/update_post_usecase.dart';
import 'firebase_service.dart';

@module
abstract class AppModule {

  // inicializa el servicio de firebase
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();



  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl();

  @injectable
  ArchivoRepository get archivoRepository => ArchivoRepositoryImpl();

  @injectable
  ColaboradorRepository get colaboradorRepository => ColaboradorRepositoryImpl();

  @injectable
  PostRepository get postRepository => PostRepositoryImpl();



  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LogininUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    lostPassword: LostPasswordUseCase(authRepository),
    updatePassword: UpdatePasswordUseCase(authRepository)
  );

  @injectable
  ArchivoUseCases get archivoUseCases => ArchivoUseCases(
      subirArchivo: SubirArchivoUseCase(archivoRepository),
      obtenerArchivo: ObtenerArchivoUseCase(archivoRepository)
  );

  @injectable
  ColaboradorUseCases get colaboradorUseCases => ColaboradorUseCases(
    registerColaborador: RegisterColaboradorUseCase(colaboradorRepository),
    updateColaborador: UpdateColaboradorUseCase(colaboradorRepository),
    deleteColaborador: DeleteColaboradorUseCase(colaboradorRepository),
    getColaborador: GetColaboradorUseCase(colaboradorRepository)
  );


  @injectable
  PostUseCases get postUseCases => PostUseCases(
      fetchPos: FetchPostUseCase(postRepository),
      deletePost: DeletePostUseCase(postRepository),
      updatePost: UpdatePostUseCase(postRepository),
      addPost: AddPostUseCase(postRepository)
  );

}
