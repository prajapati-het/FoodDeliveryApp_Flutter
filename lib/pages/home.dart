import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobimall/widget/widget_support.dart';

import '../service/database.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  Stream<QuerySnapshot>? fooditemStream;

  ontheload() async {
    try {
      fooditemStream = await DatabaseMethods().getFoodItem('Pizza');
      setState(() {});
    } catch (e) {
      print("Error loading food items: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No data available"));
        }

        if (snapshot.hasError) {
          return Center(child: Text("An error occurred: ${snapshot.error}"));
        }

        return Container(
          height: 270, // Define a fixed height for the container
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"], name: ds["Name"],price:  ds["Price"],image: ds["Image"],)),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.0,bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              ds["Image"],
                              height: 120.0,
                              width: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Name"],
                                  style: AppWidget.SemiBoldTextFieldStyle(),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Detail"],
                                  style: AppWidget.LightTextFieldStyle(),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\$"+ds["Price"],
                                  style: AppWidget.SemiBoldTextFieldStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }


  Widget allItems() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No data available"));
        }

        if (snapshot.hasError) {
          return Center(child: Text("An error occurred: ${snapshot.error}"));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"], name: ds["Name"],price:  ds["Price"],image: ds["Image"],)),
                );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            ds["Image"],
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          ds["Name"],
                          style: AppWidget.SemiBoldTextFieldStyle(),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          ds["Detail"],
                          style: AppWidget.LightTextFieldStyle(),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          ds["Price"],
                          style: AppWidget.SemiBoldTextFieldStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /*Future<void> testFirestoreQuery() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('Pizza').get();
      print('Document count: ${snapshot.docs.length}');
      for (var doc in snapshot.docs) {
        print('Document: ${doc.data()}');
      }
    } catch (e) {
      print('Error querying Firestore: $e');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //testFirestoreQuery();  // Temporarily call this function to debug Firestore connection.
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Het,",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                "Delicious Food",
                style: AppWidget.HeadlineTextFieldStyle(),
              ),
              Text(
                "Discover and Get Great Food",
                style: AppWidget.LightTextFieldStyle(),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              SizedBox(height: 30.0),
              Container(
                height: 270,
                child: allItems(),
              ),
              SizedBox(height: 30.0),
              allItemsVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                "images/ice-cream.png",
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                "images/pizza.png",
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                "images/salad.png",
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                "images/burger.png",
                height: 40.0,
                width: 40.0,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
