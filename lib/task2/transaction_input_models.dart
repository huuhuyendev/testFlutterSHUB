import 'package:formz/formz.dart';

class DateTimeInput extends FormzInput<String, String> {
  const DateTimeInput.pure() : super.pure('');
  const DateTimeInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Thời gian không được để trống';
    }
    return null;
  }
}

class PumpInput extends FormzInput<String, String> {
  const PumpInput.pure() : super.pure('');
  const PumpInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Trụ không được để trống';
    }
    return null;
  }
}
class QuantityInput extends FormzInput<String, String> {
  const QuantityInput.pure() : super.pure('');
  const QuantityInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số lượng không được để trống';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Số lượng phải là số dương';
    }
    return null;
  }
}

class RevenueInput extends FormzInput<String, String> {
  const RevenueInput.pure() : super.pure('');
  const RevenueInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Doanh thu không được để trống';
    }
    final revenue = double.tryParse(value);
    if (revenue == null || revenue < 0) {
      return 'Doanh thu phải là số không âm';
    }
    return null;
  }
}

class PriceInput extends FormzInput<String, String> {
  const PriceInput.pure() : super.pure('');
  const PriceInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Đơn giá không được để trống';
    }
    final price = double.tryParse(value);
    if (price == null || price < 0) {
      return 'Đơn giá phải là số không âm';
    }
    return null;
  }
}
