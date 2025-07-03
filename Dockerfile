# Use the Microsoft .NET Framework SDK image (Windows-based)
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
SHELL ["powershell"]

WORKDIR C:\app

# Copy all files
COPY . .

# Restore and build
RUN msbuild /p:Configuration=Release

# Use the ASP.NET runtime image for .NET Framework
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

# Copy published files from build stage
COPY --from=build "C:/app/YourWebApp/bin/Release/Publish" .

# Expose port 80
EXPOSE 80
