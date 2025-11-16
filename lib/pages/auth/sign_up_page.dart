import 'package:crud_api/blocs/form/cubit_form_state.dart';
import 'package:crud_api/pages/auth/sign_in_page.dart';
import 'package:crud_api/pages/widgets/input_widget.dart';
import 'package:crud_api/pages/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_api/blocs/auth/sign_up_cubit/sign_up_cubit.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  Widget ProgressIndicator() {
    return Center(
      // Wrap the CircularProgressIndicator with Center
      child: CircularProgressIndicator(),
    );
  }

  Widget SignUpForm(BuildContext context, CubitFormState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign up', style: TextStyle(fontSize: 30)),
          SizedBox(height: 30),
          TextError(text: state.getFailedError()),
          InputWidget(
            hintText: 'Name',
            controller: _nameController,
            validationError: state.getError('name'),
          ),
          SizedBox(height: 30),
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
          SizedBox(height: 30),
          InputWidget(
            hintText: 'Password confirmation',
            controller: _passwordConfirmationController,
            obscureText: true,
            validationError: state.getError('password_confirmation'),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              context.read<SignUpCubit>().submit(
                _nameController.text,
                _emailController.text,
                _passwordController.text,
                _passwordConfirmationController.text,
              );
            },
            child: const Text('Sign up'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
            child: Text('Sign in'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: Scaffold(
        body: BlocBuilder<SignUpCubit, CubitFormState>(
          builder: (context, state) {
            if (state.isLoading()) {
              return ProgressIndicator();
            }
            // if (SignUpState is SignUpSuccess) {
            //   // redirect
            // }
            return SignUpForm(context, state);
          },
        ),
      ),
    );
  }
}
