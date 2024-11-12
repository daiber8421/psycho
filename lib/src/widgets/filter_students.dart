import '../imports.dart';

class FilterS extends StatefulWidget {
  const FilterS({super.key});

  @override
  State<FilterS> createState() => _FilterState();
}

class _FilterState extends State<FilterS> {

  String selectedGrade = '11';
  String selectedCourse = '11';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text("Selección de grado"),
                DropdownButton<String>(
                  value: selectedGrade,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGrade = newValue!;
                    });
                  },
                  items: grades.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              children: [
                const Text("Selección de curso:"),
                DropdownButton<String>(
                  value: selectedCourse,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCourse = newValue!;
                    });
                  },
                  items: course.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}