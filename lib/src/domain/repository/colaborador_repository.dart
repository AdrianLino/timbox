import '../models/colaborador_data.dart';
import '../utils/resource.dart';

abstract class ColaboradorRepository {

  Future<Resource> colaboradorRegister(ColaboradorData colaborador);

  Future<List<ColaboradorData>> getColaboradores(int idPersona);
  Future<void> updateColaborador(int productoId, ColaboradorData colaborador);
  Future<void> deleteColaborador(int colaboradorId);

}