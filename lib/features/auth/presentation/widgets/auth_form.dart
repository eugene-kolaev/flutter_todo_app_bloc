import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final String submitLabel;
  final bool isLoading;
  final GlobalKey? submitButtonKey;
  final Future<void> Function(String email, String password) onSubmit;

  const AuthForm({
    super.key,
    required this.submitLabel,
    required this.isLoading,
    required this.onSubmit,
    this.submitButtonKey,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.onSubmit(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enabled: !widget.isLoading,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final v = value?.trim() ?? '';
              if (v.isEmpty) return 'Введите email';
              if (!v.contains('@')) return 'Некорректный email';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            enabled: !widget.isLoading,
            onFieldSubmitted: (_) => _handleSubmit(),
            decoration: InputDecoration(
              labelText: 'Пароль',
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              final v = value ?? '';
              if (v.isEmpty) return 'Введите пароль';
              if (v.length < 6) return 'Минимум 6 символов';
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              key: widget.submitButtonKey,
              onPressed: widget.isLoading ? null : _handleSubmit,
              child: widget.isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : Text(widget.submitLabel),
            ),
          ),
        ],
      ),
    );
  }
}
