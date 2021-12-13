import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var pizzaName = '';
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('images/pizza-pepperoni.jpeg'),
                width: 400,
              ),
              const SizedBox(height: 50),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Podaj nazwę restauracji'),
                onChanged: (newValue) {
                  setState(() {
                    restaurantName = newValue;
                  });
                },
              ),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Podaj nazwę pizzy'),
                onChanged: (newValue) {
                  setState(() {
                    pizzaName = newValue;
                  });
                },
              ),
              Slider(
                onChanged: (newValue) {
                  setState(() {
                    rating = newValue;
                  });
                },
                value: rating,
                min: 1.0,
                max: 6.0,
                divisions: 10,
                label: rating.toString(),
                thumbColor: Colors.amber,
                activeColor: Colors.amber,
                inactiveColor: Colors.black,
              ),
              ElevatedButton(
                onPressed: restaurantName.isEmpty || pizzaName.isEmpty
                    ? null
                    : () {
                        FirebaseFirestore.instance
                            .collection('restaurants')
                            .add(
                          {
                            'name': restaurantName,
                            'pizza': pizzaName,
                            'rating': rating,
                          },
                        );
                        widget.onSave();
                      },
                child: const Text('Dodaj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
