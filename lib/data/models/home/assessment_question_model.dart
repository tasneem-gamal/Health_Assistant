class AssessmentQuestionModel {
  final String question;
  final String? image1;
  final String? title1;
  final String? image2;
  final String? title2;
  final String? image3;
  final String? title3;
  final String? image4;
  final String? title4;

  final void Function()? onTap1;
  final void Function()? onTap2;
  final void Function()? onTap3;
  final void Function()? onTap4;

  AssessmentQuestionModel({
    required this.question,
    this.image1,
    this.title1,
    this.image2,
    this.title2,
    this.image3,
    this.title3,
    this.image4,
    this.title4,
    this.onTap1,
    this.onTap2,
    this.onTap3,
    this.onTap4,
  });
}

