import 'package:flutter_test/flutter_test.dart';
import 'package:restful_api/utils/validator.dart';

void main() {
  test('Validation', () {
    expect(Validator.nameValidator("55"), false);
    expect(Validator.nameValidator("asdf2"), false);
    expect(Validator.nameValidator("asdf asdf"), true);
    expect(Validator.nameValidator(""), false);
    expect(Validator.nameValidator(null), false);

    expect(Validator.emailValidator("sdf"), false);
    expect(Validator.emailValidator(""), false);
    expect(Validator.emailValidator("null"), false);
    expect(Validator.emailValidator("a@g.c"), true);
    expect(Validator.emailValidator("aaa@sss"), true);

    expect(Validator.phoneValidator("sdf"), false);
    expect(Validator.phoneValidator(""), false);
    expect(Validator.phoneValidator(null), false);
    expect(Validator.phoneValidator("null"), false);
    expect(Validator.phoneValidator("a@g.c"), false);
    expect(Validator.phoneValidator("162"), true);
  });
}
