import 'package:crud_api/blocs/auth/sign_in_cubit/sign_in_cubit.dart';
import 'package:crud_api/blocs/form/cubit_form_state.dart';
import 'package:crud_api/pages/auth/sign_up_page.dart';
import 'package:crud_api/pages/widgets/input_widget.dart';
import 'package:crud_api/pages/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: Scaffold(
        body: BlocBuilder<SignInCubit, CubitFormState>(
          builder: (context, state) {
            if (state.isLoading()) {
              return progressIndicator();
            }

            return signInForm(context, state);
          },
        ),
      ),
    );
  }

  Widget progressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget signInForm(BuildContext context, CubitFormState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign in', style: TextStyle(fontSize: 30)),
          SizedBox(height: 30),
          TextError(text: state.getFailedError()),
          InputWidget(
            hintText: 'Email',
            controller: _emailController,
            validationError: state.getError('email'),
          ),
          SizedBox(height: 30),
          InputWidget(
            hintText: 'Password',
            controller: _passwordController,
            obscureText: true,
            validationError: state.getError('password'),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              context.read<SignInCubit>().submit(
                _emailController.text,
                _passwordController.text,
              );
            },
            child: const Text('Sign in'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            style: ButtonStyle(),
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
