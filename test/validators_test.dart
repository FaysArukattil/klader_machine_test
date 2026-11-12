import 'package:flutter_test/flutter_test.dart';
import 'package:klader_machine_test/app/core/errors/auth_failure.dart';
import 'package:klader_machine_test/app/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('rejects empty and malformed emails', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('abc'), isNotNull);
      expect(Validators.email('abc@'), isNotNull);
      expect(Validators.email('abc@site'), isNotNull);
    });

    test('accepts valid emails', () {
      expect(Validators.email('john.doe+test@example.com'), isNull);
      expect(Validators.email('  user@mail.co.in  '), isNull);
    });
  });

  group('Validators passwords', () {
    test('login password enforces all strong password rules', () {
      expect(Validators.loginPassword(''), isNotNull);
      expect(Validators.loginPassword('12345678'), isNotNull); // < 9 chars
      expect(Validators.loginPassword('abcdef12!'), isNotNull); // no uppercase
      expect(Validators.loginPassword('ABCDEF12!'), isNotNull); // no lowercase
      expect(Validators.loginPassword('Abcdefgh!'), isNotNull); // no digit
      expect(Validators.loginPassword('Abcdef123'), isNotNull); // no special
      expect(Validators.loginPassword('Secure@12'), isNull);   // valid strong password
    });

    test('new password rejects missing requirements', () {
      // Too short
      expect(Validators.newPassword('Ab1!xyx'), isNotNull);
      // No uppercase
      expect(Validators.newPassword('abcdef1!x'), isNotNull);
      // No lowercase
      expect(Validators.newPassword('ABCDEF1!X'), isNotNull);
      // No digit
      expect(Validators.newPassword('Abcdefgh!'), isNotNull);
      // No special character
      expect(Validators.newPassword('Abcdef12x'), isNotNull);
      // Empty
      expect(Validators.newPassword(''), isNotNull);
    });

    test('new password accepts strong passwords', () {
      expect(Validators.newPassword('Secure@12'), isNull);  // 9 chars, all rules
      expect(Validators.newPassword('P@ssw0rd!'), isNull);  // classic strong password
      expect(Validators.newPassword('MyP@ss1234!'), isNull);
    });

    test('confirm password must match', () {
      expect(Validators.confirmPassword('', 'Secure@12'), isNotNull);
      expect(Validators.confirmPassword('Secure@13', 'Secure@12'), isNotNull);
      expect(Validators.confirmPassword('Secure@12', 'Secure@12'), isNull);
    });
  });

  group('AuthFailure.fromCode', () {
    test('maps the required Firebase codes', () {
      expect(AuthFailure.fromCode('weak-password').message, contains('weak'));
      expect(
        AuthFailure.fromCode('email-already-in-use').message,
        contains('already exists'),
      );
      expect(
        AuthFailure.fromCode('user-not-found').message,
        contains('No account'),
      );
    });

    test('falls back to a generic message', () {
      expect(AuthFailure.fromCode('something-new').message, isNotEmpty);
    });
  });
}
