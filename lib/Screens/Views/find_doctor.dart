import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthhub/Screens/Views/doctor_details_screen.dart';
import 'package:healthhub/Screens/Widgets/doctorList.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Login-Signup/provider.dart';

class find_doctor extends StatefulWidget {
  const find_doctor({Key? key}) : super(key: key);

  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<find_doctor> {
  List<Map<String, dynamic>> searchResults = [];
  List<Map<String, dynamic>> recentDoctors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          Provider.of<UiProvider>(context)
              .getLocale()
              .keys[Provider.of<UiProvider>(context).language]?["60"] ?? "Find Doctor",
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 51, 47, 47),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: _searchDoctor,
                decoration: InputDecoration(
                  prefixIcon: Icon(LineAwesomeIcons.search),
                  labelText: Provider.of<UiProvider>(context)
                      .getLocale()
                      .keys[Provider.of<UiProvider>(context).language]?["48"] ?? "Search doctor, drugs, articles...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    Provider.of<UiProvider>(context)
                        .getLocale()
                        .keys[Provider.of<UiProvider>(context).language]?["57"] ?? "Top Doctor",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display search results
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle tap on search result
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetails(doctorData: searchResults[index]),
                      ),
                    );
                  },
                  child: doctorList(
                    image: searchResults[index]['imageURL'] ?? '', // Utilisez une valeur par défaut si l'image est null
                    maintext: searchResults[index]['username'] ?? '', // Utilisez une valeur par défaut si le nom d'utilisateur est null
                    numRating: '', // Vous pouvez remplir cela avec les données appropriées si nécessaire
                    subtext: searchResults[index]['specialite'] ?? '', // Utilisez une valeur par défaut si la spécialité est null
                    adresse: searchResults[index]['adresse'] ?? '', // Utilisez une valeur par défaut si l'adresse est null
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

            ),
            SizedBox(height: 5),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Your Recent Doctors",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: recentDoctors.map((result) {
                print(result['username']);
                print(result['specialite']);
                final imagePath = result['imageURL'];
                final name = result['username'];
                final specialite = result['specialite'];
                final adresse = result['adresse'];
                if (imagePath != null && name != null) {
                  return doctorList(
                    image: '$imagePath', maintext: '$name', numRating: '4.5', subtext: '$specialite', adresse: '$adresse',
                  );
                } else {
                  // Gérer le cas où imagePath ou name est null
                  return SizedBox(); // Ou tout autre widget de remplacement approprié
                }
              }).toList(),
            ),

          ],
        ),
      ),
    );
  }

  void _searchDoctor(String query) {
    // Convert the search string to lowercase for case-insensitive matching
    String searchQuery = query.toLowerCase();
    print(searchQuery);
    // Perform search only if search string is not empty
    if (searchQuery.isNotEmpty) {
      // Reset search results
      setState(() {
        searchResults.clear();
      });
      // Firestore query to retrieve doctors matching the search
      FirebaseFirestore.instance
          .collection('Doctor')
          .get()
          .then((querySnapshot) {
        // Process search results
        querySnapshot.docs.forEach((doc) {
          String username = doc['username'].toLowerCase();
          String imageURL = doc['imageURL'];
          String adresse = doc['adress'];
          String specialite=doc['specialite'];
          RegExp regExp = RegExp(searchQuery);
          if (regExp.hasMatch(username)) {
            // Add search results to the list of results
            setState(() {
              searchResults.add({
                'username': doc['username'],
                'imageURL': imageURL,
                'adresse' : adresse,
                'specialite':specialite
              });
            });
          }
        });

        if (searchResults.isEmpty) {
          // No results found
          print('No doctors found for search: $searchQuery');
        }
      }).catchError((error) {
        // Handle any errors that occur while executing the search
        print('Error searching for doctors: $error');
      });
    } else {
      // If search string is empty, clear previous results
      setState(() {
        recentDoctors.addAll(searchResults);
        searchResults.clear();
      });
    }
  }

}
