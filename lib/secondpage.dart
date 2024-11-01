// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SecondPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // User details
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Career Objective
  final TextEditingController objectiveController = TextEditingController();

  // Education details
  List<Map<String, TextEditingController>> educationControllers = [
    {
      "degree": TextEditingController(),
      "year": TextEditingController(),
      "cgpa": TextEditingController(),
    },
  ];

  // Project details
  List<Map<String, TextEditingController>> projectControllers = [
    {
      "title": TextEditingController(),
      "description": TextEditingController(),
      "duration": TextEditingController(),
      "teamSize": TextEditingController(),
    },
  ];

  // Skills Section
  List<Map<String, TextEditingController>> skillControllers = [
    {
      "title": TextEditingController(),
      "subtitle": TextEditingController(),
    },
  ];

  // Certification Section
  List<Map<String, TextEditingController>> certificationControllers = [
    {
      "certificate": TextEditingController(),
      "link": TextEditingController(),
    },
  ];

  // Languages
  final TextEditingController languagesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/back2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: const Text('Edit Resume',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildEditableSection("Name", nameController),
                  _buildEditableSection("Email", emailController),
                  _buildEditableSection("Phone", phoneController),
                  _buildEditableSection("Location", locationController),
                  _buildEditableSection(
                      "Career Objective", objectiveController),
                  _buildSectionWithEntries("Education", educationControllers,
                      _buildEducationEntry, _addEducationEntry),
                  _buildSectionWithEntries("Projects", projectControllers,
                      _buildProjectEntry, _addProjectEntry),
                  _buildSectionWithEntries("Skills", skillControllers,
                      _buildSkillEntry, _addSkillEntry),
                  _buildSectionWithEntries(
                      "Certifications",
                      certificationControllers,
                      _buildCertificationEntry,
                      _addCertificationEntry),
                  _buildEditableSection("Languages", languagesController),
                  Center(
                    child: ElevatedButton(
                      onPressed: _generatePdf,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue),
                      child: Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableSection(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                hintText: 'Enter $title',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWithEntries(
      String title,
      List<Map<String, TextEditingController>> entries,
      Widget Function(int index) entryBuilder,
      VoidCallback onAdd) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Column(
                  children: entries
                      .asMap()
                      .entries
                      .map((entry) => entryBuilder(entry.key))
                      .toList(),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onAdd,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationEntry(int index) {
    return _buildEntry(
      "Education ${index + 1}",
      educationControllers[index],
      ["degree", "year", "cgpa"],
      ["Degree", "Year", "CGPA"],
      () => _removeEducationEntry(index),
    );
  }

  Widget _buildProjectEntry(int index) {
    return _buildEntry(
      "Project ${index + 1}",
      projectControllers[index],
      ["title", "description", "duration", "teamSize"],
      ["Title", "Description", "Duration", "Team Size"],
      () => _removeProjectEntry(index),
    );
  }

  Widget _buildSkillEntry(int index) {
    return _buildEntry(
      "Skill ${index + 1}",
      skillControllers[index],
      ["title", "subtitle"],
      ["Title", "Subtitle"],
      () => _removeSkillEntry(index),
    );
  }

  Widget _buildCertificationEntry(int index) {
    return _buildEntry(
      "Certification ${index + 1}",
      certificationControllers[index],
      ["certificate", "link"],
      ["Certificate", "Link (Optional)"],
      () => _removeCertificationEntry(index),
    );
  }

  Widget _buildEntry(
      String entryTitle,
      Map<String, TextEditingController> controllers,
      List<String> keys,
      List<String> labels,
      VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entryTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          for (int i = 0; i < keys.length; i++)
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: controllers[keys[i]],
                decoration: InputDecoration(
                  labelText: labels[i],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
        ],
      ),
    );
  }

  void _addEducationEntry() {
    setState(() {
      educationControllers.add({
        "degree": TextEditingController(),
        "year": TextEditingController(),
        "cgpa": TextEditingController(),
      });
    });
  }

  void _addProjectEntry() {
    setState(() {
      projectControllers.add({
        "title": TextEditingController(),
        "description": TextEditingController(),
        "duration": TextEditingController(),
        "teamSize": TextEditingController(),
      });
    });
  }

  void _addSkillEntry() {
    setState(() {
      skillControllers.add({
        "title": TextEditingController(),
        "subtitle": TextEditingController(),
      });
    });
  }

  void _addCertificationEntry() {
    setState(() {
      certificationControllers.add({
        "certificate": TextEditingController(),
        "link": TextEditingController(),
      });
    });
  }

  void _removeEducationEntry(int index) {
    setState(() {
      educationControllers.removeAt(index);
    });
  }

  void _removeProjectEntry(int index) {
    setState(() {
      projectControllers.removeAt(index);
    });
  }

  void _removeSkillEntry(int index) {
    setState(() {
      skillControllers.removeAt(index);
    });
  }

  void _removeCertificationEntry(int index) {
    setState(() {
      certificationControllers.removeAt(index);
    });
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(nameController.text,
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pw.Text(
                        '${emailController.text}  |  ${phoneController.text}  |  ${locationController.text}'),
                  ],
                ),
                pw.Divider(),
                pw.Text('CAREER OBJECTIVE',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text(objectiveController.text),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Text('EDUCATION',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                // Loop through education entries
                for (int i = 0; i < educationControllers.length; i++)
                  _education(educationControllers[i]),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Text('PROJECTS',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                // Loop through project entries
                for (int i = 0; i < projectControllers.length; i++)
                  _project(projectControllers[i]),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Text('TECHNICAL SKILLS',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                _buildSkillSection(),

                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Text('CERTIFICATES',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                _buildCertificates(),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Text('LANGUAGES',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                _buildLanguages(),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _education(Map<String, TextEditingController> controllers) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(controllers['degree']!.text,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(controllers['year']!.text,
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
            pw.Text(controllers['cgpa']!.text),
          ],
        ),
        // Assuming location is added as a part of education for demonstration
        // pw.Text('Location'), // You might want to replace this with actual data
        pw.SizedBox(height: 5),
      ],
    );
  }

  pw.Widget _project(Map<String, TextEditingController> controllers) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(controllers['title']!.text,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(
            '(Role: ${controllers['description']!.text})'), // Assuming description contains the role for simplicity
        pw.Text(controllers['description']!.text), // Actual project description
        pw.Text(controllers['duration']!.text,
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
        pw.SizedBox(height: 5),
      ],
    );
  }

  pw.Widget _buildSkillSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Text('Technical Skills:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        for (int i = 0; i < skillControllers.length; i++)
          pw.Bullet(
              text:
                  '${skillControllers[i]["title"]!.text} - ${skillControllers[i]["subtitle"]!.text}'),
      ],
    );
  }

  pw.Widget _buildCertificates() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Text('Certifications:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        for (var controller in certificationControllers)
          pw.Bullet(
            text: controller['certificate']!.text +
                (controller['link']!.text.isNotEmpty
                    ? ' (${controller['link']!.text})'
                    : ''),
          ),
      ],
    );
  }

  pw.Widget _buildLanguages() {
    final languages =
        languagesController.text.split(',').map((lang) => lang.trim()).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Text('Languages:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        for (var lang in languages) pw.Text(lang),
      ],
    );
  }
}

pw.Widget _buildPdfSection(
    String title,
    List<Map<String, TextEditingController>> entries,
    pw.Widget Function(int index) entryBuilder) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(title,
          style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold)),
      for (int i = 0; i < entries.length; i++) entryBuilder(i),
      pw.SizedBox(height: 20),
    ],
  );
}
