import 'package:flutter/material.dart';
import 'package:livecode/model/category_dishes_model.dart';
import 'package:livecode/service/service.dart';

import 'model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Model>? restaurant;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    restaurant = await RemoteService().fetchRestaurantData();
    if (restaurant != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(restaurant?.first.restaurantName ?? ""),
        backgroundColor: Colors.grey,
        elevation: 0,
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: Text("Fetching...")),
        child: SafeArea(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              List<CategoryDish>? dishes =
                  restaurant?.first.menuCategory?[index].categoryDishes;
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant?.first.menuCategory?[index].menuCategoryName ??
                          "",
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dishes?[index].dishName ?? ""),
                            Text(
                                "\$${dishes?[index].dishPrice.toString() ?? ""}")
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: dishes?.length ?? 0,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 30,
              );
            },
            itemCount: restaurant?.first.menuCategory?.length ?? 0,
          ),
        ),
      ),
    );
  }
}
