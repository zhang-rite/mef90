NP=2 
all:
	-@make -C ${MEF90_DIR} vDef
test: test2D test3D
test2D: ${MEF90_DIR}/bin/${PETSC_ARCH}/vDef
	-@for OPTIONSFILE in test1.opts test2.opts test3.opts test4.opts; do \
	make -s testvDef PREFIX=SquareNG_X-tri3 OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=SquareNG_X-tri6 OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=SquareNG_Y-tri3 OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=SquareNG_Y-tri6 OPTIONSFILE=$${OPTIONSFILE};\
	done

test3D: ${MEF90_DIR}/bin/${PETSC_ARCH}/vDef
	-@for OPTIONSFILE in test1.opts test2.opts test3.opts test4.opts; do \
	make -s testvDef PREFIX=CubeNG_X-tetra4  OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=CubeNG_X-tetra10 OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=CubeNG_Y-tetra4  OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=CubeNG_Y-tetra10 OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=CubeNG_Z-tetra4  OPTIONSFILE=$${OPTIONSFILE};\
	make -s testvDef PREFIX=CubeNG_Z-tetra10 OPTIONSFILE=$${OPTIONSFILE};\
	done

include ${PETSC_DIR}/conf/rules
include ${PETSC_DIR}/conf/variables
include ${MEF90_DIR}/Makefile.include
include ${MEF90_DIR}/MEF90/Makefile.include
include ${MEF90_DIR}/m_HeatXfer/Makefile.include
include ${MEF90_DIR}/m_DefMech/Makefile.include
BASE_DIR=${MEF90_DIR}/vDef

vDef:${MEF90_DIR}/bin/${PETSC_ARCH}/vDef
	-@echo "      $@"

${MEF90_DIR}/bin/${PETSC_ARCH}/vDef: vDef.o ${MEF90_OBJS} ${MEF90_DEFMECH_OBJS}
	-@echo "      $@"
	-@${FLINKER} -o $@ vDef.o ${MEF90_OBJS} ${MEF90_DEFMECH_OBJS} ${MEF90_HEATXFER_OBJS} ${PETSC_FORTRAN_LIB} ${PETSC_LIB} 

vDef.o: ${BASE_DIR}/vDef.F90 ${MEF90_DEFMECH_OBJS} ${MEF90_HEATXFER_OBJS}
	@echo "      $<"
	-@${FC} ${FC_FLAGS} ${FCPPFLAGS} -I${MEF90_INCLUDE} -c -o $@ $<

testvDef:
	@echo ;echo "Testing vDef with $${PREFIX} $${OPTIONSFILE}"
	@ARGS="-prefix data/$${PREFIX} -options_file data/$${OPTIONSFILE}";\
	${MPIEXEC} -n ${NP} ${MEF90_DIR}/bin/${PETSC_ARCH}/vDef $${ARGS} | grep -v -e ' \#' > $${PREFIX}-$${OPTIONSFILE}.out 2>&1;\
	if (${DIFF} -B ${MEF90_DIR}/vDef/results/${PREFIX}-$${OPTIONSFILE}.out ${PREFIX}-$${OPTIONSFILE}.out) then echo "Passed";\
	else echo "Possible problem. Diffs above"; fi
	-@${RM} $${PREFIX}-$${OPTIONSFILE}.out 
	
MEF90:
	make -C ${MEF90_DIR} MEF90
m_DEFMECH:
	make -C ${MEF90_DIR} m_DEFMECH
	
testclean::
	-@rm -f data/*out.gen data/*log

allclean: testclean
	make -C ${MEF90_DIR} clean
	
debug::
	@echo FFLAGS ${FFLAGS} 
	@echo FC_FLAGS ${FC_FLAGS}
	@echo FCFLAGS ${FCFLAGS}
	@echo FCPPFLAGS ${FCPPFLAGS}
	@echo FCPP_FLAGS ${FCPP_FLAGS}