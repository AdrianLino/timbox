import 'package:timbox/src/domain/use_cases/colaborador/registerColaborador_usecase.dart';
import 'package:timbox/src/domain/use_cases/colaborador/update_colaborador_usecase.dart';

import 'delete_colaborador_usecase.dart';
import 'get_colaborador_usecase.dart';

class ColaboradorUseCases {

  RegisterColaboradorUseCase registerColaborador;
  UpdateColaboradorUseCase updateColaborador;
  DeleteColaboradorUseCase deleteColaborador;
  GetColaboradorUseCase getColaborador;


  ColaboradorUseCases({
    required this.getColaborador,
    required this.deleteColaborador,
    required this.updateColaborador,
    required this.registerColaborador
  });


}