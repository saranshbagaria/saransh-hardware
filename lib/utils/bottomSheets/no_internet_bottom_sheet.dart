import 'package:flutter/material.dart';
import '../reusableWidgets/reusable_bottom_sheet.dart';
import '../reusableWidgets/reusable_button.dart';

class NoInternetBottomSheet {
  static Future<void> show({
    required VoidCallback onRetry,
    required VoidCallback onDismiss,
  }) async {
    await ReusableBottomSheet.show(
      config: const BottomSheetConfig(
        backgroundColor: Colors.white,
        borderRadius: 24,
        isDismissible: true,
        enableDrag: true,
      ),
      child: _NoInternetContent(
        onRetry: onRetry,
        onDismiss: onDismiss,
      ),
    );
  }
}

class _NoInternetContent extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onDismiss;

  const _NoInternetContent({
    required this.onRetry,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag Handle
        Container(
          margin: const EdgeInsets.only(top: 12),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Close Button
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              onDismiss();
              ReusableBottomSheet.close();
            },
            icon: Icon(
              Icons.close_rounded,
              color: Colors.grey.shade600,
            ),
            tooltip: 'Don\'t show again',
          ),
        ),

        // Icon with gradient background
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red.shade100,
                Colors.red.shade50,
              ],
            ),
          ),
          child: Icon(
            Icons.wifi_off_rounded,
            size: 48,
            color: Colors.red.shade400,
          ),
        ),

        const SizedBox(height: 24),

        // Title
        const Text(
          'No Internet Connection',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),

        const SizedBox(height: 12),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Please check your internet connection and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Retry Button using ReusableButton
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ReusableButton(
            title: 'Try Again',
            onTap: () {
              onRetry();
              ReusableBottomSheet.close();
            },
            backgroundColor: Colors.blue.shade600,
            height: 52,
            radius: 12,
            leadingWidget: const Icon(
              Icons.refresh_rounded,
              color: Colors.white,
              size: 20,
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          ),
        ),

        // Don't show again button
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 12,
            bottom: 24,
          ),
          child: ReusableButton(
            title: 'Don\'t Show Again',
            onTap: () {
              onDismiss();
              ReusableBottomSheet.close();
            },
            backgroundColor: Colors.transparent,
            textColor: Colors.grey.shade600,
            height: 44,
            radius: 12,
            borderColor: Colors.grey.shade300,
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}