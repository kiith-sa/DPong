include ../inc/$(PLATFORM)_inc.mak
include ../inc/$(DC)_inc.mak

PACKAGE_PATH=derelict/devil
IL_LIB=$(LIB_PRE)DerelictIL.$(LIB_EXT)
ILU_LIB=$(LIB_PRE)DerelictILU.$(LIB_EXT)
ILUT_LIB=$(LIB_PRE)DerelictILUT.$(LIB_EXT)

all : $(IL_LIB) $(ILU_LIB) $(ILUT_LIB) copylib
DerelictIL : $(IL_LIB) copylib
DerelictILU : $(ILU_LIB) copylib
DerelictILUT : $(ILUT_LIB) copylib

IL_SRC= \
	$(PACKAGE_PATH)/il.d \
    $(PACKAGE_PATH)/ilfuncs.d \
    $(PACKAGE_PATH)/iltypes.d
    
ILU_SRC= \
	$(PACKAGE_PATH)/ilu.d \
    $(PACKAGE_PATH)/ilufuncs.d \
    $(PACKAGE_PATH)/ilutypes.d
    
ILUT_SRC= \
	$(PACKAGE_PATH)/ilut.d \
    $(PACKAGE_PATH)/ilutfuncs.d \
    $(PACKAGE_PATH)/iluttypes.d
    
$(IL_LIB) : $(DC)_build_il
$(ILU_LIB) : $(DC)_build_ilu
$(ILUT_LIB) : $(DC)_build_ilut

# DMD ##############################################
dmd_build_il :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(IL_SRC) $(HD)/$(PACKAGE_PATH) $(OF)$(IL_LIB)

dmd_build_ilu :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(ILU_SRC) $(HD)/$(PACKAGE_PATH) $(OF)$(ILU_LIB)

dmd_build_ilut :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(ILUT_SRC) $(HD)/$(PACKAGE_PATH) $(OF)$(ILUT_LIB)

# LDC ##############################################
ldc_build_il :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(IL_SRC) $(HD)/$(PACKAGE_PATH)
	ar rcs $(IL_LIB) *.o
	$(RM) *.o

ldc_build_ilu :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(ILU_SRC) $(HD)/$(PACKAGE_PATH)
	ar rcs $(ILU_LIB) *.o
	$(RM) *.o

ldc_build_ilut :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(ILUT_SRC) $(HD)/$(PACKAGE_PATH)
	ar rcs $(ILUT_LIB) *.o
	$(RM) *.o
	
# GDMD/GDC ##############################################
gdmd_build_il :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(IL_SRC) $(HD)/$(PACKAGE_PATH) $(OF)$(IL_LIB)

gdmd_build_ilu :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(ILU_SRC) $(HD)/$(PACKAGE_PATH) $(OF)$(ILU_LIB)

gdmd_build_ilut :
	$(DC) $(DFLAGS) $(DFLAGS_REQ) $(ILUT_SRC) $(HD)/$(PACKAGE_PATH) $(OF)$(ILUT_LIB)

####################################################
copylib:		
	$(CP) *.$(LIB_EXT) $(LIB_DEST)
	$(RM) *.$(LIB_EXT)

