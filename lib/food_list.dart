import 'package:flutter/material.dart';
import 'package:foodie/cartpage.dart';

class FoodListPage extends StatefulWidget {
  final String category;

  FoodListPage({required this.category});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final List<Map<String, dynamic>> foodItems = [
    // 🍕 Pizza
    {
      'name': 'Margherita Pizza',
      'price': 199,
      'image': 'assets/images/pizza1.jpg',
      'category': 'Pizza',
    },
    {
      'name': 'Pepperoni Pizza',
      'price': 249,
      'image': 'assets/images/pizza2.jpg',
      'category': 'Pizza',
    },
    {
      'name': 'Veggie Supreme',
      'price': 229,
      'image': 'assets/images/pizza3.jpg',
      'category': 'Pizza',
    },

    // 🍔 Burgers
    {
      'name': 'Cheeseburger',
      'price': 159,
      'image': 'assets/images/burger1.jpg',
      'category': 'Burgers',
    },
    {
      'name': 'Veggie Burger',
      'price': 139,
      'image': 'assets/images/burger2.jpg',
      'category': 'Burgers',
    },
    {
      'name': 'Chicken Burger',
      'price': 179,
      'image': 'assets/images/burger3.jpg',
      'category': 'Burgers',
    },

    // 🍜 Chinese
    {
      'name': 'Veg Hakka Noodles',
      'price': 149,
      'image': 'assets/images/chinese1.jpg',
      'category': 'Chinese',
    },
    {
      'name': 'Manchurian Gravy',
      'price': 169,
      'image': 'assets/images/chinese2.jpg',
      'category': 'Chinese',
    },
    {
      'name': 'Fried Rice',
      'price': 139,
      'image': 'assets/images/chinese3.jpg',
      'category': 'Chinese',
    },

    // 🍰 Desserts
    {
      'name': 'Chocolate Cake',
      'price': 99,
      'image': 'assets/images/dessert1.jpg',
      'category': 'Desserts',
    },
    {
      'name': 'Gulab Jamun',
      'price': 69,
      'image': 'assets/images/dessert2.jpg',
      'category': 'Desserts',
    },
    {
      'name': 'Ice Cream',
      'price': 89,
      'image': 'assets/images/dessert3.jpg',
      'category': 'Desserts',
    },

    // 🥤 Drinks
    {
      'name': 'Coca Cola',
      'price': 49,
      'image': 'assets/images/drink1.jpg',
      'category': 'Drinks',
    },
    {
      'name': 'Mango Shake',
      'price': 79,
      'image': 'assets/images/drink2.jpg',
      'category': 'Drinks',
    },
    {
      'name': 'Cold Coffee',
      'price': 99,
      'image': 'assets/images/drink3.jpg',
      'category': 'Drinks',
    },
  ];

  List<Map<String, dynamic>> cart = [];

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        foodItems.where((item) => item['category'] == widget.category).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).primaryColor, // Or any color you want
        iconTheme: const IconThemeData(color: Colors.white), // Icon color white
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold), // Title text color white
        title: Text('${widget.category} Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart),
                ),
              );
            },
          )
        ],
      ),
      body: filteredItems.isEmpty
          ? const Center(child: Text('No items available in this category.'))
          : ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final food = filteredItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        food['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(food['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('₹${food['price']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cart.add(food);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Important to wrap content tightly
                        children: const [
                          Icon(Icons.add_shopping_cart,
                              color: Colors.white), // Custom icon color
                          SizedBox(
                              width: 6), // Small space between icon and text
                          Text('Add',
                              style: TextStyle(
                                  color: Colors.white)), // Custom text color
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
