CPP= @echo " G++ $<";g++

# 获取项目文件夹地址
PROJ_ROOT := $(abspath .)
# 设置临时文件夹路径
TMP_PATH = ${PROJ_ROOT}/.tmp
# 设置项目名称及输出位置
TARGET_NAME = ceshi
TARGET_PATH = ${PROJ_ROOT}/bin
TARGET = ${TARGET_PATH}/${TARGET_NAME}
# 设置项目源码路径
SOURCE_PATH = ${PROJ_ROOT}/src
# 设置头文件包含路径
INCLUDE_PATH_DIR := ${PROJ_ROOT}/include
INCLUDE_PATH := ${INCLUDE_PATH_DIR}
INC := $(foreach path,${INCLUDE_PATH},-I${path})
# 设置包含路径
LIB_PATH = ${PROJ_ROOT}/lib
# 设置编译参数
SRC := ${PROJ_ROOT}/src/*.cpp
SRC := $(wildcard ${SRC})
OBJ := $(patsubst ${SOURCE_PATH}/%.cpp,${TMP_PATH}/%.o,${SRC})

${TARGET}:${OBJ}
	${CPP} ${CFLAG} ${OBJ} -o $@

${TMP_PATH}/%.o:${SOURCE_PATH}/%.cpp
	@mkdir -p .tmp
	@mkdir -p bin
	${CPP} -c ${CFLAG} ${INC} $< -o $@

.PHONY: clean run build clear
build:
	@echo "building project...";mkdir -p ${INCLUDE_PATH} ${LIB_PATH} ${TARGET_PATH} ${SOURCE_PATH}
	@echo "installing head file...";cd ${INCLUDE_PATH};wget https://gitee.com/tranlin/ceshi/raw/main/include/ceshi.h
	@echo "installing code file...";touch ./src/ceshi.cpp;echo "#include \"ceshi.h\"\n\n\nint main()\n{\n    \n}" >> ./src/ceshi.cpp
run:
	@${TARGET}
clean:
	rm -rf ${TARGET}
	rm -rf ${TMP_PATH}
clear:
	rm -rf ${TMP_PATH}
	rm -rf ${INCLUDE_PATH}
	rm -rf ${LIB_PATH}
	rm -rf ${SOURCE_PATH}
	rm -rf ${TARGET_PATH}
