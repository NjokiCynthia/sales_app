class BankModel {
  int id;
  String dealer;
  String accountNumber;
  String accountName;
  String bankBranch;
  String bankName;

  BankModel(
      {required this.id,
      required this.dealer,
      required this.accountNumber,
      required this.accountName,
      required this.bankBranch,
      required this.bankName});
}
