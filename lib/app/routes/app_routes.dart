class Routes {
  Routes._();

  /// Auth gate: decides between Login and Home based on auth state.
  static const root = '/';
  static const login = '/login';
  static const home = '/home';
  static const signUp = '/sign-up';
}
