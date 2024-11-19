# This Dockerfile enables the construction of a Docker image that includes MATLAB, 
# Simulink, Simulink Check, and the CI/CD Support package, all installed via 
# the MATLAB Package Manager. Use the optional build arguments to customize the 
# version of MATLAB, list of products to install, and the location at which to install MATLAB.

# Here is an example docker build command with the optional build arguments.
# docker build --build-arg MATLAB_RELEASE=2023b 
#              --build-arg PRODUCTS="MATLAB Simulink Simulink_Check CI/CD_Automation_for_Simulink_Check Simulink_Test"
#              --build-arg MATLAB_INSTALL_LOCATION="/opt/matlab/R2023b"
#              --build-arg LICENSE_SERVER=12345@hostname.com 
#              -t my_matlab_image_name .



# To specify which MATLAB release to install in the container, edit the value of the MATLAB_RELEASE argument.
# Use lower case to specify the release, for example: ARG MATLAB_RELEASE=2022b

ARG MATLAB_RELEASE=2023b


# In order to run all the builtin tasks in the default processmodel, 
# following products can be added
# 	-Simulink_Coverage 
# 	-Simulink_Test
# 	-Simulink_Design_Verifier
# 	-MATLAB_Coder
# 	-MATLAB_Report_Generator
#	-Simulink_Coder
#   -Embedded_Coder
#	-Simulink_Report_Generator
#	-Requirements_Toolbox
#	-Polyspace_Bug_Finder
# In the absence of the above products, respective tasks will be 
# automatically disabled

ARG PRODUCTS="MATLAB Simulink Simulink_Check CI/CD_Automation_for_Simulink_Check"


# Specify the host and port of the machine that serves the network licenses, 
# if you want to bind in the license info as an environment variable. This 
# is the preferred option for licensing. e.g. ARG LICENSE_SERVER = 27000@flexlm-server-name

ARG LICENSE_SERVER=27000@MyServer

# Alternatively you can put a license file into the container.
# You should fill this lic file out with the details of the license 
# server you want to use and uncomment the line in STEP - 5.


# Specify MATLAB Install Location.
ARG MATLAB_INSTALL_LOCATION="/opt/matlab/R${MATLAB_RELEASE}"

##########################################################
### Should not need to change anything else down below ###
##########################################################

# STEP - 1
# When you start the build stage, this Dockerfile by default uses the Ubuntu-based matlab-deps image.
# To check the available matlab-deps images, see: https://hub.docker.com/r/mathworks/matlab-deps
FROM mathworks/matlab-deps:r${MATLAB_RELEASE}

# Declare build arguments
ARG MATLAB_RELEASE
ARG PRODUCTS
ARG LICENSE_SERVER
ARG MATLAB_INSTALL_LOCATION


# STEP - 2
# Install mpm dependencies
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
    && apt-get install --no-install-recommends --yes \
	   wget \
       unzip \
	   xvfb \
	   gcc \
	   g++ \
       ca-certificates \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# STEP - 3
# Add "matlab" user and grant sudo permission.
RUN adduser --shell /bin/bash --disabled-password --gecos "" matlab \
    && echo "matlab ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/matlab \
    && chmod 0440 /etc/sudoers.d/matlab
	
# Set user and work directory.	
USER matlab
WORKDIR /home/matlab

	
# STEP - 4
# Run mpm to install "PRODUCTS" in the target location and delete the mpm installation afterwards.
# If mpm fails to install successfully then output the logfile to the terminal, otherwise cleanup.
RUN wget -q https://www.mathworks.com/mpm/glnxa64/mpm \ 
    && chmod +x mpm \
    && sudo HOME=${HOME} ./mpm install \
        --release=r${MATLAB_RELEASE} \
        --destination=${MATLAB_INSTALL_LOCATION} \
        --products ${PRODUCTS} \
	|| (echo "MPM Installation Failure. See below for more information:" && cat /tmp/mathworks_root.log && false) \
    && sudo rm -f mpm /tmp/mathworks_root.log \
	&& sudo ln -s ${MATLAB_INSTALL_LOCATION}/bin/matlab /usr/local/bin/matlab
	

# STEP - 5
ENV MLM_LICENSE_FILE=$LICENSE_SERVER
# COPY network.lic ${MATLAB_INSTALL_LOCATION}/licenses


# Use
# "docker build" command to create an image from this Dockerfile
# "docker run" command to create a container from the generated image# This Dockerfile enables the construction of a Docker image that includes MATLAB, 
# Simulink, Simulink Check, and the CI/CD Support package, all installed via 
# the MATLAB Package Manager. Use the optional build arguments to customize the 
# version of MATLAB, list of products to install, and the location at which to install MATLAB.

# Here is an example docker build command with the optional build arguments.
# docker build --build-arg MATLAB_RELEASE=2023b 
#              --build-arg PRODUCTS="MATLAB Simulink Simulink_Check CI/CD_Automation_for_Simulink_Check Simulink_Test"
#              --build-arg MATLAB_INSTALL_LOCATION="/opt/matlab/R2023b"
#              --build-arg LICENSE_SERVER=12345@hostname.com 
#              -t my_matlab_image_name .



# To specify which MATLAB release to install in the container, edit the value of the MATLAB_RELEASE argument.
# Use lower case to specify the release, for example: ARG MATLAB_RELEASE=2022b

ARG MATLAB_RELEASE=2023b


# In order to run all the builtin tasks in the default processmodel, 
# following products can be added
# 	-Simulink_Coverage 
# 	-Simulink_Test
# 	-Simulink_Design_Verifier
# 	-MATLAB_Coder
# 	-MATLAB_Report_Generator
#	-Simulink_Coder
#   -Embedded_Coder
#	-Simulink_Report_Generator
#	-Requirements_Toolbox
#	-Polyspace_Bug_Finder
# In the absence of the above products, respective tasks will be 
# automatically disabled

ARG PRODUCTS="MATLAB Simulink Simulink_Check CI/CD_Automation_for_Simulink_Check"


# Specify the host and port of the machine that serves the network licenses, 
# if you want to bind in the license info as an environment variable. This 
# is the preferred option for licensing. e.g. ARG LICENSE_SERVER = 27000@flexlm-server-name

ARG LICENSE_SERVER=27000@MyServer

# Alternatively you can put a license file into the container.
# You should fill this lic file out with the details of the license 
# server you want to use and uncomment the line in STEP - 5.


# Specify MATLAB Install Location.
ARG MATLAB_INSTALL_LOCATION="/opt/matlab/R${MATLAB_RELEASE}"

##########################################################
### Should not need to change anything else down below ###
##########################################################

# STEP - 1
# When you start the build stage, this Dockerfile by default uses the Ubuntu-based matlab-deps image.
# To check the available matlab-deps images, see: https://hub.docker.com/r/mathworks/matlab-deps
FROM mathworks/matlab-deps:r${MATLAB_RELEASE}

# Declare build arguments
ARG MATLAB_RELEASE
ARG PRODUCTS
ARG LICENSE_SERVER
ARG MATLAB_INSTALL_LOCATION


# STEP - 2
# Install mpm dependencies
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
    && apt-get install --no-install-recommends --yes \
	   wget \
       unzip \
	   xvfb \
	   gcc \
	   g++ \
       ca-certificates \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# STEP - 3
# Add "matlab" user and grant sudo permission.
RUN adduser --shell /bin/bash --disabled-password --gecos "" matlab \
    && echo "matlab ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/matlab \
    && chmod 0440 /etc/sudoers.d/matlab
	
# Set user and work directory.	
USER matlab
WORKDIR /home/matlab

	
# STEP - 4
# Run mpm to install "PRODUCTS" in the target location and delete the mpm installation afterwards.
# If mpm fails to install successfully then output the logfile to the terminal, otherwise cleanup.
RUN wget -q https://www.mathworks.com/mpm/glnxa64/mpm \ 
    && chmod +x mpm \
    && sudo HOME=${HOME} ./mpm install \
        --release=r${MATLAB_RELEASE} \
        --destination=${MATLAB_INSTALL_LOCATION} \
        --products ${PRODUCTS} \
	|| (echo "MPM Installation Failure. See below for more information:" && cat /tmp/mathworks_root.log && false) \
    && sudo rm -f mpm /tmp/mathworks_root.log \
	&& sudo ln -s ${MATLAB_INSTALL_LOCATION}/bin/matlab /usr/local/bin/matlab
	

# STEP - 5
ENV MLM_LICENSE_FILE=$LICENSE_SERVER
# COPY network.lic ${MATLAB_INSTALL_LOCATION}/licenses


# Use
# "docker build" command to create an image from this Dockerfile
# "docker run" command to create a container from the generated image