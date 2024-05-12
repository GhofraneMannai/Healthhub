import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthhub/Screens/Views/Dashboard_screen.dart';
import 'package:healthhub/Screens/Widgets/doctorList.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Login-Signup/provider.dart';
import 'doctor_details_screen.dart';

class doctor_search extends StatelessWidget {
  final String specialty;

  const doctor_search({Key? key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title:   Text(
          "Doctor $specialty",
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 51, 47, 47),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: specialty.isEmpty
                    ? FirebaseFirestore.instance.collection('Doctor').snapshots()
                    : FirebaseFirestore.instance.collection('Doctor').where('specialite', isEqualTo: specialty).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Aucun médecin de cette spécialité n\'a été trouvé.'));
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorDetails(doctorData: data)),
                            );
                          },
                          child: doctorList(
                            image: data['imageURL'],
                            maintext: data['username'],
                            numRating: '',
                            subtext: data['specialite'],
                            adresse: data['adress'],
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
