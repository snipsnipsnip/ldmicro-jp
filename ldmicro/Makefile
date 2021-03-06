DEFINES = /D_WIN32_WINNT=0x400 /DISOLATION_AWARE_ENABLED /D_WIN32_IE=0x400 /DWIN32_LEAN_AND_MEAN /DWIN32 /D$(D)
CFLAGS  = /W3 /nologo -I..\common\win32 /O2 /D_CRT_SECURE_NO_WARNINGS /D_DEBUG /Zi

HEADERS = ..\common\win32\freeze.h ldmicro.h mcutable.h intcode.h

OBJDIR = obj

FREEZE   = $(OBJDIR)\freeze.obj

LDOBJS   = $(OBJDIR)\ldmicro.obj \
           $(OBJDIR)\maincontrols.obj \
           $(OBJDIR)\helpdialog.obj \
           $(OBJDIR)\schematic.obj \
           $(OBJDIR)\draw.obj \
           $(OBJDIR)\draw_outputdev.obj \
           $(OBJDIR)\circuit.obj \
           $(OBJDIR)\undoredo.obj \
           $(OBJDIR)\loadsave.obj \
           $(OBJDIR)\simulate.obj \
           $(OBJDIR)\commentdialog.obj \
           $(OBJDIR)\contactsdialog.obj \
           $(OBJDIR)\coildialog.obj \
           $(OBJDIR)\simpledialog.obj \
           $(OBJDIR)\resetdialog.obj \
           $(OBJDIR)\lutdialog.obj \
           $(OBJDIR)\confdialog.obj \
           $(OBJDIR)\iolist.obj \
           $(OBJDIR)\miscutil.obj \
           $(OBJDIR)\lang.obj \
           $(OBJDIR)\intcode.obj \
           $(OBJDIR)\compilecommon.obj \
           $(OBJDIR)\ansic.obj \
           $(OBJDIR)\interpreted.obj \
           $(OBJDIR)\pic16.obj \
           $(OBJDIR)\avr.obj

HELPOBJ  = $(OBJDIR)\helptext.obj

LIBS = user32.lib gdi32.lib comctl32.lib advapi32.lib

# CP = cp
# MV = mv
# RM = rm
# RMRF = rm -rf
# TOUCH = touch
CP = copy
MV = move
RM = del
RMRF = rmdir /s /q
TOUCH = echo. 2>

all: $(OBJDIR)/ldmicro.exe $(OBJDIR)/ldinterpret.exe
	@$(CP) $(OBJDIR)/ldmicro.exe .
	@$(CP) $(OBJDIR)/ldinterpret.exe .

test: all
	@cd reg
	@go.bat
	@cd ..

clean:
	$(RMRF) obj
	mkdir obj
	$(TOUCH) obj/dummy

distclean: clean
	$(RM) *.pdb *.obj *.exe *.ilk *.res lang-tables.h helptext.cpp
	cd reg
	$(RMRF) results

lang.cpp: $(OBJDIR)/lang-tables.h

$(OBJDIR)/lang-tables.h: lang*.txt
	perl lang-tables.pl > $(OBJDIR)/lang-tables.h

$(OBJDIR)/ldinterpret.exe: ldinterpret.c
	@$(CC) -Fe$(OBJDIR)/ldinterpret.exe $(LIBS) ldinterpret.c

$(OBJDIR)/ldmicro.exe: $(LDOBJS) $(FREEZE) $(HELPOBJ) $(OBJDIR)/ldmicro.res
	@$(CC) $(DEFINES) $(CFLAGS) -Fe$(OBJDIR)/ldmicro.exe $(LDOBJS) $(FREEZE) $(HELPOBJ) $(OBJDIR)/ldmicro.res $(LIBS)

$(OBJDIR)/ldmicro.res: ldmicro.rc ldmicro.ico
	@rc ldmicro.rc
	@$(MV) ldmicro.res $(OBJDIR)

$(LDOBJS): $(@B).cpp $(HEADERS)
	@$(CC) $(CFLAGS) $(DEFINES) -c -Fo$(OBJDIR)/$(@B).obj $(@B).cpp

$(FREEZE): ..\common\win32\$(@B).cpp $(HEADERS)
	@$(CC) $(CFLAGS) $(DEFINES) -c -Fo$(OBJDIR)/$(@B).obj ..\common\win32\$(@B).cpp

$(HELPOBJ): $(OBJDIR)/helptext.cpp
	@$(CC) $(CFLAGS) $(DEFINES) -c -Fo$(OBJDIR)/helptext.obj $(OBJDIR)/helptext.cpp

$(OBJDIR)/helptext.cpp: manual.txt manual-*.txt
	perl txt2c.pl > $(OBJDIR)/helptext.cpp
