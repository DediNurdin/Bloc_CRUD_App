import 'package:bloc_online_store/bloc/user/user_bloc.dart';
import 'package:bloc_online_store/presentation/screens/user/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful')),
            );
            Navigator.pushReplacementNamed(context, '/bottomnav');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: usernameController,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          final username = usernameController.text;
                          final password = passwordController.text;

                          context.read<LoginBloc>().add(
                                SubmitLoginEvent(
                                    username: username, password: password),
                              );
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage(
                                    type: 'Add',
                                  )));
                        },
                        child: Text('Dont have an account? Register here')),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
