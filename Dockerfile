FROM ubuntu:latest
RUN apt-get update && apt-get -y update
RUN apt-get install -y build-essential python3.6 python3-pip python3-dev
RUN pip3 -q install pip --upgrade
RUN mkdir src
WORKDIR src/
COPY . .
RUN pip freeze > requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install jupyter
RUN python3 module.py
RUN pip install numpy
RUN pip install pandas
RUN pip install dataset
RUN pip install datatest
RUN pip install sklearn
RUN pip install nltk
RUN pip install textblob
RUN pip install matplotlib
WORKDIR /src/notebooks
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]