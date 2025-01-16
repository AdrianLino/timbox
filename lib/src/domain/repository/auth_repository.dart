import '../models/personas_data.dart';
import '../utils/resource.dart';

abstract class AuthRepository {

  Future<Resource> login( String email, String password);
  Future<Resource> register(PersonasData user);
  Future<bool> lostPassword(String email, String rfc);
  Future<bool> updatePassword(String correo, String rfc, String nuevaPassword);
}