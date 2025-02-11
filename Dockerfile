FROM silkeh/clang

WORKDIR /app

RUN apt-get update && apt-get install -y \
        # Build system generator
        cmake \
        # Fuzzer
        afl++ \
        # Memory profiling
        valgrind \
        # Testing 
        libcriterion-dev \
        libcriterion3

# Copy only what is needed
ADD ./src ./CMakeLists.txt ./fuzz ./tests ./cmake /app/ 

RUN cmake -DCMAKE_C_COMPILER=afl-cc -S . -B build
RUN cmake --build build --target axolotl-fuzz
