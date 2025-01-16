import '../models/colaborador_data.dart';
import '../utils/resource.dart';

abstract class ColaboradorRepository {

  Future<Resource> colaboradorRegister(ColaboradorData colaborador);

}