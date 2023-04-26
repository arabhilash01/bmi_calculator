// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bmiValues.g.dart';

@Riverpod(keepAlive: true)
class BmiValue extends _$BmiValue {
  @override
  BmiResult build() {
    return BmiResult(result: 0.0, condition: Condition.notspecified);
  }

  void update(double result, Condition condition) {
    print('Updated $result');
    state = BmiResult(result: result, condition: condition);
    print(state.condition);
  }

  void reset() {
    state = BmiResult(result: 0.0, condition: Condition.notspecified);
  }
}

class BmiResult {
  double result;
  Condition condition;
  BmiResult({
    required this.result,
    required this.condition,
  });
}

enum Condition { notspecified, underweight, perfect, overweight, obese }
