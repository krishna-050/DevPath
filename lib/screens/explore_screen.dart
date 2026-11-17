import 'package:dev_path/Widgets/roadmap_list_widget.dart';
import 'package:dev_path/Widgets/roadmap_progress_widget.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'All';
  bool isGridView = false;

  final List<Map<String, dynamic>> categoryList = const [
    {'name': 'All', 'icon': Icons.apps_rounded},
    {'name': 'Mobile', 'icon': Icons.phone_android_rounded},
    {'name': 'Frontend', 'icon': Icons.code_rounded},
    {'name': 'Backend', 'icon': Icons.dns_rounded},
    {'name': 'DevOps', 'icon': Icons.cloud_queue_rounded},
    {'name': 'AI & Data', 'icon': Icons.psychology_rounded},
    {'name': 'Security', 'icon': Icons.security_rounded},
    {'name': 'Web3', 'icon': Icons.currency_bitcoin_rounded},
  ];

  final TextEditingController searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isTablet = screenWidth > 600;

    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header & Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  if (Navigator.canPop(context)) ...[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: textPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                  Text(
                    'Explore Roadmaps',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: textPrimaryColor,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Interactive Search Bar with Focus Glow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 50,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _searchFocusNode.hasFocus
                        ? (isDark ? const Color(0xFF60A5FA) : AppColor.secondary)
                        : borderColor,
                    width: _searchFocusNode.hasFocus ? 1.8 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _searchFocusNode.hasFocus
                          ? (isDark
                              ? const Color(0xFF60A5FA).withValues(alpha: 0.25)
                              : AppColor.secondary.withValues(alpha: 0.18))
                          : textPrimaryColor.withValues(alpha: 0.03),
                      blurRadius: _searchFocusNode.hasFocus ? 12 : 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (val) {
                    setState(() {});
                    controller.searchRoadmap(val);
                  },
                  style: TextStyle(
                    color: textPrimaryColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    hintText: 'Search 20+ roadmaps, tech or skills...',
                    hintStyle: TextStyle(
                      color: textSecondaryColor,
                      fontSize: 13.5,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: _searchFocusNode.hasFocus
                          ? (isDark
                              ? const Color(0xFF60A5FA)
                              : AppColor.secondary)
                          : textSecondaryColor,
                      size: 22,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.clear();
                                controller.searchRoadmap('');
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFE2EAF2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: 14,
                                color: textSecondaryColor,
                              ),
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.tune_rounded,
                            color: isDark
                                ? const Color(0xFF60A5FA)
                                : AppColor.secondary,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // 3. Category Filter Chips with Icons
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryList.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = categoryList[index];
                  final name = cat['name'] as String;
                  final icon = cat['icon'] as IconData;
                  final isSelected = selectedCategory == name;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = name;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF0072FF),
                                  Color(0xFF00C6FF),
                                ],
                              )
                            : null,
                        color: isSelected ? null : surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF0072FF)
                              : borderColor,
                          width: 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF0072FF)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 15,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                    ? const Color(0xFF60A5FA)
                                    : AppColor.secondary),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : textPrimaryColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // 4. Results Bar & View Toggle (Grid / List)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Obx(() {
                final allRoadmaps = controller.filteredRoadmaps;
                final filteredList = _getFilteredList(allRoadmaps);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filteredList.length} roadmaps available',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: textSecondaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        // List View Icon Button
                        GestureDetector(
                          onTap: () {
                            if (isGridView) {
                              setState(() {
                                isGridView = false;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: !isGridView
                                  ? (isDark
                                      ? const Color(0xFF1E293B)
                                      : AppColor.lightBlue)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.view_agenda_rounded,
                              size: 18,
                              color: !isGridView
                                  ? AppColor.secondary
                                  : textSecondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Grid View Icon Button
                        GestureDetector(
                          onTap: () {
                            if (!isGridView) {
                              setState(() {
                                isGridView = true;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isGridView
                                  ? (isDark
                                      ? const Color(0xFF1E293B)
                                      : AppColor.lightBlue)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.grid_view_rounded,
                              size: 18,
                              color: isGridView
                                  ? AppColor.secondary
                                  : textSecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),

            // 5. Roadmaps Display (List View or Grid View)
            Expanded(
              child: Obx(() {
                final allRoadmaps = controller.filteredRoadmaps;
                final filteredList = _getFilteredList(allRoadmaps);

                if (filteredList.isEmpty) {
                  return _buildEmptyState(
                    selectedCategory,
                    searchController.text,
                    isDark,
                    textPrimaryColor,
                    textSecondaryColor,
                    surfaceColor,
                    borderColor,
                  );
                }

                if (isGridView) {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTablet ? 3 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: isTablet ? 1.05 : 0.72,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return _buildGridCard(
                        item: item,
                        surfaceColor: surfaceColor,
                        borderColor: borderColor,
                        textPrimaryColor: textPrimaryColor,
                        textSecondaryColor: textSecondaryColor,
                        isDark: isDark,
                      );
                    },
                  );
                }

                // Default List View
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return RoadmapListWidget(item: filteredList[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<RoadmapModel> _getFilteredList(List<RoadmapModel> list) {
    if (selectedCategory == 'All') return list;

    final target = selectedCategory.toLowerCase();
    return list.where((item) {
      final cat = item.category.toLowerCase();
      if (cat == target) return true;

      // Smart tag matching
      if (target == 'frontend') {
        return cat.contains('front') ||
            item.language.contains('React') ||
            item.language.contains('Vue') ||
            item.language.contains('Angular') ||
            item.language.contains('Web');
      }
      if (target == 'mobile') {
        return cat.contains('mobile') ||
            cat.contains('app') ||
            item.language.contains('Flutter') ||
            item.language.contains('Android') ||
            item.language.contains('iOS') ||
            item.language.contains('React Native');
      }
      if (target == 'backend') {
        return cat.contains('backend') ||
            item.language.contains('Node') ||
            item.language.contains('Java') ||
            item.language.contains('Python') ||
            item.language.contains('Go') ||
            item.language.contains('SQL') ||
            item.language.contains('GraphQL');
      }
      if (target == 'ai & data') {
        return cat.contains('ai') ||
            cat.contains('data') ||
            item.language.contains('Data') ||
            item.language.contains('Machine Learning');
      }
      if (target == 'security') {
        return cat.contains('security') ||
            item.language.contains('Cybersecurity');
      }
      if (target == 'web3') {
        return cat.contains('web3') ||
            cat.contains('blockchain') ||
            item.language.contains('Solidity');
      }

      return false;
    }).toList();
  }

  Widget _buildGridCard({
    required RoadmapModel item,
    required Color surfaceColor,
    required Color borderColor,
    required Color textPrimaryColor,
    required Color textSecondaryColor,
    required bool isDark,
  }) {
    return InkWell(
      onTap: () {
        Get.to(() => RoadmapDetailScreen(roadmap: item));
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: textPrimaryColor.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color:
                        isDark ? const Color(0xFF1E293B) : AppColor.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    item.imgUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.code_rounded,
                      color:
                          isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF332014)
                          : AppColor.lightOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.language,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
                color: textPrimaryColor,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 3),
            Expanded(
              child: Text(
                item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textSecondaryColor,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 6),
            RoadmapProgressWidget(roadmap: item),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    String category,
    String query,
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    Color surfaceColor,
    Color borderColor,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : AppColor.lightBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 46,
                color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              query.isNotEmpty
                  ? 'No results for "$query"'
                  : 'No $category Roadmaps Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try searching with a different keyword or select another category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedCategory = 'All';
                  searchController.clear();
                  Get.find<HomeController>().searchRoadmap('');
                });
              },
              child: const Text(
                'Reset All Filters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
