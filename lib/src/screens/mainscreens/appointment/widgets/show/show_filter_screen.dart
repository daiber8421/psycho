import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phsycho/src/data/styles.dart';
import 'package:phsycho/src/imports.dart';

class ShowFilterScreen extends StatefulWidget {
  const ShowFilterScreen({
    super.key,
    required this.selectedGrade,
    required this.selectedCourse,
    required this.selectedStatus,
    required this.selectedImportanci,
    required this.selectedDate,
  });

  final String selectedGrade;
  final String selectedCourse;
  final String selectedStatus;
  final String selectedImportanci;
  final String selectedDate;

  @override
  State<ShowFilterScreen> createState() => _ShowFilterScreenState();
}

class _ShowFilterScreenState extends State<ShowFilterScreen> {
  late String selectedGrade;
  late String selectedCourse;
  late String selectedStatus;
  late String selectedImportanci;
  late String selectedDate;

  @override
  void initState() {
    super.initState();
    selectedGrade = widget.selectedGrade;
    selectedCourse = widget.selectedCourse;
    selectedStatus = widget.selectedStatus;
    selectedImportanci = widget.selectedImportanci;
    selectedDate = widget.selectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), // Fecha de inicio
      lastDate: DateTime(2101), // Fecha de fin
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'selectedGrade': selectedGrade,
      'selectedCourse': selectedCourse,
      'selectedStatus': selectedStatus,
      'selectedImportanci': selectedImportanci,
      'selectedDate': selectedDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrar citas"),
        flexibleSpace: Container(
          decoration: AddContainerStyle.appBarGradient,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Filtros",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colours.main2,
                ),
              ),
            ),
            _buildFilterDropdown(
              "Grado",
              Icons.school,
              selectedGrade,
              grades,
              (String? newValue) {
                setState(() {
                  selectedGrade = newValue!;
                });
              },
            ),
            _buildFilterDropdown(
              "Curso",
              Icons.class_,
              selectedCourse,
              course,
              (String? newValue) {
                setState(() {
                  selectedCourse = newValue!;
                });
              },
            ),
            _buildFilterDropdown(
              "Estado",
              Icons.check_circle_outline,
              selectedStatus,
              status,
              (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
            ),
            _buildFilterDropdown(
              "Importancia",
              Icons.priority_high,
              selectedImportanci,
              gradeIlistF,
              (String? newValue) {
                setState(() {
                  selectedImportanci = newValue!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(
                  Icons.date_range,
                  color: Colours.main2,
                ),
                title: Text(selectedDate.isEmpty ? 'Selecciona la fecha' : selectedDate,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    )),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today, color: Colours.secondary),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.filter_list, color: Colors.white),
                label: Text("Aplicar filtros"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.main2,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
      String label, IconData icon, String selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colours.main2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            isDense: true,
            isExpanded: true,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

