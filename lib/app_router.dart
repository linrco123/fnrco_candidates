import 'package:flutter/material.dart';
import 'ui/screens/required_documents/required_documents_apps.dart';
import 'data/models/management_content/poll_percentage_model.dart';
import 'ui/screens/management_content/polls/polls_percentage.dart';
import 'ui/screens/overview/overview_apps.dart';
import 'ui/screens/medical_declaration/medical_declaration_apps.dart';
import 'ui/screens/profile_get/experience/experience_description.dart';
import 'ui/screens/profile_get/get_job_details.dart';
import 'ui/screens/request/request.dart';
import 'ui/screens/shared_documents/apps_documents.dart';
import 'ui/screens/terms_conditions.dart';
import 'ui/screens/air_ticket/air_ticket_apps.dart';
import 'ui/screens/local_process/local_proces_apps.dart';
import 'ui/screens/joining_date/apps_joining_date.dart';
import 'ui/screens/job_contract/contract_applications.dart';
import 'ui/screens/job_offer/job_applications.dart';
import 'ui/screens/visa_approval/visa_approval_apps.dart';
import 'constants/app_pages_names.dart';
import 'constants/constances.dart';
import 'ui/screens/animated_splash.dart';
import 'ui/screens/auth/auth.dart';
import 'ui/screens/auth/reset_password.dart';
import 'ui/screens/auth/forget_password.dart';
import 'ui/screens/auth/log_in.dart';
import 'ui/screens/home_page/home_page.dart';
import 'ui/screens/internet_connection.dart';
import 'ui/screens/management_content/announcement.dart';
import 'ui/screens/management_content/contents.dart';
import 'ui/screens/management_content/faqs.dart';
import 'ui/screens/management_content/polls/polls.dart';
import 'ui/screens/notifications.dart';
import 'ui/screens/on_boarding/on_boarding2_screen.dart';
import 'ui/screens/auth/otp.dart';
import 'ui/screens/auth/sign_up.dart';
import 'ui/screens/profile/achievements.dart';
import 'ui/screens/profile/contacts.dart';
import 'ui/screens/profile/credentials.dart';
import 'ui/screens/profile/education_qualification.dart';
import 'ui/screens/profile/key_words.dart';
import 'ui/screens/profile/language.dart';
import 'ui/screens/profile/notes.dart';
import 'ui/screens/profile/profile.dart';
import 'ui/screens/profile/profile_editing.dart';
import 'ui/screens/profile/skills.dart';
import 'ui/screens/profile/work_experience.dart';
import 'ui/screens/resume.dart';
import 'ui/screens/success.dart';
import 'ui/screens/management_content/survey/surveys.dart';
import 'ui/screens/ticket.dart';
import 'ui/screens/tutorial/tutorial_content.dart';
import 'ui/screens/welcome.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route? routeTo(RouteSettings settings) {
    switch (settings.name) {
      case AppPagesNames.INITIAL:
        // return MaterialPageRoute(
        //   builder: (context) => const OnboardingScreen(),
        // );
        return PageTransition(
            child: const OnboardingScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      case AppPagesNames.WELCOME:
        // return MaterialPageRoute(
        //   builder: (context) => const WelcomeScreen(),
        // );
        return PageTransition(
            child: const WelcomeScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      case AppPagesNames.AUTH:
        return PageTransition(
            child: const SigninOrSignupScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      // return MaterialPageRoute(
      //     builder: (context) => const SigninOrSignupScreen());
      case AppPagesNames.LOGIN:
        // return MaterialPageRoute(
        //   builder: (context) => const SignInScreen(),
        // );
        return PageTransition(
            child: const SignInScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      case AppPagesNames.SIGNUP:
        // return MaterialPageRoute(
        //   builder: (context) => const SignUpScreen(),
        // );
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.OTP:
        var identifier = (settings.arguments as Map)['identifier'];
        var page = (settings.arguments as Map)['page'];

        // return MaterialPageRoute(
        //     builder: (context) => const VerificationScreen(),
        //     settings: RouteSettings(
        //         arguments: {'identifier': identifier, 'page': page}));

        return PageTransition(
            child: const VerificationScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1),
            settings: RouteSettings(
                arguments: {'identifier': identifier, 'page': page}));

      case AppPagesNames.RESETPASSWORD:
        var identifier = (settings.arguments as Map)['identifier'];
        // return MaterialPageRoute(
        //     builder: (context) => ChangePasswordScreen(),
        //     settings: RouteSettings(arguments: {'identifier': identifier}));

        return PageTransition(
            child: ChangePasswordScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1),
            settings: RouteSettings(arguments: {'identifier': identifier}));

      case AppPagesNames.FORGETPASSWORD:
        // return MaterialPageRoute(
        //   builder: (context) => ForgotPassword(),
        // );
        return PageTransition(
          child: ForgotPassword(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.HOMEPAGE:
        // return MaterialPageRoute(
        //   builder: (context) => const HomePageScreen(),
        // );
        return PageTransition(
          child: HomePageScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.PROFILE:
        // return MaterialPageRoute(
        //   builder: (context) => const ProfileScreen(),
        // );
        return PageTransition(
          child: ProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.PROFILE_EDITING:
        // return MaterialPageRoute(
        //   builder: (context) => const EditProfileScreen(),
        // );
        return PageTransition(
          child: EditProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.RESUME:
        // return MaterialPageRoute(
        //   builder: (context) => ResumeScreen(),
        // );
        return PageTransition(
          child: ResumeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.SUCCESS:
        // return MaterialPageRoute(
        //   builder: (context) => SuccessScreen(
        //     screenType: (settings.arguments as Map)[PAGE_KEYWORD],
        //   ),
        // );
        return PageTransition(
          child: SuccessScreen(
            screenType: (settings.arguments as Map)[PAGE_KEYWORD],
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.JOB_OFFERS:
        // return MaterialPageRoute(
        //   builder: (context) => JobOfferScreen(
        //     pdfLink: '',
        //   ),
        // );
        return PageTransition(
          child: JobApplicationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.INTERNET_CONNECTION:
        //   return MaterialPageRoute(
        //     builder: (context) => InternetConnectionScreen(),
        //   );
        return PageTransition(
          child: InternetConnectionScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.ANIMATED_SPLASH:
        // return MaterialPageRoute(
        //   builder: (context) => CustomAnimatedSplashScreen(),
        // );
        return PageTransition(
            child: const CustomAnimatedSplashScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      // case AppPagesNames.JOB_APPLICATION:
      //   // return MaterialPageRoute(
      //   //     builder: (context) => JobApplicationScreen(),
      //   //     );
      //   return PageTransition(
      //     child: JobApplicationScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.centerLeft,
      //     duration: const Duration(seconds: 1),
      //   );
      case AppPagesNames.SURVIES:
        // return MaterialPageRoute(
        //     builder: (context) => SurviesScreen(),
        //     );
        return PageTransition(
          child: SurviesScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      //JobApplicationScreen
      case AppPagesNames.SKILLS:
        // return MaterialPageRoute(
        //     builder: (context) => SkillsSCreen(),
        //     );
        return PageTransition(
          child: SkillsSCreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.EXPERIENCES:
        // return MaterialPageRoute(
        //     builder: (context) => ExperienceScreen(),
        //     );
        return PageTransition(
          child: ExperienceScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.AIR_TICKETS:
        // return MaterialPageRoute(
        //     builder: (context) => AirTicketApplicationsScreen(),
        //     );
        return PageTransition(
          child: AirTicketApplicationsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.EDUCATION:
        // return MaterialPageRoute(
        //     builder: (context) => EducationAndQualificationScreen(),
        //     );
        return PageTransition(
          child: EducationAndQualificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.CONTACT_TYPE:
        // return MaterialPageRoute(
        //     builder: (context) => ContactsScreen(),
        //     );
        return PageTransition(
          child: ContactsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.CREDENTIALS:
        // return MaterialPageRoute(
        //     builder: (context) => CredentialsScreen(),
        //     );
        return PageTransition(
          child: CredentialsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.LANGUAGE:
        // return MaterialPageRoute(
        //     builder: (context) => CredentialsScreen(),
        //     );
        return PageTransition(
          child: LanguageScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.ACHIEVEMENTS:
        // return MaterialPageRoute(
        //     builder: (context) => AchievementsSCreen(),
        //     );
        return PageTransition(
          child: AchievementsSCreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.NOTES:
        // return MaterialPageRoute(
        //     builder: (context) => NotesScreen(),
        //     );
        return PageTransition(
          child: NotesScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.KEYWORDS:
        // return MaterialPageRoute(
        //     builder: (context) => KeyWordsSCreen(),
        //     );
        return PageTransition(
          child: KeyWordsSCreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.NOTIFICATION:
        // return MaterialPageRoute(
        //     builder: (context) => NotificationsScreen(),
        //     );
        return PageTransition(
          child: NotificationsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.POLLS:
        // return MaterialPageRoute(
        //     builder: (context) => PollsScreen(),
        //     );
        return PageTransition(
          child: PollsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.FAQS:
        // return MaterialPageRoute(
        //     builder: (context) => FAQsScreen(),
        //     );
        return PageTransition(
          child: FAQsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.TUTORIAL:
        // return MaterialPageRoute(
        //     builder: (context) => TutorialsContentScreen(),
        //     );
        return PageTransition(
          child: TutorialsContentScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.ANNOUNCEMENT:
        // return MaterialPageRoute(
        //     builder: (context) => AnnouncementScreen(),
        //     );
        return PageTransition(
          child: AnnouncementScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.CONTENTS:
        // return MaterialPageRoute(
        //     builder: (context) => ContentsScreen(),
        //     );
        return PageTransition(
          child: ContentsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.TICKETS:
        // return MaterialPageRoute(
        //     builder: (context) => TicketsScreen(),
        //     );
        return PageTransition(
          child: TicketsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.VISA_APPROVALS:
        // return MaterialPageRoute(
        //     builder: (context) => VisaApprovalAppsScreen(),
        //     );
        return PageTransition(
          child: VisaApprovalAppsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.JOINING_DATES:
        // return MaterialPageRoute(
        //     builder: (context) => DateApplicationScreen(),
        //     );
        return PageTransition(
          child: DateApplicationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.JOB_CONTRACTS:
        // return MaterialPageRoute(
        //     builder: (context) => JoiningDateSCreen(),
        //     );
        return PageTransition(
          child: ContractApplicationsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.LOCAL_PROCESSES:
        // return MaterialPageRoute(
        //     builder: (context) => LocalProcessScreen(),
        //     );
        return PageTransition(
          child: LocalProcessApplicationsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.MEDICAL_DECLARATION:
        // return MaterialPageRoute(
        //     builder: (context) => MedicalDeclaration(),
        //     );
        return PageTransition(
          child: MedicalDeclarationAppsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.TERMS_CONDITIONS:
        return PageTransition(
          child: TermsAndConditionsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.EXPERIENCE_DESC:
        final String desc = (settings.arguments as Map)['desc'];
        return PageTransition(
          child: ExperienceDescriptionScreen(
            description: desc,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.JOB_APPLIED_DETAILS:
        final details = (settings.arguments as Map)['job_details'];
        return PageTransition(
          child: GetJobDetailsScreen(
            job: details,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.REQUEST:
        return PageTransition(
          child: RequestScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.SHARED_DOCUMENTS:
        return PageTransition(
          child: SharedDocsAppsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.OVERVIEW:
        return PageTransition(
          child: OverviewAppsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

         case AppPagesNames.required_documents:
        return PageTransition(
          child: RequiredDocumentsApplicationsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.percentage:
        final votePercentage =
            (settings.arguments! as Map)['percentage'] as VotePercentages;
        final question = (settings.arguments! as Map)['question'] as String;

        return PageTransition(
          child: PollsPercentageScreen(
            question: question,
            votePercentages: votePercentage,
          ),
          // settings: RouteSettings(),
          type: PageTransitionType.fade,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
    }

    return null;
  }
}
