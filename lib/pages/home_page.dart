import 'package:kuis_mobile_124230102/data/ambafood.dart';
import 'package:kuis_mobile_124230102/pages/login_page.dart';
import 'package:kuis_mobile_124230102/pages/profile_page.dart';
import 'package:kuis_mobile_124230102/pages/detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AmbaFood'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                return ProfilePage();
              }));
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), 
              (route) => false);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Hallo $username, Selamat datang di AmbaFood!"),
            Expanded(child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                ),
              itemBuilder: (context, index) {
                return _foodStoreCard(context, index);
              },
              itemCount: dummyFoods.length,
            )),
          ],
        ),
      ),
    );
  }

Widget _foodStoreCard(BuildContext context, int index) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(food: dummyFoods[index]),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
        border: Border.all(width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                dummyFoods[index].image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            dummyFoods[index].name,
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Kategori : ${dummyFoods[index].category}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Harga : ${dummyFoods[index].price}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}


}