import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/domain/use_cases/archivo/archivo_usescases.dart';
import 'package:timbox/src/domain/use_cases/colaborador/colaborador_usecases.dart';
import 'package:timbox/src/presentation/pages/auth/register/register_page.dart';
import 'package:timbox/src/presentation/pages/home/carga_archivos/carga_archivos_page.dart';
import 'package:timbox/src/presentation/pages/home/carga_archivos/carga_archivos_viewmodel.dart';
import 'package:timbox/src/presentation/pages/home/colaborador/colaborador_page.dart';
import 'package:timbox/src/presentation/pages/home/colaborador/colaborador_viewmodel.dart';
import 'package:timbox/src/presentation/pages/home/empleados/empleados_page.dart';
import 'package:timbox/src/presentation/pages/home/empleados/empleados_viewmodel.dart';
import 'package:timbox/src/presentation/pages/home/servicios/servicios_page.dart';
import 'package:timbox/src/presentation/pages/utils/auth_guard.dart';
import 'package:timbox/src/presentation/pages/utils/auth_viewmodel.dart';
import 'package:toastification/toastification.dart'; // Importa Toastification
import 'package:timbox/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:timbox/src/presentation/pages/auth/login/login_page.dart';
import 'package:timbox/src/presentation/pages/auth/login/login_viewmodel.dart';
import 'package:timbox/src/presentation/pages/auth/register/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  // Cargar el token al inicio
  final authViewModel = AuthViewModel();
  await authViewModel.loadToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authViewModel),
        ChangeNotifierProvider(create: (context) => LoginViewModel(locator<AuthUseCases>())),
        ChangeNotifierProvider(create: (context) => RegisterViewModel(locator<AuthUseCases>())),
        ChangeNotifierProvider(create: (context) => ArchivosViewModel(locator<ArchivoUseCases>())),
        ChangeNotifierProvider(create: (context) => ColaboradorViewModel(locator<ColaboradorUseCases>())),
        ChangeNotifierProvider(create: (context) => EmpleadosViewmodel(locator<ColaboradorUseCases>())),


      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          return MaterialApp(
            title: 'Timbox',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            // Redirigir según el estado de autenticación
            initialRoute: authViewModel.isLoggedIn ? 'cargaArchivos' : 'login',
            routes: {
              'login': (context) => LoginPage(),
              'register': (context) => RegisterPage(),
              'cargaArchivos': (context) => AuthGuard(child: CargaArchivosPage()),
              'colaborador': (context) => AuthGuard(child: ColaboradorPage()),
              'empleados': (context) => AuthGuard(child: EmpleadosPage()),
              'servicios': (context) => AuthGuard(child: ServiciosPage()),
            },
          );
        },
      ),
    );
  }
}
