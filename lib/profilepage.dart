import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD12345',
      'items': [
        {'name': 'Burger', 'quantity': 2},
        {'name': 'Pizza', 'quantity': 1},
      ],
      'totalAmount': 450,
      'date': '27 April 2025',
    },
    {
      'orderId': 'ORD12346',
      'items': [
        {'name': 'Pasta', 'quantity': 1},
        {'name': 'French Fries', 'quantity': 1},
      ],
      'totalAmount': 300,
      'date': '28 April 2025',
    },
    // Add more orders if you want
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderCard(order: order);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ExpansionTile(
        title: Text(
          'Order ID: ${order['orderId']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Date: ${order['date']}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          const Divider(),
          ...order['items'].map<Widget>((item) {
            return ListTile(
              leading: const Icon(Icons.fastfood),
              title: Text(item['name']),
              trailing: Text('x${item['quantity']}'),
            );
          }).toList(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${order['totalAmount']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
