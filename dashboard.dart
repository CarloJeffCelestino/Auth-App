import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/screens/settings.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.data() == null) {
          // User document does not exist or is empty
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('Home'),
                      onTap: () {
                        // Navigate to Home
                      },
                    ),
                    ListTile(
                      title: const Text('Settings'),
                      onTap: () {
                        // Navigate to Settings
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Logout'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                      child: Text(
                    'Loading please wait...',
                    style: TextStyle(
                        color: Color.fromARGB(255, 187, 30, 19), fontSize: 40),
                  )),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final imageUrl = userData['image_url'];
        final firstName = userData['firstName'];
        final lastName = userData['lastName'];

        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            actions: [
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
            ],
          ),
          drawer: Drawer(
            width: 250,
            child: Container(
              color: Colors.black
                  .withOpacity(0.6), // Add blur black background color
              child: ListView(
                children: [
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Navigate to Dashboard
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Create a UserCredential object using the user's UID
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: Text('Welcome back $firstName $lastName '),
          ),
        );
      },
    );
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DashScreen extends StatelessWidget {
//   const DashScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text(''),
//             ),
//             body: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         if (!snapshot.hasData || snapshot.data!.data() == null) {
//           // User document does not exist or is empty
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Scaffold(
//               appBar: AppBar(
//                 title: const Text(''),
//               ),
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   const Center(
//                       child: Text(
//                     'Loading please wait...',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 187, 30, 19), fontSize: 40),
//                   )),
//                   Center(
//                     child: IconButton(
//                       onPressed: () {
//                         FirebaseAuth.instance.signOut();
//                       },
//                       icon: const Icon(
//                         Icons.exit_to_app,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         final userData = snapshot.data!.data() as Map<String, dynamic>;
//         final imageUrl = userData['image_url'];
//         final firstName = userData['firstName'];
//         final lastName = userData['lastName'];

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text(''),
//             actions: [
//               if (imageUrl != null)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20.0),
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(imageUrl),
//                   ),
//                 ),
//               Center(
//                 child: IconButton(
//                   onPressed: () {
//                     FirebaseAuth.instance.signOut();
//                   },
//                   icon: const Icon(
//                     Icons.exit_to_app,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           body: Center(
//             child: Text('Welcome back $firstName $lastName '),
//           ),
//         );
//       },
//     );
//   }
// }
