import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  TextEditingController controller = TextEditingController();
  String? errorText;
  double result = 0;

  void convert() {
    // print(controller);
    String text = controller.text;

    if (text.isEmpty) {
      errorText = "Field is empty!!";
    } else {
      errorText = null;
      result = double.parse(text) * 121.64;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text("Converter"),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 500,
          child: Card(
            color: Colors.blueGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("USD ", style: TextStyle(fontSize: 20)),
                    Icon(Icons.swap_horiz),
                    Text(" BDT", style: TextStyle(fontSize: 20)),
                  ],
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      errorText: errorText,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                ElevatedButton(onPressed: convert, child: Text("Convert")),

                SizedBox(height: 20),

                Text("BDT $result", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
