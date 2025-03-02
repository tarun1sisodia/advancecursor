import 'package:flutter/material.dart';
import 'package:smart_attendance/core/widgets/custom_snackbar_content.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showCustomSnackbar(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    ),
  );
}

void showLoginSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Login successful!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showLoginFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Login failed. Please try again.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showRegistrationSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Registration successful! Welcome!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showRegistrationFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Registration failed. Please check your details.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showPasswordResetSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Password reset email sent successfully!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showPasswordResetFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Failed to send password reset email.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showProfileUpdateSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Profile updated successfully!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showProfileUpdateFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Profile update failed. Please try again.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showLogoutSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'You have been logged out successfully.',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showLogoutFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Logout failed. Please try again.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showDataFetchSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Data fetched successfully!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showDataFetchFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Failed to fetch data. Please check your connection.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showItemAddedToCart(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Item added to cart!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showItemRemovedFromCart(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Item removed from cart.',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showOrderPlacedSuccess(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Order placed successfully!',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    ),
  );
}

void showOrderPlacedFailure(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Failed to place order. Please try again.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showNetworkError(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Network error. Please check your connection.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showPermissionDenied(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'Permission denied. Please enable permissions in settings.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showFeatureUnavailable(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'This feature is currently unavailable.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showActionNotAllowed(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'You are not allowed to perform this action.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}

void showUnexpectedError(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackbarContent(
      message: 'An unexpected error occurred. Please try again later.',
      backgroundColor: Colors.red,
      icon: Icons.error,
    ),
  );
}
