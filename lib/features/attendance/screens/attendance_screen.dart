// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/attendance_bloc.dart';

// class AttendanceScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AttendanceBloc(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Attendance')),
//         body: AttendanceForm(),
//       ),
//     );
//   }
// }

// class AttendanceForm extends StatefulWidget {
//   @override
//   _AttendanceFormState createState() => _AttendanceFormState();
// }

// class _AttendanceFormState extends State<AttendanceForm> {
//   final TextEditingController _sessionIdController = TextEditingController();

//   void _markAttendance() {
//     final sessionId = _sessionIdController.text.trim();
//     // context.read<AttendanceBloc>().add(AttendanceMarkRequested(sessionId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _sessionIdController,
//           decoration: InputDecoration(labelText: 'Session ID'),
//         ),
//         ElevatedButton(
//           onPressed: _markAttendance,
//           child: const Text('Mark Attendance'),
//         ),
//         // BlocBuilder<AttendanceBloc, AttendanceState>(
//           // builder: (context, state) {
//             // if (state is AttendanceLoading) {
//               // return CircularProgressIndicator();
//             // } else if (state is AttendanceMarked) {
//               // return Text('Attendance marked successfully!');
//             // } else if (state is AttendanceError) {
//               // return Text('Error: ${state.message}');
//             }
//             return Container();
//           },
//         ),
//       ],
//     );
//   }
// }
