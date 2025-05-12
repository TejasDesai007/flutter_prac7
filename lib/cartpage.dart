import 'package:flutter/material.dart';
import 'package:foodie/checkoutpage.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    // Initialize quantities
    for (var item in widget.cart) {
      String itemId = item['name'];
      if (itemQuantities.containsKey(itemId)) {
        itemQuantities[itemId] = itemQuantities[itemId]! + 1;
      } else {
        itemQuantities[itemId] = 1;
      }
    }
  }

  List<Map<String, dynamic>> get uniqueItems {
    final uniqueItemsMap = <String, Map<String, dynamic>>{};
    for (var item in widget.cart) {
      uniqueItemsMap[item['name']] = item;
    }
    return uniqueItemsMap.values.toList();
  }

  int get totalAmount {
    int total = 0;
    for (var item in uniqueItems) {
      total += (item['price'] as int) * itemQuantities[item['name']]!;
    }
    return total;
  }

  void updateQuantity(String itemName, int change) {
    setState(() {
      int currentQty = itemQuantities[itemName] ?? 0;
      int newQty = currentQty + change;

      if (newQty <= 0) {
        // Remove item from cart if quantity becomes zero or less
        itemQuantities.remove(itemName);
        widget.cart.removeWhere((item) => item['name'] == itemName);
      } else {
        itemQuantities[itemName] = newQty;

        // If increasing, add another instance of this item to the cart
        if (change > 0) {
          final itemToAdd =
              widget.cart.firstWhere((item) => item['name'] == itemName);
          widget.cart.add(Map<String, dynamic>.from(itemToAdd));
        }
        // If decreasing, remove one instance of this item from the cart
        else if (change < 0) {
          final index =
              widget.cart.indexWhere((item) => item['name'] == itemName);
          if (index != -1) {
            widget.cart.removeAt(index);
          }
        }
      }
    });
  }

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          cart: widget.cart,
          quantities: itemQuantities,
          totalAmount: totalAmount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Add some delicious food items to your cart!'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: uniqueItems.length,
                    itemBuilder: (context, index) {
                      final item = uniqueItems[index];
                      final quantity = itemQuantities[item['name']] ?? 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${item['price']}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Total: ₹${(item['price'] as int) * quantity}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 16),
                                      onPressed: () {
                                        updateQuantity(item['name'], -1);
                                      },
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 16),
                                      onPressed: () {
                                        updateQuantity(item['name'], 1);
                                      },
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹$totalAmount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: widget.cart.isEmpty ? null : checkout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.cart.isEmpty
                              ? Colors.grey // disabled
                              : Theme.of(context).primaryColor, // enabled
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'CHECKOUT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Always white text
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
