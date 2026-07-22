import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/session_provider.dart';
import '../widgets/big_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _asAdmin = false;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    await context.read<SessionProvider>().login(
          _nameController.text.trim(),
          _emailController.text.trim(),
          isAdmin: _asAdmin,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로컬 로그인')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '서버 연동 없이 이 기기에 로컬로 저장되는 간단한 계정입니다.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: '이름', border: OutlineInputBorder()),
                    validator: (v) => (v == null || v.trim().isEmpty) ? '이름을 입력해 주세요' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '이메일을 입력해 주세요';
                      if (!v.contains('@')) return '올바른 이메일 형식이 아닙니다';
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: _asAdmin,
                    onChanged: (v) => setState(() => _asAdmin = v ?? false),
                    title: const Text('관리자 계정으로 로그인'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 24),
                  _submitting
                      ? const CircularProgressIndicator()
                      : BigButton(label: '로그인', icon: Icons.check, onPressed: _submit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
