#if MEF90_DIM == 3
#define MEF90_DEFMECHSPLIT            MEF90DefMechSplit3D
#define MEF90_DEFMECHSPLITNONE        MEF90DefMechSplitNone3D
#define MEF90_DEFMECHSPLITMASONRY     MEF90DefMechSplitMasonry3D
#define MEF90_DEFMECHSPLITHD          MEF90DefMechSplitHD3D
#define MEF90_DEFMECHSPLITDEVIATORIC  MEF90DefMechSplitDeviatoric3D
#define MEF90_DEFMECHSPLITHYDROSTATIC MEF90DefMechSplitHydrostatic3D
#else
#define MEF90_DEFMECHSPLIT            MEF90DefMechSplit2D
#define MEF90_DEFMECHSPLITNONE        MEF90DefMechSplitNone2D
#define MEF90_DEFMECHSPLITMASONRY     MEF90DefMechSplitMasonry2D
#define MEF90_DEFMECHSPLITHD          MEF90DefMechSplitHD2D
#define MEF90_DEFMECHSPLITDEVIATORIC  MEF90DefMechSplitDeviatoric2D
#define MEF90_DEFMECHSPLITHYDROSTATIC MEF90DefMechSplitHydrostatic2D
#endif