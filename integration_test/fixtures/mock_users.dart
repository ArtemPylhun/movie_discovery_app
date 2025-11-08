/// Test user data for integration tests
class TestUser {
  final String email;
  final String password;
  final String displayName;

  const TestUser({
    required this.email,
    required this.password,
    required this.displayName,
  });
}

class TestUsers {
  /// Valid test user for successful login tests
  /// Note: This user should be created in Firebase before running tests
  static const validUser = TestUser(
    email: 'test@movieapp.com',
    password: 'Test123456!',
    displayName: 'Test User',
  );

  /// Invalid user for testing error handling
  static const invalidUser = TestUser(
    email: 'invalid@test.com',
    password: 'wrongpassword',
    displayName: 'Invalid User',
  );

  /// User with malformed email
  static const malformedEmailUser = TestUser(
    email: 'not-an-email',
    password: 'password123',
    displayName: 'Malformed User',
  );

  /// User with short password
  static const shortPasswordUser = TestUser(
    email: 'user@test.com',
    password: '123',
    displayName: 'Short Password User',
  );
}
