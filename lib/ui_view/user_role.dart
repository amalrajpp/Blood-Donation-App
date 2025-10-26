class UserManager {
  static final UserManager _instance = UserManager._internal();

  String? _role;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  // Getter for user role
  String? get role => _role;

  // Setter for user role
  void setRole(String role) {
    _role = role;
  }
}
