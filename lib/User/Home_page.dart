import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/User/Product_details.dart';
import 'package:karshi/User/profile.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String Selected_catagory = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Krashi'),
        automaticallyImplyLeading: false, // Remove the back button icon
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Add profile icon onPressed logic
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProfilePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            DropdownButton<String>(
              value: Selected_catagory, // Maintain original variable name
              icon: const Icon(Icons.arrow_drop_down), // Down arrow icon
              iconSize: 24.0, // Icon size
              elevation: 16, // Shadow effect
              // Customize the style to match your UI
              style: const TextStyle(
                color: Colors.black, // Adjust text color
                fontSize: 16.0, // Adjust font size
              ),
              underline: Container(
                height: 2.0, // Thickness of the underline
                color: Colors.grey, // Adjust underline color
              ),
              onChanged: (String? newValue) {
                setState(() {
                  Selected_catagory = newValue!;
                });
              },
              items: <String>[
                'All',
                'One',
                'Two',
                'Three'
              ] // List of dropdown options
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ProductItem());
                },
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // View cart logic
                    },
                    child: const Text('View Cart'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Wishlist logic
                    },
                    child: const Text('Wishlist'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Product Name', // Replace with actual product name
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  // Add your function here
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProductDetailsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );

                  print('Image clicked!');
                },
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/images/temp.png"), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Add to wishlist logic
                },
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add to cart logic
                  setState(() {
                    quantity = 1;
                  });
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
