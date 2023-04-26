// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'userdetails.g.dart';

@riverpod
class User extends _$User {
  @override
  UserDetails build() {
    return UserDetails(gender: Gender.male, age: 25, weight: 60,height: 150);
  }

  void updateGender(Gender gender) {
    state = UserDetails(gender: gender, age: state.age, weight: state.weight,height: state.height);
  }

  void updateAge(int age) {
    state = UserDetails(gender: state.gender, age: age, weight: state.weight,height: state.height);
  }

  void updateWeight(int weight) {
    state = UserDetails(gender: state.gender, age: state.age, weight: weight,height: state.height);
  }
  void updateHeight(int height) {
    state = UserDetails(gender: state.gender, age: state.age, weight: state.weight,height:height);
  }
  void reset(){
    state = UserDetails(gender: Gender.male, age: 25, weight: 60,height: 150);
  }
}

class UserDetails {
  Gender gender;
  int age;
  int weight;
  int height;
  UserDetails({
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
  });
}

enum Gender { male, female, notselected }
