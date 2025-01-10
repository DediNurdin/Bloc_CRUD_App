import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_form_field_widget.dart';
import '../../../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Utils.isDarkMode(context)
        ? ThemeUtils.darkTheme(false)
        : ThemeUtils.lightTheme(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Utils.showToast('Login Successful');
            Navigator.pushReplacementNamed(context, '/bottomnav');
          } else if (state is LoginFailure) {
            Utils.showToast(state.error);
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return main(true);
          }
          return main(false);
        },
      ),
    );
  }

  Widget main(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Text('Welcome Back!',
                style: Theme.of(context).textTheme.headlineLarge),
            Text('Login to your account',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              controller: usernameController,
              labelText: 'Username',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              controller: passwordController,
              labelText: 'Password',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            const SizedBox(height: 32),
            botton(isLoading)
          ],
        ),
      ),
    );
  }

  Widget botton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final username = usernameController.text;
            final password = passwordController.text;

            context.read<LoginBloc>().add(
                  SubmitLoginEvent(username: username, password: password),
                );
          }
        },
        child: isLoading ? CupertinoActivityIndicator() : Text('Login'),
      ),
    );
  }
}
