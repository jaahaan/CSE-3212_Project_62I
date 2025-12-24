import 'package:flutter/material.dart';
import 'package:project_62i/converter_page.dart';
import 'package:project_62i/gridview_page.dart';
import 'package:project_62i/listview_page.dart';
import 'package:project_62i/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    final res =
        await _supabase.from('profiles').select().eq('id', user.id).single();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.blueGrey,
        // leading: Icon(Icons.home),
        actions: [
          IconButton(
            onPressed: () {
              _supabase.auth.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: NavigationDrawer(
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  }
                  if (!snapshot.hasData) {
                    return const Text("No User Found!!");
                  }
                  final profile = snapshot.data as Map<String, dynamic>;
                  return SizedBox(
                    width: 300,
                    height: 100,
                    child: Card(
                      color: Colors.blueGrey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Name: ${profile['name']}"),
                          Text("Email: ${profile['email']}"),
                          if (profile['avatar_url'] != null)
                            Image.network(profile['avatar_url']),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListviewPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      fixedSize: Size(150, 50),
                    ),
                    child: Text("ListView"),
                  ),

                  SizedBox(width: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GridviewPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      fixedSize: Size(150, 50),
                    ),
                    child: Text("GridView"),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConverterPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      fixedSize: Size(150, 50),
                    ),
                    child: Text("Converter"),
                  ),

                  SizedBox(width: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      fixedSize: Size(150, 50),
                    ),
                    child: Text("Profile"),
                  ),
                ],
              ),
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
      ),
    );
  }
}
