import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Entry Point
// ─────────────────────────────────────────────────────────────────────────────
void main() => runApp(const KartuProfilApp());

// ─────────────────────────────────────────────────────────────────────────────
// Root App – StatelessWidget
// ─────────────────────────────────────────────────────────────────────────────
class KartuProfilApp extends StatelessWidget {
  const KartuProfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Profil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF1A2A40),
      ),
      home: const ProfilePage(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Biodata – ganti sesuai data mahasiswa
// ─────────────────────────────────────────────────────────────────────────────
const String _name = 'JOENED SASTRA';
const String _prodi = 'Mahasiswa Sistem Informasi';
const String _bio =
    'Saya adalah mahasiswa Sistem Informasi yang memiliki minat besar pada '
    'pengembangan aplikasi mobile dan perancangan antarmuka (UI/UX). '
    'Saya antusias dalam menciptakan solusi digital yang tidak hanya '
    'fungsional, tetapi juga memberikan pengalaman pengguna yang intuitif dan menarik.';

const List<String> _skills = [
  'Flutter',
  'UI/UX Design',
  'Figma',
  'Dart',
];

// ─────────────────────────────────────────────────────────────────────────────
// Profile Page – StatelessWidget
// ─────────────────────────────────────────────────────────────────────────────
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2A40),
      // ── Responsive via LayoutBuilder ──────────────────────────────────────
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: _ProfileCard(isWide: isWide),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile Card – kartu putih utama
// ─────────────────────────────────────────────────────────────────────────────
class _ProfileCard extends StatelessWidget {
  final bool isWide;
  const _ProfileCard({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: isWide
          // ── Lebar > 600px: Row (foto kiri, info kanan) ─────────────────
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AvatarSection(),
                const SizedBox(width: 32),
                const Expanded(child: _InfoSection()),
              ],
            )
          // ── Sempit ≤ 600px: Column (bertumpuk) ─────────────────────────
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _AvatarSection()),
                SizedBox(height: 24),
                _InfoSection(),
              ],
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Avatar Section – foto profil + badge "Available" (Stack + Positioned)
// ─────────────────────────────────────────────────────────────────────────────
class _AvatarSection extends StatelessWidget {
  const _AvatarSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Foto profil dengan border hijau ──────────────────────────────
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF4DB6AC), width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const CircleAvatar(
                  radius: 58,
                  backgroundColor: Color(0xFFE0F2F1),
                  child: Icon(
                    Icons.person,
                    size: 56,
                    color: Color(0xFF4DB6AC),
                  ),
                ),
              ),
            ),
          ),

          // ── Badge "Available" (Positioned di sudut kiri bawah) ───────────
          Positioned(
            bottom: 4,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF4DB6AC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: Colors.white, size: 6),
                  SizedBox(width: 4),
                  Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Info Section – nama, jabatan, bio, kontak, skill
// ─────────────────────────────────────────────────────────────────────────────
class _InfoSection extends StatelessWidget {
  const _InfoSection();

  @override
  Widget build(BuildContext context) {
    // MediaQuery untuk deteksi orientasi
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label "MY PROFILE" ────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECEF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'MY PROFILE',
            style: TextStyle(
              color: Color(0xFFE57373),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // ── Nama ──────────────────────────────────────────────────────────
        const Text(
          _name,
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontSize: 26,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 4),

        // ── Prodi ─────────────────────────────────────────────────────────
        const Text(
          _prodi,
          style: TextStyle(
            color: Color(0xFF4DB6AC),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        // ── Bio ───────────────────────────────────────────────────────────
        const Text(
          _bio,
          style: TextStyle(
            color: Color(0xFF555555),
            fontSize: 14,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 20),

        // ── CONNECT WITH ME – Row 3 ikon sosial ──────────────────────────
        const Text(
          'CONNECT WITH ME',
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),

        // Row dengan 3 ikon kontak (Email, Phone, WA)
        const Row(
          children: [
            _SocialIcon(icon: Icons.email_rounded, color: Color(0xFF4DB6AC)),
            SizedBox(width: 12),
            _SocialIcon(icon: Icons.phone_rounded, color: Color(0xFF4DB6AC)),
            SizedBox(width: 12),
            _SocialIcon(icon: Icons.chat_rounded, color: Color(0xFF4DB6AC)), // Untuk WhatsApp
          ],
        ),

        const SizedBox(height: 20),

        // ── MY SKILLS – Wrap chip ─────────────────────────────────────────
        const Text(
          'MY SKILLS',
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),

        // Wrap: otomatis pindah baris kalau ruang habis
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _skills
              .map((s) => _SkillChip(label: s))
              .toList(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Social Icon Button
// ─────────────────────────────────────────────────────────────────────────────
class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Skill Chip
// ─────────────────────────────────────────────────────────────────────────────
class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  static const List<Color> _colors = [
    Color(0xFF9C8DFF), // ungu
    Color(0xFF64B5F6), // biru
    Color(0xFF4DB6AC), // teal
    Color(0xFFFFB74D), // oranye
    Color(0xFFF06292), // pink
  ];

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFD89B5F); // Text color for skill chip
    const bgColor = Color(0xFFFAEDD8); // Background color for skill chip
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
