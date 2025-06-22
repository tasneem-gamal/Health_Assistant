import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/core/utils/extensions.dart';
import 'package:health_assistant/core/widgets/custom_loading_indicator.dart';
import 'package:health_assistant/presentation/controllers/auth/update_user_info_cubit.dart';

class UpdateUserInfoBlocListner extends StatelessWidget {
  const UpdateUserInfoBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoCubit, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UpdateUserInfoLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const CustomLoadingIndicator(),
          );
        } else {
          if (Navigator.canPop(context)) {
            context.pop();
          }
        }

        if (state is UpdateUserInfoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User profile updated successfully")),
          );
        }

        if (state is UpdateUserInfoFailure) {
          final errorMessage = state.errMessage.toLowerCase();

          if (errorMessage.contains("network") ||
              errorMessage.contains("connection") ||
              errorMessage.contains("offline")) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Network issue occurred. Update might still be successful."),
                backgroundColor: Colors.orange,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Update failed: ${state.errMessage}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
