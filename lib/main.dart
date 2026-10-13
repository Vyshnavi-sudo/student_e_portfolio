import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const StudentPortfolioApp());
}

const Color primaryPurple = Color(0xFF7047EB);
const Color lightPurple = Color(0xFFF5F1FF);

class StudentPortfolioApp extends StatelessWidget {
  const StudentPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student E-Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFCFAFF),
      ),
      home: const LoginPage(),
    );
  }
}

// ================= LOGIN PAGE =================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (nameController.text.trim().isEmpty ||
        rollController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the fields')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardPage(
          studentName: nameController.text.trim(),
          rollNumber: rollController.text.trim(),
        ),
      ),
    );
  }

  Widget profilePhoto({double size = 125, Color iconColor = primaryPurple}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primaryPurple, width: 3),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/profile.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: size * 0.62, color: iconColor);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryPurple, Color(0xFFB69AFF), lightPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'STUDENT E-PORTFOLIO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: primaryPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome to My Portfolio',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    profilePhoto(),
                    const SizedBox(height: 25),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: rollController,
                      decoration: InputDecoration(
                        labelText: 'Roll Number',
                        prefixIcon: const Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= DASHBOARD =================

class DashboardPage extends StatefulWidget {
  final String studentName;
  final String rollNumber;

  const DashboardPage({
    super.key,
    required this.studentName,
    required this.rollNumber,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProfilePage(
        studentName: widget.studentName,
        rollNumber: widget.rollNumber,
      ),
      const AcademicInformationPage(),
      const AchievementsPage(),
      const ActivitiesPage(),
      const ProjectsPage(),
      const CertificatesPage(),
    ];

    final destinations = const [
      NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      NavigationDestination(icon: Icon(Icons.school), label: 'Academics'),
      NavigationDestination(
        icon: Icon(Icons.emoji_events),
        label: 'Achievements',
      ),
      NavigationDestination(icon: Icon(Icons.groups), label: 'Activities'),
      NavigationDestination(icon: Icon(Icons.code), label: 'Projects'),
      NavigationDestination(
        icon: Icon(Icons.workspace_premium),
        label: 'Certificates',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Portfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: lightPurple,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: destinations,
      ),
    );
  }
}

// ================= REUSABLE CARD =================

Widget portfolioCard(IconData icon, String title, String description) {
  return Card(
    color: Colors.white,
    elevation: 2,
    margin: const EdgeInsets.only(bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFEAE2FF),
        child: Icon(icon, color: primaryPurple),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(description, style: const TextStyle(height: 1.5)),
      ),
    ),
  );
}

Widget pageHeading(String title, {String? subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: Color(0xFF35245E),
        ),
      ),
      if (subtitle != null) ...[
        const SizedBox(height: 8),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
      const SizedBox(height: 22),
    ],
  );
}

// ================= PROFILE =================

class ProfilePage extends StatelessWidget {
  final String studentName;
  final String rollNumber;

  const ProfilePage({
    super.key,
    required this.studentName,
    required this.rollNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        pageHeading('My Profile'),
        Center(
          child: Container(
            width: 136,
            height: 136,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryPurple, width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/profile.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 82,
                    color: primaryPurple,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: Text(
            studentName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            rollNumber,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        const SizedBox(height: 25),
        portfolioCard(
          Icons.school,
          'College',
          'BVRIT Hyderabad College of Engineering for Women, Hyderabad',
        ),
        portfolioCard(
          Icons.computer,
          'Branch',
          'Computer Science and Engineering',
        ),
        portfolioCard(
          Icons.person_outline,
          'About Me',
          'I am a CSE undergraduate interested in analytical thinking, '
              'technology, and solving real-world problems.',
        ),
        portfolioCard(
          Icons.flag,
          'Career Interests',
          'FinTech, Product Management, Business Analysis, and Data Analytics.',
        ),
      ],
    );
  }
}

// ================= ACADEMIC INFORMATION =================

class AcademicInformationPage extends StatelessWidget {
  const AcademicInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        pageHeading(
          'Academic Information',
          subtitle: 'My education journey and academic performance',
        ),
        portfolioCard(
          Icons.school,
          'Bachelor of Technology (B.Tech)',
          'Branch: Computer Science and Engineering\n'
              'Institution: BVRIT Hyderabad College of Engineering for Women, Hyderabad\n'
              'Duration: 2024–2028\n'
              'CGPA: 7.9',
        ),
        portfolioCard(
          Icons.menu_book,
          'Intermediate – TSBIE',
          'Institution: Narayana Junior College, Hyderabad\n'
              'Duration: 2022–2024\n'
              'Percentage: 96.4%',
        ),
        portfolioCard(
          Icons.history_edu,
          'Secondary Education – CBSE',
          'Institution: Harvest Public School, Khammam\n'
              'Duration: 2021–2022\n'
              'Percentage: 91.4%',
        ),
      ],
    );
  }
}

// ================= ACHIEVEMENTS =================

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        pageHeading('My Achievements'),
        portfolioCard(
          Icons.code,
          'Python Certification',
          'Completed Python certification from Scaler.',
        ),
        portfolioCard(
          Icons.coffee,
          'Java OOP Certification',
          'Completed Object-Oriented Programming with Java.',
        ),
        portfolioCard(
          Icons.account_tree,
          'DSA Certification',
          'Completed Data Structures and Algorithms training.',
        ),
        portfolioCard(
          Icons.language,
          'HTML and CSS',
          'Completed HTML and CSS courses through Infosys Springboard.',
        ),
        portfolioCard(
          Icons.emoji_events,
          'AlgoHack 2.0',
          'Participated in AlgoHack 2.0 at BVRIT Hyderabad College of '
              'Engineering for Women.',
        ),
        portfolioCard(
          Icons.school,
          'FOSSEE Python Workshop',
          'Participated in a Python workshop through FOSSEE, IIT Bombay.',
        ),
      ],
    );
  }
}

// ================= EXTRACURRICULAR ACTIVITIES =================

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        pageHeading('Extracurricular Activities'),
        portfolioCard(
          Icons.volunteer_activism,
          'Graduation Ceremony Volunteer',
          'BVRITH · August 2025\n'
              'Managed event logistics, stage coordination, and certificate '
              'distribution.',
        ),
        portfolioCard(
          Icons.groups,
          'Orientation Programme Volunteer',
          'BVRITH · August 2025\n'
              'Supported event logistics and stage coordination for the '
              'orientation programme.',
        ),
        portfolioCard(
          Icons.event,
          'Google Developer Groups (GDG) Event',
          'August 2025\n'
              'Attended technical sessions on emerging technologies, '
              'developer tools, and industry practices.',
        ),
        portfolioCard(
          Icons.handshake,
          'Skills',
          'Teamwork, communication, event coordination, responsibility, '
              'and time management.',
        ),
      ],
    );
  }
}

// ================= PROJECTS =================

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        pageHeading('My Projects'),
        portfolioCard(
          Icons.account_balance,
          'Macro-AI Credit Risk Assessment Model',
          'An AI-based system that assesses credit risk using borrower '
              'information and macroeconomic indicators.\n'
              'Date: April 2026',
        ),
        portfolioCard(
          Icons.input,
          'Input Parameters',
          'Credit score, income, loan amount, GDP growth, inflation, '
              'and unemployment.',
        ),
        portfolioCard(
          Icons.analytics,
          'Project Output',
          'Classifies predicted credit risk as Low, Medium, or High and '
              'provides suggestions.',
        ),
        portfolioCard(
          Icons.terminal,
          'Technologies Used',
          'Python, Machine Learning, Random Forest, Flask, HTML, CSS, and CSV.',
        ),
        portfolioCard(
          Icons.lightbulb,
          'My Contribution',
          'Contributed to ideation, technology research, implementation, '
              'and model evaluation.',
        ),
        portfolioCard(
          Icons.schedule,
          'Cobbler’s Shop Order Scheduling System',
          'Developed a Python application that prioritizes customer requests '
              'using a scheduling algorithm.\n'
              'Date: February 2025',
        ),
        portfolioCard(
          Icons.memory,
          'Scheduling Project Technologies',
          'Python, Priority Queue, heapq, and scheduling algorithms.\n'
              'Contribution: Designed the scheduling algorithm, implemented '
              'the Python code, and tested the solution.',
        ),
      ],
    );
  }
}

// ================= CERTIFICATES =================

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fadeAnimation;
  late final Animation<double> scaleAnimation;

  int currentIndex = 0;
  Timer? timer;

  final List<Map<String, String>> certificates = [
    {'title': 'Python Programming', 'organization': 'Scaler'},
    {
      'title': 'Object-Oriented Programming in Java',
      'organization': 'CodeChef',
    },
    {
      'title': 'Data Structures and Algorithms',
      'organization': 'CodeChef',
    },
    {'title': 'HTML and CSS', 'organization': 'Infosys Springboard'},
  ];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    controller.forward();

    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;

      setState(() {
        currentIndex = (currentIndex + 1) % certificates.length;
      });

      controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final certificate = certificates[currentIndex];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        pageHeading(
          'My Certificates',
          subtitle: 'My learning journey and certifications',
        ),
        FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryPurple, Color(0xFFB69AFF)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    color: Colors.white,
                    size: 65,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'CERTIFICATE OF ACHIEVEMENT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    certificate['title']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    certificate['organization']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${currentIndex + 1} / ${certificates.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'Certificate Gallery',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ...List.generate(certificates.length, (index) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.workspace_premium,
                color: primaryPurple,
              ),
              title: Text(certificates[index]['title']!),
              subtitle: Text(certificates[index]['organization']!),
              trailing: const Icon(Icons.play_circle_outline),
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
                controller.forward(from: 0);
              },
            ),
          );
        }),
        const SizedBox(height: 15),
        const Text(
          'This gallery lists certificate names. Add original certificate '
          'images later if you want to display the actual documents.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}