String errorCode(String code) {
  switch (code) {
    case 'user-not-found':
      return 'No account found!';
    case 'invalid-email':
      return 'Please use a proper email!';
    case 'wrong-password':
      return 'Password is invalid!';
    case 'email-already-in-use':
      return 'Email already in use!';
    case 'network-request-failed':
      return 'Connection Failed! Please try again.';
    default:
      return 'Oops! Unexpected Error!';
  }
}
