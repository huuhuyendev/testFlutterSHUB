import 'models.dart';

List<int> processQueries(List<int> data, List<Query> queries) {
  int n = data.length;

  List<int> prefixSum = List.filled(n + 1, 0);
  List<int> prefixAltSum = List.filled(n + 1, 0);

  for (int i = 0; i < n; i++) {
    prefixSum[i + 1] = prefixSum[i] + data[i];
    if (i % 2 == 0) {
      prefixAltSum[i + 1] = prefixAltSum[i] + data[i];
    } else {
      prefixAltSum[i + 1] = prefixAltSum[i] - data[i];
    }
  }

  List<int> results = [];
  for (var query in queries) {
    int l = query.range[0];
    int r = query.range[1];

    if (query.type == "1") {
      int sum = prefixSum[r + 1] - prefixSum[l];
      results.add(sum);
    } else if (query.type == "2") {
      int altSum = prefixAltSum[r + 1] - prefixAltSum[l];
      results.add(altSum);
    }
  }

  return results;
}
