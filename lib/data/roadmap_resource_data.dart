import 'package:dev_path/models/roadmap_resource_model.dart';

class RoadmapResourceData {
  static final Map<String, List<RoadmapResourceModel>> languageResources = {
    'Flutter': [
      RoadmapResourceModel(
        title: 'Official Flutter Documentation',
        url: 'https://docs.flutter.dev',
      ),
      RoadmapResourceModel(
        title: 'Dart Language Documentation',
        url: 'https://dart.dev/guides',
      ),
      RoadmapResourceModel(
        title: 'Flutter Widget Catalog',
        url: 'https://docs.flutter.dev/ui/widgets',
      ),
    ],
    'Web Development': [
      RoadmapResourceModel(
        title: 'MDN Web Docs (HTML/CSS/JS)',
        url: 'https://developer.mozilla.org',
      ),
      RoadmapResourceModel(
        title: 'W3Schools Web Tutorials',
        url: 'https://www.w3schools.com',
      ),
      RoadmapResourceModel(
        title: 'Modern JavaScript Info',
        url: 'https://javascript.info',
      ),
    ],
    'Python': [
      RoadmapResourceModel(
        title: 'Python Official Documentation',
        url: 'https://docs.python.org/3/',
      ),
      RoadmapResourceModel(
        title: 'Real Python Tutorials',
        url: 'https://realpython.com',
      ),
    ],
    'React': [
      RoadmapResourceModel(
        title: 'React Official Documentation',
        url: 'https://react.dev',
      ),
      RoadmapResourceModel(
        title: 'React Learn & Interactive Guide',
        url: 'https://react.dev/learn',
      ),
    ],
    'Java': [
      RoadmapResourceModel(
        title: 'Oracle Java Documentation',
        url: 'https://docs.oracle.com/en/java/',
      ),
      RoadmapResourceModel(
        title: 'Baeldung Java Tutorials',
        url: 'https://www.baeldung.com',
      ),
    ],
    'Android (Kotlin)': [
      RoadmapResourceModel(
        title: 'Android Developer Documentation',
        url: 'https://developer.android.com/docs',
      ),
      RoadmapResourceModel(
        title: 'Kotlin Official Language Docs',
        url: 'https://kotlinlang.org/docs/home.html',
      ),
    ],
    'Node.js': [
      RoadmapResourceModel(
        title: 'Node.js Official Documentation',
        url: 'https://nodejs.org/en/docs/',
      ),
      RoadmapResourceModel(
        title: 'Express.js Framework Guide',
        url: 'https://expressjs.com',
      ),
    ],
    'DevOps & Cloud': [
      RoadmapResourceModel(
        title: 'Docker Official Documentation',
        url: 'https://docs.docker.com',
      ),
      RoadmapResourceModel(
        title: 'Kubernetes Documentation',
        url: 'https://kubernetes.io/docs/',
      ),
      RoadmapResourceModel(
        title: 'AWS Cloud Documentation',
        url: 'https://docs.aws.amazon.com',
      ),
    ],
    'Data Science & AI': [
      RoadmapResourceModel(
        title: 'Pandas Data Analysis Docs',
        url: 'https://pandas.pydata.org/docs/',
      ),
      RoadmapResourceModel(
        title: 'NumPy Documentation',
        url: 'https://numpy.org/doc/',
      ),
    ],
    'iOS (Swift)': [
      RoadmapResourceModel(
        title: 'Apple Swift Documentation',
        url: 'https://developer.apple.com/swift/',
      ),
      RoadmapResourceModel(
        title: 'SwiftUI Official Tutorials',
        url: 'https://developer.apple.com/documentation/swiftui/',
      ),
    ],
    'C++ & DSA': [
      RoadmapResourceModel(
        title: 'cppreference.com (C++ Standard Reference)',
        url: 'https://en.cppreference.com',
      ),
      RoadmapResourceModel(
        title: 'GeeksforGeeks Data Structures & Algorithms',
        url: 'https://www.geeksforgeeks.org/data-structures/',
      ),
    ],
    'Vue.js': [
      RoadmapResourceModel(
        title: 'Vue 3 Official Documentation',
        url: 'https://vuejs.org/guide/introduction.html',
      ),
    ],
    'Cybersecurity': [
      RoadmapResourceModel(
        title: 'OWASP Cybersecurity Top 10 Docs',
        url: 'https://owasp.org/www-project-top-ten/',
      ),
    ],
    'Go (Golang)': [
      RoadmapResourceModel(
        title: 'Go Language Official Documentation',
        url: 'https://go.dev/doc/',
      ),
    ],
    'Angular': [
      RoadmapResourceModel(
        title: 'Angular Official Documentation',
        url: 'https://angular.dev',
      ),
    ],
    'React Native': [
      RoadmapResourceModel(
        title: 'React Native Official Docs',
        url: 'https://reactnative.dev/docs/getting-started',
      ),
    ],
    'SQL & Database Design': [
      RoadmapResourceModel(
        title: 'PostgreSQL Official Documentation',
        url: 'https://www.postgresql.org/docs/',
      ),
      RoadmapResourceModel(
        title: 'MySQL Official Documentation',
        url: 'https://dev.mysql.com/doc/',
      ),
    ],
    'GraphQL': [
      RoadmapResourceModel(
        title: 'GraphQL Official Documentation',
        url: 'https://graphql.org/learn/',
      ),
    ],
    'Blockchain & Solidity': [
      RoadmapResourceModel(
        title: 'Solidity Language Documentation',
        url: 'https://docs.soliditylang.org',
      ),
      RoadmapResourceModel(
        title: 'Ethereum Developer Documentation',
        url: 'https://ethereum.org/en/developers/docs/',
      ),
    ],
    'Machine Learning': [
      RoadmapResourceModel(
        title: 'PyTorch Official Documentation',
        url: 'https://pytorch.org/docs/stable/index.html',
      ),
      RoadmapResourceModel(
        title: 'TensorFlow Documentation',
        url: 'https://www.tensorflow.org/learn',
      ),
    ],
  };

  static List<RoadmapResourceModel> getResourcesForLanguage(String language) {
    return languageResources[language] ??
        [
          RoadmapResourceModel(
            title: '$language Official Documentation',
            url: 'https://devdocs.io',
          )
        ];
  }
}