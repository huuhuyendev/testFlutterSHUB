import 'package:flutter/material.dart';
import 'api_service.dart';
import 'query_processor.dart';
import 'models.dart';

class QueryScreen extends StatelessWidget {
  const QueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Query Results',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<ApiResponse>(
        future: ApiService().fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final apiResponse = snapshot.data!;
            final results = processQueries(apiResponse.data, apiResponse.queries);

            ApiService().sendResults(apiResponse.token, results);

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Result of Query ${index + 1}: ${results[index]}'),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
