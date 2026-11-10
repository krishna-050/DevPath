import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/saved_controller.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoadmapDetailScreen extends StatefulWidget {
  final RoadmapModel? roadmap;


  const RoadmapDetailScreen({super.key, this.roadmap});

  @override
  State<RoadmapDetailScreen> createState() => _RoadmapDetailScreenState();
}

class _RoadmapDetailScreenState extends State<RoadmapDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int expandedStepIndex = 0;
  List saved = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roadmapItem = widget.roadmap ?? RoadmapData.roadmaps.first;
    final learningTopics = _getTopicsForRoadmap(roadmapItem.language);
    final savedController = Get.find<SavedController>();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.background,
        centerTitle: true,
        title: Text(
          roadmapItem.language,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColor.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx((){
            final isBookmarked = savedController.isSaved(roadmapItem);
            return IconButton(

              icon: Icon(
             isBookmarked ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              color: isBookmarked ? AppColor.primary : AppColor.textPrimary,
              ),
              onPressed: () {

                  savedController.toggleSaved(roadmapItem);
                Get.snackbar(
                  isBookmarked ?'Removed from Favorites':'Saved to Favorites',
                  '${roadmapItem.language} Roadmap',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColor.surface,
                  colorText: AppColor.textPrimary,
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                );
              },
            );
          }),
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: AppColor.textPrimary,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Hero Card Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.lightBlue,
                      AppColor.lightBlue.withValues(alpha: 0.5),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColor.border.withValues(alpha: 0.8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.secondary.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon + Title + Category Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColor.border.withValues(alpha: 0.6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.textPrimary
                                    .withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            roadmapItem.imgUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.code_rounded,
                              color: AppColor.secondary,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      roadmapItem.language,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.textPrimary,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightOrange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      roadmapItem.category,
                                      style: const TextStyle(
                                        color: AppColor.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                roadmapItem.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColor.textSecondary,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Metadata Pill Badges
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColor.border.withValues(alpha: 0.6),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: AppColor.primary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                roadmapItem.duration,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.border.withValues(alpha: 0.6),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.workspace_premium_outlined,
                                  size: 14,
                                  color: AppColor.primary,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    roadmapItem.level,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Start Learning CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shadowColor: AppColor.primary.withValues(alpha: 0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          _tabController.animateTo(1);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start Learning',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Tab Bar Header
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColor.border, width: 1),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColor.primary,
                indicatorWeight: 3,
                labelColor: AppColor.primary,
                unselectedLabelColor: AppColor.textSecondary,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Roadmap'),
                  Tab(text: 'Resources'),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildOverviewTab(roadmapItem, learningTopics),
                  _buildRoadmapTab(roadmapItem, learningTopics),
                  _buildResourcesTab(roadmapItem),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Overview Tab View
  Widget _buildOverviewTab(RoadmapModel roadmap, List<String> topics) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What You'll Learn",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),

          // Bullet Items List
          ...topics.map(
            (topic) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColor.border.withValues(alpha: 0.6),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColor.lightOrange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColor.primary,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      topic,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Pro Tip Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.lightBlue,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColor.secondary.withValues(alpha: 0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.secondary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColor.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pro Tip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Start with the basics and build small projects. Practice regularly to become job ready!',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Interactive Step-by-Step Roadmap Tab View
  Widget _buildRoadmapTab(RoadmapModel roadmap, List<String> topics) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final stepNumber = index + 1;
        final isExpanded = expandedStepIndex == index;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Badge & Line
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedStepIndex = isExpanded ? -1 : index;
                      });
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color:
                            isExpanded ? AppColor.primary : AppColor.lightBlue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isExpanded
                              ? AppColor.primary
                              : AppColor.secondary,
                          width: 1.8,
                        ),
                        boxShadow: isExpanded
                            ? [
                                BoxShadow(
                                  color:
                                      AppColor.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '$stepNumber',
                          style: TextStyle(
                            color:
                                isExpanded ? Colors.white : AppColor.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (index < topics.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: AppColor.border,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Expandable Step Card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        expandedStepIndex = isExpanded ? -1 : index;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColor.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isExpanded
                              ? AppColor.primary.withValues(alpha: 0.6)
                              : AppColor.border.withValues(alpha: 0.7),
                          width: isExpanded ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.textPrimary.withValues(
                              alpha: isExpanded ? 0.06 : 0.03,
                            ),
                            blurRadius: isExpanded ? 12 : 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  topics[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isExpanded
                                        ? AppColor.primary
                                        : AppColor.textPrimary,
                                  ),
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: isExpanded
                                    ? AppColor.primary
                                    : AppColor.textSecondary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${1 + index}-${2 + index} weeks',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (isExpanded) ...[
                            const SizedBox(height: 12),
                            const Divider(color: AppColor.border, height: 1),
                            const SizedBox(height: 12),
                            _buildSubTopicCheck('Syntax & Key Concepts'),
                            _buildSubTopicCheck('Functions & Logic'),
                            _buildSubTopicCheck('Practice & Exercises'),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Start Step $stepNumber →',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubTopicCheck(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColor.primary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Resources Tab View
  Widget _buildResourcesTab(RoadmapModel roadmap) {
    final resources = [
      {'title': 'Official Documentation', 'icon': Icons.description_outlined},
      {'title': 'Recommended Video Courses', 'icon': Icons.play_circle_outline},
      {'title': 'Hands-on Practice Projects', 'icon': Icons.code_rounded},
      {'title': 'Community & Forum Discussions', 'icon': Icons.forum_outlined},
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: resources.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final res = resources[index];
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColor.border),
              boxShadow: [
                BoxShadow(
                  color: AppColor.textPrimary.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColor.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    res['icon'] as IconData,
                    color: AppColor.secondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    res['title'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.open_in_new_rounded,
                  color: AppColor.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> _getTopicsForRoadmap(String language) {
    if (language.contains('Flutter')) {
      return [
        'Dart Language Basics',
        'Flutter Environment Setup',
        'Widgets and UI',
        'State Management',
        'API Integration',
        'Firebase & Backend',
        'Build & Deploy',
      ];
    } else if (language.contains('Web') || language.contains('React')) {
      return [
        'HTML5 & Modern CSS3',
        'JavaScript ES6+ Fundamentals',
        'Git & GitHub Version Control',
        'React Components & Hooks',
        'State Management (Redux/Zustand)',
        'RESTful API & Axios',
        'Web Hosting & Deployment',
      ];
    } else if (language.contains('Python')) {
      return [
        'Python Basics & Syntax',
        'Data Structures & Algorithms',
        'Object-Oriented Programming (OOP)',
        'File Handling & Exception Control',
        'FastAPI / Django Web Framework',
        'Database Integration (PostgreSQL)',
        'API Testing & Deployment',
      ];
    } else {
      return [
        'Core Language Basics',
        'Environment & Tooling Setup',
        'Fundamentals & Data Structures',
        'Frameworks & Libraries',
        'Backend & Database Integration',
        'Testing & Debugging',
        'Production Deployment',
      ];
    }
  }
}


