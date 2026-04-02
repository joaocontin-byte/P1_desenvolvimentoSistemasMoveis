import 'package:flutter/material.dart';
import '../data/usuario_mock_store.dart';
import '../models/usuario_model.dart';

enum CadastroResultado { sucesso, emailJaExiste }

class SignupViewModel extends ChangeNotifier {
  final UsuarioMockStore _store = UsuarioMockStore();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _senhaVisivel = false;
  bool get senhaVisivel => _senhaVisivel;

  bool _confirmarSenhaVisivel = false;
  bool get confirmarSenhaVisivel => _confirmarSenhaVisivel;

  bool _carregando = false;
  bool get carregando => _carregando;

  void toggleSenhaVisivel() {
    _senhaVisivel = !_senhaVisivel;
    notifyListeners();
  }

  void toggleConfirmarSenhaVisivel() {
    _confirmarSenhaVisivel = !_confirmarSenhaVisivel;
    notifyListeners();
  }

  void setCarregando(bool valor) {
    _carregando = valor;
    notifyListeners();
  }

  String? validarNome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o seu nome';
    if (value.trim().length < 3) return 'Nome muito curto';
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o e-mail';
    if (!value.contains('@') || !value.contains('.')) return 'E-mail inválido';
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  String? validarConfirmarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Confirme a sua senha';
    if (value != senhaController.text) return 'As senhas não coincidem';
    return null;
  }

  /// Tenta fazer um cadastro de um novo usuário.
  /// Retorna [CadastroResultado] mostrando o que aconteceu depois de terminar o processo.
  CadastroResultado cadastrar() {
    if (_store.emailJaCadastrado(emailController.text.trim())) {
      return CadastroResultado.emailJaExiste;
    }

    final novoUsuario = UsuarioModel(
      nome: nomeController.text.trim(),
      email: emailController.text.trim(),
      senha: senhaController.text,
    );

    _store.cadastrar(novoUsuario);
    return CadastroResultado.sucesso;
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }
}
