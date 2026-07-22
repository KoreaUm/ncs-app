import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/category.dart';
import '../models/question.dart';

class PdfGenerator {
  static Future<Uint8List> buildQuestionPaper(List<Question> questions) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Text('NCS 직업기초능력 문제지',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        build: (context) => [
          for (var i = 0; i < questions.length; i++) _questionBlock(i, questions[i]),
        ],
      ),
    );
    return doc.save();
  }

  static pw.Widget _questionBlock(int index, Question q) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('${index + 1}. [${q.category.label} / 난이도 ${q.difficulty.label}]',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.SizedBox(height: 4),
          pw.Text(q.stem, style: const pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 6),
          for (var i = 0; i < q.choices.length; i++)
            pw.Text('  ${String.fromCharCode(65 + i)}. ${q.choices[i]}',
                style: const pw.TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  static Future<Uint8List> buildAnswerSheet(List<Question> questions) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Text('NCS 직업기초능력 정답 및 해설지',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        build: (context) => [
          for (var i = 0; i < questions.length; i++) _answerBlock(i, questions[i]),
        ],
      ),
    );
    return doc.save();
  }

  static pw.Widget _answerBlock(int index, Question q) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
              '${index + 1}. 정답: ${String.fromCharCode(65 + q.correctIndex)} (${q.choices[q.correctIndex]})',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 2),
          pw.Text('해설: ${q.explanation}', style: const pw.TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
