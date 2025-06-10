import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';
import 'package:health_assistant/data/models/analyze_symptoms.dart/analyze_symptoms_request_model.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';


class AnalyzeSymptomsBottomSheet extends StatefulWidget {
  const AnalyzeSymptomsBottomSheet({super.key, required this.chatController, required this.onActionDone});
  final InMemoryChatController chatController;
  final VoidCallback onActionDone;

  @override
  State<AnalyzeSymptomsBottomSheet> createState() => _AnalyzeSymptomsBottomSheetState();
}

class _AnalyzeSymptomsBottomSheetState extends State<AnalyzeSymptomsBottomSheet> {
  final TextEditingController symptomController = TextEditingController();
  final TextEditingController painLevelController = TextEditingController();

  final List<Map<String, dynamic>> symptomsList = [];

  @override
  void dispose() {
    symptomController.dispose();
    painLevelController.dispose();
    super.dispose();
  }

  void addSymptom() {
    final symptom = symptomController.text.trim();
    final pain = int.tryParse(painLevelController.text.trim());

    if (symptom.isNotEmpty && pain != null && pain > 0) {
      setState(() {
        symptomsList.add({
          'name': symptom,
          'painLevel': pain,
        });
        symptomController.clear();
        painLevelController.clear();
      });
    }
  }

  void analyze() {
  if (symptomsList.isEmpty) return;

  final model = AnalyzeSymptomsRequestModel(
    symptoms: symptomsList.map((e) => e['name'] as String).toList(),
    painLevel: symptomsList.last['painLevel'] as int,
    duration: '3 days',
    startDate: DateTime.now().toIso8601String(),
  );

  final userMessage = 'Symptoms: ${model.symptoms.join(', ')}\nPain Level: ${model.painLevel}\nDuration: ${model.duration}';
  widget.chatController.insertMessage(
    TextMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: 'user1',
      createdAt: DateTime.now().toUtc(),
      text: userMessage,
    ),
  );

  context.read<AnalyzeSymptomsCubit>().analyzeSymptoms(model);
  widget.onActionDone();
  Navigator.pop(context); 
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/stethoscope.png', height: 24),
                horizontalSpace(context, 12),
                Text(
                  'Advanced Symptoms Checker',
                  style: CustomTextStyles.font12BlackMedium(context).copyWith(
                    color: ColorsManager.lightGray,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            verticalSpace(context, 12),
            const Divider(thickness: 1, color: ColorsManager.mainColor),
            verticalSpace(context, 16),
            CustomTextFormField(
              controller: symptomController,
              hintText: 'e.g. cough',
              validator: (_) {},
            ),
            verticalSpace(context, 12),
            CustomTextFormField(
              controller: painLevelController,
              hintText: 'Pain level (1-10)',
              validator: (_) {},
            ),
            verticalSpace(context, 12),
            CustomAppButton(
              onPressed: addSymptom,
              buttonHeight: 50,
              btnText: 'Add Symptom',
            ),
            verticalSpace(context, 16),
            if (symptomsList.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: symptomsList.length,
                itemBuilder: (context, index) {
                  final item = symptomsList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text("Pain level: ${item['painLevel']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            symptomsList.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            verticalSpace(context, 24),
            CustomAppButton(
              onPressed: analyze,
              buttonHeight: 60,
              btnText: 'Analyze Symptoms',
            ),
          ],
        ),
      ),
    );
  }
}
