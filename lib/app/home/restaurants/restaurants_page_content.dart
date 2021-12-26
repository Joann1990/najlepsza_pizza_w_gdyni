import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_gdyni/app/home/restaurants/cubit/restaurants_cubit.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit(),
      child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Something went wrong: ${state.errorMessage}'),
            );
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = state.documents;
          return Container(
            color: Colors.grey,
            child: ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('restaurants')
                          .doc(document.id)
                          .delete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['name']),
                              Text(document['pizza']),
                            ],
                          ),
                          Text(document['rating'].toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('restaurants')
                  .orderBy('rating', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {});
        },
      ),
    );
  }
}
