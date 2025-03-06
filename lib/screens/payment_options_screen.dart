import 'package:flutter/material.dart';

class PaymentOptionsScreen extends StatelessWidget {
  final String participant;
  final double betAmount;

  const PaymentOptionsScreen({Key? key, required this.participant, required this.betAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Participant: $participant'),
            Text('Bet Amount: \$${betAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            const Text('Choose your payment method:'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement credit/debit card payment
                print('Credit/Debit Card Payment Selected');
              },
              child: const Text('Credit / Debit Card'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement Apple Pay payment
                print('Apple Pay Selected');
              },
              child: const Text('Apple Pay'),
            ),
          ],
        ),
      ),
    );
  }
}