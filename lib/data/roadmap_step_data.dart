import 'package:dev_path/data/roadmaps/angular_roadmap.dart';
import 'package:dev_path/data/roadmaps/android_roadmap.dart';
import 'package:dev_path/data/roadmaps/cpp_dsa_roadmap.dart';
import 'package:dev_path/data/roadmaps/cybersecurity_roadmap.dart';
import 'package:dev_path/data/roadmaps/data_science_roadmap.dart';
import 'package:dev_path/data/roadmaps/devops_roadmap.dart';
import 'package:dev_path/data/roadmaps/flutter_roadmap.dart';
import 'package:dev_path/data/roadmaps/golang_roadmap.dart';
import 'package:dev_path/data/roadmaps/graphql_roadmap.dart';
import 'package:dev_path/data/roadmaps/java_roadmap.dart';
import 'package:dev_path/data/roadmaps/machine_learning_roadmap.dart';
import 'package:dev_path/data/roadmaps/nodejs_roadmap.dart';
import 'package:dev_path/data/roadmaps/python_roadmap.dart';
import 'package:dev_path/data/roadmaps/react_native_roadmap.dart';
import 'package:dev_path/data/roadmaps/react_roadmap.dart';
import 'package:dev_path/data/roadmaps/solidity_blockchain_roadmap.dart';
import 'package:dev_path/data/roadmaps/sql_roadmap.dart';
import 'package:dev_path/data/roadmaps/swift_ios_roadmap.dart';
import 'package:dev_path/data/roadmaps/vue_roadmap.dart';
import 'package:dev_path/data/roadmaps/web_dev_roadmap.dart';
import 'package:dev_path/models/roadmap_step_model.dart';

class RoadmapStepData {
  static final Map<String, List<RoadmapStepModel>> languageSteps = {
    'Flutter': flutterRoadmapSteps,
    'Web Development': webDevRoadmapSteps,
    'Python': pythonRoadmapSteps,
    'React': reactRoadmapSteps,
    'Java': javaRoadmapSteps,
    'Android (Kotlin)': androidRoadmapSteps,
    'Android': androidRoadmapSteps,
    'Node.js': nodejsRoadmapSteps,
    'DevOps & Cloud': devopsRoadmapSteps,
    'DevOps': devopsRoadmapSteps,
    'Data Science & AI': dataScienceRoadmapSteps,
    'Data Science': dataScienceRoadmapSteps,
    'iOS (Swift)': swiftIosRoadmapSteps,
    'iOS': swiftIosRoadmapSteps,
    'C++ & DSA': cppDsaRoadmapSteps,
    'C++': cppDsaRoadmapSteps,
    'Vue.js': vueRoadmapSteps,
    'Vue': vueRoadmapSteps,
    'Cybersecurity': cybersecurityRoadmapSteps,
    'Go (Golang)': golangRoadmapSteps,
    'Golang': golangRoadmapSteps,
    'Angular': angularRoadmapSteps,
    'React Native': reactNativeRoadmapSteps,
    'SQL & Database Design': sqlRoadmapSteps,
    'SQL': sqlRoadmapSteps,
    'GraphQL': graphqlRoadmapSteps,
    'Blockchain & Solidity': solidityBlockchainRoadmapSteps,
    'Solidity': solidityBlockchainRoadmapSteps,
    'Machine Learning': machineLearningRoadmapSteps,
  };

  static List<RoadmapStepModel> getStepsForLanguage(String language) {
    if (language.contains('Flutter')) return flutterRoadmapSteps;
    if (language.contains('Android') || language.contains('Kotlin')) {
      return androidRoadmapSteps;
    }
    if (language == 'Java') return javaRoadmapSteps;
    if (language.contains('Node')) return nodejsRoadmapSteps;
    if (language == 'Python') return pythonRoadmapSteps;
    if (language == 'React' || language == 'React.js') return reactRoadmapSteps;
    if (language.contains('Web Development') || language == 'Web') {
      return webDevRoadmapSteps;
    }

    if (language.contains('DevOps') || language.contains('Cloud')) {
      return devopsRoadmapSteps;
    }
    if (language.contains('Data Science')) return dataScienceRoadmapSteps;
    if (language.contains('iOS') || language.contains('Swift')) {
      return swiftIosRoadmapSteps;
    }
    if (language.contains('C++') || language.contains('DSA')) {
      return cppDsaRoadmapSteps;
    }
    if (language.contains('Vue')) return vueRoadmapSteps;
    if (language.contains('Cybersecurity') || language.contains('Security')) {
      return cybersecurityRoadmapSteps;
    }
    if (language.contains('Go') || language.contains('Golang')) {
      return golangRoadmapSteps;
    }
    if (language.contains('Angular')) return angularRoadmapSteps;
    if (language.contains('React Native')) return reactNativeRoadmapSteps;
    if (language.contains('SQL') || language.contains('Database')) {
      return sqlRoadmapSteps;
    }
    if (language.contains('GraphQL')) return graphqlRoadmapSteps;
    if (language.contains('Blockchain') || language.contains('Solidity')) {
      return solidityBlockchainRoadmapSteps;
    }
    if (language.contains('Machine Learning')) {
      return machineLearningRoadmapSteps;
    }

    return languageSteps[language] ?? generateDefaultSteps(language);
  }

  static List<RoadmapStepModel> generateDefaultSteps(String language) {
    return [
      RoadmapStepModel(
        id: 1,
        title: '$language Language Basics',
        description:
            'Master core syntax, data types, functions, control flow and foundational programming principles.',
        duration: '1-2 weeks',
        subtopics: [
          'Syntax & Key Concepts',
          'Variables & Data Types',
          'Control Flow & Functions',
          'Debugging & Basic Logic',
        ],
        resources: [
          '$language Official Documentation: https://devdocs.io',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Core Concepts & Tooling',
        description:
            'Understand environment setup, package management, object-oriented concepts, and debugging.',
        duration: '2 weeks',
        subtopics: [
          'Environment Setup & Package Manager',
          'Object-Oriented Design',
          'Debugging & Exception Handling',
        ],
        resources: [
          '$language Package Guide: https://devdocs.io',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Frameworks & Libraries',
        description:
            'Master popular frameworks, state management, API integration, and database connectivity.',
        duration: '3-4 weeks',
        subtopics: [
          'Popular Framework Architecture',
          'State & API Integration',
          'Database Connectivity',
        ],
        resources: [
          '$language Framework Docs: https://devdocs.io',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Real-world Projects & Deployment',
        description:
            'Build full-stack applications, write automated tests, and deploy to production cloud servers.',
        duration: '2-3 weeks',
        subtopics: [
          'Building Real-world Application',
          'Automated Unit Testing',
          'Production Cloud Deployment',
        ],
        resources: [
          '$language Deployment Guide: https://devdocs.io',
        ],
      ),
    ];
  }
}
