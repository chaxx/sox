#
# Sound Tools Makefile
#
# 	builds libst.a and sox
#
# Updated on 02/24/97 - by Chris Bagwell (cbagwell@sprynet.com)
#   Inhanced Makefile to install software and documented a little better.
#
# Updated on 05 May 1998 by Chris Bagwell (cbagwell@sprynet.com)
#   Made some changes for various platforms based on others sugestions
#   and made my home system (Linux) the default. ;-)
#
# July 19, 1998 - Chris Bagwell (cbagwell@sprynet.com)
#   Redid makefile so that libraries could be optionally linked in.
#   Also made each specific portion of system specifics a seperate
#   line to comment/uncomment so that it will be easier to see how
#   to compiler on a wider array of systems (he says with a grin).
#   

# These things are site dependant so you may want to change.
PREFIX	= /usr/local
BINDIR  = $(PREFIX)/bin
LIBDIR	= $(PREFIX)/lib
MANDIR  = $(PREFIX)/man

SRCDIR	= sox-12.16

##############################################################################

FSRC	= 8svx.c aiff.c au.c auto.c cdr.c cvsd.c dat.c g711.c g721.c \
	  g723_24.c g723_40.c g72x.c gsm.c hcom.c maud.c oss.c raw.c \
	  sbdsp.c sf.c smp.c sndrtool.c sunaudio.c tx16w.c voc.c wav.c wve.c

ESRC	= avg.c band.c chorus.c copy.c cut.c deemphas.c dyn.c echo.c echos.c \
	  flanger.c highp.c lowp.c map.c mask.c phaser.c pick.c \
	  polyphas.c rate.c resample.c reverb.c reverse.c split.c \
	  stat.c vibro.c 

PSRC	= sox.c

SOURCES = $(PSRC) $(FSRC) $(ESRC) handlers.c libst.c misc.c util.c getopt.c

##############################################################################

HEADERS = st.h libst.h sfheader.h sfircam.h patchlvl.h version.h wav.h \
	  g72x.h resdefs.h resampl.h

TESTS   = tests.sh testall.sh monkey.au monkey.voc

MISC    = README INSTALL TODO TIPS CHEAT CHEAT.eft Changelog sox.1 sox.txt \
	  libst.3 libst.txt play.1 Makefile.unx Makefile.dos Makefile.b30 \
	  Makefile.c70 soxeffect play rec

SKEL	= skel.c skeleff.c

AMIGA	= Makefile.ami amiga.h

DOS	= tests.bat testall.bat

OS9	= Makefile.os9

VMS     = descrip.mms sound2au.com sound2sun.c sound2sun.opt \
	  sox.opt tests.com vms.lis

FILES   = $(MISC) $(HEADERS) $(SOURCES) \
	  $(AMIGA) $(DOS) $(OS9) $(VMS) \
	  $(SKEL) $(TESTS)

##############################################################################

FOBJ	= 8svx.o aiff.o au.o auto.o cdr.o cvsd.o dat.o g711.o g721.o \
	  g723_24.o g723_40.o g72x.o gsm.o hcom.o maud.o oss.o raw.o \
	  sbdsp.o sf.o smp.o sndrtool.o sunaudio.o tx16w.o voc.o wav.o wve.o

EOBJ	= avg.o band.o chorus.o copy.o cut.o deemphas.o dyn.o echo.o echos.o \
	  flanger.o highp.o lowp.o map.o mask.o phaser.o pick.o \
	  polyphas.o rate.o resample.o reverb.o reverse.o split.o \
	  stat.o vibro.o

SOUNDLIB = libst.a
LIBOBJS = $(FOBJ) $(EOBJ) handlers.o libst.o misc.o util.o getopt.o

##############################################################################

#
# System dependency parameters
#   Find anything related to your system and uncomment.
#

# Default way to delete files.
RM	    = rm -f

# Chose the best compiler you got from the following:
#
# GCC with all warnings and debug info
CC		= gcc -g -Wall
#
# GCC with no special options
# CC		= gcc
#
# Generic compiler on your system
# CC		= cc
#
# EMX GCC under OS/2 seems to need the following
# CC		= gcc -Zcrtdll -Zexe

# For optimized compilation, uncomment one of the following that your
# compiler understands.
#
# gcc's all understand this as do lots of standard compilers.  Try this one
# first.
# O		= -O2

# getopt() support is defined here.  If you have a built-in
# getopt() that is compatible with SVR5 then you don't need to
# do anything special.
#
# If you don't have any getopt() function then use the following
# define to use Sox's builtin version
# GETOPT_DEFINES	= -DHAVE_GETOPT
#
# If your system has the more advanced version of getopt() that
# also has its own getopt.h file (Such as the case with GNU libc 2.0)
# then uncomment the following line.  Don't uncomment anything if
# its in stdlib.h.
GETOPT_DEFINES	= -DHAVE_GETOPT_H

# Uncomment the following if your system does not have a built in
# strerror().  This includes SunOS.
#
# STRERR_DEFINES	= -DHAVE_STRERROR

# Uncomment the following if your system does not have a built in
# MEMMOVE function.  Sox will attempt to use bcopy instead.
# SunOS has this problem.
#
# MEMMOVE_DEFINES	= -DHAVE_MEMMOVE

# If you have the GSM 6.10 libraries installed then uncomment the follow
# 4 lines, and change to reflect your installation paths.
#
#GSM_PRE_LIBS	= -L/usr/local/lib
#GSM_POST_LIBS	= -lgsm
#GSM_INCLUDES	= -I/usr/local/include/
#GSM_DEFINES	= -DHAS_GSM

# For sound support on machines that include the OSS sound driver
# (such as Linux) then uncomment the following line.
#
#PLAYER_DEFINES	= -DOSS_PLAYER

# For sound support under SunOS and Solaris then uncomment the following line.
#
# PLAYER_DEFINES = -DSUNAUDIO_PLAYER

# For sound support on 386 AT&T Unix then uncomment the following line
#
# PLAYER_DEFINES = -DBLASTER

# For sound support on Intel BSD-derived Unix's using Steve Haenichen's SBLAST
# driver uncomment the following line.
#
# PLAYER_DEFINES = -DSBLAST

# Uncomment the following lines if your compiling under DOS or Windows.
# defines .snd to mean a DOS soundtool file (starts with SOUND)
#
# DOS_DEFINES	= -DDOS
# RM		= del /q

# Uncomment the following line if compiling under NeXT.
# defines .snd to mean a NeXT sound format file only.
#
# NEXT_DEFINES	= -DNeXT

# MISC DEFINES - The catch all for things that make even less sense
#  then normal under unix.  If you need more than one of the following
#  MISC DEFINES remember to include them on one line so it isn't just
#  redefined.
#
# Testing new improved rate code.  You can use the older version if ther
# are problems.
# MISC_DEFINES	= -DUSE_OLD_RATE
#
# For an extra 32k memory, you can include u-law/a-law lookup
# tables to speed compressiong/decompression of this type data.
# MISC_DEFINES = -DFAST_ULAW_COMPRESSION -DFAST_ALAW_COMPRESSION 


##############################################################################

# Library setup

# How should libaries be created.  Most systems can simply use the following.
AR		= ar r

# How should 'ranlib' be performed. HPUX, Linux, BSD-ish, SunOS, Solaris
RANLIB		= ranlib

# AT&T System V and GCC on DOS or OS/2 based systems
# RANLIB	= ar ts

# Some systems don't have a ranlib that you can run.  Use the following
# for those systems.
# RANLIB    = true

##############################################################################

SOX_PRE_LIBS	= $(GSM_PRE_LIBS)
SOX_POST_LIBS	= $(GSM_POST_LIBS) -lm
SOX_INCLUDES	= $(GSM_INCLUDES)
SOX_DEFINES	= $(GSM_DEFINES) $(PLAYER_DEFINES) \
  $(GETOPT_DEFINES) $(STRERR_DEFINES) $(MEMMOVE_DEFINES) \
  $(DOS_DEFINES) $(NEXT_DEFINES) $(MISC_DEFINES)

CFLAGS  = $O $(SOX_DEFINES) $(SOX_INCLUDES)

all: sox

sox: sox.o $(SOUNDLIB)
	$(CC) $(CFLAGS) -o sox sox.o $(SOUNDLIB) $(SOX_PRE_LIBS) $(SOX_POST_LIBS)

$(SOUNDLIB): $(LIBOBJS)
	$(RM) $(SOUNDLIB)
	$(AR) $(SOUNDLIB) $(LIBOBJS)
	$(RANLIB) $(SOUNDLIB)

sox.o:		sox.c st.h

$(LIBOBJS):	st.h version.h patchlvl.h

man: sox.1 libst.3
	$(RM) sox.txt libst.txt
	nroff -man sox.1 | col -b > sox.txt
	nroff -man libst.3 | col -b > libst.txt

install: sox
	-install -c -m 755 sox play rec $(BINDIR)
	-install -c -m 644 sox.1 play.1 $(MANDIR)/man1

install-lib: libst.a
	-install -c -m 644 libst.a $(LIBDIR)
	-install -c -m 644 libst.3 $(MANDIR)/man3

clean:
	$(RM) *~ *.o *.raw *.sf core sox libst.a

tar:	clean
	$(RM) ../$(SRCDIR).tar
	cd ..; tar cvf $(SRCDIR).tar $(SRCDIR)
