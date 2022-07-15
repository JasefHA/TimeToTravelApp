part of 'usuario_cubit.dart';

@immutable
abstract class UsuarioState {
  get nombre => null;

  get email => null;
}

class UsuarioInitial extends UsuarioState {
  final existeUsuario = false;
}

class UsuarioActivo extends UsuarioState {
  final existeUsuario = true;
  final UserModel usuario;

  UsuarioActivo(this.usuario);
}
