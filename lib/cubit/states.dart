abstract class NotiziaStates {}

class NotiziaInitalizeStates extends NotiziaStates {}

class NotiziaChangeBottomNavigationState extends NotiziaStates {}

class NotiziaChangeThemeState extends NotiziaStates {}




// ****************  Articles  *************************//

class NotiziaGetArticlsLoadingState extends NotiziaStates {}

class NotiziaGetArticlsSucessState extends NotiziaStates {}

class NotiziaGetArticlsErrorState extends NotiziaStates {}


// **************** Search *************************//
class NotiziaGetSearchLoadingState extends NotiziaStates {}

class NotiziaGetSearchSucessState extends NotiziaStates {}

class NotiziaGetSearchErrorState extends NotiziaStates {}
