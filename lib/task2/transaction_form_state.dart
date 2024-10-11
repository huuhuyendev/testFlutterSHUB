import 'package:formz/formz.dart';
import 'package:test_project/task2/transaction_input_models.dart';

class TransactionFormState {
  final FormzStatus status;
  final DateTimeInput dateTime;
  final PumpInput pump;
  final QuantityInput quantity;
  final RevenueInput revenue;
  final PriceInput price;
  final bool isSubmitting;
  final String errorMessage;

  TransactionFormState({
    this.status = FormzStatus.pure,
    this.dateTime = const DateTimeInput.pure(),
    this.pump = const PumpInput.pure(),
    this.quantity = const QuantityInput.pure(),
    this.revenue = const RevenueInput.pure(),
    this.price = const PriceInput.pure(),
    this.isSubmitting = false,
    this.errorMessage = '',
  });

  TransactionFormState copyWith({
    FormzStatus? status,
    DateTimeInput? dateTime,
    PumpInput? pump,
    QuantityInput? quantity,
    RevenueInput? revenue,
    PriceInput? price,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return TransactionFormState(
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      pump: pump ?? this.pump,
      quantity: quantity ?? this.quantity,
      revenue: revenue ?? this.revenue,
      price: price ?? this.price,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
