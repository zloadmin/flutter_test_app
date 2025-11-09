import 'package:crud_api/blocs/login_cubit/login_cubit.dart';
import 'package:crud_api/pages/widgets/input_widget.dart';
import 'package:crud_api/pages/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login_cubit/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget ProgressIndicator() {
    return Center(
      // Wrap the CircularProgressIndicator with Center
      child: CircularProgressIndicator(),
    );
  }

  Widget LoginForm(BuildContext context, LoginState loginState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login', style: TextStyle(fontSize: 30)),
          SizedBox(height: 30),
          TextError(text: loginState is LoginFailed ? 'Server Error' : null),
          InputWidget(
            hintText: 'Email',
            controller: _emailController,
            validationError: loginState is LoginValidationError
                ? loginState.getError('email')
                : null,
          ),
          SizedBox(height: 30),
          InputWidget(
            hintText: 'Password',
            controller: _passwordController,
            obscureText: true,
            validationError: loginState is LoginValidationError
                ? loginState.getError('password')
                : null,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().submit(
                _emailController.text,
                _passwordController.text,
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, loginState) {
            if (loginState is LoginLoading) {
              return ProgressIndicator();
            }
            if (loginState is LoginSuccess) {
              // redirect
            }
            return LoginForm(context, loginState);
          },
        ),
      ),
    );
  }
}
