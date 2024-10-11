import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_project/task2/transaction_form_cubit.dart';
import 'package:test_project/task2/transaction_form_state.dart';
import 'package:test_project/task2/widgets/dateTimePickerX.dart';
import 'package:test_project/task2/widgets/dropdownX.dart';
import 'package:test_project/task2/widgets/textFieldX.dart';

class TransactionFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionFormCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(
            'Nhập giao dịch',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TransactionFormCubit, TransactionFormState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Chọn Thời gian (DateTime Picker)
                  DateTimePickerX(
                    label: 'Thời gian',
                    errorText: state.dateTime.invalid && state.isSubmitting
                        ? (state.dateTime.value.isEmpty
                            ? 'Thời gian không được để trống'
                            : 'Thời gian không hợp lệ')
                        : null,
                    isSubmitting: state.isSubmitting,
                    value: state.dateTime.value,
                    onChanged: (value) {
                      context
                          .read<TransactionFormCubit>()
                          .onDateTimeChanged(value);
                    },
                  ),

                  // Dropdown chọn Trụ
                  DropdownX(
                    label: 'Chọn trụ',
                    errorText: state.pump.invalid && state.isSubmitting
                        ? (state.pump.value.isEmpty
                            ? 'Trụ không được để trống'
                            : 'Trụ không hợp lệ')
                        : null,
                    isSubmitting: state.isSubmitting,
                    value:
                        state.pump.value.isNotEmpty ? state.pump.value : null,
                    items: const <String>[
                      'Trụ 1',
                      'Trụ 2',
                      'Trụ 3',
                      'Trụ 4',
                    ],
                    onChanged: (String? newValue) {
                      context
                          .read<TransactionFormCubit>()
                          .onPumpChanged(newValue ?? '');
                    },
                  ),

                  TextFieldX(
                    label: "Số lượng",
                    errorText: state.quantity.invalid && state.isSubmitting
                        ? (state.quantity.value.isEmpty
                            ? 'Số lượng không được để trống'
                            : 'Số lượng không hợp lệ')
                        : null,
                    isSubmitting: state.isSubmitting,
                    onChanged: (value) => context
                        .read<TransactionFormCubit>()
                        .onQuantityChanged(value),
                    // Doanh thu
                  ),
                  TextFieldX(
                    label: "Doanh thu",
                    errorText: state.revenue.invalid && state.isSubmitting
                        ? (state.revenue.value.isEmpty
                            ? 'Doanh thu không được để trống'
                            : 'Doanh thu không hợp lệ')
                        : null,
                    isSubmitting: state.isSubmitting,
                    onChanged: (value) => context
                        .read<TransactionFormCubit>()
                        .onRevenueChanged(value),
                    // Doanh thu
                  ),

                  // Đơn giá
                  TextFieldX(
                    label: "Đơn giá",
                    errorText: state.price.invalid && state.isSubmitting
                        ? (state.price.value.isEmpty
                            ? 'Đơn giá không được để trống'
                            : 'Đơn giá không hợp lệ')
                        : null,
                    isSubmitting: state.isSubmitting,
                    onChanged: (value) => context
                        .read<TransactionFormCubit>()
                        .onPriceChanged(value),
                    // Đơn giá
                  ),

                  if (state.errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  // Nút cập nhật

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TransactionFormCubit>().onSubmit(context);
                    },
                    child: const Text('Cập nhật'),
                  ),
                  // Hiển thị thông báo lỗi chung (nếu có)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
