import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/widgets/custom_loading_indicator.dart';
import 'package:health_assistant/presentation/controllers/auth/auth_cubit.dart';

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
        if(state is AuthLoading){
          showDialog(
            context: context, 
            builder: (context) => const CustomLoadingIndicator()
          );
        } else if (state is AuthSuccess){
          showSuccessDialog(context, 'Signup Successful', 'Congratulations, you have signed up successfully!');
        } else if(state is AuthFailure){
          setupErrorState(context, state.error);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

      dynamic showSuccessDialog(BuildContext context, String sucessMessage, String message ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(sucessMessage),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorsManager.mainColor,
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text('Continue'),
              )
            ],
          );
        }
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