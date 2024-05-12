import 'package:flutter/material.dart';
import 'package:healthhub/Screens/Login-Signup/CustomDrawer.dart';
import 'package:healthhub/Screens/Login-Signup/dashboard.dart';
import 'package:page_transition/page_transition.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About' , style: TextStyle(
          color: Colors.white, // Couleur du texte en blanc
        ),),
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/icons/men.png', color: Colors.white,// Remplacez par le chemin de votre image
                ),
              ),
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 116, 180, 234),
      ),

      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image centrée
            Center(
              child: Image.asset(
                "images/bnb.png", // Chemin de l'image à afficher
                width: 250,
              ),
            ),
            SizedBox(height: 20),
            // Texte "HealthHub" en rouge
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black ,),
                children: <TextSpan>[
                  TextSpan(text: 'Health', style: TextStyle(color: Colors.blueAccent)),
                  TextSpan(text: 'Hub', style: TextStyle(color: Colors.blueAccent)),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
            // Paragraphe de description
            Text(
              "HealthHub revolutionizes appointment scheduling by providing a user-friendly platform for patients to easily find and book appointments with healthcare professionals based on specialty, location, and availability. It eliminates the hassle of long wait times and phone calls, making it simple to manage healthcare schedules and stay connected with medical providers.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            // Autres détails, si nécessaire
          ],
        ),
      ),
    );
  }
}
