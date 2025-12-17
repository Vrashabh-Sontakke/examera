import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../subscription/subscription_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subProvider = context.watch<SubscriptionProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 16),
            Text('User Name', style: Theme.of(context).textTheme.headlineSmall),
            Text(
              'user@example.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 32),
            ListTile(
              leading: Icon(
                subProvider.isPremium ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              title: const Text('Premium Subscription'),
              subtitle: Text(
                subProvider.isPremium ? 'Active until Dec 2026' : 'Inactive',
              ),
              trailing: subProvider.isPremium
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () =>
                          subProvider.showSubscriptionPopup(context),
                      child: const Text('Upgrade'),
                    ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
