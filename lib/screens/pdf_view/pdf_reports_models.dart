class BudgetOnMothReportModel {
  final int budgetOnStart;
  final List<BudgetPayoutModel> paymentToWorkers;
  final List<BudgetPayoutModel> homeServicePayments;
  final List<BudgetPayoutModel> otherPayments;

  BudgetOnMothReportModel(this.budgetOnStart, this.paymentToWorkers, this.homeServicePayments, this.otherPayments);

  int getPayoutDataTotal() {
    int payoutDataTotal = paymentToWorkers.map((e) => e.value).reduce(
          (a, b) => a + b,
        );

    return payoutDataTotal;
  }

  int getServicesPaymentsTotal() {
    int payoutDataTotal = homeServicePayments.map((e) => e.value).reduce(
          (a, b) => a + b,
        );

    return payoutDataTotal;
  }

  int getOtherPaymentsTotal() {
    int payoutDataTotal = otherPayments.map((e) => e.value).reduce(
          (a, b) => a + b,
        );

    return payoutDataTotal;
  }

  int getBalanceAtTheEnd() {
    int balanceAtTheEnd = budgetOnStart - getOtherPaymentsTotal() - getPayoutDataTotal() - getServicesPaymentsTotal();
    return balanceAtTheEnd;
  }
}

class BudgetPayoutModel {
  final String name;
  final int value;

  BudgetPayoutModel(this.name, this.value);
}

class BudgetIncomeReport {
  final int budgetFinish;
  final List<BudgetIncomeModel> paymentsToBudget;

  BudgetIncomeReport(this.budgetFinish, this.paymentsToBudget);
}

class BudgetIncomeModel {
  final String name;
  final int value;
  final DateTime paymentDate;

  BudgetIncomeModel(this.name, this.value, this.paymentDate);
}

class ServicesRatingReport {
  final DateTime servicesDate;
  final String userName;
  final String workerName;
  final int ratingValue;
  final String serviceName;
  ServicesRatingReport(
      {required this.servicesDate,
      required this.userName,
      required this.workerName,
      required this.ratingValue,
      required this.serviceName});
}
