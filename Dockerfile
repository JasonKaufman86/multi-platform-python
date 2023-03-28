FROM python:3.9.16-bullseye
RUN mkdir -p /app
COPY . main.py /app/
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 8080
CMD [ "app.py" ]
ENTRYPOINT [ "python" ]
