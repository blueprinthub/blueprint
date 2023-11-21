import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/guards/authentication_guard.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({
    required this.onResult,
    super.key,
  });

  final AuthenticationResultFunction onResult;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: _SignUpView(
        onResult: onResult,
      ),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView({
    required this.onResult,
  });

  final AuthenticationResultFunction onResult;

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _showPassword = true;

  bool _repeatShowPassword = true;

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.watch<SignUpCubit>();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccessful) {
                  widget.onResult(result: true);
                } else if (state is SignUpError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.failure.toString()),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlueprintLogo(
                        width: size.width * 0.3,
                        height: size.height * 0.15,
                      ),
                      const SizedBox(height: AppSpacing.xxlg),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _passwordController,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _repeatPasswordController,
                        obscureText: _repeatShowPassword,
                        decoration: InputDecoration(
                          labelText: 'Repeat Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _repeatShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _repeatShowPassword = !_repeatShowPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final repeatPassword = _repeatPasswordController.text;
                          if (password != repeatPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match'),
                              ),
                            );
                            return;
                          }

                          if (email.isNotEmpty && password.isNotEmpty) {
                            signInCubit.signUpWithEmailAndPassword(
                              email,
                              password,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.xlg),
                      const Text("Don't have an account?"),
                      const SizedBox(height: AppSpacing.md),
                      TextButton(
                        child: const Text('Sign In'),
                        onPressed: () => context.router.push(
                          SignInRoute(onResult: widget.onResult),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
