import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'dart:io';
import 'package:pocket_home/screens/pdf_view/pdf_reports_models.dart';

Future<File?> monthBudgetPdfGenerate(BudgetOnMothReportModel model) async {
  final pdf = Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );
  final font = Font.ttf(await rootBundle.load("assets/fonts/roboto.ttf"));

  final budgetOnStartHeader = ['Бюджет до вычета платежей', '${model.budgetOnStart} тг'];

  final workersPayoutHeader = [
    'Выплаты сотрудникам',
    'Сумма',
  ];

  final payoutData = model.paymentToWorkers
      .map(
        (e) => [e.name, '${e.value} тг'],
      )
      .toList();

  final homeServiceData = model.homeServicePayments
      .map(
        (e) => [e.name, '${e.value} тг'],
      )
      .toList();

  final otherExpensesData = model.otherPayments
      .map(
        (e) => [e.name, '${e.value} тг'],
      )
      .toList();

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
          '${model.getPayoutDataTotal()} тг',
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
          '${model.getServicesPaymentsTotal()} тг',
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
          '${model.getOtherPaymentsTotal()} тг',
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
          '${model.getBalanceAtTheEnd()} тг',
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
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Отчет по расходам бюджета', style: TextStyle(font: font)),
              Text(FormatterUtils.formattedDate(DateTime.now(), 'ru-RU'), style: TextStyle(font: font))
            ])),
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

Future<File?> monthIncomeToBudgetPdfGenerate(
  BudgetIncomeReport model,
) async {
  final pdf = Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );
  final font = Font.ttf(await rootBundle.load("assets/fonts/roboto.ttf"));

  final workersPayoutHeader = [
    'ФИО совершившего платеж',
    'Дата платежа',
    'Сумма',
  ];

  final payoutData = model.paymentsToBudget
      .map(
        (e) => [e.name, FormatterUtils.formattedDate(e.paymentDate, 'ru-RU'), '${e.value} тг'],
      )
      .toList();

  final tableRows = <TableRow>[
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
      decoration: const BoxDecoration(
        color: PdfColors.green400,
      ),
      children: [
        Text(
          'Итого',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
        Text(
          ' ',
          style: TextStyle(fontWeight: FontWeight.bold, font: font),
        ),
        Text(
          '${model.budgetFinish} тг',
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
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Отчет по пополнению в бюджет', style: TextStyle(font: font)),
              Text(
                FormatterUtils.formattedDate(DateTime.now(), 'ru-RU'),
                style: TextStyle(font: font),
              )
            ])),
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

Future<File?> ratingPdfGenerate(
  List<ServicesRatingReport> model,
) async {
  final pdf = Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );
  final font = Font.ttf(await rootBundle.load("assets/fonts/roboto.ttf"));

  final workersPayoutHeader = [
    'Наименование услуги',
    'Дата',
    'Имя заказавшего услугу',
    'Имя сотрудника',
    'Проставленный рейтинг'
  ];

  final payoutData = model
      .map(
        (e) => [
          e.serviceName,
          FormatterUtils.formattedDate(e.servicesDate, 'ru-RU'),
          e.userName,
          e.workerName,
          e.ratingValue.toString()
        ],
      )
      .toList();

  final tableRows = <TableRow>[
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
  ];

  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) => [
        Header(
            level: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Отчет по оказанным услугам', style: TextStyle(font: font)),
              Text(
                FormatterUtils.formattedDate(DateTime.now(), 'ru-RU'),
                style: TextStyle(font: font),
              )
            ])),
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
