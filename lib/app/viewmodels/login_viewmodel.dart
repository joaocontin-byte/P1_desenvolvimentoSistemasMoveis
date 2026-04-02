import 'package:flutter/material.dart';
import '../data/usuario_mock_store.dart';
import '../models/usuario_model.dart';

class LoginViewModel extends ChangeNotifier {
  final UsuarioMockStore _store = UsuarioMockStore();

  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _senhaVisivel = false;
  bool get senhaVisivel => _senhaVisivel;

  bool _carregando = false;
  bool get carregando => _carregando;

  void toggleSenhaVisivel() {
    _senhaVisivel = !_senhaVisivel;
    notifyListeners();
  }

  void setCarregando(bool valor) {
    _carregando = valor;
    notifyListeners();
  }

  String? validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o e-mail';
    if (!value.contains('@')) return 'E-mail inválido';
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 6) return 'Senha deve ter ao menos 6 caracteres';
    return null;
  }

  /// Tenta fazer uma autenticar do usuário.
  /// Vai retornar o [UsuarioModel] se der certo ou null se der inválido inválido.
  UsuarioModel? login() {
    return _store.autenticar(
      emailController.text.trim(),
      senhaController.text,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}
