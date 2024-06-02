// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginParm {
  final String email;
  final String password;
  LoginParm({
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'LoginParm(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginParm other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  LoginParm copyWith({
    String? email,
    String? password,
  }) {
    return LoginParm(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
