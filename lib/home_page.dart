import 'package:flutter/material.dart';
import 'package:foodie/BackgroundContainer.dart';
import 'food_list.dart'; // Import the FoodListPage
import 'profilepage.dart'; // Import ProfilePage
import 'searchpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Pizza', 'icon': Icons.local_pizza, 'color': Colors.orange},
    {'name': 'Burgers', 'icon': Icons.fastfood, 'color': Colors.amber},
    {'name': 'Chinese', 'icon': Icons.ramen_dining, 'color': Colors.redAccent},
    {'name': 'Desserts', 'icon': Icons.cake, 'color': Colors.pink},
    {'name': 'Drinks', 'icon': Icons.local_drink, 'color': Colors.blue},
  ];
  // Sample restaurants list
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCategoryTapped(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodListPage(category: category),
      ),
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 1) {
      return SearchPage();
    } else if (_selectedIndex == 2) {
      return ProfilePage();
    } else {
      final List<Map<String, dynamic>> restaurants = [
        {
          'name': 'Pizza Palace',
          'image': 'assets/images/restaurant1.jpg',
          'review': 4.5,
        },
        {
          'name': 'Burger Hub',
          'image': 'assets/images/restaurant2.jpg',
          'review': 4.2,
        },
        {
          'name': 'Dragon Wok',
          'image': 'assets/images/restaurant3.jpg',
          'review': 4.6,
        },
        {
          'name': 'Sweet Treats',
          'image': 'assets/images/restaurant4.jpg',
          'review': 4.8,
        },
      ];

      return BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: category['color'].withOpacity(0.9),
                      child: InkWell(
                        onTap: () => _onCategoryTapped(category['name']),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(category['icon'],
                                  size: 40, color: Colors.white),
                              const SizedBox(height: 8),
                              Text(
                                category['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Popular Restaurants',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurants.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 160,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              restaurant['image'],
                              height: 100,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          size: 16, color: Colors.orange),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${restaurant['review']}',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
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
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Foodie'),
        backgroundColor: Colors.red[700],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
