FROM mcr.microsoft.com/mssql/server:2019-latest

USER root
ENV ACCEPT_EULA=Y

RUN apt-get update && apt-get install -y curl gnupg

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# install SQL Server tools
RUN apt-get install -y mssql-tools unixodbc-dev

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bash_profile"
RUN /bin/bash -c "source ~/.bashrc"
