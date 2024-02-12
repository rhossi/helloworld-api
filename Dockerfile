# Use the Microsoft's official .NET SDK image for .NET 8.0 to build the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["helloworld-api.csproj", "./"]
RUN dotnet restore "./helloworld-api.csproj"

# Copy the rest of the source code and build the project
COPY . .
RUN dotnet publish "helloworld-api.csproj" -c Release -o /app/publish

# Use the Microsoft's official ASP.NET Core runtime image for .NET 8.0 to run the project
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "helloworld-api.dll"]
