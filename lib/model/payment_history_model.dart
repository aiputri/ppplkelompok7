import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class PaymentHistoryModel extends IdentifierModel {
  final String paymentID, bookingID, guestName, currency, paymentMethod, paymentStatus, transactionID, paymentNote;
  final DateTime paymentDate;
  final double amountPaid;

  PaymentHistoryModel(super.id, this.paymentID, this.bookingID, this.guestName, this.currency, this.paymentMethod, this.paymentStatus, this.paymentDate,
      this.transactionID, this.paymentNote, this.amountPaid);

  static PaymentHistoryModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String paymentID = decoder.getString('payment_id');
    String bookingID = decoder.getString('booking_id');
    String guestName = decoder.getString('guest_name');
    String currency = decoder.getString('currency');
    String paymentMethod = decoder.getString('payment_method');
    String paymentStatus = decoder.getString('payment_status');
    DateTime paymentDate = decoder.getDateTime('payment_date');
    String transactionID = decoder.getString('transaction_id');
    String paymentNote = decoder.getString('payment_notes');
    double amountPaid = decoder.getDouble('amount_paid');

    return PaymentHistoryModel(
        decoder.getId, paymentID, bookingID, guestName, currency, paymentMethod, paymentStatus, paymentDate, transactionID, paymentNote, amountPaid);
  }

  static List<PaymentHistoryModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => PaymentHistoryModel.fromJSON(e)).toList();
  }

  static List<PaymentHistoryModel>? _dummyList;

  static Future<List<PaymentHistoryModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/payment_history.json');
  }
}
