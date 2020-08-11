BIN=Main
OBJ_DIR = objs
MKDIR = mkdir -p

#DIRECTORY = /home/fredericgo/research
PROJECT_DIR = $(shell pwd)
#PROJECT_DIR = $(shell dirname $(shell dirname $(CUR)))

EIGEN_DIR = $(PROJECT_DIR)/libraries/eigen
BULLET_INC_DIR = $(PROJECT_DIR)/libraries/bullet3/src

PYTHON_INC = $(HOME)/anaconda3/envs/tf1/include/python3.7m
PYTHON_LIB = $(HOME)/anaconda3/envs/tf1/lib/ -lpython3.7m

LD_FLAGS=-L$(PROJECT_DIR)/libraries/bullet3/lib
RPATH=-Wl,-rpath='.',-rpath='$(PROJECT_DIR)/libraries/bullet3/lib'

INC = -I./ \
	-I$(EIGEN_DIR) \
	-I$(BULLET_INC_DIR)

LIBS = -lGLEW -lGL -lGLU -lglut -lBulletDynamics -lBulletCollision -lLinearMath -lm -lstdc++

CC = g++
CFLAGS = -std=c++11 -O3 -Wall -fPIC

SRC_DIRS = util/ \
	util/json/ \
	anim/ \
	sim/ \
	render/ \
	render/lodepng/ \
	scenes/ \
	scenes/arm/ \
	scenes/particle/ \
	scenes/pendulum/

SRC_FILES = $(BIN).cpp DeepMimicCore.cpp $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)*.cpp))
OUT_DIRS = $(addprefix $(OBJ_DIR)/, $(SRC_DIRS))
OBJ = $(addprefix $(OBJ_DIR)/, $(patsubst %.cpp, %.o, $(SRC_FILES)))


default: build

build: $(BIN)

print:
	$(OUT_DIRS)

python: $(OUT_DIRS) $(OBJ)
	swig -c++ -python DeepMimicCore.i
	$(CC) -c -g $(CFLAGS) $(INC) $(LIBS) $(LD_FLAGS) DeepMimicCore.cpp DeepMimicCore_wrap.cxx -I$(PYTHON_INC) $(RPATH)
	$(CC) -shared $(CFLAGS) $(OBJ) $(LIBS) $(LD_FLAGS) DeepMimicCore_wrap.o -o _DeepMimicCore.so -L$(PYTHON_LIB) $(RPATH)

$(OBJ_DIR)/%.o: %.cpp
	$(CC) -c -g $(CFLAGS) $(INC) -o $@ $<

$(BIN): $(OUT_DIRS) $(OBJ)
	$(CC) -g $(CFLAGS) $(OBJ) $(LIBS) -o $@

$(OUT_DIRS):
	$(MKDIR) $(OUT_DIRS)

clean:
	- rm -f -r $(OUT_DIRS) $(BIN) $(OBJ) $(OBJ_DIR) DeepMimicCore_wrap.cxx _DeepMimicCore.so
