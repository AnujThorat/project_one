// lib/screens/announcements_screen.dart
// Announcements list screen using FutureBuilder with full CRUD interactions and FAB

import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../repositories/post_repository.dart';
import '../widgets/announcement_card.dart';
import '../widgets/custom_bottom_nav.dart';
import 'create_announcement_screen.dart';
import 'edit_announcement_screen.dart';
import 'timetable_screen.dart';
import 'events_screen.dart';
import 'profile_screen.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  // Repository pattern: instantiate directly inside the widget
  final PostRepository _postRepository = PostRepository();
  late Future<List<GetAllPostsModel>> _postsFuture;

  // Search controller as required
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadAnnouncements();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Refresh data using setState as strictly instructed
  void _loadAnnouncements() {
    setState(() {
      _postsFuture = _postRepository.fetchPosts();
    });
  }

  Future<void> _handleDelete(GetAllPostsModel post) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Announcement'),
        content: Text('Are you sure you want to delete "${post.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && post.id != null) {
      try {
        await _postRepository.deletePost(post.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Announcement deleted successfully'),
              backgroundColor: Colors.redAccent,
            ),
          );
          // Refresh list using setState
          _loadAnnouncements();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting: $e')),
          );
        }
      }
    }
  }

  void _navigateToCreate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAnnouncementScreen(),
      ),
    );

    if (result == true) {
      // Refresh list after creation
      _loadAnnouncements();
    }
  }

  void _navigateToEdit(GetAllPostsModel post) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAnnouncementScreen(post: post),
      ),
    );

    if (result == true) {
      // Refresh list after update
      _loadAnnouncements();
    }
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TimetableScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EventsScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: _isSearchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search announcements...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              )
            : const Text(
                'Announcements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearchVisible ? Icons.close : Icons.search,
              color: const Color(0xFF1E293B),
            ),
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                  _searchQuery = '';
                }
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadAnnouncements();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: FutureBuilder<List<GetAllPostsModel>>(
            future: _postsFuture,
            builder: (context, snapshot) {
              // 1. Loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A237E)),
                  ),
                );
              }

              // 2. Error state
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                      const SizedBox(height: 12),
                      Text('Error: ${snapshot.error}'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _loadAnnouncements,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E),
                        ),
                        child: const Text('Try Again', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }

              // 3. Success state
              var posts = snapshot.data ?? [];

              // Apply search filter if query is not empty
              if (_searchQuery.isNotEmpty) {
                posts = posts.where((p) {
                  final titleMatch = (p.title ?? '').toLowerCase().contains(_searchQuery);
                  final bodyMatch = (p.body ?? '').toLowerCase().contains(_searchQuery);
                  final catMatch = (p.category ?? '').toLowerCase().contains(_searchQuery);
                  return titleMatch || bodyMatch || catMatch;
                }).toList();
              }

              if (posts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.campaign_outlined, size: 64, color: Color(0xFFCBD5E1)),
                      const SizedBox(height: 12),
                      Text(
                        _searchQuery.isNotEmpty
                            ? 'No announcements match "$_searchQuery"'
                            : 'No announcements posted yet.',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _navigateToCreate,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('Create Announcement', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return AnnouncementCard(
                    post: post,
                    onEdit: () => _navigateToEdit(post),
                    onDelete: () => _handleDelete(post),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreate,
        backgroundColor: const Color(0xFF1A237E), // Deep Indigo
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
