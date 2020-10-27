FROM  python
#  Docker Engine will use Existing Docker image to integrate with Scode 
#  it will pull python based docker image from Docker HUB 
MAINTAINER   ashutoshh@linux.com 
#  option field but used for image designer info 
RUN  mkdir  /myscript
COPY  ashu.py   /myscript/ashu.py 
# copy will take data from Host Os and copy it to Docker image during image build process
#  make sure Dockerfile and ashu.py must be on the same location
WORKDIR  /myscript
# changing directory during image build process
# it is similar to cd command in linux 
RUN chmod +x  ashu.py
# giving you a shell inside container during image build process 
CMD  ["python","ashu.py"]
# will be used to define default parent process of my Docker image
