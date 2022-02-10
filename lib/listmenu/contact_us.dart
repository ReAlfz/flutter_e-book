import 'package:ebooks/helper/colors_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contact_Us extends StatefulWidget {
  @override
  _Contact_UsState createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
            ),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: new TextStyle(
                  fontSize: 16.0,
                  color: ColorsRes.black
                ),
                children: <TextSpan>[
                  new TextSpan(
                    text: "For any kind of queries related to products please contact us. \n  \n",
                    style: new TextStyle(),
                  ),
                  new TextSpan(
                    text: "To help our ",
                    style: new TextStyle(),
                  ),
                  new TextSpan(
                    text: "Customers",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new TextSpan(
                    text: ", we constantly be in touch with every customer if they need any assistance regarding our product. We offer our customers support from Mon – Fri 9.00am to 6.00pm IST (GMT +5.30) – We are a company located in India – Asia.Typically we reply to our customers for all the questions and queries within 24 hours of time via comments, support forums, or emails. ",
                  ),
                  new TextSpan(
                    text: "\n \nThank You...",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
