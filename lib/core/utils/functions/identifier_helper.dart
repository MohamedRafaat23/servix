class SplitIdentifierResult {
  final String email;
  final String phone;
  const SplitIdentifierResult({required this.email, required this.phone});
}

SplitIdentifierResult splitIdentifier(String value) {
  final trimmed = value.trim();
  final isEmail = trimmed.contains('@');
  return SplitIdentifierResult(
    email: isEmail ? trimmed : '',
    phone: isEmail ? '' : trimmed,
  );
}