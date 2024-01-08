import 'package:intl/intl.dart';

// String _formatCurrency(String amountString) {
//   final currencyFormat = NumberFormat.currency(locale: 'en_KES', symbol: 'KES');
//   final double amount =
//       double.tryParse(amountString) ?? 0.0; // Convert to double
//   return currencyFormat
//       .format(amount); // Format with KES symbol and thousand separators
// }

final currencyFormat = NumberFormat("#,##0.00", "en_KE");
