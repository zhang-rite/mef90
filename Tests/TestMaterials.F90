Program TestMaterials
#include "finclude/petscdef.h"
   Use m_MEF90
   Use m_MEF_Materials
   Use petsc
   Implicit NONE   

   PetscInt                            :: i,numMat=1
   PetscBool                           :: flg
   PetscBag,Dimension(:),Pointer       :: matBag2D,matBag3D
   Type(MEF90_MatProp2D_Type),pointer  :: matProp2D
   Type(MEF90_MatProp3D_Type),pointer  :: matProp3D
   Character(len=256)                  :: IOBuffer
   Character(len=80)                   :: name,prefix
   character(len=1),pointer            :: dummychar(:)
   PetscErrorCode                      :: ierr
   

   Call MEF90_Initialize()
   Call PetscOptionsGetInt(PETSC_NULL_CHARACTER,'-n',numMat,flg,ierr);CHKERRQ(ierr);
   
   Allocate(matBag2D(numMat))
   Allocate(matBag3D(numMat))

   Do i = 1,numMat   
      Write(iobuffer,99) i
      Call PetscPrintf(PETSC_COMM_WORLD,IOBuffer,ierr)

      Call PetscBagCreate(PETSC_COMM_WORLD,sizeofMEF90_MatProp2D,matBag2D(i),ierr)
      write(name,200) i
      write(prefix,201) i
      Call PetscBagRegisterMEF90_MatProp(matBag2D(i),name,prefix,MEF90_Mathium2D,ierr)
      Call PetscBagView(matBag2D(i),PETSC_VIEWER_STDOUT_WORLD,ierr)
      Call PetscBagGetDataMEF90_MatProp(matBag2D(i),matProp2D,ierr)
      Call PetscPrintf(PETSC_COMM_WORLD,'\n',ierr)
   EndDo


   Do i = 1,numMat   
      Write(iobuffer,99) i
      Call PetscPrintf(PETSC_COMM_WORLD,IOBuffer,ierr)

      Call PetscBagCreate(PETSC_COMM_WORLD,sizeofMEF90_MatProp3D,matBag3D(i),ierr)
      write(name,300) i
      write(prefix,301) i

      Call PetscBagRegisterMEF90_MatProp(matBag3D(i),name,prefix,MEF90_Mathium3D,ierr)
      Call PetscBagView(matBag3D(i),PETSC_VIEWER_STDOUT_WORLD,ierr)
      Call PetscBagGetDataMEF90_MatProp(matBag3D(i),matProp3D,ierr)

      matProp3D%Density = -123456.0
      write(*,*) 'before: ',matProp3D%Density
      Call PetscBagSetFromOptions(matBag3D(i),ierr)
      ! PetscBagSetFromOptions resets only to CL options, not to default options
      ! This could probably be fixed by inserting the options in the registration routine, if desired
      ! Calling PetscBagSetFromOptions means the the help message will be re-displayed
      Call PetscBagGetDataMEF90_MatProp(matBag3D(i),matProp3D,ierr)
      write(*,*) 'after: ',matProp3D%Density
      Call PetscPrintf(PETSC_COMM_WORLD,'\n',ierr)
   EndDo

99  format('registering material ',I2.2,'\n')
200 format('2D material ',I2.2)
201 format('mat2D',I2.2,'_')
300 format('3D material ',I2.2)
301 format('mat3D',I2.2,'_')
   DeAllocate(matBag2D)
   DeAllocate(matBag3D)
   Call MEF90_Finalize()
End Program TestMaterials