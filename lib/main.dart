// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expense_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F1F1F),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF9E9E9E),
            secondary: Color(0xFF616161),
            surface: Color(0xFF1E1E1E),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF424242),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF424242),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF2C2C2C),
            labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF424242)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF424242)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF9E9E9E), width: 1.5),
            ),
          ),
          dropdownMenuTheme: const DropdownMenuThemeData(
            menuStyle: MenuStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF2C2C2C)),
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge:  TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Color(0xFFBDBDBD)),
            bodySmall:  TextStyle(color: Color(0xFF9E9E9E)),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}