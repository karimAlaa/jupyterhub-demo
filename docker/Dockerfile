FROM jupyter/scipy-notebook

USER root

ENV APACHE_SPARK_VERSION 2.1.1
ENV HADOOP_VERSION 2.4

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get install netcat -y
RUN conda install -c conda-forge gmaps -y && conda install -c conda-forge  geocoder -y && conda install -y shapely && conda install -y geopy
RUN cd /tmp && \
        wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

USER $NB_USER

ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

EXPOSE 4040
RUN python3 -m pip install jupyterhub==0.8.0b3

RUN wget -O /home/$NB_USER/work/Exam.ipynb https://www.dropbox.com/s/uz73y78ahugqt8u/Fina%2BExam.ipynb?dl=0
RUN jupyter trust /home/$NB_USER/work/Exam.ipynb

RUN mkdir /home/$NB_USER/work/data && \
    wget -O /home/$NB_USER/work/data/flight-data.zip https://www.dropbox.com/s/g4c3eap5j3r33d9/flight-data.zip?dl=0 && \
    unzip /home/$NB_USER/work/data/flight-data.zip -d /home/$NB_USER/work/data && \
    rm -r /home/$NB_USER/work/data/__MACOSX && \
    rm -r /home/$NB_USER/work/data/flight-data.zip

