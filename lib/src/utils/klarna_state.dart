enum KlarnaState {
  initial,
  initialized,
  loaded,
  authorized,
  finalized,
  reauthorized,
  errorOccurred,
  loadPaymentReview,
  unknown
}

KlarnaState klarnaStateFromString(String input) {
  for (final state in KlarnaState.values) {
    if (input == state.name) {
      return state;
    }
  }

  return KlarnaState.unknown;
}
