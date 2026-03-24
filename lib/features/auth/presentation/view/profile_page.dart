import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.color4, AppColor.color3],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=5',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          const Text(
            "Sara Al-Maddati",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const Text(
            "Senior System Administrator",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),

          const SizedBox(height: 30),

          _buildProfileTile(
            Icons.person_outline_rounded,
            "Account Settings",
            "Manage your personal data",
          ),
          _buildProfileTile(
            Icons.security_rounded,
            "Privacy & Security",
            "Password and 2FA",
          ),
          _buildProfileTile(
            Icons.help_outline_rounded,
            "Support Center",
            "Get help or report a bug",
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: AppColor.color4),
              child: const Text(
                "Log Out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String sub) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.color2.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColor.color3, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}
