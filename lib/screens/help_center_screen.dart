import 'package:flutter/material.dart';
import 'package:home_hub/utils/colors.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Help Center",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 16.0),
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          FAQItem(
            question: 'How do I book a service?',
            answer:
            'To book a service, simply follow these steps:\n\n1. Open the app and sign in.\n2. Browse available services.\n3. Select the desired service.\n4. Select your location. \n5. Confirm your booking.',
          ),
          SizedBox(height: 16.0),
          FAQItem(
            question: 'Can I cancel my booking?',
            answer:
            'Yes, you can cancel your booking. To cancel a booking, go to the My Bookings section and select the booking you wish to cancel. Follow the prompts to complete the cancellation process.',
          ),
          SizedBox(height: 16.0),
          FAQItem(
            question: 'How do I contact customer support?',
            answer:
            'If you need assistance or have any questions, you can contact our customer support team via email at yasinusama414@gmail.com. Our support team is available 24/7 to help you.',
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(widget.answer),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            _expanded = expanded;
          });
        },
      ),
    );
  }
}
