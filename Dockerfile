FROM microsoft/dotnet:1.1.1-sdk

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y nodejs npm
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
RUN npm install -g bower

COPY ./src /app
COPY ./NuGet.config /app/
WORKDIR /app/Host
RUN dotnet restore

RUN dotnet publish -c Debug -o out

EXPOSE 5000
ENTRYPOINT ["dotnet", "out/Host.dll"]