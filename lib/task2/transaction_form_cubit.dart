import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_project/task2/transaction_form_state.dart';
import 'package:test_project/task2/transaction_input_models.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(TransactionFormState());

  void onDateTimeChanged(String value) {
    final dateTime = DateTimeInput.dirty(value);
    emit(state.copyWith(
      dateTime: dateTime,
      status: Formz.validate([dateTime, state.pump, state.quantity, state.revenue, state.price]),
      errorMessage: '',
    ));
  }

  void onPumpChanged(String value) {
    final pump = PumpInput.dirty(value);
    emit(state.copyWith(
      pump: pump,
      status: Formz.validate([state.dateTime, pump, state.quantity, state.revenue, state.price]),
      errorMessage: '',
    ));
  }

  void onQuantityChanged(String value) {
    final quantity = QuantityInput.dirty(value);
    emit(state.copyWith(
      quantity: quantity,
      status: Formz.validate([state.dateTime, state.pump, quantity, state.revenue, state.price]),
      errorMessage: '',
    ));
  }

  void onRevenueChanged(String value) {
    final revenue = RevenueInput.dirty(value);
    emit(state.copyWith(
      revenue: revenue,
      status: Formz.validate([state.dateTime, state.pump, state.quantity, revenue, state.price]),
      errorMessage: '',
    ));
  }

  void onPriceChanged(String value) {
    final price = PriceInput.dirty(value);
    emit(state.copyWith(
      price: price,
      status: Formz.validate([state.dateTime, state.pump, state.quantity, state.revenue, price]),
      errorMessage: '',
    ));
  }


  Future<void> onSubmit(BuildContext context) async {
    emit(state.copyWith(isSubmitting: true)); // Đặt trạng thái đang submit

    String? errorMessage;

    if (state.dateTime.invalid) {
      errorMessage = 'Thời gian không hợp lệ';
    } else if (state.dateTime.value.isEmpty) {
      errorMessage = 'Thời gian không được để trống';
    } else if (state.pump.invalid) {
      errorMessage = 'Trụ không hợp lệ';
    } else if (state.pump.value.isEmpty) {
      errorMessage = 'Trụ không được để trống';
    } else if (state.quantity.invalid) {
      errorMessage = 'Số lượng không hợp lệ';
    } else if (state.quantity.value.isEmpty) {
      errorMessage = 'Số lượng không được để trống';
    } else if (state.revenue.invalid) {
      errorMessage = 'Doanh thu không hợp lệ';
    } else if (state.revenue.value.isEmpty) {
      errorMessage = 'Doanh thu không được để trống';
    } else if (state.price.invalid) {
      errorMessage = 'Đơn giá không hợp lệ';
    } else if (state.price.value.isEmpty) {
      errorMessage = 'Đơn giá không được để trống';
    }

    if (errorMessage != null) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: errorMessage,
      ));
    } else {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: '',
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thành công!')),
      );
    }
  }

}
