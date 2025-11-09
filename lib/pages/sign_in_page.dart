import 'package:crud_api/blocs/sign_in_cubit/sign_in_cubit.dart';
import 'package:crud_api/pages/widgets/input_widget.dart';
import 'package:crud_api/pages/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/sign_in_cubit/sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget ProgressIndicator() {
    return Center(
      // Wrap the CircularProgressIndicator with Center
      child: CircularProgressIndicator(),
    );
  }

  Widget SignInForm(BuildContext context, SignInState signInState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('SignIn', style: TextStyle(fontSize: 30)),
          SizedBox(height: 30),
          TextError(text: signInState is SignInFailed ? 'Server Error' : null),
          InputWidget(
            hintText: 'Email',
            controller: _emailController,
            validationError: signInState is SignInValidationError
                ? signInState.getError('email')
                : null,
          ),
          SizedBox(height: 30),
          InputWidget(
            hintText: 'Password',
            controller: _passwordController,
            obscureText: true,
            validationError: signInState is SignInValidationError
                ? signInState.getError('password')
                : null,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              context.read<SignInCubit>().submit(
                _emailController.text,
                _passwordController.text,
              );
            },
            child: const Text('SignIn'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: Scaffold(
        body: BlocBuilder<SignInCubit, SignInState>(
          builder: (context, signInState) {
            if (signInState is SignInLoading) {
              return ProgressIndicator();
            }
            if (signInState is SignInSuccess) {
              // redirect
            }
            return SignInForm(context, signInState);
          },
        ),
      ),
    );
  }
}
