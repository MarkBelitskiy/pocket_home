import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';

Future<File?> monthBudgetPdfGenerate() async {
  // создаем PDF-документ
  final pdf = Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );
  final font = Font.ttf(await rootBundle.load("assets/fonts/roboto.ttf"));

  final budgetOnStartHeader = ['Бюджет на начало месяца', '700000 тг'];

  final workersPayoutHeader = [
    'Выплаты сотрудникам',
    'Сумма',
  ];

  final payoutData = [
    ['ФИО1', '10000 тг'],
    ['ФИО2', '15000 тг'],
    ['ФИО3', '8000 тг'],
  ];

  final homeServiceData = [
    ['Побелка бордюров', '25000 тг'],
  ];

  final otherExpensesData = [
    ['Краска для побелки', '20000 тг'],
  ];

  final tableRows = <TableRow>[
    TableRow(
      decoration: const BoxDecoration(
        color: PdfColors.amber400,
      ),
      children: budgetOnStartHeader.map((header) {
        return Text(header, style: TextStyle(fontWeight: FontWeight.bold, font: font));
      }).toList(),
    ),
    TableRow(
      decoration: const BoxDecoration(
        color: PdfColors.grey400,
      ),
      children: workersPayoutHeader.map((header) {
        return Text(header, style: TextStyle(fontWeight: FontWeight.bold, font: font));
      }).toList(),
    ),
    ...payoutData.map((data) {
      return TableRow(
        children: data.map((value) {
          return (Text(value, style: TextStyle(font: font)));
        }).toList(),
      );
    }),
    TableRow(
      children: [
        Text(
          'Итого',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
        Text(
          '30500 тг',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
      ],
    ),
    TableRow(
      decoration: const BoxDecoration(
        color: PdfColors.grey400,
      ),
      children: [
        Text('Расходы на обслуживание дома', style: TextStyle(fontWeight: FontWeight.bold, font: font)),
      ],
    ),
    ...homeServiceData.map((data) {
      return TableRow(
        children: data.map((value) {
          return Text(value, style: TextStyle(font: font));
        }).toList(),
      );
    }),
    TableRow(
      children: [
        Text(
          'Итого',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
        Text(
          '30500 тг',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
      ],
    ),
    TableRow(
      decoration: const BoxDecoration(
        color: PdfColors.grey400,
      ),
      children: [
        Text('Прочие расходы', style: TextStyle(fontWeight: FontWeight.bold, font: font)),
      ],
    ),
    ...otherExpensesData.map((data) {
      return TableRow(
        children: data.map((value) {
          return Text(value, style: TextStyle(font: font));
        }).toList(),
      );
    }),
    TableRow(
      children: [
        Text(
          'Итого',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
        Text(
          '30500 тг',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
      ],
    ),
    TableRow(
      decoration: const BoxDecoration(
        color: PdfColors.green,
      ),
      children: [
        Text(
          'Бюджет на конец месяца',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
        Text(
          '30500 тг',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
      ],
    ),
  ];

  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) => [
        Header(
          level: 0,
          child: Text('Отчет по бюджету за месяц', style: TextStyle(font: font)),
        ),
        Table(
          children: tableRows,
        ),
      ],
    ),
  );
  Directory? directory = Directory.systemTemp;

  final file = File('${directory.path}/example.pdf');
  file.writeAsBytesSync(await pdf.save());
  return file;
}
