EXE=rebook
FILES=main.cpy


ARCH?=arm
CXX_BIN?=arm-linux-gnueabihf-g++
CC_BIN?=arm-linux-gnueabihf-gcc
CPP_FLAGS=-pthread -lpthread -fdata-sections -ffunction-sections -Wl,--gc-sections 
CPP_FLAGS += -I../../libs/boost/ -I../../libs/rmkit/src 


OKP_FLAGS=-ni -I../../libs/boost/ -I../../libs/rmkit/src 
OKP_FLAGS += -for -d ../.${APP}_cpp/ -o ../../build/${EXE} ${FILES}

compile:
ifeq ($(ARCH),x86)
	make compile_x86
else ifeq ($(ARCH),arm)
	make compile_arm
else
	# Unsupported arch: ${ARCH}
	exit 1
endif

compile_arm: export CPP_FLAGS += -O2 
compile_arm: export OKP_FLAGS += ../../libs/rmkit/src/build/stb.arm.o
compile_arm:
	CXX=${CXX_BIN} okp ${OKP_FLAGS} -- -D"REMARKABLE=1" ${CPP_FLAGS}

compile_x86: export CPP_FLAGS += -O0 -g -I
compile_x86: export OKP_FLAGS += ../../libs/rmkit/src/build/stb.x86.o
compile_x86:
	okp ${OKP_FLAGS} -- ${CPP_FLAGS}

clean:
	rm -rf ._cpp
