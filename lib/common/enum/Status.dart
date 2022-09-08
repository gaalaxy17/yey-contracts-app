class Status {
  static const Map<String, String> AWAITING_SIGNATURE = {
    "Aguardando Assinatura": "awaiting_signature"
  };
  static const Map<String, String> SIGNED = {"Assinado": "signed"};
  static const Map<String, String> ACTIVE = {"Ativo": "active"};
  static const Map<String, String> EXPIRED = {"Expirado": "expired"};
  static const Map<String, String> REVOKED = {"Rescindido": "revoked"};
  static const Map<String, String> CANCELLED = {"Cancelado": "cancelled"};

  static Map<String, String> values() {
    Map<String, String> results = new Map<String, String>();

    results.addAll(AWAITING_SIGNATURE);
    results.addAll(SIGNED);
    results.addAll(ACTIVE);
    results.addAll(EXPIRED);
    results.addAll(REVOKED);
    results.addAll(CANCELLED);

    return results;
  }

  static Map<String, String>? filteredValues(String status) {
    Map<String, Map<String, String>> statusMap =
        new Map<String, Map<String, String>>();

    Map<String, String> awaitingSignature = new Map();
    awaitingSignature.addAll(AWAITING_SIGNATURE);
    awaitingSignature.addAll(SIGNED);
    awaitingSignature.addAll(CANCELLED);

    statusMap['awaiting_signature'] = awaitingSignature;

    Map<String, String> signed = new Map();
    signed.addAll(SIGNED);
    signed.addAll(CANCELLED);

    statusMap['signed'] = signed;

    Map<String, String> active = new Map();
    active.addAll(AWAITING_SIGNATURE);
    active.addAll(ACTIVE);
    active.addAll(REVOKED);

    statusMap['active'] = active;

    Map<String, String> expired = new Map();
    expired.addAll(EXPIRED);

    statusMap['expired'] = expired;

    Map<String, String> revoked = new Map();
    revoked.addAll(REVOKED);

    statusMap['revoked'] = revoked;

    Map<String, String> cancelled = new Map();
    cancelled.addAll(CANCELLED);

    statusMap['cancelled'] = cancelled;

    return statusMap[status];
  }
}
