class OnboardingModel {
  String title;
  String description;
  OnboardingModel({
    required this.title,
    required this.description,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: 'Welcome to TaskMate',
    description:
        'Stay organized and boost your productivity with TaskMate - your ultimate to-do companion.',
  ),
  OnboardingModel(
    title: 'Create Tasks Effortlessly',
    description:
        'Easily create and manage your tasks. TaskMate helps you keep track of everything on your to-do list.',
  ),
  OnboardingModel(
    title: 'Prioritize and Achieve',
    description:
        'Prioritize your tasks and accomplish more. TaskMate helps you focus on what matters most.',
  ),
];
