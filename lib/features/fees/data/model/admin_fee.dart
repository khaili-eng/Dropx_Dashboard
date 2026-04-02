class AdminFee {
  final String status;
  final String message;
  final FeeData data;

  AdminFee({required this.status, required this.message, required this.data});

  factory AdminFee.fromJson(Map<String, dynamic> json) {
    return AdminFee(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      // تأكدنا هنا أن data لا تسبب كراش إذا كانت فارغة تماماً من السيرفر
      data:
          (json['data'] != null && json['data'] is Map)
              ? FeeData.fromJson(json['data'])
              : FeeData(totalEarnings: 0.0, period: '', details: []),
    );
  }
}

class FeeData {
  final double totalEarnings;
  final String period;
  final List<Transaction>
  details; // حولناها إلى قائمة غير نول لتسهيل التعامل في الـ UI

  FeeData({
    required this.totalEarnings,
    required this.period,
    required this.details,
  });

  factory FeeData.fromJson(Map<String, dynamic> json) {
    // معالجة تفصيلية لحقل details لتجنب خطأ List<dynamic>
    var list = json['details'] as List?;
    List<Transaction> detailsList =
        list != null ? list.map((i) => Transaction.fromJson(i)).toList() : [];

    return FeeData(
      // استخدام .toDouble() مع num يضمن عدم حدوث خطأ إذا كان الرقم int أو double
      totalEarnings: (json['total_earnings'] ?? 0.0).toDouble(),
      period: json['period']?.toString() ?? '',
      details: detailsList,
    );
  }
}

class Transaction {
  final int id;
  final double amount;
  final String date;
  final String sourceName;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.sourceName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      amount: (json['amount'] ?? 0.0).toDouble(),
      date: json['date']?.toString() ?? '',
      sourceName: json['source_name']?.toString() ?? 'غير محدد',
    );
  }
}
