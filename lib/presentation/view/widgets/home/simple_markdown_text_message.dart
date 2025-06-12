import 'package:flutter/material.dart';

class CustomMarkdownTextMessage extends StatelessWidget {
  final dynamic message;

  const CustomMarkdownTextMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final spans = _parseMarkdown(message.text);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16),
          children: spans,
        ),
      ),
    );
  }

  List<TextSpan> _parseMarkdown(String text) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'(\*\*.*?\*\*|_.*?_|\[.*?\]\(.*?\))');

    final matches = regex.allMatches(text);
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
      }

      final matchText = match.group(0)!;

      if (matchText.startsWith('**') && matchText.endsWith('**')) {
        spans.add(TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (matchText.startsWith('_') && matchText.endsWith('_')) {
        spans.add(TextSpan(
          text: matchText.substring(1, matchText.length - 1),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      } else if (matchText.contains('](')) {
        final textPart = RegExp(r'\[(.*?)\]').firstMatch(matchText)?.group(1) ?? '';
        spans.add(TextSpan(
          text: textPart,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ));
      }

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(text: text.substring(currentIndex)));
    }

    return spans;
  }
}
