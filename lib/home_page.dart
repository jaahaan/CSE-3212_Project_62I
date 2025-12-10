import 'package:flutter/material.dart';
import 'package:project_62i/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.blueGrey,
        // leading: Icon(Icons.home),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        // ],
      ),
      endDrawer: NavigationDrawer(
        children: [
          DrawerHeader(
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              accountName: Text("Name"),
              accountEmail: Text("Email"),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.home),
            title: Text("Homepage"),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/flutter.png", height: 200, width: 200),
            Text(
              "Homepage",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Card(
                color: Colors.brown,
                child: Center(
                  child: Text("Card", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.fromLTRB(20, 30, 40, 50),
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                border: Border.all(color: Colors.lightBlueAccent, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // shape: BoxShape.circle,
              ),
              child: Text("Container"),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      fixedSize: Size(150, 40),
                    ),
                    child: Text("Elevated"),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text("Hello")),
                SizedBox(width: 20),
                OutlinedButton(onPressed: () {}, child: Text("Outlined")),
                TextButton(onPressed: () {}, child: Text("Hello")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
