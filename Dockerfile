#FROM ubuntu:latest
#ADD scala-library-2.13.6.jar /app
FROM apline
RUN RUN apk add --update --no-cache libexpat-2.6.4-r0

