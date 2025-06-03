import 'package:flutter/material.dart';

import 'package:blood_donor/widgets/buttons/app_back_button.dart';
import 'package:blood_donor/core/theme.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final bool showBackButton;
  final String backButtonLabel;
  final Widget child;
  final Widget? trailing;
  final Widget? footer;

  const AppScaffold({
    super.key,
    this.title,
    this.showBackButton = false,
    this.backButtonLabel = 'Kembali',
    required this.child,
    this.trailing,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed Header Section
            if (showBackButton || title != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button (Optional)
                    if (showBackButton)
                      AppBackButton(label: backButtonLabel),

                    // Space between back button and title
                    if (showBackButton && title != null)
                      const SizedBox(height: 8),

                    // Header title (Optional)
                    if (title != null)
                      Text(title ?? '', style: AppTextStyles.headingBold),

                    // Trailing widget below header (Optional)
                    if (trailing != null) trailing!,
                  ],
                ),
              ),

            // Scrollable Main Content Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: child,
              ),
            ),

            // Fixed Footer Section
            if (footer != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
}
