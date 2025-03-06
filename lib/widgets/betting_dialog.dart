import 'package:flutter/material.dart';
import '../screens/payment_options_screen.dart'; // Import the new screen

class BettingDialog extends StatefulWidget {
  final List<String> participants;

  const BettingDialog({Key? key, required this.participants}) : super(key: key);

  @override
  _BettingDialogState createState() => _BettingDialogState();
}

class _BettingDialogState extends State<BettingDialog> {
  String? selectedParticipant;
  double betAmount = 5.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Place Your Bet'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select a participant:'),
          DropdownButton<String>(
            value: selectedParticipant,
            hint: const Text('Choose participant'),
            items: widget.participants.map((String participant) {
              return DropdownMenuItem<String>(
                value: participant,
                child: Text(participant),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedParticipant = newValue;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text('Select bet amount:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    betAmount = 5.0;
                  });
                },
                child: const Text('\$5'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    betAmount = 10.0;
                  });
                },
                child: const Text('\$10'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    betAmount = 15.0;
                  });
                },
                child: const Text('\$15'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedParticipant != null) {
              // Navigate to the payment options screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentOptionsScreen(
                    participant: selectedParticipant!,
                    betAmount: betAmount,
                  ),
                ),
              );
            } else {
              // Show an error message if no participant is selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a participant to place a bet.'),
                ),
              );
            }
          },
          child: const Text('Place Bet'),
        ),
      ],
    );
  }
}