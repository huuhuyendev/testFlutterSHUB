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
        title: const Text('Query Processing App'),
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
