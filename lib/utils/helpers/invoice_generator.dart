import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class InvoiceGenerator {
  static Future<Uint8List> generateInvoicePdf({
    required String customerName,
    required String customerPhone,
    required String month,
    required List<Map<String, String>> purchases,
    required String totalAmount,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Text('Customer: $customerName'),
              pw.Text('Phone: $customerPhone'),
              pw.SizedBox(height: 16),
              pw.Text('Month: $month'),
              pw.SizedBox(height: 16),
              pw.Text('Purchases:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Table.fromTextArray(
                headers: ['Material', 'Quantity', 'Price'],
                data: purchases
                    .map((p) => [p['material'], p['qty'], p['price']])
                    .toList(),
              ),
              pw.SizedBox(height: 16),
              pw.Text('Total Amount: $totalAmount'),

            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
