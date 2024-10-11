import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_project/task2/transaction_form_cubit.dart';
import 'package:test_project/task2/transaction_form_state.dart';

class TransactionFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionFormCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('Nhập giao dịch')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TransactionFormCubit, TransactionFormState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Chọn Thời gian (DateTime Picker)
                  GestureDetector(
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        final TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedTime != null) {
                          final DateTime fullDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          context
                              .read<TransactionFormCubit>()
                              .onDateTimeChanged(
                                  fullDateTime.toIso8601String());
                        }
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Thời gian',
                        errorText: state.dateTime.invalid && state.isSubmitting
                            ? (state.dateTime.value.isEmpty
                                ? 'Thời gian không được để trống'
                                : 'Thời gian không hợp lệ')
                            : null,
                      ),
                      child: Text(
                        state.dateTime.value.isEmpty
                            ? 'Chọn thời gian'
                            : DateFormat('dd/MM/yyyy HH:mm')
                                .format(DateTime.parse(state.dateTime.value)),
                      ),
                    ),
                  ),

                  // Dropdown chọn Trụ
                  DropdownButtonFormField<String>(
                    value:
                        state.pump.value.isNotEmpty ? state.pump.value : null,
                    onChanged: (String? newValue) {
                      context
                          .read<TransactionFormCubit>()
                          .onPumpChanged(newValue ?? '');
                    },
                    items: <String>[
                      'Trụ 1',
                      'Trụ 2',
                      'Trụ 3',
                      'Trụ 4',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Chọn trụ',
                      errorText: state.pump.invalid && state.isSubmitting
                          ? (state.pump.value.isEmpty
                              ? 'Trụ không được để trống'
                              : 'Trụ không hợp lệ')
                          : null,
                    ),
                  ),

                  // Số lượng
                  TextField(
                    onChanged: (value) => context
                        .read<TransactionFormCubit>()
                        .onQuantityChanged(value),
                    decoration: InputDecoration(
                      labelText: 'Số lượng',
                      errorText: state.quantity.invalid && state.isSubmitting
                          ? (state.quantity.value.isEmpty
                              ? 'Số lượng không được để trống'
                              : 'Số lượng không hợp lệ')
                          : null,
                    ),
                  ),

                  // Doanh thu
                  TextField(
                    onChanged: (value) => context
                        .read<TransactionFormCubit>()
                        .onRevenueChanged(value),
                    decoration: InputDecoration(
                      labelText: 'Doanh thu',
                      errorText: state.revenue.invalid && state.isSubmitting
                          ? (state.revenue.value.isEmpty
                              ? 'Doanh thu không được để trống'
                              : 'Doanh thu không hợp lệ')
                          : null,
                    ),
                  ),

                  // Đơn giá
                  TextField(
                    onChanged: (value) => context
                        .read<TransactionFormCubit>()
                        .onPriceChanged(value),
                    decoration: InputDecoration(
                      labelText: 'Đơn giá',
                      errorText: state.price.invalid && state.isSubmitting
                          ? (state.price.value.isEmpty
                              ? 'Đơn giá không được để trống'
                              : 'Đơn giá không hợp lệ')
                          : null,
                    ),
                  ),
                  if (state.errorMessage.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                  // Nút cập nhật

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TransactionFormCubit>().onSubmit(context);
                    },
                    child: Text('Cập nhật'),
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
