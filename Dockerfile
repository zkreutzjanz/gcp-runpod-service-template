FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# Non interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    curl \
    openssh-server \
    build-essential \
    yasm \
    cmake \
    libtool \
    libc6 \
    libc6-dev \
    unzip \
    libnuma1 \
    libnuma-dev \
    wget \
    git \
    screen \
    pkg-config \      
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libavdevice-dev \
    libavfilter-dev \
    libswresample-dev \
    libavutil-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 


# Install Anaconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/conda.sh && \
    /bin/bash /tmp/conda.sh -b -p /opt/miniconda && \
    rm /tmp/conda.sh

ENV PATH /opt/miniconda/bin:$PATH

# Create and install the conda environment
COPY ./environment.yaml /tmp/environment.yaml
RUN conda env create -f /tmp/environment.yaml

# Install dlib with GPU support
RUN git clone --single-branch https://github.com/davisking/dlib.git /opt/dlib && \
    mkdir -p /opt/dlib/build && \
    cmake -H/opt/dlib -B/opt/dlib/build -DDLIB_USE_CUDA=1 -DUSE_AVX_INSTRUCTIONS=1 -DCUDA_ARCH_NAME=Auto && \
    cmake --build /opt/dlib/build --verbose && \
    conda run -n conda_env --no-capture-output /bin/bash -c "cd /opt/dlib && python3 setup.py install"

# Install FFMPEG with GPU support
# RUN git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git /opt/nv-codec-headers
# RUN cd /opt/nv-codec-headers && make install
# RUN git clone https://git.ffmpeg.org/ffmpeg.git /opt/ffmpeg
# RUN cd /opt/ffmpeg && ./configure --enable-nonfree --enable-cuda-nvcc \
# --enable-libnpp --extra-cflags=-I/usr/local/cuda/include \
# --extra-ldflags=-L/usr/local/cuda/lib64 --disable-static --enable-shared
# RUN cd /opt/ffmpeg && make -j 8 && make install

# Install FFMPEG without GPU support
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    

# Copy files
# COPY . /tmp/repo
COPY ./init_runpod.sh ./init_runpod.sh
RUN chmod +x ./init_runpod.sh

CMD [ "./init_runpod.sh" ]
