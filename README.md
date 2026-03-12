# Expense Tracker Application

Expense Tracker is a simple Flutter mobile application that demonstrates global state management using the Provider package. Users can view a running list of expenses and add new ones in real time. The app is structured around the ExpenseProvider class which acts as the single source of truth for all expense data.

## Features

•	View all expenses in a scrollable list

•	See a live total of all expense amounts

•	Add new expenses via a dedicated form screen

•	Input validation (empty title or zero amount is rejected)

•	Pre-loaded sample data on first launch

•	Reactive UI — list and total update instantly on state change

## State Management

The app follows the Provider pattern for state management. Here is how the key concepts map to files:

MultiProvider — main.dart

Wraps the entire widget tree so that ExpenseProvider is accessible from any screen without prop drilling.

ChangeNotifier — expense_provider.dart

ExpenseProvider extends ChangeNotifier and holds the private _expenses list. It exposes:

•	expenses — read-only getter (unmodifiable list)

•	total — computed sum of all amounts

•	addExpense(title, amount) — creates and appends a new Expense, then calls notifyListeners()

Consumer — home_screen.dart

Consumer<ExpenseProvider> wraps the body of the home screen. Whenever notifyListeners() fires, only the Consumer subtree rebuilds — keeping re-renders efficient.

## Prerequisites

•	Flutter SDK 3.0.0 or higher

•	Dart SDK 3.0.0 or higher

•	Android emulator or physical device (Android / iOS)


The app follows the Provider pattern for state management. Here is how the key concepts map to files:
