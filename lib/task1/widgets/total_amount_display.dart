import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/transaction_bloc.dart';
import '../blocs/transaction_state.dart';

class TotalAmountDisplay extends StatelessWidget {
  const TotalAmountDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFB0F0B0), width: 1),
            color: const Color(0xFFE6FFE6),
          ),
          child: Column(
            children: [
              if (state is TotalCalculatedState) ...[
                Text(
                  'Total Amount: ${state.totalAmount}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ] else ...[
                const Text(
                  'Total Amount: 0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
