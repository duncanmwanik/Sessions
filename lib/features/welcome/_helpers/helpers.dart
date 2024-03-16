import '../../../_providers/_provider_variables.dart';
import '../_variables/variables.dart';

void goToNextOnBoardingPage() {
  if (viewsProviderX.selectedOnboardingView < 3) {
    onBoadingPageViewcontroller.jumpToPage(viewsProviderX.selectedOnboardingView + 1);
  }
}

void goToPreviousOnBoardingPage() {
  if (viewsProviderX.selectedOnboardingView > 0) {
    onBoadingPageViewcontroller.jumpToPage(viewsProviderX.selectedOnboardingView - 1);
  }
}

void goToSpecifiedOnBoardingPage(int pageIndex) {
  onBoadingPageViewcontroller.jumpToPage(pageIndex);
  viewsProviderX.updateOnboardingView(pageIndex);
}

void skipToLastOnBoardingPage() {
  onBoadingPageViewcontroller.jumpToPage(3);
}
