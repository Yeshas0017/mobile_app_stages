import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Stage1SimpleApp());

class Stage1SimpleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stage 1 App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Stage1Home(),
    );
  }
}

enum YesNo { yes, no }

class Stage1Home extends StatefulWidget {
  @override
  _Stage1HomeState createState() => _Stage1HomeState();
}

class _Stage1HomeState extends State<Stage1Home> {
  final TextEditingController msgCtrl = TextEditingController(
    text: 'Welcome to my app',
  );
  final TextEditingController nameCtrl = TextEditingController(text: 'Name');

  YesNo choice = YesNo.yes;
  List<String> options = ['Option A', 'Option B', 'Option C'];
  String selected = 'Option A';

  void submit() {
    final msg = msgCtrl.text;
    final name = nameCtrl.text;
    final c = choice == YesNo.yes ? "Yes" : "No";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Submitted Info"),
        content: Text(
          "Message: $msg\n"
          "Name: $name\n"
          "Choice: $c\n"
          "Selected: $selected",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Future<void> openWebsite() async {
    final url = Uri.parse("https://www.google.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stage 1 Basic App")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // image
            Image.asset(
              'assets/images/myphoto.png',
              height: 150,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 10),

            Text(
              "Hello World!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            TextField(
              controller: msgCtrl,
              decoration: InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            DropdownButtonFormField(
              value: selected,
              items: options
                  .map((x) => DropdownMenuItem(value: x, child: Text(x)))
                  .toList(),
              onChanged: (v) => setState(() => selected = v!),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: YesNo.yes,
                  groupValue: choice,
                  onChanged: (v) => setState(() => choice = v!),
                ),
                Text("Yes"),
                SizedBox(width: 20),
                Radio(
                  value: YesNo.no,
                  groupValue: choice,
                  onChanged: (v) => setState(() => choice = v!),
                ),
                Text("No"),
              ],
            ),

            ElevatedButton(onPressed: submit, child: Text("Submit")),

            OutlinedButton(
              onPressed: openWebsite,
              child: Text("Open Website (Google)"),
            ),

            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SecondScreen()),
              ),
              child: Text("Go to Next Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Alert"),
              content: Text("This is an alert popup"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
          ),
          child: Text("Show Alert"),
        ),
      ),
    );
  }
}
