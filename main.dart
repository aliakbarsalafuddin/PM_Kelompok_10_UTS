import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz RRQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomePage(),
    );
  }
}

// ===================== HOME PAGE =====================
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/rrq.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Mulai RRQuiz',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== QUIZ PAGE =====================
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

//ABSTRAKSI
class Question {
  String text;
  List<String> options;
  int correctIndex;

  Question(this.text, this.options, this.correctIndex);
}

//ENKAPSULASI
class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [
    Question("Apa kepanjangan RRQ?", ["Rek Rek Qang", "Rang Rang Qing", "Rose Rasa Qutang", "Rex Regum Qeon"], 3),
    Question("Apa arti nama RRQ?", ["Raja Badut", "Raja Langit", "Raja dari Segala Raja", "Raja Bumi"], 2),
    Question("Berapa kali RRQ juara MPL?", ["1", "2", "3", "4"], 3),
    Question("Siapa salah satu pendiri RRQ?", ["Pak AP", "Albert", "Lemon", "Acil"], 0),
    Question("Siapa salah satu nama player RRQ?", ["Pak AP", "Jess No Limit", "Lemon", "Acil"], 2),
    Question("Siapa rival RRQ hingga disebut ELCLASICO?", ["EVOS", "ONIC", "ALTER EGO", "BIGETRON"], 0),
    Question("Tahun berapa RRQ dibuat?", ["2010", "2011", "2012", "2013"], 3),
    Question("Sebutkan salah satu sponsor RRQ?", ["Biznet", "Indomie", "Kacang Garuda", "Torabica Cappucino"], 0),
    Question("Berapa kali RRQ juara MSERIES?", ["0", "1", "4", "5"], 0),
    Question("Dimana homebase RRQ?", ["Aceh", "Bali", "Jakarta", "Surabaya"], 2),
  ];

  int currentQuestion = 0;
  int score = 0;
  bool isAnswered = false;
  String feedback = "";

  void checkAnswer(int selectedIndex) {
    if (isAnswered) return;

    setState(() {
      isAnswered = true;
      if (selectedIndex == questions[currentQuestion].correctIndex) {
        score++;
        feedback = "Benar! 🎉";
      } else {
        feedback = "Salah! 😢";
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentQuestion < questions.length - 1) {
          currentQuestion++;
          isAnswered = false;
          feedback = "";
        } else {
          // Quiz selesai
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultPage(score: score, total: questions.length)),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Question q = questions[currentQuestion];
    return Scaffold(
      appBar: AppBar(title: Text("Soal ${currentQuestion + 1}/${questions.length}")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              q.text,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...List.generate(q.options.length, (index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: Size.fromHeight(45),
                ),
                onPressed: () => checkAnswer(index),
                child: Text(q.options[index]),
              );
            }),
            SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(fontSize: 20, color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}

// ===================== RESULT PAGE =====================
class ResultPage extends StatelessWidget {
  final int score;
  final int total;

  ResultPage({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hasil Quiz")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Skor Kamu",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "$score dari $total benar",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text("Kembali ke Beranda"),
            )
          ],
        ),
      ),
    );
  }
}
