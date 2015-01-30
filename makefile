all: bin/classify bin/align_single bin/exportCode bin/bfclassify

CV_INCLUDE = -I"include/cv"
VL_INCLUDE = -I"include"
VL_LINK = -L"lib/vl" -lvl
CV_LINK = -L"lib/cv"  -lopencv_core -lopencv_highgui  -lopencv_objdetect -lopencv_imgproc -lopencv_legacy -lopencv_flann 
#-lopencv_contrib -lopencv_legacy

bin/classify: build/main.o build/classifier.o build/detector.o build/flandmark_detector.o build/liblbp.o
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:lib/vl:lib/cv
	g++ -o bin/classify build/main.o build/classifier.o build/detector.o  build/flandmark_detector.o build/liblbp.o $(VL_LINK) $(CV_LINK)

bin/bfclassify: build/bfclassify.o build/vladIndex.o build/classifier.o build/detector.o build/flandmark_detector.o build/liblbp.o
	g++ -o bin/bfclassify build/bfclassify.o build/vladIndex.o build/classifier.o build/detector.o build/flandmark_detector.o build/liblbp.o $(VL_LINK) $(CV_LINK)

bin/exportCode: build/exportCode.o build/classifier.o build/detector.o build/flandmark_detector.o build/liblbp.o
	g++ -o bin/exportCode build/exportCode.o build/classifier.o build/detector.o build/flandmark_detector.o build/liblbp.o $(VL_LINK) $(CV_LINK)

bin/align_single: build/align_single.o build/flandmark_detector.o build/liblbp.o
	g++ -o ./bin/align_single ./build/align_single.o ./build/flandmark_detector.o ./build/liblbp.o $(CV_LINK)

build/main.o: src/main.cpp
	g++ -c ./src/main.cpp -o ./build/main.o $(CV_INCLUDE) $(VL_INCLUDE)

build/bfclassify.o: src/bfclassify.cpp
	g++ -c src/bfclassify.cpp -o build/bfclassify.o $(CV_INCLUDE) $(VL_INCLUDE)

build/exportCode.o: src/exportCode.cpp
	g++ -c ./src/exportCode.cpp -o ./build/exportCode.o $(VL_INCLUDE) $(CV_INCLUDE)

build/classifier.o: src/classifier.cpp
	g++ -c ./src/classifier.cpp -o ./build/classifier.o $(VL_INCLUDE) $(CV_INCLUDE)

build/align_single.o: src/align_single.cpp 
	g++ -c -O3 src/align_single.cpp -o build/align_single.o  $(CV_INCLUDE)

build/vladIndex.o: src/vladIndex.cpp src/vladIndex.h
	g++ -c src/vladIndex.cpp -o build/vladIndex.o $(CV_INCLUDE) $(VL_INCLUDE)

build/detector.o: src/detector.cpp
	g++ -c -O3 src/detector.cpp -o build/detector.o $(CV_INCLUDE)

build/flandmark_detector.o: src/flandmark_detector.cpp
	g++ -c -O3 src/flandmark_detector.cpp -o build/flandmark_detector.o $(CV_INCLUDE)

build/liblbp.o: ./src/liblbp.cpp
		g++ -c src/liblbp.cpp -o build/liblbp.o $(CV_INCLUDE)
	
clean:
	rm ./build/*.o
	rm ./bin/classify
	rm ./bin/bfclassify
	rm ./bin/exportCode
	rm ./bin/align_single
