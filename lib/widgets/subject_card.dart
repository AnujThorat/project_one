import 'package:flutter/material.dart';
import '../const/const.dart';
import '../models/attendance_model.dart';

class SubjectCard extends StatelessWidget {
  final SubjectAttendanceModel subject;

  const SubjectCard({
    super.key,
    required this.subject,
  });

  IconData _getSubjectIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('computer')) return Icons.computer_outlined;
    if (lower.contains('math')) return Icons.calculate_outlined;
    if (lower.contains('web')) return Icons.code_outlined;
    if (lower.contains('english') || lower.contains('comm')) return Icons.menu_book_outlined;
    if (lower.contains('database')) return Icons.storage_outlined;
    return Icons.school_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Color(subject.colorValue);
    final percentage = subject.percentage;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getSubjectIcon(subject.subject),
                  color: accentColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.subject,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${subject.attended} / ${subject.total} classes',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: percentage >= 75 ? const Color(0xFF1E293B) : Colors.redAccent,
                    ),
                  ),
                  Text(
                    '(${subject.attended}/${subject.total})',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (subject.total == 0) ? 0.0 : (subject.attended / subject.total),
              minHeight: 6,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
