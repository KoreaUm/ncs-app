import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/admin_config.dart';
import '../providers/session_provider.dart';
import '../widgets/big_button.dart';
import 'admin/admin_home_screen.dart';
import 'category_selection_screen.dart';
import 'join_by_code_screen.dart';
import 'login_screen.dart';
import 'stats_screen.dart';
import 'wrong_notes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school, size: 96, color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text('NCS 직업기초능력 훈련',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text(
                    session.isLoggedIn
                        ? '${session.currentUser!.name}님, 환영합니다'
                        : session.isGuest
                            ? '게스트 모드로 이용 중입니다'
                            : '10개 영역 직업기초능력을 연습해 보세요',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  BigButton(
                    label: '게스트로 시작하기',
                    icon: Icons.play_arrow,
                    onPressed: () {
                      context.read<SessionProvider>().startGuest();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CategorySelectionScreen()));
                    },
                  ),
                  const SizedBox(height: 16),
                  if (!session.isLoggedIn)
                    BigButton(
                      label: '로그인',
                      icon: Icons.login,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const LoginScreen()));
                      },
                    )
                  else
                    BigButton(
                      label: '문제 풀러 가기',
                      icon: Icons.play_arrow,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const CategorySelectionScreen()));
                      },
                    ),
                  const SizedBox(height: 16),
                  BigButton(
                    label: '코드로 문제 세트 참여',
                    icon: Icons.qr_code,
                    color: Colors.teal,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const JoinByCodeScreen()));
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: BigButton(
                          label: '오답노트',
                          icon: Icons.error_outline,
                          color: Colors.orange,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const WrongNotesScreen()));
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BigButton(
                          label: '통계',
                          icon: Icons.bar_chart,
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const StatsScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextButton.icon(
                    style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
                    onPressed: () => _enterAdminMode(context),
                    icon: const Icon(Icons.admin_panel_settings),
                    label: const Text('관리자 모드 진입'),
                  ),
                  if (session.isLoggedIn || session.isGuest)
                    TextButton(
                      style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
                      onPressed: () => context.read<SessionProvider>().logout(),
                      child: const Text('로그아웃 / 게스트 종료'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enterAdminMode(BuildContext context) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('관리자 코드 입력'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              obscureText: true,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '관리자 코드',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != kAdminAccessCode) {
                  return '코드가 일치하지 않습니다';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                if (formKey.currentState!.validate()) {
                  Navigator.of(dialogContext).pop(true);
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(dialogContext).pop(true);
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );

    if (ok == true && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AdminHomeScreen()),
      );
    }
  }
}
