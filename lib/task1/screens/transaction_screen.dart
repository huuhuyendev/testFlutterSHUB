import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../blocs/transaction_bloc.dart';
import '../blocs/transaction_event.dart';
import '../blocs/transaction_state.dart';
import '../widgets/time_input_widget.dart';
import '../widgets/total_amount_display.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String? startTimeInput;
  String? endTimeInput;
  String? filePath;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final transactionBloc = BlocProvider.of<TransactionBloc>(context);

    return Scaffold(

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
          'Transaction Report',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // FILE UPLOAD WIDGET
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFB0CFFD)),
                  color: const Color(0xFFE8F0FB),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.file_upload_outlined,
                      size: 40,
                      color: Colors.blue,
                    ),
                    const Text(
                      'Upload your file here',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          filePath = result.files.single.path;
                          transactionBloc.add(UploadFileEvent(filePath!));
                        }
                      },
                      child: const Text(
                        'Browse',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // FILE PATH DISPLAY
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: const Color(0xFFB0F0B0), width: 0.5),
                  color: const Color(0xFFE6FFE6),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.file_copy_outlined,
                      size: 20,
                      color: Colors.green,
                    ),
                    BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ));
                        } else if (state is FileUploadedState) {
                          return Text('File Path: ${state.fileName}');
                        } else if (state is TotalCalculatedState) {
                          return Column(
                            children: [
                              Text('File Path: ${state.fileName}'),
                            ],
                          );
                        } else {
                          return const Text('Upload a file to start');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // INPUT START TIME AND END TIME
              TimeInputWidget(
                label: 'Start Time (HH:mm:ss)',
                onChanged: (value) {
                  startTimeInput = value;
                },
              ),
              const SizedBox(height: 16),
              TimeInputWidget(
                label: 'End Time (HH:mm:ss)',
                onChanged: (value) {
                  endTimeInput = value;
                },
              ),

              const SizedBox(height: 16),

              // CALCULATE TOTAL BUTTON

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  if (filePath != null &&
                      startTimeInput != null &&
                      endTimeInput != null) {
                    DateTime now = DateTime.now();
                    DateTime startDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      int.parse(startTimeInput!.split(':')[0]),
                      int.parse(startTimeInput!.split(':')[1]),
                      int.parse(startTimeInput!.split(':')[2]),
                    );
                    DateTime endDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      int.parse(endTimeInput!.split(':')[0]),
                      int.parse(endTimeInput!.split(':')[1]),
                      int.parse(endTimeInput!.split(':')[2]),
                    );

                    transactionBloc
                        .add(CalculateTotalEvent(startDateTime, endDateTime));
                  }
                },
                child: const Text(
                  'Calculate Total',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 16),

              // TOTAL AMOUNT DISPLAY
              const TotalAmountDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}
