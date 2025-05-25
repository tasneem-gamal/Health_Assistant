import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/widgets/custom_loading_indicator.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';
import 'package:health_assistant/presentation/view/screens/auth/login/login_view.dart';

class SignupBlocListner extends StatelessWidget {
  const SignupBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthLoading ||
          current is AuthSuccess ||
          current is AuthFailure,
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomLoadingIndicator(),
          ); 
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signup Successful!'),
            ),
          );
          final navigator = Navigator.of(context);
          Future.delayed(const Duration(seconds: 2), () {
            navigator.pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginView()),
            );
          });
        } else if (state is AuthFailure) {
          setupErrorState(context, state.error);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

      void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: CustomTextStyles.font12BlackMedium(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: CustomTextStyles.font12BlackMedium(context),
            ),
          ),
        ],
      ),
    );
  }
}