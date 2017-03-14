# experimental commandline-only build

CONFIG = qt console c++11

TARGET = delaycut_nogui

INCLUDEPATH += src

SOURCES += src/cli.cpp src/delayac3.cpp
HEADERS += src/cli.h   src/delayac3.h   src/dc_types.h   src/sil48.h

!win32 {
  !greaterThan(QT_MAJOR_VERSION, 4):QMAKE_CXXFLAGS += -std=c++11
  QMAKE_CXXFLAGS += -Wno-unused-but-set-variable -Wno-unused-variable
  # don't link against QtGUi or other unneeded libraries
  QMAKE_LFLAGS += -Wl,--as-needed
}

win32-g++* {
  !greaterThan(QT_MAJOR_VERSION, 4):QMAKE_CXXFLAGS += -std=c++11
  QMAKE_CXXFLAGS += -Wno-unused-but-set-variable -Wno-unused-variable
  # tested with MXE (https://github.com/mxe/mxe)
  !contains(QMAKE_HOST.arch, x86_64):QMAKE_LFLAGS += -Wl,--large-address-aware
}

win32-msvc* {
  QMAKE_CXXFLAGS += /bigobj # allow big objects
  !contains(QMAKE_HOST.arch, x86_64):QMAKE_LFLAGS += /LARGEADDRESSAWARE
  QMAKE_CFLAGS_RELEASE += -WX
  QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO += -WX


  # for Windows XP compatibility
  contains(QMAKE_HOST.arch, x86_64) {
    #message(Going for Windows XP 64bit compatibility)
    #QMAKE_LFLAGS += /SUBSYSTEM:WINDOWS,5.02 # Windows XP 64bit
  } else {
    message(Going for Windows XP 32bit compatibility)
    QMAKE_LFLAGS += /SUBSYSTEM:WINDOWS,5.01 # Windows XP 32bit
  }
}

