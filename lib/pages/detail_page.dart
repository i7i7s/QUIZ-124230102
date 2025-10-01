import 'package:flutter/material.dart';
import 'package:kuis_mobile_124230102/models/ambastore.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Food food;
  const DetailPage({super.key, required this.food});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  final TextEditingController _qtyController = TextEditingController(text: "1");

  Future<void> _openRecipe() async {
    final uri = Uri.parse(widget.food.recipeUrl);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil Checkout ${widget.food.name} x$quantity"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = widget.food.price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.food.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.food.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text("Kategori: ${widget.food.category}"),
            Text("Harga: Rp ${widget.food.price}"),
            Text("Bahan: ${widget.food.ingredients}"),
            Text("Kalori: ${widget.food.calories} kkal"),
            const SizedBox(height: 12),
            Text(widget.food.description, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _openRecipe,
                child: Text("Lihat Resep ${widget.food.name}"),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Jumlah",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        quantity = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                Text(
                  "Total Harga: Rp $totalPrice"
                )
              ],
            ),

            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: _checkout,
                child: const Text("Checkout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
