import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';
import 'package:health_assistant/core/utils/spacing.dart';
import 'package:health_assistant/core/widgets/custom_app_button.dart';
import 'package:health_assistant/core/widgets/custom_text_form_field.dart';
import 'package:health_assistant/data/models/analyze_symptoms/analyze_symptoms_request_model.dart';
import 'package:health_assistant/presentation/controllers/analyze_symptoms/analyze_symptoms_cubit.dart';


class AnalyzeSymptomsBottomSheet extends StatefulWidget {
  const AnalyzeSymptomsBottomSheet(
      {super.key, required this.chatController, required this.onActionDone});
  final InMemoryChatController chatController;
  final VoidCallback onActionDone;

  @override
  State<AnalyzeSymptomsBottomSheet> createState() =>
      _AnalyzeSymptomsBottomSheetState();
}

class _AnalyzeSymptomsBottomSheetState
    extends State<AnalyzeSymptomsBottomSheet> {
  final TextEditingController symptomController = TextEditingController();
  final TextEditingController painLevelController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  final List<Map<String, dynamic>> symptomsList = [];

  @override
  void dispose() {
    symptomController.dispose();
    painLevelController.dispose();
    durationController.dispose();
    startDateController.dispose();
    super.dispose();
  }

  void addSymptom() {
    final symptom = symptomController.text.trim();
    final pain = int.tryParse(painLevelController.text.trim());
    final duration = durationController.text.trim();
    final startDateText = startDateController.text.trim();
    final startDate = DateTime.tryParse(startDateText);

    if (symptom.isNotEmpty &&
        pain != null &&
        pain > 0 &&
        duration.isNotEmpty &&
        startDate != null) {
      setState(() {
        symptomsList.add({
          'name': symptom,
          'painLevel': pain,
          'duration': duration,
          'startDate': startDate.toIso8601String(),
        });
        symptomController.clear();
        painLevelController.clear();
        durationController.clear();
        startDateController.clear();
      });
    }
  }

  void analyze() {
    if (symptomsList.isEmpty) return;

    final model = AnalyzeSymptomsRequestModel(
      symptoms: symptomsList.map((e) => e['name'] as String).toList(),
      painLevel: symptomsList.last['painLevel'] as int,
      duration: symptomsList.last['duration'] as String,
      startDate: symptomsList.last['startDate'] as String,
    );

    final userMessage =
        'Symptoms: ${model.symptoms.join(', ')}\nPain Level: ${model.painLevel}\nDuration: ${model.duration}\nStart Date: ${model.startDate}';
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
            CustomTextFormField(
              controller: durationController,
              hintText: 'Duration (e.g. 3 days)',
              validator: (_) {},
            ),
            verticalSpace(context, 12),
            CustomTextFormField(
              controller: startDateController,
              hintText: 'Start date (e.g. 2024-06-01)',
              readOnly: true,
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  setState(() {
                    startDateController.text =
                        pickedDate.toIso8601String().split('T').first;
                  });
                }
              },
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
